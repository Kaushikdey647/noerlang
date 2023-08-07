#include "dfa.h"
#include <stdlib.h>
#include <stdio.h>
// Automaton

/**
 * Identifier Automaton
 * 
 * Regex: [a-zA-Z][a-zA-Z0-9_]*
 * 
 * Number of States: 3
 * 
 * Start State: 0
 * 
 * Accepting States: {2}
 * 
 * Accepting Labels: {
 *  2: "IDENTIFIER"
 * }
*/
dfa identifier_automaton(){

    dfa automaton;
    
    automaton.start_state = 0; //start state
    automaton.accept_state = 2; //accepting state
    automaton.retracting = 1; //retracting dfa state
    automaton.label = "IDENTIFIER";
    automaton.priority = 1;

    //reset all transitions to -1
    for(int i = 0; i < MAX_STATES; i++){
        for(int j = 0; j < MAX_SYMBOLS; j++){
            automaton.transitions[i][j] = -1;
        }
    }

    //reset all transitions from a to z from 0 as 1
    for(char c = 'a' ; c <= 'z'; c++){
        automaton.transitions[0][(int)c] = 1;
    }
    //reset all transitions from A to Z from 0 as 1
    for(char c = 'A' ; c <= 'Z'; c++){
        automaton.transitions[0][(int)c] = 1;
    }

    //reset all transitions from 1 as 2
    for(int i = 0; i < MAX_SYMBOLS; i++){
        automaton.transitions[1][i] = 2;
    }

    //reset all transitions from 1 through A to Z as 1
    for(char c = 'A' ; c <= 'Z'; c++){
        automaton.transitions[1][(int)c] = 1;
    }
    //reset all transitions from 1 through a to z as 1
    for(char c = 'a' ; c <= 'z'; c++){
        automaton.transitions[1][(int)c] = 1;
    }
    //reset all transitions from 1 through 0 to 9 as 1
    for(char c = '0' ; c <= '9'; c++){
        automaton.transitions[1][(int)c] = 1;
    }
    //reset all transitions from 1 through _ as 1
    automaton.transitions[1]['_'] = 1;

    //return the automaton
    return automaton;

}

/**
 * Integer Automaton
 * 
 * Regex: [0-9]+
 * 
 * Number of States: 3
 * 
 * Start State: 0
 * 
 * Accepting States: {2}
 * 
 * Accepting Labels: {
 *  2: "INTEGER"
 * }
*/

dfa integer_automaton(){

    dfa automaton;
    
    automaton.start_state = 0; //start state
    automaton.accept_state = 2; //accepting state
    automaton.retracting = 1; //retracting dfa state
    automaton.label = "INTEGER";
    automaton.priority = 2;

    //reset all transitions to -1
    for(int i = 0; i < MAX_STATES; i++){
        for(int j = 0; j < MAX_SYMBOLS; j++){
            automaton.transitions[i][j] = -1;
        }
    }

    //reset all transitions from 0 through 9 from 0 as 1
    for(char c = '0' ; c <= '9'; c++){
        automaton.transitions[0][(int)c] = 1;
    }

    //reset all transitions from 1 through 0 to 9 as 1
    for(char c = '0' ; c <= '9'; c++){
        automaton.transitions[1][(int)c] = 1;
    }

    //stops at 2 if it sees ' ' or '\t' or '\n' or '\0' or relops or brackets
    automaton.transitions[1][(int)' '] = 2;
    automaton.transitions[1][(int)'\t'] = 2;
    automaton.transitions[1][(int)'\n'] = 2;
    automaton.transitions[1][(int)'\0'] = 2;
    automaton.transitions[1][(int)'='] = 2;
    automaton.transitions[1][(int)'<'] = 2;
    automaton.transitions[1][(int)'>'] = 2;
    automaton.transitions[1][(int)'('] = 2;
    automaton.transitions[1][(int)')'] = 2;
    automaton.transitions[1][(int)'{'] = 2;
    automaton.transitions[1][(int)'}'] = 2;


    //return the automaton
    return automaton;

}

/**
 * Acceptor for floats
 * 
 * Regex: [0-9]+.[0-9]+
 * 
 * Number of States: 4
 * 
 * Start State: 0
 * 
 * Accepting State: 3
 * 
 * Accepting Labels: {
 * 3: "FLOAT"
 * }
*/

dfa float_automaton(){

    dfa automaton;

    automaton.start_state = 0; //start state
    automaton.accept_state = 3; //accepting state
    automaton.retracting = 1; //retracting dfa state
    automaton.label = "FLOAT";
    automaton.priority = 2;

    //reset all transitions to -1
    for(int i = 0; i < MAX_STATES; i++){
        for(int j = 0; j < MAX_SYMBOLS; j++){
            automaton.transitions[i][j] = -1;
        }
    }

    //reset all transitions from 0 through 9 from 0 as 1
    for(char c = '0' ; c <= '9'; c++){
        automaton.transitions[0][(int)c] = 1;
    }

    //reset all transitions from 1 to 1
    for(char c = '0' ; c <= '9'; c++){
        automaton.transitions[1][(int)c] = 1;
    }

    //dot
    automaton.transitions[1][(int)'.'] = 2;

    //reset all transitions from 2 to 3
    for(char c = '0' ; c <= '9'; c++){
        automaton.transitions[2][(int)c] = 3;
    }

    //reset all transitions from 3 to 3
    for(char c = '0' ; c <= '9'; c++){
        automaton.transitions[3][(int)c] = 3;
    }

    //stops at 4 if it sees ' ' or '\t' or '\n' or '\0' or relops or brackets
    automaton.transitions[3][(int)' '] = 4;
    automaton.transitions[3][(int)'\t'] = 4;
    automaton.transitions[3][(int)'\n'] = 4;
    automaton.transitions[3][(int)'\0'] = 4;
    automaton.transitions[3][(int)'='] = 4;
    automaton.transitions[3][(int)'<'] = 4;
    automaton.transitions[3][(int)'>'] = 4;
    automaton.transitions[3][(int)'('] = 4;
    automaton.transitions[3][(int)')'] = 4;
    automaton.transitions[3][(int)'{'] = 4;
    automaton.transitions[3][(int)'}'] = 4;

    //return the automaton
    return automaton;
}

/**
 * Acceptor for if keyword
 * 
 * Regex: if
 * 
 * Number of States: 3
 * 
 * Start State: 0
 * 
 * Accepting State: 2
 * 
 * Accepting Labels: {
 * 2: "IF"
 * }
*/

dfa if_automaton(){

    dfa automaton;
    
    automaton.start_state = 0; //start state
    automaton.accept_state = 3; //accepting state
    automaton.retracting = 1; //retracting dfa state
    automaton.label = "IF";
    automaton.priority = 3;

    //reset all transitions to -1
    for(int i = 0; i < MAX_STATES; i++){
        for(int j = 0; j < MAX_SYMBOLS; j++){
            automaton.transitions[i][j] = -1;
        }
    }

    //reset all transitions from i as 1
    automaton.transitions[0][(int)'i'] = 1;

    //reset all transitions from f as 2
    automaton.transitions[1][(int)'f'] = 2;

    //reset all transitions from ' ' as 3
    automaton.transitions[2][(int)' '] = 3;

    //reset all transitions from '\t' as 3
    automaton.transitions[2][(int)'\t'] = 3;

    //reset all transitions from '\n' as 3
    automaton.transitions[2][(int)'\n'] = 3;

    //return the automaton
    return automaton;

}

/**
 * Acceptor for elsif keyword
 * 
 * Regex: elsif
 * 
 * Number of States: 5
 * 
 * Start State: 0
 * 
 * Accepting State: 4
*/

dfa elsif_automaton(){

    dfa automaton;
    
    automaton.start_state = 0; //start state
    automaton.accept_state = 4; //accepting state
    automaton.retracting = 1; //retracting dfa state
    automaton.label = "ELSIF";
    automaton.priority = 3;

    //reset all transitions to -1
    for(int i = 0; i < MAX_STATES; i++){
        for(int j = 0; j < MAX_SYMBOLS; j++){
            automaton.transitions[i][j] = -1;
        }
    }

    //reset all transitions from e as 1
    automaton.transitions[0][(int)'e'] = 1;

    //reset all transitions from l as 2
    automaton.transitions[1][(int)'l'] = 2;

    //reset all transitions from s as 3
    automaton.transitions[2][(int)'s'] = 3;

    //reset all transitions from i as 4
    automaton.transitions[3][(int)'i'] = 4;

    //reset all transitions from f as 5
    automaton.transitions[4][(int)'f'] = 5;

    //reset all transitions from ' ' as 6
    automaton.transitions[5][(int)' '] = 6;

    //reset all transitions from '\t' as 6
    automaton.transitions[5][(int)'\t'] = 6;

    //reset all transitions from '\n' as 6
    automaton.transitions[5][(int)'\n'] = 6;

    //return the automaton
    return automaton;

}

/**
 * Acceptor for else keyword
 * 
 * Regex: else
 * 
 * Number of States: 4
 * 
 * Start State: 0
 * 
 * Accepting State: 3
*/

dfa else_automaton(){

    dfa automaton;
    
    automaton.start_state = 0; //start state
    automaton.accept_state = 5; //accepting state
    automaton.retracting = 0; //retracting dfa state
    automaton.label = "ELSE";
    automaton.priority = 3;

    //reset all transitions to -1
    for(int i = 0; i < MAX_STATES; i++){
        for(int j = 0; j < MAX_SYMBOLS; j++){
            automaton.transitions[i][j] = -1;
        }
    }

    //reset all transitions from e as 1
    automaton.transitions[0][(int)'e'] = 1;

    //reset all transitions from l as 2
    automaton.transitions[1][(int)'l'] = 2;

    //reset all transitions from s as 3
    automaton.transitions[2][(int)'s'] = 3;

    //reset all transitions from 'e' as 4
    automaton.transitions[3][(int)'e'] = 4;

    //reset all transitions from ' ' as 5
    automaton.transitions[4][(int)' '] = 5;

    //reset all transitions from '\t' as 5
    automaton.transitions[4][(int)'\t'] = 5;

    //reset all transitions from '\n' as 5
    automaton.transitions[4][(int)'\n'] = 5;

    //return the automaton
    return automaton;

}

/**
 * Acceptor for 'then'
*/

dfa then_automaton(){

    dfa automaton;
    
    automaton.start_state = 0; //start state
    automaton.accept_state = 4; //accepting state
    automaton.retracting = 1; //retracting dfa state
    automaton.label = "THEN";
    automaton.priority = 3;

    //reset all transitions to -1
    for(int i = 0; i < MAX_STATES; i++){
        for(int j = 0; j < MAX_SYMBOLS; j++){
            automaton.transitions[i][j] = -1;
        }
    }

    //reset all transitions from t as 1
    automaton.transitions[0][(int)'t'] = 1;

    //reset all transitions from h as 2
    automaton.transitions[1][(int)'h'] = 2;

    //reset all transitions from e as 3
    automaton.transitions[2][(int)'e'] = 3;

    //reset all transitions from n as 4
    automaton.transitions[3][(int)'n'] = 4;

    //reset all transitions from ' ' as 5
    automaton.transitions[4][(int)' '] = 5;

    //reset all transitions from '\t' as 5
    automaton.transitions[4][(int)'\t'] = 5;

    //reset all transitions from '\n' as 5
    automaton.transitions[4][(int)'\n'] = 5;

    //return the automaton
    return automaton;

}

/**
 * Acceptor for relop
 * 
 * Regex: ==|<>|<=|>=|<|>
 * 
 * Number of States: 3
 * 
 * Start State: 0
 * 
 * Accepting State: 2
 * 
 * Accepting Labels: {
 * 2: "RELOP"
 * }
*/

dfa relop_automaton(){
    dfa automaton;

    automaton.start_state = 0; //start state
    automaton.accept_state = 8; //accepting state
    automaton.retracting = 1; //retracting dfa state
    automaton.label = "RELOP";
    automaton.priority = 3;

    //reset all transitions to -1
    for(int i = 0; i < MAX_STATES; i++){
        for(int j = 0; j < MAX_SYMBOLS; j++){
            automaton.transitions[i][j] = -1;
        }
    }

    // Phase 1
    automaton.transitions[0][(int)'='] = 1; //assignment
    automaton.transitions[0][(int)'<'] = 2; //less than
    automaton.transitions[0][(int)'>'] = 3; //greater than

    // Phase 2
    automaton.transitions[1][(int)'='] = 4; //equal to
    automaton.transitions[2][(int)'='] = 5; //less than or equal to
    automaton.transitions[3][(int)'='] = 6; //greater than or equal to
    automaton.transitions[2][(int)'>'] = 7; //not equal to

    // Phase 3: route to end of the automaton
    for(int i = 0; i < MAX_SYMBOLS; i++){
        automaton.transitions[1][i] = 8;
        automaton.transitions[2][i] = 8;
        automaton.transitions[3][i] = 8;
        automaton.transitions[4][i] = 8;
        automaton.transitions[5][i] = 8;
        automaton.transitions[6][i] = 8;
        automaton.transitions[7][i] = 8;
    }

    //return the automaton
    return automaton;
}