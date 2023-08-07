#include "dfa.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_TOKENS 256

typedef struct token {
    char* label;
    char* value;
} token;

token tokens[MAX_TOKENS];
int token_counter = 0;

void add_tokens(char* label, char* value){
    tokens[token_counter].label = label;
    tokens[token_counter].value = value;
    token_counter++;
}

void print_tokens(){
    for(int i = 0; i < token_counter; i++){
        printf("(%s: %s)\n", tokens[i].value, tokens[i].label);
    }
}

void tokenize(char* str, dfa* dfa_list, int dfa_num){
    int i = 0;
    // i f x   = 1  /0
    // 0 1 2 3 4 5   6
    //initialize the states for all dfas
    int* states = malloc(sizeof(int) * dfa_num);
    int* last_reset = malloc(sizeof(int) * dfa_num);

    int best_candidate = -1;
    int best_prefix_length = 0;

    for(int j = 0; j < dfa_num; j++){
        states[j] = 0;
        last_reset[j] = 0;
    }

    //iterate through the string
    while( str[i] != '\0'){
        
        //iterate through the dfas and update the curent states
        for(int j = 0; j < dfa_num; j++){

            states[j] = dfa_list[j].transitions[states[j]][(int)str[i]];

            //if states[j] is -1, reset it to 0
            if( states[j] == -1 ){
                states[j] = 0;
                last_reset[j] = i;
            }

            //is states[j] an accepting state?
            else if( states[j] == dfa_list[j].accept_state ){

                //check if the token is longer than the current best candidate
                int token_length = i - last_reset[j];


                if( token_length > best_prefix_length ){
                    best_candidate = j;
                    best_prefix_length = token_length;
                }
                else if( token_length == best_prefix_length ){
                    if( dfa_list[j].priority > dfa_list[best_candidate].priority ){
                        best_candidate = j;
                        best_prefix_length = token_length;
                    }
                }

                //reset the state
                states[j] = 0;
                last_reset[j] = i;

            }

        }

        //if best_candidate is not -1
        if( best_candidate != -1 ){
            
            //if retracting, then retract
            i -= dfa_list[best_candidate].retracting;

            //add the token
            char* value = malloc(sizeof(char) * (best_prefix_length + 1));
            strncpy(value, str + last_reset[best_candidate], best_prefix_length);
            value[best_prefix_length] = '\0';
            add_tokens(dfa_list[best_candidate].label, value);

            //reset all the states
            for(int j = 0; j < dfa_num; j++){
                states[j] = 0;
                last_reset[j] = i;
            }

            //reset the best candidate
            best_candidate = -1;
            best_prefix_length = 0;
            
        }

        i += 1;

    }
}

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


