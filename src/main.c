#include <stdio.h>
#include <string.h>
#include "tokens.h"
#include "token_dict.h"
#include "trie.h"


int main(){
    token_dict_t dict = init_dictionary();
    char* test = "if i == 0 statement1 elseif i == 1 statement2 else statement3";

    //Iterate through the string and advance the pointer, printing the token type when a token is found

    printf("Test string: %s\n", test);

    for(size_t i = 0; i < strlen(test); i++){
        printf("%c", test[i]);
        if(advance_pointer(&dict, test[i]) == 1){
            printf(":[%s]", dict.flag);
            reset_pointer(&dict);
        }
    }
    printf("\n");

    return 0;
}


