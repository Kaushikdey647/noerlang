#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "dag.h"

struct DAGNode* generate_dag_node(struct ASTNode* astNode) {
    struct DAGNode* dagNode = (struct DAGNode*) malloc(sizeof(struct DAGNode));
    dagNode->type = astNode->type;
    dagNode->value = astNode->value;
    dagNode->left = NULL;
    dagNode->right = NULL;
    return dagNode;
}

struct DAGHashMap* create_hash_map(){
    struct DAGHashMap* dagHashMap = (struct DAGHashMap*) malloc(sizeof(struct DAGHashMap));
    for (int i = 0; i < TABLE_SIZE; i++) {
        dagHashMap->table[i] = NULL;
    }
    return dagHashMap;
}

int hash_value(int value) {
    // A simple hash function that takes the modulo of the value with the table size
    return value % TABLE_SIZE;
}

struct DAGNode* insert_dag(struct DAGHashMap* dagHashMap, struct ASTNode* astNode) {
    int hash = hash_value(astNode->value);
    struct DAGListNode* curr = dagHashMap->table[hash];
    while (curr != NULL) {
        if (curr->dag->value == astNode->value && curr->dag->type == astNode->type) {
            // If the value and type already exist in the hash map, return 0 to indicate failure
            return curr->dag;
        }
        curr = curr->next;
    }
    // If the value does not exist in the hash map, insert it and return 1 to indicate success
    struct DAGListNode* newNode = (struct DAGListNode*) malloc(sizeof(struct DAGListNode));
    struct DAGNode* dagNode = generate_dag_node(astNode);
    newNode->dag = dagNode;
    newNode->next = dagHashMap->table[hash];
    dagHashMap->table[hash] = newNode;
    return dagNode;
}

void delete_dag(struct DAGNode* dagNode) {
    if (dagNode == NULL) {
        return;
    }
    delete_dag(dagNode->left);
    delete_dag(dagNode->right);
    free(dagNode);
}

void delete_hash_map(struct DAGHashMap* dagHashMap) {
    for (int i = 0; i < TABLE_SIZE; i++) {
        struct DAGListNode* curr = dagHashMap->table[i];
        while (curr != NULL) {
            struct DAGListNode* temp = curr;
            curr = curr->next;
            delete_dag(temp->dag);
            free(temp);
        }
    }
}

struct DAGNode* create_dag_from_ast(struct ASTNode* root, struct DAGHashMap* dagHashMap) {
    if (root == NULL) {
        return NULL;
    }
    struct DAGNode* left = create_dag_from_ast(root->left, dagHashMap);
    struct DAGNode* right = create_dag_from_ast(root->right, dagHashMap);
    struct DAGNode* dagNode = insert_dag(dagHashMap, root);
    dagNode->left = left;
    dagNode->right = right;
    return dagNode;
}

void visualize_dag(struct DAGNode* root) {
    if (root == NULL) {
        return;
    }
    printf("%d [label=\"%d\"];\n", root->value, root->value);
    if (root->left != NULL) {
        printf("%d -> %d [label=\"left\"];\n", root->value, root->left->value);
        visualize_dag(root->left);
    }
    if (root->right != NULL) {
        printf("%d -> %d [label=\"right\"];\n", root->value, root->right->value);
        visualize_dag(root->right);
    }
}
