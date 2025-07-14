#!/usr/bin/env bash

unset PROBLEM
unset PROBLEM_DIR
unset PROBLEM_NAME
unset EXT
unset TIME_LIMIT
unset INPUT_FILE
unset OUTPUT_FILE
unset LANGUAGE
unset TESTSET_PATH
unset BASENAME
unset COMMAND
unset KEEP
unset ARG_FILE
unset DOTS
unset DOTS_COUNT

if [ "$#" -eq "1" ]; then
  KEEP=false
  ARG_FILE=$1
elif [ "$#" -eq "2" ]; then
  KEEP=true
  if [ "$1" = "--keep" ]; then
    ARG_FILE=$2
  elif [ "$2" = "--keep" ]; then
    ARG_FILE=$1
  else
    echo "Usage: $0 <file> [--keep]" >&2
    exit 1
  fi
else
  echo "Usage: $0 <file> [--keep]" >&2
  exit 1
fi

if [ ! -e "$ARG_FILE" ]; then
  echo "$ARG_FILE: file not found" >&2
  exit 1
elif [ ! -f "$ARG_FILE" ]; then
  echo "$ARG_FILE: not a regular file" >&2
  exit 1
elif [ ! -r "$ARG_FILE" ]; then
  echo "$ARG_FILE: permission denied" >&2
  exit 1
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
	themayans) 
    PROBLEM=A
		PROBLEM_DIR="a_themayans"
		TIME_LIMIT=1
	;;

	scoreboard) 
    PROBLEM=B
		PROBLEM_DIR="b_scoreboard"
		TIME_LIMIT=1
	;;
	
	agricultor) 
    PROBLEM=C
		PROBLEM_DIR="c_agricultor"
		TIME_LIMIT=1
	;;

	helicon) 
    PROBLEM=D
		PROBLEM_DIR="d_helicon"
		TIME_LIMIT=1
	;;

	triangulo) 
    PROBLEM=E
		PROBLEM_DIR="e_triangulo"
		TIME_LIMIT=1
	;;

	suprimentos) 
    PROBLEM=F
		PROBLEM_DIR="f_suprimentos"
		TIME_LIMIT=1
	;;

	base) 
    PROBLEM=G
		PROBLEM_DIR="g_base"
		TIME_LIMIT=1
	;;

	fatectok) 
    PROBLEM=H
		PROBLEM_DIR="h_fatectok"
		TIME_LIMIT=1
	;;

	anonnavai) 
    PROBLEM=I
		PROBLEM_DIR="i_anonnavai"
		TIME_LIMIT=1
	;;

	camisetas) 
    PROBLEM=J
		PROBLEM_DIR="j_camisetas"
		TIME_LIMIT=1
	;;

	fonte) 
    PROBLEM=K
		PROBLEM_DIR="k_fonte"
		TIME_LIMIT=1
	;;

	*)
		echo "$ARG_FILE: $PROBLEM_NAME: Wrong problem name"	>&2
    echo "$ARG_FILE kept"
		exit 1
	;;
esac

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
      python3 -m py_compile "$PROBLEM_NAME".py
    elif command -v python &> /dev/null; then
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

  start=$(date +%s)
  "${COMMAND[@]}" < "$INPUT_FILE" > user_answer
  end=$(date +%s)

  runtime=$((end-start))
  if [ $TIME_LIMIT -lt $runtime ]; then
    echo "Time limit exceeded: $runtime sec"
    break
  fi
  diff --strip-trailing-cr "$OUTPUT_FILE" user_answer
  a1=$OUTPUT_FILE
  a2=user_answer

  if diff --strip-trailing-cr -q "$a1" "$a2" &>/dev/null; then
    echo -e "diff \"$a1\" \"$a2\" # files match"
    echo "Files match exactly"
    continue
  fi
  if diff --strip-trailing-cr -q -b "$a1" "$a2" &>/dev/null; then
    echo -e "diff -c -b \"$a1\" \"$a2\" # files match"
    echo -e "diff -c \"$a1\" \"$a2\" # files dont match - see output"
    diff --strip-trailing-cr -c "$a1" "$a2"
    echo "Files match with differences in the amount of white spaces"
    break
  fi
  if diff --strip-trailing-cr -q -b -B "$a1" "$a2" &>/dev/null; then
    echo -e "diff -c -b -B \"$a1\" \"$a2\" # files match"
    echo -e "diff -c -b \"$a1\" \"$a2\" # files dont match - see output"
    diff --strip-trailing-cr -c -b "$a1" "$a2"
    echo "Files match with differences in the amount of white spaces and blank lines"
    break
  fi
  if diff --strip-trailing-cr -q -i -b -B "$a1" "$a2" &>/dev/null; then
    echo -e "diff -c -i -b -B \"$a1\" \"$a2\" # files match"
    echo -e "diff -c -b -B \"$a1\" \"$a2\" # files dont match - see output"
    diff --strip-trailing-cr -c -b -B "$a1" "$a2"
    echo "Files match if we ignore case and differences in the amount of white spaces and blank lines"
    break
  fi
  if diff --strip-trailing-cr -q -b -B -w "$a1" "$a2" &>/dev/null; then
    echo -e "diff -c -b -B -w \"$a1\" \"$a2\" # files match"
    echo -e "diff -c -i -b -B \"$a1\" \"$a2\" # files dont match - see output"
    diff --strip-trailing-cr -c -i -b -B "$a1" "$a2"
    echo "Files match if we discard all white spaces"
    break
  fi
  if diff --strip-trailing-cr -q -i -b -B -w "$a1" "$a2" &>/dev/null; then
    echo -e "diff -c -i -b -B -w \"$a1\" \"$a2\" # files match"
    echo -e "diff -c -b -B -w \"$a1\" \"$a2\" # files dont match - see output"
    diff --strip-trailing-cr -c -b -B -w "$a1" "$a2"
    echo "Files match if we ignore case and discard all white spaces"
    break
  fi
  wd=$(which wdiff)
  if [ "$wd" != "" ]; then
    if wdiff "$a1" "$a2" &>/dev/null; then
      echo -e "wdiff \"$a1\" \"$a2\" # files match"
      echo -e "diff -c -i -b -B -w \"$a1\" \"$a2\" # files dont match - see output" 
      diff -c -i -b -B -w "$a1" "$a2"
      echo "BUT Files match if we compare word by word, ignoring everything else, using wdiff"
      break
    fi
  fi
  echo -e "### files dont match - see output"
  diff -c -i -b -B -w "$a1" "$a2"
  echo "Differences found"
  break
done

rm "$PROBLEM_NAME"."$EXT"
rm user_answer
case $EXT in
	hs)
    rm -f "$PROBLEM_NAME".hi
    rm -f "$PROBLEM_NAME".o
    rm executable
  ;;
	java)
    rm "$PROBLEM_NAME".class
  ;;
	c|cpp)
    rm executable
  ;;
	py)
    rm -rf __pycache__
  ;;
  js)
  ;;
esac
