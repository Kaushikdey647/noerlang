## Assignment 4

1. **left-factored-grammar.cpp**:

    This C++ program processes a context-free grammar and generates an equivalent left-factored grammar. It uses sets and vectors to store non-terminals and production rules. The `equivalentLeftFactoredGrammar()` function analyzes the input context-free grammar and performs left-factoring by creating new non-terminals and rules. The main function reads an input file, processes the grammar, and prints the original and left-factored grammars.

2. **recursive-descent.cpp**:

    This C++ program implements a recursive descent parser for a simple language. It defines a class `RecursiveDescentParser` with parsing functions for non-terminals 'S', 'B', and 'A'. It reads an input string and parses it to check if it's accepted by the grammar. The result is either "Accepted" or "Rejected."

3. **remove-left-recursion.cpp**:

    This C++ program deals with removing left recursion from a context-free grammar. It reads a context-free grammar from an input file, stores it in a map data structure, and then removes left recursion using the `removeLeftRecursion()` function. The result is printed as the modified context-free grammar.

Each of these programs is focused on a specific aspect of context-free grammars and language processing, such as left factoring, recursive descent parsing, and left recursion removal. You can run these programs with appropriate input files to see their functionality in action.