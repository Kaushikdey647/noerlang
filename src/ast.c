#include <stdio.h>
#include <stdlib.h>
#include "ast.h"

ASTNode* create_number_node(int value) {
    ASTNode* node = (ASTNode*)malloc(sizeof(ASTNode));
    node->type = 'N';
    node->value = value;
    node->left = NULL;
    node->right = NULL;
    return node;
}

ASTNode* create_unary_op_node(char type, ASTNode* left) {
    ASTNode* node = (ASTNode*)malloc(sizeof(ASTNode));
    node->type = type;
    node->value = 0;
    node->left = left;
    node->right = NULL;
    return node;
}

ASTNode* create_binary_op_node(char type, ASTNode* left, ASTNode* right) {
    ASTNode* node = (ASTNode*)malloc(sizeof(ASTNode));
    node->type = type;
    node->value = 0;
    node->left = left;
    node->right = right;
    return node;
}

void print_ast(ASTNode* node, int depth) {
    if (node == NULL) {
        return;
    }

    // Indent based on the depth in the tree
    for (int i = 0; i < depth; i++) {
        printf("  ");
    }

    if (node->type != NULL) {
        printf("%s", node->type);
        if (strcmp(node->type, "Number") == 0) {
            printf("(%d)\n", node->value);
        } else {
            printf("\n");
        }
    } else {
        printf("NULL\n");
    }

    print_ast(node->left, depth + 1);
    print_ast(node->right, depth + 1);
}

void free_ast(ASTNode* node) {
    if (node == NULL) {
        return;
    }
    free_ast(node->left);
    free_ast(node->right);
    free(node);
}
