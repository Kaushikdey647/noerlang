#ifndef AST_H
#define AST_H

typedef struct ASTNode {
    char type;
    int value;
    struct ASTNode* left;
    struct ASTNode* right;
} ASTNode;

ASTNode* create_number_node(int value);
ASTNode* create_add_node(ASTNode* left, ASTNode* right);
ASTNode* create_subtract_node(ASTNode* left, ASTNode* right);
ASTNode* create_multiply_node(ASTNode* left, ASTNode* right);
ASTNode* create_divide_node(ASTNode* left, ASTNode* right);

void free_ast(ASTNode* node);

#endif