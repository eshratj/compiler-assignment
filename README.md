# AuraScript (.aura) Programming Language

AuraScript is a custom-built interpreted programming language designed with an intuitive domain vocabulary, a Flex lexical scanner, a Bison LALR parser, an Abstract Syntax Tree (AST) generator, and a C execution interpreter. Created as a Compiler Design Lab assignment.

---

## 🏛️ Architecture Overview

The AuraScript compiler pipeline consists of three core stages:
```
                +-------------------+
                |   Source (.aura)  |
                +---------+---------+
                          |
                          v
                +-------------------+
                |    Flex Scanner   |  (lexer.l)
                | (Lexical Tokens)  |
                +---------+---------+
                          |
                          v
                +-------------------+
                |    Bison Parser   |  (parser.y)
                | (AST Construction)|
                +---------+---------+
                          |
                          v
                +-------------------+
                | C AST Interpreter |  (execute_program)
                |  (Symbol Engine)  |
                +-------------------+
```
### 1. Lexical Analysis (`lexer.l`)
- Built using **Flex**.
- Converts `.aura` raw source code into structured tokens: keywords (`let`, `print`, `input`, `if`, `else`, `unless`, `while`), identifiers, integer constants, double-quoted string literals, and operators (`^`, `+`, `-`, `*`, `/`, `==`, `!=`, `<=`, `>=`).
- Handles escape sequences, skips whitespace, and strips single-line `//` comments[cite: 1].

### 2. Syntax Analysis & AST Generation (`parser.y`)
- Built using **GNU Bison**.
- Parses the token stream according to formal context-free grammar rules.
- Builds an Abstract Syntax Tree (AST) composed of typed nodes for declarations, assignments, I/O, control flow, and expressions[cite: 1, 2].

### 3. Runtime Interpreter Engine (`parser.y`)
- Recursively evaluates the AST statement lists[cite: 1, 2].
- Manages a runtime symbol table (`symtab`) for variable declarations and assignments.
- Performs numerical evaluation, string literal handling, and expression execution.
- Handles runtime variable lookups and execution flow smoothly.

---

## ⚡ Key Features

- **Custom Vocabulary**:
  - `let`: Variable declaration and value assignment (e.g., `let x = 5;`).
  - `print`: Print output for expressions and string literals (e.g., `print "Hello!";`).
  - `input`: Runtime user input handling.
  - `if` / `else`: Conditional branching.
  - `unless`: Custom inverse conditional statement (executes a block only when a condition is false).
  - `while`: While loop control structure.
- **Unique Extensions**:
  - Custom `unless` conditional blocks for inverse condition execution.
  - Strict operator precedence and expression evaluations.
- **String Literal Output**: Supports string formatting and text printing.

---

## 🛠️ Technical Challenges & Solutions

### 1. Resolving Grammar Ambiguities
- **Challenge**: Parsing nested blocks and control structures creates potential shift/reduce grammar conflicts in LALR parsers.
- **Solution**: Explicitly defined token precedence levels (`%left`, `%right`, `%nonassoc`) and structured grammar rules in `parser.y` to resolve conflicts cleanly.

### 2. Handling Nested Statement Blocks
- **Challenge**: Supporting arbitrarily nested `{ ... }` block statements inside control structures like `if`, `unless`, and `while` without execution corruption[cite: 1].
- **Solution**: Structured grammar rules and C-based action blocks to seamlessly handle block scopes and statement execution hierarchies[cite: 1].

### 3. Symbol Table Scope & Storage
- **Challenge**: Managing variable state persistence and dynamic lookups during runtime execution[cite: 1].
- **Solution**: Implemented linear lookup and update functions (`set_val` and `get_val`) in C to maintain variable state across program statements[cite: 1].

---

## 🚀 Building & Running

### Prerequisites
- GCC (`gcc`)[cite: 1, 2]
- Flex (`flex`)[cite: 1, 2]
- Bison (`bison`)[cite: 1, 2]

### Compile
Run from the repository root:

```bash
bison -d parser.y
flex lexer.l
gcc parser.tab.c lex.yy.c -o aura -lm

./aura < examples/demo.aura
