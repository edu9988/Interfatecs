#!/usr/bin/env bash

if [ "$#" -eq "1" ]; then
  KEEP=false
  ARG_FILE=$1
elif [ "$#" -eq "2" ]; then
  KEEP=true
  if [ "$1" = "--keep" ] || [ "$1" = "-k" ]; then
    ARG_FILE=$2
  elif [ "$2" = "--keep" ] || [ "$2" = "-k" ]; then
    ARG_FILE=$1
  else
    echo "Usage: $0 <file> [-k|--keep]" >&2
    exit 1
  fi
else
  echo "Usage: $0 <file> [-k|--keep]" >&2
  exit 1
fi

declare -A problem_dirs
problem_dirs=([A]="a_secrets" [B]="b_fliperama" [C]="c_semaforo" [D]="d_enfeites" [E]="e_papel" [F]="f_fiscal" [G]="g_palavras" [H]="h_layoutlinear" [I]="i_emprego" [J]="j_transferencias")

TESTSET_LONGPATH=$(dirname "$(realpath "$0")")
ARGFILE_LONGPATH=$(realpath "$ARG_FILE")

if [ ! -e "$ARG_FILE" ]; then
  echo "$ARG_FILE: file not found" >&2
  exit 1
else
  for dir in "${problem_dirs[@]}";do
    if [[ "$ARGFILE_LONGPATH" == "$TESTSET_LONGPATH/$dir"/* ]]; then
      echo "$ARG_FILE: $(dirname $ARG_FILE): don't place files in this folder or its subfolders" >&2
      echo "$ARG_FILE kept"
      exit 1
    fi
  done
  if [ ! -f "$ARG_FILE" ]; then
    echo "$ARG_FILE: not a regular file" >&2
    exit 1
  elif [ ! -r "$ARG_FILE" ]; then
    echo "$ARG_FILE: permission denied" >&2
    exit 1
  fi
fi

TESTSET_PATH=$(dirname "$0")      #TESTSET_PATH=${0%%judge.sh}
BASENAME=$(basename "$ARG_FILE")       #BASENAME=${ARG_FILE##*/}
EXT=${BASENAME##*.}
PROBLEM_NAME=${BASENAME%%.*}         #removes extension from input file

DOTS=${BASENAME//[^.]}
DOTS_COUNT=${#DOTS}

if [ "$DOTS_COUNT" -eq 0 ]; then
  echo "$ARG_FILE: file extension not found" >&2
  echo "$ARG_FILE kept"
  exit 1
elif [ "$DOTS_COUNT" -gt 1 ]; then
  echo "$ARG_FILE: multiple extensions not allowed" >&2
  echo "$ARG_FILE kept"
  exit 1
fi

case $PROBLEM_NAME in 
	secrets) 
    PROBLEM=A
		PROBLEM_DIR="${problem_dirs[A]}"
		TIME_LIMIT=1.0
	;;

	fliperama) 
    PROBLEM=B
		PROBLEM_DIR="${problem_dirs[B]}"
		TIME_LIMIT=1.0
	;;
	
	semaforo) 
    PROBLEM=C
		PROBLEM_DIR="${problem_dirs[C]}"
		TIME_LIMIT=1.0
	;;

	enfeites) 
    PROBLEM=D
		PROBLEM_DIR="${problem_dirs[D]}"
		TIME_LIMIT=1.0
	;;

	papel) 
    PROBLEM=E
		PROBLEM_DIR="${problem_dirs[E]}"
		TIME_LIMIT=1.0
	;;

	fiscal) 
    PROBLEM=F
		PROBLEM_DIR="${problem_dirs[F]}"
		TIME_LIMIT=1.0
	;;

	palavras) 
    PROBLEM=G
		PROBLEM_DIR="${problem_dirs[G]}"
		TIME_LIMIT=1.0
	;;

	layoutlinear) 
    PROBLEM=H
		PROBLEM_DIR="${problem_dirs[H]}"
		TIME_LIMIT=1.0
	;;

	emprego) 
    PROBLEM=I
		PROBLEM_DIR="${problem_dirs[I]}"
		TIME_LIMIT=1.0
	;;

	transferencias) 
    PROBLEM=J
		PROBLEM_DIR="${problem_dirs[J]}"
		TIME_LIMIT=1.0
	;;

	*)
		echo "$ARG_FILE: $PROBLEM_NAME: Wrong problem name"	>&2
    echo "$ARG_FILE kept"
		exit 1
	;;
esac

DOTS=${TIME_LIMIT//[^.]}
DOTS_COUNT=${#DOTS}
if [ "$DOTS_COUNT" -eq 0 ]; then
  TIME_LIMIT_NS=$((TIME_LIMIT*1000000000))
else
  TIME_LIMIT_L=${TIME_LIMIT%%.*} #integer part
  TIME_LIMIT_R=${TIME_LIMIT##*.} #fractional part
  FRACTIONAL_SIZE=${#TIME_LIMIT_R}
  if [ "$FRACTIONAL_SIZE" -eq 0 ]; then
    TIME_LIMIT_NS=$((TIME_LIMIT_L*1000000000))
  else
    FACTOR=1
    for (( i=0; i<9-FRACTIONAL_SIZE; i++ )); do
      FACTOR=$((FACTOR*10))
    done
    TIME_LIMIT_NS=$((TIME_LIMIT_L*1000000000 + 10#$TIME_LIMIT_R*FACTOR))
  fi
fi

if [ "$KEEP" = "false" ]; then
  if [ "$BASENAME" = "$ARG_FILE" ]; then
    echo "WARNING: This will remove $BASENAME"
  else
    echo "WARNING: This will remove $BASENAME ($ARG_FILE)"
  fi
  mv "$ARG_FILE" "$TESTSET_PATH"/$PROBLEM_DIR
elif [ "$KEEP" = "true" ]; then
  if [ "$BASENAME" = "$ARG_FILE" ]; then
    echo "Keeping $BASENAME"
  else
    echo "Keeping $BASENAME ($ARG_FILE)"
  fi
  cp "$ARG_FILE" "$TESTSET_PATH"/$PROBLEM_DIR
fi
cd "$TESTSET_PATH"/$PROBLEM_DIR || { rm "$TESTSET_PATH"/$PROBLEM_DIR/"$BASENAME"; exit 1; }
echo "Judging problem $PROBLEM ($PROBLEM_NAME)..."

case $EXT in
	hs)
    echo "Compiling in haskell..."
    LANGUAGE=Haskell
    if command -v ghc &> /dev/null; then
      COMMAND=(./executable)
      CLEANUP=(executable "$PROBLEM_NAME".{o,hi})
      ghc "$PROBLEM_NAME".hs -o executable -lm
    else
      echo "Error: ghc not installed" >&2
      rm "$PROBLEM_NAME".hs
      exit 1
    fi
  ;;

	java)
		echo "Compiling in java..."
    LANGUAGE=Java
    if command -v javac &> /dev/null; then
      COMMAND=(java "$PROBLEM_NAME")
      CLEANUP=("$PROBLEM_NAME".class)
      javac "$PROBLEM_NAME".java
    else
      echo "Error: javac not installed" >&2
      rm "$PROBLEM_NAME".java
      exit 1
    fi
  ;;

	cpp)
		echo "Compiling in C++..."		
    LANGUAGE=C++
    if command -v g++ &> /dev/null; then
      COMMAND=(./executable)
      CLEANUP=(executable)
      g++ "$PROBLEM_NAME".cpp -o executable -lm
    else
      echo "Error: g++ not installed" >&2
      rm "$PROBLEM_NAME".cpp
      exit 1
    fi
  ;;

	c)
		echo "Compiling in C..."		
    LANGUAGE=C
    if command -v gcc &> /dev/null; then
      COMMAND=(./executable)
      CLEANUP=(executable)
      gcc "$PROBLEM_NAME".c -o executable -lm 
    else
      echo "Error: gcc not installed" >&2
      rm "$PROBLEM_NAME".c
      exit 1
    fi
  ;;

	py)
		echo "Running python pre-execution checks (this step is analogous to compilation)..."		
    LANGUAGE=Python
    if command -v python3 &> /dev/null && python3 -c "exit(0)"; then
      COMMAND=(python3 "$PROBLEM_NAME.py")
      CLEANUP=(__pycache__)
      python3 -m py_compile "$PROBLEM_NAME".py
    elif command -v python &> /dev/null && python -c "exit(0)"; then
      COMMAND=(python "$PROBLEM_NAME.py")
      python -m py_compile "$PROBLEM_NAME".py
    else
      echo "Error: python not installed" >&2
      rm "$PROBLEM_NAME".py
      exit 1
    fi
  ;;

	js)
		echo "Running javascript pre-execution checks (this step is analogous to compilation)..."		
    LANGUAGE=Javascript
    if command -v node &> /dev/null; then
      COMMAND=(node "$PROBLEM_NAME.js")
      CLEANUP=()
      node --check "$PROBLEM_NAME".js
    else
      echo "Error: node not installed" >&2
      rm "$PROBLEM_NAME".js
      exit 1
    fi
  ;;

	*)
		echo "$ARG_FILE: $EXT: unsupported file extension" >&2
    rm "$BASENAME"
    exit 1
	;;
esac

if [ $? -ne 0 ]; then
  echo
  echo "Compilation error"
  if [ "$EXT" = "py" ]; then
    rm -rf __pycache__
  fi
  rm "$PROBLEM_NAME"."$EXT"
  exit 1
fi

echo "Compilation finished. Press enter to run..."
read -r
echo "Executing in $LANGUAGE. Time limit: $TIME_LIMIT sec"		

for INPUT_FILE in in/*; do
  OUTPUT_FILE=${INPUT_FILE//in/out}

  start_ns=$(date +%s%N)
  "${COMMAND[@]}" < "$INPUT_FILE" > user_answer
  end_ns=$(date +%s%N)

  runtime_ns=$((end_ns - start_ns))
  printf -v runtime "%.3f" "$((10#${runtime_ns}))e-9"
  runtime=${runtime/,/.}
  if (( runtime_ns > TIME_LIMIT_NS )); then
    echo "$TESTSET_PATH/$PROBLEM_DIR/$INPUT_FILE: Time limit exceeded: $runtime sec"
    break
  fi
  a1=$OUTPUT_FILE
  a2=user_answer
  b1="$TESTSET_PATH/$PROBLEM_DIR/$OUTPUT_FILE"

  if diff --strip-trailing-cr -q "$a1" "$a2" &>/dev/null; then
    echo "diff \"$b1\" \"$a2\": files match exactly"
    echo "Execution time: $runtime sec"
    continue
  fi
  # -b ignores differences in the amount of white space
  if diff --strip-trailing-cr -q -b "$a1" "$a2" &>/dev/null; then
    echo "diff -u -b \"$b1\" \"$a2\": files match"
    echo "diff -u \"$b1\" \"$a2\": files don't match - see output"
    diff --strip-trailing-cr -u "$a1" "$a2"
    echo "Files match with differences in the amount of white spaces"
    break
  fi
  # -B ignores differences where lines are all blank
  if diff --strip-trailing-cr -q -b -B "$a1" "$a2" &>/dev/null; then
    echo "diff -u -b -B \"$b1\" \"$a2\": files match"
    echo "diff -u -b \"$b1\" \"$a2\": files don't match - see output"
    diff --strip-trailing-cr -u -b "$a1" "$a2"
    echo "Files match with differences in the amount of white spaces and blank lines"
    break
  fi
  # -w ignores all white space
  if diff --strip-trailing-cr -q -b -B -w "$a1" "$a2" &>/dev/null; then
    echo "diff -u -b -B -w \"$b1\" \"$a2\": files match"
    echo "diff -u -b -B \"$b1\" \"$a2\": files don't match - see output"
    diff --strip-trailing-cr -u -b -B "$a1" "$a2"
    echo "Files match if we discard all white spaces"
    break
  fi
  # -i ignores case differences
  if diff --strip-trailing-cr -q -i "$a1" "$a2" &>/dev/null; then
    echo "diff -u -i \"$b1\" \"$a2\": files match"
    echo "diff -u -b -B -w \"$b1\" \"$a2\": files don't match - see output"
    diff --strip-trailing-cr -u -b -B -w "$a1" "$a2"
    echo "Files match if we ignore case differences"
    break
  fi
  if diff --strip-trailing-cr -q -i -b -B "$a1" "$a2" &>/dev/null; then
    echo "diff -u -i -b -B \"$b1\" \"$a2\": files match"
    echo "diff -u -i \"$b1\" \"$a2\": files don't match, and"
    echo "diff -u -b -B -w \"$b1\" \"$a2\": files don't match - see output"
    diff --strip-trailing-cr -u -b -B -w "$a1" "$a2"
    echo "Files match if we ignore case and differences in the amount of white spaces and blank lines"
    break
  fi
  if diff --strip-trailing-cr -q -i -b -B -w "$a1" "$a2" &>/dev/null; then
    echo "diff -u -i -b -B -w \"$b1\" \"$a2\": files match"
    echo "diff -u -b -B -w \"$b1\" \"$a2\": files don't match - see output"
    diff --strip-trailing-cr -u -b -B -w "$a1" "$a2"
    echo "Files match if we ignore case and discard all white spaces"
    break
  fi
  if command -v wdiff &> /dev/null && wdiff "$a1" "$a2" &>/dev/null; then
    echo "wdiff \"$b1\" \"$a2\": files match"
    echo "BUT Files match only if we compare word by word, ignoring everything else, using wdiff"
    echo "diff -u -i -b -B -w \"$b1\" \"$a2\": files don't match - see output" 
    diff -u -i -b -B -w "$a1" "$a2"
    break
  fi
  echo "$b1, $a2: files don't match - see output"
  diff --strip-trailing-cr -u -i -b -B -w "$a1" "$a2"
  echo "Differences found"
  break
done

rm "$PROBLEM_NAME"."$EXT"
rm user_answer
for f in "${CLEANUP[@]}"; do
  rm -rf "$f"
done
