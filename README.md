# AuraScript (.aura) Programming Language

AuraScript is a lightweight, custom-built interpreted programming language designed using **Flex** and **Bison**, featuring variable declarations, standard arithmetic, logical evaluations, and custom control-flow statements like `unless`. Created as a Compiler Design Lab assignment.

## Repository Structure
* `lexer.l`: Lexical analyzer rules for tokenization.
* `parser.y`: Grammar rules, syntax analysis, and symbol table management backend.
* `examples/`: Sample scripts demonstrating language capabilities (`demo.aura`).
* `Language_Manual.txt`: User syntax guide and compilation instructions.

## Built With
* **Flex** (Fast Lexical Analyzer Generator)
* **GNU Bison** (Parser Generator)
* **GCC** (GNU Compiler Collection)

## Compilation & Execution
1. Generate parser and lexer files:
   ```bash
   bison -d parser.y
   flex lexer.l