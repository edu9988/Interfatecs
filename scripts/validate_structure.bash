#!/usr/bin/env bash

error_counter=0
declare -a problem_names

validate_testset(){
  local testset_dir=$1

  if [ ! -e "$testset_dir/judge.sh" ]; then
    echo "ERROR: $testset_dir: Missing file judge.sh" >&2
    error_counter=$((error_counter + 1))
  elif [ ! -f "$testset_dir/judge.sh" ]; then
    echo "ERROR: $testset_dir/judge.sh: Not a regular file" >&2
    error_counter=$((error_counter + 1))
  elif [ ! -x "$testset_dir/judge.sh" ]; then
    echo "ERROR: $testset_dir/judge.sh: No execute permission" >&2
    error_counter=$((error_counter + 1))
  else
    local judge_present=true
    local for_line
    for_line="$(grep -n "for .* in .*/.*do$" "$testset_dir"/judge.sh)"
    local line_number=${for_line%%:*}
    local for_loop=${for_line##*:}
    local loop_output_mapping
    loop_output_mapping="$(head -n $((line_number+1)) "$testset_dir"/judge.sh|tail -1)"
    local aux=${for_loop##for }
    local input_var=${aux%% in*}
    aux=${loop_output_mapping##* }
    local output_var=${aux%%=*}
  fi

  for problem in "${problem_names[@]}"; do
    if [[ ! -e "$testset_dir/$problem" ]]; then
      echo "ERROR: $testset_dir/$problem: Missing folder" >&2
      error_counter=$((error_counter + 1))
    elif [[ ! -d "$testset_dir/$problem" ]]; then
      echo "ERROR: $testset_dir/$problem: Not a directory" >&2
      error_counter=$((error_counter + 1))
    else
      if [[ ! -r "$testset_dir/$problem" ]]; then
        echo "ERROR: $testset_dir/$problem: No read permission" >&2
        error_counter=$((error_counter + 1))
      fi
      if [[ ! -w "$testset_dir/$problem" ]]; then
        echo "ERROR: $testset_dir/$problem: No write permission" >&2
        error_counter=$((error_counter + 1))
      fi
      if [[ ! -x "$testset_dir/$problem" ]]; then
        echo "ERROR: $testset_dir/$problem: No execute permission" >&2
        error_counter=$((error_counter + 1))
      fi
    fi

    if [ -e "$testset_dir/judge.sh" ]; then
      if ! grep -q "$problem" "$testset_dir/judge.sh" 2>/dev/null; then
        echo "ERROR: $testset_dir/judge.sh: reference to $problem/ not found within script" >&2
        error_counter=$((error_counter + 1))
      fi
    fi
  done

  for folder in "$testset_dir"/*/; do
    [ -e "$folder" ] || continue

    local folder_name
    folder_name="$(basename "$folder")"

    if [[ ! " ${problem_names[*]} " =~  $folder_name ]]; then
      echo "ERROR: $folder: $folder_name is not a valid folder name, expected one of these: ${problem_names[*]}" >&2
      error_counter=$((error_counter + 1))
    fi

    local subfolders=("$folder"*)

    for subfolder in "${subfolders[@]}"; do
      [ -e "$subfolder" ] || continue

      if [[ ! -d $subfolder ]]; then
        echo "ERROR: $subfolder: Not a regular folder" >&2
        error_counter=$((error_counter + 1))
      fi
    done

    local visited_inputs
    visited_inputs="$(mktemp)"
    local visited_outputs
    visited_outputs="$(mktemp)"

    if [[ "$judge_present" = true ]]; then
      cd "$folder"
      eval "$for_loop" \
        "$loop_output_mapping" ";" \
        "if grep \$$input_var $visited_inputs &>/dev/null; then" \
          "echo \"ERROR: \$$input_var: double visit\";" \
          "error_counter=\$((error_counter + 1));" \
        "fi;" \
        "if grep \$$output_var $visited_outputs &>/dev/null; then" \
          "echo \"ERROR: \$$output_var: double visit\";" \
          "error_counter=\$((error_counter + 1));" \
        "fi;" \
        "echo \"\$$input_var\" >> $visited_inputs;" \
        "echo \"\$$output_var\" >> $visited_outputs;" \
      "done"
      cd - &> /dev/null
    fi

    if [[ ${#subfolders[@]} -ne 2 ]]; then
      echo "ERROR: $folder: 2 and only 2 subfolders required, found ${#subfolders[@]} folders/files" >&2
      error_counter=$((error_counter + 1))
    else
      local inputs=("${subfolders[0]}"/*)
      local outputs=("${subfolders[1]}"/*)

      if [[ ${#inputs[@]} -ne ${#outputs[@]} ]]; then
        echo "ERROR: $folder: $(basename "${subfolders[0]}")/, $(basename "${subfolders[1]}")/: Different number of files" >&2
        error_counter=$((error_counter + 1))
      elif [[ -z "$(ls -A "${subfolders[0]}" 2> /dev/null)" ]]; then
        echo "ERROR: "$folder": $(basename ${subfolders[0]})/, $(basename ${subfolders[1]})/: No test cases" >&2
        error_counter=$((error_counter + 1))
      fi

      for input in "${inputs[@]}"; do
        if [[ ! -e $input ]]; then
          continue
        elif [[ ! -f $input ]]; then
          echo "ERROR: $input: not a regular file" >&2
          error_counter=$((error_counter + 1))
        elif [[ ! -r $input ]]; then
          echo "ERROR: $input: no read permission" >&2
          error_counter=$((error_counter + 1))
        fi

        if [[ "$judge_present" = true ]]; then
          if ! grep "$(basename "$input")" "$visited_inputs" &>/dev/null; then
            echo "ERROR: $input: not visited" >&2
            error_counter=$((error_counter + 1))
          fi
        fi
      done
      for output in "${outputs[@]}"; do
        if [[ ! -e $output ]]; then
          continue
        elif [[ ! -f $output ]]; then
          echo "ERROR: $output: not a regular file" >&2
          error_counter=$((error_counter + 1))
        elif [[ ! -r $output ]]; then
          echo "ERROR: $output: no read permission" >&2
          error_counter=$((error_counter + 1))
        fi

        if [[ "$judge_present" = true ]]; then
          if ! grep "$(basename "$output")" "$visited_outputs" &>/dev/null; then
            echo "ERROR: $output: not visited" >&2
            error_counter=$((error_counter + 1))
          fi
        fi
      done
    fi

    inputs=()
    outputs=()
    rm "$visited_inputs"
    rm "$visited_outputs"
  done
}

validate_phase() {
  echo "Checking $1..."
  local phase_dir="$1"
  local year=${phase_dir%%_*}
  problem_names=()

  if [[ ! "$phase_dir" =~ ^[0-9]{4}_fase([1-2]|-unica)$ ]]; then
    echo "ERROR: $phase_dir: Invalid folder name" >&2
    echo "  Expected format: YYYY_fase[1|2]" >&2
    error_counter=$((error_counter + 1))
  elif [[ "$year" -lt 2012 ]]; then
    echo "ERROR: $phase_dir: $year: Invalid year" >&2
    echo "  Must be >= 2012" >&2
    error_counter=$((error_counter + 1))
  fi

  if [ ! -e "$phase_dir/Caderno_Questoes.pdf" ]; then
    if [ ! -e "$phase_dir/Caderno_Questoes_comentado.pdf" ]; then
      echo "ERROR: $phase_dir: Missing file Caderno_Questoes.pdf" >&2
      error_counter=$((error_counter + 1))
    elif [ ! -f "$phase_dir/Caderno_Questoes_comentado.pdf" ]; then
      echo "ERROR: $phase_dir/Caderno_Questoes_comentado.pdf: Not a regular file" >&2
      error_counter=$((error_counter + 1))
    elif [ ! -r "$phase_dir/Caderno_Questoes_comentado.pdf" ]; then
      echo "ERROR: $phase_dir/Caderno_Questoes_comentado.pdf: No read permission" >&2
      error_counter=$((error_counter + 1))
    fi
  elif [ ! -f "$phase_dir/Caderno_Questoes.pdf" ]; then
    echo "ERROR: $phase_dir/Caderno_Questoes.pdf: Not a regular file" >&2
    error_counter=$((error_counter + 1))
  elif [ ! -r "$phase_dir/Caderno_Questoes.pdf" ]; then
    echo "ERROR: $phase_dir/Caderno_Questoes.pdf: No read permission" >&2
    error_counter=$((error_counter + 1))
  fi

  if [ ! -e "$phase_dir/testset" ]; then
    echo "ERROR: $phase_dir: Missing folder testset/" >&2
    error_counter=$((error_counter + 1))
  elif [ ! -d "$phase_dir/testset" ]; then
    echo "ERROR: $phase_dir/testset: Not a directory" >&2
    error_counter=$((error_counter + 1))
  else
    if [ ! -r "$phase_dir/testset" ]; then
      echo "ERROR: $phase_dir/testset: No read permission" >&2
      error_counter=$((error_counter + 1))
    fi
    if [ ! -w "$phase_dir/testset" ]; then
      echo "ERROR: $phase_dir/testset: No write permission" >&2
      error_counter=$((error_counter + 1))
    fi
    if [ ! -x "$phase_dir/testset" ]; then
      echo "ERROR: $phase_dir/testset: No execute permission" >&2
      error_counter=$((error_counter + 1))
    fi
  fi

  for file in "$phase_dir"/*; do
    [ -e "$file" ] || continue

    file_name=$(basename "$file")     #file_name=${file##*/}
    if [ -f "$file" ]; then
      case $file_name in
        Classificacao.pdf|ListaDeEspera.pdf|PlacarFinal.pdf|PlacarBaloes.pdf)
          #.gitignored
        ;;
        Caderno_Questoes.pdf|Caderno_Questoes_comentado.pdf)
          # Extract the lines with "Arquivo fonte:", then process them to get the names
          mapfile -t problem_names < <(pdftotext "$file" - | grep -E "Arquivo fonte:|Source file:|Source code:|Nome do arquivo fonte:|Source file name:" | sed -E 's/(Arquivo fonte|Source file|Source code|Nome do arquivo fonte|Source file name): ([^.]*)\..*/\2/')

          #append letter_ to problem names to get folder names
          letters=({a..z})
          for ((i=0; i<${#problem_names[@]}; i++)); do
            problem_names[i]="${letters[i]}_${problem_names[i]}"
          done

          # Print the array to verify
          #printf "%s\n" "${problem_names[@]}"
          #echo "problem_names length: ${#problem_names[@]}"
        ;;
        Estatisticas.pdf)
          #optional
        ;;
        *)
          echo "ERROR: $file: Invalid file name" >&2
          echo "  Expected: Caderno_Questoes.pdf|Caderno_Questoes_comentado.pdf|Estatistiscas.pdf" >&2
          error_counter=$((error_counter + 1))
        ;;
      esac
    elif [ -d "$file" ]; then
      case $file_name in
        code)
          #.gitignored
        ;;
        solutions)
          #optional
        ;;
        testset)
          #mandatory
          validate_testset "$file"
        ;;
        *)
          echo "ERROR: $file: Invalid folder name" >&2
          echo "  Expected: solutions|testset" >&2
          error_counter=$((error_counter + 1))
        ;;
      esac
    fi
  done
}

for phase in */; do
  validate_phase "${phase%%/}"
done

echo "$error_counter errors found"
exit $error_counter
