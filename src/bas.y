%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #include "lex.yy.c"

    void yyerror(const char *s);
    int yylex();
    int yywrap();
%}

%token INT_TYPE FLOAT_TYPE CHAR_TYPE STRING_TYPE INTEGER FLOATING STRING IF ELSE WHILE BREAK RETURN ASSIGN IDENTIFIER LOGICAL NEGATION RELATIONAL ADDITIVE MULTIPLICATIVE UNARY TRUE FALSE STATIC THEN

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

var_declaration: type_specifier var_decl_list ';'
;

scoped_var_declaration: STATIC type_specifier var_decl_list ';'
| type_specifier var_decl_list ';'
;

var_decl_list: var_decl_list ',' var_decl_init
| var_decl_init
;

var_decl_init: var_decl_id
| var_decl_id '=' simple_exp
;

var_decl_id: IDENTIFIER
| IDENTIFIER '[' INTEGER ']'
;

type_specifier: INT_TYPE
| FLOAT_TYPE
| CHAR_TYPE
| STRING_TYPE
;

fun_declaration: type_specifier IDENTIFIER '(' params ')' stmt
| IDENTIFIER '(' params ')' stmt
;

params: param_list
| 
;

param_list: param_list ';' param_type
| param_type
;

param_type: type_specifier param_id
;

param_id: IDENTIFIER
| IDENTIFIER '[' ']'
;

stmt: expression_stmt
| compound_stmt
| selection_stmt
| iteration_stmt
| return_stmt
| break_stmt
;

expression_stmt: expression ';'
| ';'
;

compound_stmt: '{' local_declarations stmt_list '}'
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

iteration_stmt: WHILE '(' expression ')' stmt
;

return_stmt: RETURN ';'
| RETURN expression ';'
;

break_stmt: BREAK ';'
;

expression: mutable ASSIGN expression
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
| IDENTIFIER '[' expression ']'
;

immutable: '(' expression ')'
| call
| const
;

call: IDENTIFIER '(' args ')'
;

args: arg_list
| 
;

arg_list: arg_list ',' expression
| expression
;

const: INTEGER
| FLOATING
| STRING
| TRUE
| FALSE
;

%%

int main(){
    yyparse();
}

void yyerror(const char *msg){
    fprintf(stderr, "%s\n", msg);
}