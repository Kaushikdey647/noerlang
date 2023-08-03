#include <stddef.h>
#include <stdlib.h>
#include <string.h>

#include "trie.h"

trie_node* create_node(){
    trie_node* node = (trie_node*)malloc(sizeof(trie_node));
    node->token_type = NULL;
    node->is_end = 0;
    for(int i=0; i<MAX_ASCII; i++){
        node->children[i] = NULL;
    }
    return node;
}

void insert_token(trie_node* root, char* token_type, const char* token){
    trie_node* curr = root;
    for(size_t i=0; i<strlen(token); i++){
        if(curr->children[(int)token[i]] == NULL){
            curr->children[(int)token[i]] = create_node();
        }
        curr = curr->children[(int)token[i]];
    }
    curr->is_end = 1;
    curr->token_type = token_type;
}

trie_node* search_token(trie_node* root, char* token){
    trie_node* curr = root;
    for(size_t i=0; i<strlen(token); i++){
        if(curr->children[(int)token[i]] == NULL){
            return NULL;
        }
        curr = curr->children[(int)token[i]];
    }
    if(curr->is_end == 1){
        return curr;
    }
    return NULL;
}

void delete_token(trie_node* root, char* token){
    trie_node* curr = root;
    for(size_t i=0; i<strlen(token); i++){
        if(curr->children[(int)token[i]] == NULL){
            return;
        }
        curr = curr->children[(int)token[i]];
    }
    if(curr->is_end == 1){
        curr->is_end = 0;
        curr->token_type = NULL;
    }
}

void delete_trie(trie_node* root){
    if(root == NULL){
        return;
    }
    for(int i=0; i<MAX_ASCII; i++){
        delete_trie(root->children[i]);
    }
    free(root);
}