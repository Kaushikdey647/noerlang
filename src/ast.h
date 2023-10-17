#ifndef AST_H
#define AST_H

struct ASTNode {
    char type;
    int value;
    struct ASTNode* left;
    struct ASTNode* right;
};

struct ASTNode* create_unary_op_node(char type, struct ASTNode* left);
struct ASTNode* create_binary_op_node(char type, struct ASTNode* left, struct ASTNode* right);
struct ASTNode* create_number_node(int value);
void print_ast(struct ASTNode* node, int depth);
void free_ast(struct ASTNode* node);

#endif