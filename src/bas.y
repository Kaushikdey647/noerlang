%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include<ctype.h>
    #include "lex.yy.c"

    void yyerror(const char *s);
    int yylex();
    int yywrap();
%}

%token INT_TYPE FLOAT_TYPE CHAR_TYPE
STRING_TYPE INTEGER FLOATING STRING
IF ELSE WHILE BREAK RETURN ASSIGN
IDENTIFIER LOGICAL NEGATION RELATIONAL
ADDITIVE MULTIPLICATIVE UNARY TRUE
FALSE STATIC THEN VOID CHAR
LPAREN RPAREN LBRACE RBRACE LBRACKET RBRACKET
COMMA SEMICOLON QUESTION DOT ARROW COLON REASSIGN

%%

/* HIGHER LEVEL PROGRAM GRAMMAR */
program: declaration_list
;

declaration_list: declaration_list declaration
| declaration
;

declaration: var_declaration
| fun_declaration
;

var_declaration: type_specifier var_decl_list SEMICOLON
;

scoped_var_declaration: STATIC type_specifier var_decl_list SEMICOLON
| type_specifier var_decl_list SEMICOLON
;

var_decl_list: var_decl_list COMMA var_decl_init
| var_decl_init
;

var_decl_init: var_decl_id
| var_decl_id ASSIGN simple_exp
;

var_decl_id: IDENTIFIER
| IDENTIFIER LBRACKET INTEGER RBRACKET
;

type_specifier: INT_TYPE
| FLOAT_TYPE
| CHAR_TYPE
| STRING_TYPE
;

fun_declaration: type_specifier IDENTIFIER LPAREN params RPAREN stmt
| IDENTIFIER LPAREN params RPAREN stmt
;

params: param_list
| 
;

param_list: param_list SEMICOLON param_type
| param_type
;

param_type: type_specifier param_id
;

param_id: IDENTIFIER
| IDENTIFIER LBRACKET RBRACKET
;

stmt: expression_stmt
| compound_stmt
| selection_stmt
| iteration_stmt
| return_stmt
| break_stmt
;

expression_stmt: expression SEMICOLON
| SEMICOLON
;

compound_stmt: LBRACE local_declarations stmt_list RBRACE
;

local_declarations: local_declarations scoped_var_declaration
| 
;

stmt_list: stmt_list stmt
| 
;

selection_stmt: IF simple_exp THEN stmt
| IF simple_exp THEN stmt ELSE stmt
;

iteration_stmt: WHILE LPAREN expression RPAREN stmt
;

return_stmt: RETURN SEMICOLON
| RETURN expression SEMICOLON
;

break_stmt: BREAK SEMICOLON
;

expression: mutable REASSIGN expression
| mutable ASSIGN expression
| simple_exp
;

simple_exp: simple_exp LOGICAL unary_rel_exp
| unary_rel_exp
;


unary_rel_exp: NEGATION rel_exp
| rel_exp
;

rel_exp: additive_exp RELATIONAL additive_exp
| additive_exp
;

additive_exp: additive_exp ADDITIVE multiplicative_exp
| multiplicative_exp
;

multiplicative_exp: multiplicative_exp MULTIPLICATIVE unary_exp
| unary_exp
;

unary_exp: UNARY unary_exp
| factor
;

factor: immutable
| mutable


mutable: IDENTIFIER
| IDENTIFIER LBRACKET expression RBRACKET
;

immutable: LPAREN expression RPAREN
| call
| const
;

call: IDENTIFIER LPAREN args RPAREN
;

args: arg_list
| 
;

arg_list: arg_list COMMA expression
| expression
;

const: INTEGER
| FLOATING
| STRING
| CHAR
| TRUE
| FALSE
| VOID
;

%%

int main(){
    yyparse();
}

void yyerror(const char *msg){
    fprintf(stderr, "%s at line %d \n", msg, yylineno);
}