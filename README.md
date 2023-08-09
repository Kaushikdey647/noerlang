# DFA based Lexer

### Kaushik Dey | 20CS01043

The `dfa.h` header file provides a set of functions and structures for working with Deterministic Finite Automata (DFAs). DFAs are used in lexical analysis to recognize patterns in input strings.

The header file defines the following structures:
- `dfa`: a structure representing a DFA, with fields for the start state, accept state, retracting flag, priority, label, and transition table.

The header file also defines the following functions:

- `identifier_automaton`: a function that returns a DFA that recognizes identifiers in a programming language.
- `integer_automaton`: a function that returns a DFA that recognizes integers in a programming language.
- `float_automaton`: a function that returns a DFA that recognizes floating-point numbers in a programming language.
- `if_automaton`: a function that returns a DFA that recognizes the keyword "if" in a programming language.
- `elsif_automaton`: a function that returns a DFA that recognizes the keyword "elsif" in a programming language.
- `else_automaton`: a function that returns a DFA that recognizes the keyword "else" in a programming language.
- `then_automaton`: a function that returns a DFA that recognizes the keyword "then" in a programming language.
- `relop_automaton`: a function that returns a DFA that recognizes relational operators in a programming language.

To use the `dfa.h` header file, include it in your code and call the appropriate functions to create and use DFAs.

Here is an example usage of the `dfa.h` header file:

```c
#include "dfa.h"

#include <stdio.h>
#include <string.h>

int main(){

    //malloc for 6 dfas
    dfa* dfas = malloc(sizeof(dfa) * 8);

    //initialize all dfas
    dfas[0] = identifier_automaton();
    dfas[1] = integer_automaton();
    dfas[2] = if_automaton();
    dfas[3] = elsif_automaton();
    dfas[4] = else_automaton();
    dfas[5] = relop_automaton();
    dfas[6] = float_automaton();
    dfas[7] = then_automaton();

    //allocate 256 characters for input
    char* input = malloc(sizeof(char) * 256);

    printf("Enter input: ");

    //read input using fgets
    fgets(input, 256, stdin);

    //tokenize the input
    tokenize(input, dfas, 8);

    print_tokens();

    return 0;
}
```
Here more functions have been defined for ease of use:

- `tokenize`: a function that tokenizes the input string using the given DFAs.

- `print_tokens`: a function that prints the tokens recognized by the DFAs.

### To use this code:

- Add it to the src folder, rename it to main.c

- Use a linux environment to run `make all` to build the executable

- Run the executable from `./bin/main`

- Cleanup using `make clean`




