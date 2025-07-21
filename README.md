# Interfatecs

This repository contains yearly editions of our college's programming contest ([interfatecs.com.br](https://interfatecs.com.br "Maratona Interfatecs")). Each edition includes the official problem set in PDF format and a set of sample input/output test cases for every problem, to be used with a judge script.

## Usage

1. Navigate to the `testset` folder of the desired edition (optional):
  ```bash
  cd YYYY-faseN/testset
  ```

2. Run the judge script with your solution file:
  ```bash
  ./judge.sh mysolution.ext
  ```
  >**WARNING**: By default, this will delete `mysolution.ext` file. This is standard behavior in judging scripts, to prevent competitor's files from accumulating in the `testset` folder.
>
>Replace `mysolution` with the actual problem name and `ext` with actual extension (e.g., `themayans.cpp`, `triangulo.py`, etc.).
>
>### Optional Flags
>- `-k` or `--keep`: Prevents removal of supplied solution file.
  >```bash
  >./judge.sh mysolution.ext -k
  >```

## Currently Supported Languages

- Haskell (`.hs`)
- C (`.c`)
- C++ (`.cpp`)
- Java (`.java`)
- Python (`.py`)
- JavaScript (Node.js) (`.js`)

 **Note:** To run the judge successfully, your system must have the corresponding compiler or interpreter installed and available in the system `PATH`.

| Language   | Required Tool         |
|------------|------------------------|
| C          | `gcc`                  |
| C++        | `g++`                  |
| Java       | `javac` and `java`     |
| Python     | `python3` or `python`  |
| JavaScript | `node`                 |
| Haskell    | `ghc`                  |

**Note:** Interfatecs currently only allows use of C, C++, Java and Python. Support for Haskell and Javascript in this repository was added for training and learning purposes.

## Contributing

Feel free to contribute by adding future editions, improving test coverage or fixing bugs. Please refer to [Contribution Guidelines](./CONTRIBUTING.md "CONTRIBUTING.md")
