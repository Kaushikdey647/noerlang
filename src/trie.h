#include "tokens.h"

#ifndef TRIE_H

#define TRIE_H

/**
 * @brief Trie structure to store tokens
*/
typedef struct trie_node{
    char* token_type;
    struct trie_node* children[MAX_ASCII];
    int is_end;
} trie_node;

trie_node* create_node();

void insert_token(trie_node* root, char* token_type, const char* token);

trie_node* search_token(trie_node* root, char* token);

void delete_token(trie_node* root, char* token);

void delete_trie(trie_node* root);

#endif