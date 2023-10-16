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

/* KEYWORDS */
%token RETURN IF ELSE WHILE FOR BREAK CONTINUE FUNCTION CLASS

/* DATA TYPES */
%token INT8_T INT16_T INT32_T INT64_T INT128_T CHAR_T FLOAT16_T FLOAT32_T FLOAT64_T FLOAT128_T BOOL_T VOID_T

/* ASSIGNMENT */
%token ASSIGN

/* LOGICAL OPERATORS */
%token EQ NEQ GT LT GE LE AND OR NOT

/* BITWISE OPERATORS */
%token BWAND BWOR BWNOT BWXOR BWSHL BWSHR

/* ARITHMETIC OPERATORS */
%token PLUS MINUS MUL DIV MOD

/* UNARY ARITHMETIC */
%token INC DEC

/* OTHER OPERATORS */
%token LPAREN RPAREN LBRACE RBRACE LBRACKET RBRACKET SEMICOLON COMMA DOT COLON QUESTION

/* IDENTIFIERS */
%token IDENTIFIER

/* LITERALS */
%token INTEGER_LITERAL FLOAT_LITERAL CHAR_LITERAL SCIENTIFIC_NOTATION STRING_LITERAL

/* NON-TERMINALS */
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%start program

%%

// EXTERNAL STRUCTURE

program: declaration_list
;

declaration_list: declaration_list declaration_statement
| declaration_statement
;

declaration_statement: function_declaration
| variable_declaration
| class_declaration
;

// VARIABLES

variable_declaration: type_specifier IDENTIFIER SEMICOLON
| type_specifier IDENTIFIER ASSIGN expression SEMICOLON
| IDENTIFIER ASSIGN expression SEMICOLON
;

// FUNCTIONS

function_declaration: type_specifier IDENTIFIER ASSIGN lambda_function
;

lambda_function: params compound_statement SEMICOLON
;

params: LPAREN parameter_list RPAREN

parameter_list: parameter_list COMMA parameter
| parameter
;

parameter: type_specifier IDENTIFIER
;

// CLASSESS

class_declaration: CLASS IDENTIFIER compound_statement SEMICOLON
;

// WHILE LOOP

while_statement: WHILE LPAREN logical_exp RPAREN compound_statement
;

// FOR LOOP

for_statement: FOR for_header compound_statement
;

for_header: LPAREN for_initializer SEMICOLON for_condition SEMICOLON for_iterator RPAREN
;

for_initializer: variable_declaration
| expression
;

for_condition: logical_exp
;

for_iterator: expression
;

// IF ELSE IF ELSE

if_else_statement: IF LPAREN logical_exp RPAREN compound_statement
| IF LPAREN logical_exp RPAREN compound_statement ELSE compound_statement
;

// STATEMENTS

compound_statement: LBRACE statement_list RBRACE
;

statement_list: statement_list statement
| statement
;

statement: declaration_statement
| assignment_statement
| for_statement
| while_statement
| if_else_statement
;

// ASSIGNMENTS

assignment_statement: type_specifier IDENTIFIER ASSIGN expression SEMICOLON
| IDENTIFIER ASSIGN expression SEMICOLON
| IDENTIFIER ASSIGN lambda_function SEMICOLON
;

// EXPRESSIONS

expression: IDENTIFIER
| const
| operation
| function
;

function: IDENTIFIER LPAREN argument_list RPAREN
| IDENTIFIER LPAREN RPAREN
;

argument_list: argument_list COMMA expression
| expression
;


operation: arithmetic_exp
| logical_exp
| bitwise_exp
| unary_exp
;

arithmetic_exp: expression PLUS expression
| expression MINUS expression
| expression MUL expression
| expression DIV expression
| expression MOD expression
;

logical_exp: expression EQ expression
| expression NEQ expression
| expression GT expression
| expression LT expression
| expression GE expression
| expression LE expression
| expression AND expression
| expression OR expression
| expression NOT expression
;

bitwise_exp: expression BWAND expression
| expression BWOR expression
| expression BWNOT expression
| expression BWXOR expression
| expression BWSHL expression
| expression BWSHR expression
;

unary_exp: expression INC
| expression DEC
| INC expression
| DEC expression
;

// DATA TYPES AND CONSTANTS

type_specifier: INT8_T
| INT16_T
| INT32_T
| INT64_T
| INT128_T
| FLOAT16_T
| FLOAT32_T
| FLOAT64_T
| FLOAT128_T
| CHAR_T
| BOOL_T
| VOID_T
;

const: INTEGER_LITERAL
| FLOAT_LITERAL
| CHAR_LITERAL
| STRING_LITERAL
| SCIENTIFIC_NOTATION
;
%%



int main(){
    yyparse();
}

void yyerror(const char *msg){
    fprintf(stderr, " [ line: %d ] %s at at token [ '%s' ] \n", yylineno, msg, yytext);
}