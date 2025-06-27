#!/usr/bin/env bash

unset $PROBLEM
unset $PROBLEM_DIR
unset $PROBLEM_NAME
unset $EXT
unset $TIME_LIMIT
unset $INPUT_FILE
unset $OUTPUT_FILE
unset $LANGUAGE
unset $TESTSET_PATH
unset $AUX
unset $COMMAND
unset $KEEP
unset $ARG_FILE

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
  echo "$ARG_FILE: file not found"
  exit 1
elif [ ! -f "$ARG_FILE" ]; then
  echo "$ARG_FILE: not a regular file"
  exit 1
elif [ ! -r "$ARG_FILE" ]; then
  echo "$ARG_FILE: permission denied"
  exit 1
fi

TESTSET_PATH=${0%%judge.sh}
EXT=${ARG_FILE##*.}
AUX=${ARG_FILE##*/}       #removes path from input file
PROBLEM_NAME=${AUX%%.*}   #removes extension from input file

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
		echo "$ARG_FILE: $PROBLEM_NAME: Wrong problem name"	
    echo "$ARG_FILE kept"
		exit 1
	;;
esac

if [ "$KEEP" = "false" ]; then
  echo "WARNING: This will remove $ARG_FILE"
  mv $ARG_FILE $TESTSET_PATH$PROBLEM_DIR
elif [ "$KEEP" = "true" ]; then
  echo "Keeping $ARG_FILE"
  cp $ARG_FILE $TESTSET_PATH$PROBLEM_DIR
fi
cd $TESTSET_PATH$PROBLEM_DIR
echo "Judging problem $PROBLEM ($PROBLEM_NAME)..."

case $EXT in
	hs)
		echo "Compiling in haskell..."
    LANGUAGE=Haskell
    COMMAND=(./executable)
		ghc $PROBLEM_NAME.hs -o executable -lm
  ;;

	java)
		echo "Compiling in java..."
    LANGUAGE=Java
    COMMAND=(java "$PROBLEM_NAME")
		javac $1
  ;;

	cpp)
		echo "Compiling in C++..."		
    LANGUAGE=C++
    COMMAND=(./executable)
		g++ $PROBLEM_NAME.cpp -o executable -lm
  ;;

	c)
		echo "Compiling in C..."		
    LANGUAGE=C
    COMMAND=(./executable)
		gcc $PROBLEM_NAME.c -o executable -lm 
  ;;

	py)
		echo "Compiling in python..."		
    LANGUAGE=Python
    COMMAND=(python3 "$PROBLEM_NAME.py")
		python3 -m py_compile $PROBLEM_NAME.py
  ;;

	js)
		echo "Compiling in javascript..."		
    LANGUAGE=Javascript
    COMMAND=(node "$PROBLEM_NAME.js")
		node --check $PROBLEM_NAME.js
  ;;

	*)
		echo "$ARG_FILE: $EXT: unsupported file extension"	
    rm $PROBLEM_NAME.$EXT
    exit 1
	;;
esac

if [ $? -ne 0 ]; then
  echo
  echo "Compilation error"
  if [ "$EXT" = "py" ]; then
    rm -rf __pycache__
  fi
  rm $PROBLEM_NAME.$EXT
  exit 1
fi

echo "Compilation finished. Press enter to run..."		
read
echo "Executing in $LANGUAGE. Time limit: $TIME_LIMIT sec"		

for INPUT_FILE in in/*
  do
    OUTPUT_FILE=${INPUT_FILE//in/out}

    start=`date +%s`
    "${COMMAND[@]}" < "$INPUT_FILE" > user_answer
    end=`date +%s`

    runtime=$((end-start))
    if [ $TIME_LIMIT -lt $runtime ]; then
      echo "Time limit exceeded: $runtime sec"
      break
    fi
    diff $OUTPUT_FILE user_answer
    a1=$OUTPUT_FILE
    a2=user_answer
    
    diff -q "$a1" "$a2" >/dev/null 2>/dev/null
    if [ "$?" == "0" ]; then
        echo -e "diff \"$a1\" \"$a2\" # files match"
        echo "Files match exactly"
        continue
    fi
    diff -q -b "$a1" "$a2" >/dev/null 2>/dev/null
    if [ "$?" == "0" ]; then
        echo -e "diff -c -b \"$a1\" \"$a2\" # files match"
        echo -e "diff -c \"$a1\" \"$a2\" # files dont match - see output"
        diff -c "$a1" "$a2"
        echo "Files match with differences in the amount of white spaces"
        break
    fi
    diff -q -b -B "$a1" "$a2" >/dev/null 2>/dev/null
    if [ "$?" == "0" ]; then
        echo -e "diff -c -b -B \"$a1\" \"$a2\" # files match"
        echo -e "diff -c -b \"$a1\" \"$a2\" # files dont match - see output"
        diff -c -b "$a1" "$a2"
        echo "Files match with differences in the amount of white spaces and blank lines"
        break
    fi
    diff -q -i -b -B "$a1" "$a2" >/dev/null 2>/dev/null
    if [ "$?" == "0" ]; then
        echo -e "diff -c -i -b -B \"$a1\" \"$a2\" # files match"
        echo -e "diff -c -b -B \"$a1\" \"$a2\" # files dont match - see output"
        diff -c -b -B "$a1" "$a2"
        echo "Files match if we ignore case and differences in the amount of white spaces and blank lines"
        break
    fi
    diff -q -b -B -w "$a1" "$a2" >/dev/null 2>/dev/null
    if [ "$?" == "0" ]; then
        echo -e "diff -c -b -B -w \"$a1\" \"$a2\" # files match"
        echo -e "diff -c -i -b -B \"$a1\" \"$a2\" # files dont match - see output"
        diff -c -i -b -B "$a1" "$a2"
        echo "Files match if we discard all white spaces"
        break
    fi
    diff -q -i -b -B -w "$a1" "$a2" >/dev/null 2>/dev/null
    if [ "$?" == "0" ]; then
        echo -e "diff -c -i -b -B -w \"$a1\" \"$a2\" # files match"
        echo -e "diff -c -b -B -w \"$a1\" \"$a2\" # files dont match - see output"
        diff -c -b -B -w "$a1" "$a2"
        echo "Files match if we ignore case and discard all white spaces"
        break
    fi
    wd=`which wdiff`
    if [ "$wd" != "" ]; then
        wdiff \"$a1\" \"$a2\" >/dev/null 2>/dev/null
        if [ "$?" == "0" ]; then
          echo -e "wdiff \"$a1\" \"$a2\" # files match"
          echo -e "diff -c -i -b -B -w \"$a1\" \"$a2\" # files dont match - see output" 
          diff -c -i -b -B -w "$a1" "$a2"
          echo "BUT Files match if we compare word by word, ignoring everything else, using wdiff"
          echo "diff has a bug that, if a line contains a single space, this is not discarded by -w"
          break
        fi
    fi
    echo -e "### files dont match - see output"
    diff -c -i -b -B -w "$a1" "$a2"
    echo "Differences found"
    break
  done

rm $PROBLEM_NAME.$EXT
rm user_answer
case $EXT in
	hs)
    rm -f $PROBLEM_NAME.hi
    rm -f $PROBLEM_NAME.o
    rm executable
  ;;
	java)
    rm $PROBLEM_NAME.class
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
