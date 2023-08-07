#ifndef AUTOMATA_H

#define AUTOMATA_H

#define MAX_STATES 256
#define MAX_SYMBOLS 256

typedef struct dfa {
    int start_state;
    int accept_state;
    int retracting;
    char* label;
    int transitions[MAX_STATES][MAX_SYMBOLS];
} dfa;

dfa identifier_automaton();

dfa integer_automaton();

dfa float_automaton();

dfa if_automaton();

dfa elsif_automaton();

dfa else_automaton();

dfa relop_automaton();

#endif