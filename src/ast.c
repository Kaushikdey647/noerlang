#include <stdio.h>
#include <stdlib.h>
#include "ast.h"

struct ASTNode* create_number_node(int value) {
    struct ASTNode* node = (struct ASTNode*)malloc(sizeof(struct ASTNode));
    node->type = 'N';
    node->value = value;
    node->left = NULL;
    node->right = NULL;
    return node;
}

struct ASTNode* create_unary_op_node(char type, struct ASTNode* left) {
    struct ASTNode* node = (struct ASTNode*)malloc(sizeof(struct ASTNode));
    node->type = type;
    node->value = 0;
    node->left = left;
    node->right = NULL;
    return node;
}

struct ASTNode* create_binary_op_node(char type, struct ASTNode* left, struct ASTNode* right) {
    struct ASTNode* node = (struct ASTNode*)malloc(sizeof(struct ASTNode));
    node->type = type;
    node->value = 0;
    node->left = left;
    node->right = right;
    return node;
}

void print_ast(struct ASTNode* node, int depth) {
    if (node == NULL) {
        return;
    }

    // Indent based on the depth in the tree
    for (int i = 0; i < depth; i++) {
        printf("...");
    }

    if (node != NULL) {
        printf("%c[%d]\n", node->type, node->value);
    } else {
        printf("NULL\n");
    }

    print_ast(node->left, depth + 1);
    print_ast(node->right, depth + 1);
}

void free_ast(struct ASTNode* node) {
    if (node == NULL) {
        return;
    }
    free_ast(node->left);
    free_ast(node->right);
    free(node);
}
