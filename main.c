#include <stdio.h>
#include"lexer/tokens.h"
#include"lexer/token_dict.h"
#include"lexer/trie.h"


void main(){
    token_dict_t dict = init_dictionary();
    printf("Success\n");
}