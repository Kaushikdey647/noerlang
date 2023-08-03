#include <stddef.h>

#include "tokens.h"
#include "trie.h"
#include "token_dict.h"

token_dict_t init_dictionary(){

    trie_node* root = create_node();

    // Add the keywords
    for(int i = 0; i < MAX_KEYWORDS; i++){
        if(!keywords[i]) break;
        insert_token(root, "KEYWORD", keywords[i]);
    }

    // Add the arithmetic operators
    for(int i = 0; i < MAX_ARITHMETIC_OPS; i++){
        if(!arithmetic_ops[i]) break;
        insert_token(root, "ARITHMETIC_OP", arithmetic_ops[i]);
    }

    // Add the relational operators
    for(int i = 0; i < MAX_RELATIONAL_OPS; i++){
        if(!relational_ops[i]) break;
        insert_token(root, "RELATIONAL_OP", relational_ops[i]);
    }

    // generate token_dict_t

    token_dict_t dict_ptr;

    dict_ptr.root = root;
    dict_ptr.pointer = root;
    dict_ptr.flag = NULL;

    return dict_ptr;
}

int reset_pointer(token_dict_t* dict_ptr){
    dict_ptr->pointer = dict_ptr->root;
    dict_ptr->flag = NULL;
    return 0;
}

int advance_pointer(token_dict_t* dict_ptr, char c){

    if(dict_ptr->pointer->children[(int)c] == NULL){
        
        //invalid character, reset pointer
        reset_pointer(dict_ptr);
        return -1;

    }

    dict_ptr->pointer = dict_ptr->pointer->children[(int)c];

    if(dict_ptr->pointer->is_end){

        dict_ptr->flag = dict_ptr->pointer->token_type;
        return 1;

    }

    return 0;
}