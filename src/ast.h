#ifndef AST_H
#define AST_H

typedef struct ASTNode {
    char type;
    int value;
    struct ASTNode* left;
    struct ASTNode* right;
} ASTNode;

ASTNode* create_unary_op_node(char type, ASTNode* left);
ASTNode* create_binary_op_node(char type, ASTNode* left, ASTNode* right);
ASTNode* create_number_node(int value);
void print_ast(ASTNode* node, int depth);
void free_ast(ASTNode* node);

#endif