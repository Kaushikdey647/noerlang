#ifndef AST_H
#define AST_H

typedef struct ASTNode {
    char* type;      // Node type: "Number", "Add", "Subtract", "Multiply", "Divide"
    int value;       // For "Number" nodes, stores the numeric value
    struct ASTNode* left;   // Left child node
    struct ASTNode* right;  // Right child node
} ASTNode;

ASTNode* create_number_node(int value);
ASTNode* create_add_node(ASTNode* left, ASTNode* right);
ASTNode* create_subtract_node(ASTNode* left, ASTNode* right);
ASTNode* create_multiply_node(ASTNode* left, ASTNode* right);
ASTNode* create_divide_node(ASTNode* left, ASTNode* right);

void free_ast(ASTNode* node);

#endif