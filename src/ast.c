// ast.c
#include <stdio.h>
#include <stdlib.h>
#include "ast.h"

ASTNode* create_number_node(int value) {
    ASTNode* node = (ASTNode*)malloc(sizeof(ASTNode));
    node->type = "Number";
    node->value = value;
    node->left = NULL;
    node->right = NULL;
    return node;
}

ASTNode* create_add_node(ASTNode* left, ASTNode* right) {
    ASTNode* node = (ASTNode*)malloc(sizeof(ASTNode));
    node->type = "Add";
    node->left = left;
    node->right = right;
    return node;
}

ASTNode* create_subtract_node(ASTNode* left, ASTNode* right) {
    ASTNode* node = (ASTNode*)malloc(sizeof(ASTNode));
    node->type = "Subtract";
    node->left = left;
    node->right = right;
    return node;
}

ASTNode* create_multiply_node(ASTNode* left, ASTNode* right) {
    ASTNode* node = (ASTNode*)malloc(sizeof(ASTNode));
    node->type = "Multiply";
    node->left = left;
    node->right = right;
    return node;
}

ASTNode* create_divide_node(ASTNode* left, ASTNode* right) {
    ASTNode* node = (ASTNode*)malloc(sizeof(ASTNode));
    node->type = "Divide";
    node->left = left;
    node->right = right;
    return node;
}

void free_ast(ASTNode* node) {
    if (node == NULL) {
        return;
    }
    free_ast(node->left);
    free_ast(node->right);
    free(node);
}
