
#include "ast.h"

#define TABLE_SIZE 1000

struct DAGNode {
    char type;
    int value;
    struct DAGNode* left;
    struct DAGNode* right;
};

struct DAGListNode {
    struct DAGNode* dag;
    struct DAGListNode* next;
};

struct DAGHashMap {
    struct DAGListNode* table[TABLE_SIZE];
};

struct DAGHashMap* create_hash_map();

struct DAGNode* generate_dag_node(
    struct ASTNode* astNode
);

int hash_value(
    int value
);

struct DAGNode* insert_dag(
    struct DAGHashMap* dagHashMap,
    struct ASTNode* astNode
);

void delete_dag(
    struct DAGNode* dagNode
);

void delete_hash_map(
    struct DAGHashMap* dagHashMap
);

struct DAGNode* create_dag_from_ast(
    struct ASTNode* root,
    struct DAGHashMap* dagHashMap
);

void visualize_dag(
    struct DAGNode* root
);

