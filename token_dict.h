#include "tokens.h"
#include "trie.h"

#ifndef LEXER_H

#define LEXER_H

typedef struct token_dict_t{
    trie_node* root;
    trie_node* pointer;
    char* flag;
} token_dict_t;

token_dict_t init_dictionary();

int reset_pointer(token_dict_t* lexer);

int advance_pointer(token_dict_t* lexer, char c);

#endif