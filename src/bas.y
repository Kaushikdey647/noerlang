%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include<ctype.h>
    #include "lex.yy.c"
    int complete_flag = 0;
    void yyerror(const char *s);
    int yylex();
    int yywrap();
%}

%union {
    int int_val;
    float float_val;
    char *str_val;
}

%token AND ASSIGN COLON COMMA DEF DIV DOT ELSE END
EQ EXITLOOP FLOAT FLOAT_CONST FORMAT FROM FUN GE
GLOBAL GT ID IF INT INT_CONST LEFT_PAREN LEFT_SQ_BKT
LE LT MINUS MOD MULT NE NOT NUL OR PLUS PRINT PRODUCT
READ RETURN RETURNS RIGHT_PAREN RIGHT_SQ_BKT SEMICOLON
SKIP STEP STRING TO WHILE

%left PLUS MINUS
%left MULT DIV MOD
%nonassoc DOT
%left AND OR
%nonassoc UNARY
%right UPLUS UMINUS
%nonassoc NOT

%start s

%%

s: prog {
    complete_flag = 1;
    return 0;
}

prog: GLOBAL declList stmtList END
    ;

declList: decl declList
    | /* empty */
    ;

decl: DEF typeList END
    | FUN funDef END
    ;

typeList: typeList SEMICOLON varList COLON type
    | varList COLON type
    | typeDef
    ;

varList: var COMMA varList
    | var
    ;

var: ID sizeListO
    ;

sizeListO: sizeList
    | /* empty */
    ;

sizeList: sizeList LEFT_SQ_BKT INT_CONST RIGHT_SQ_BKT
    | LEFT_SQ_BKT INT_CONST RIGHT_SQ_BKT
    ;

type: INT
    | FLOAT
    | STRING
    | NUL
    | typeDef
    | ID
    ;

typeDef: ID ASSIGN PRODUCT typeList END
    ;

funDef: funID fparamListO RETURNS type funBody
    ;

funID: ID
    ;

fparamListO: fparamList
    | /* empty */
    ;

fparamList: fparamList SEMICOLON pList COLON type
    | pList COLON type
    ;

pList: pList COMMA idP
    | idP
    ;

idP: ID sizeListO
    ;

funBody: declList stmtListO
    ;

stmtListO: stmtList
    | /* empty */
    ;

stmtList: stmtList SEMICOLON stmt
    | stmt
    ;

stmt: assignmentStmt
    | readStmt
    | printStmt
    | ifStmt
    | whileStmt
    | loopStmt
    | callStmt
    | returnStmt
    | exitLoop
    | skip
    ;

assignmentStmt: dotId ASSIGN exp
    ;

dotId: id
    | id DOT dotId
    ;

readStmt: READ FORMAT exp
    ;

printStmt: PRINT STRING
    | PRINT FORMAT exp
    ;

ifStmt: IF bExp COLON stmtList elsePart END
    ;

elsePart: ELSE stmtList
    | /* empty */
    ;

whileStmt: WHILE bExp COLON stmtList END
    ;

loopStmt: FROM id ASSIGN exp TO exp stepPart COLON stmtListO END
    ;

stepPart: STEP exp
    | 
    ;

callStmt: LEFT_PAREN ID COLON actParamList RIGHT_PAREN
    ;

returnStmt: RETURN expO
    ;

expO: exp
    | /* empty */
    ;

exitLoop: EXITLOOP
    ;

skip: SKIP
    ;

id: ID indxListO
    ;

indxListO: indxList
    | /* empty */
    ;

indxList: indxList LEFT_SQ_BKT exp RIGHT_SQ_BKT
    | LEFT_SQ_BKT exp RIGHT_SQ_BKT
    ;

bExp: bExp OR bExp
    | bExp AND bExp
    | NOT bExp
    | LEFT_PAREN bExp RIGHT_PAREN
    | exp relOP exp
    ;

relOP: EQ
    | LE
    | LT
    | GE
    | GT
    | NE
    ;

exp: exp PLUS exp
    | exp MINUS exp
    | exp MULT exp
    | exp DIV exp
    | exp MOD exp
    | MINUS exp %prec UNARY
    | PLUS exp %prec UNARY
    | exp DOT exp
    | LEFT_PAREN exp RIGHT_PAREN
    | id
    | LEFT_PAREN ID COLON actParamListO RIGHT_PAREN
    | INT_CONST
    | FLOAT_CONST
    ;

actParamListO: actParamList
    | /* empty */
    ;

actParamList: actParamList COMMA exp
    | exp
    ;

%%

extern FILE* yyin;  // Declare the input file pointer

void yyerror(const char *msg){
    fprintf(stderr, " [ line: %d ] %s at at token %s \n", yylineno, msg, yytext);
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return 1;
    }

    // Open the input file
    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("Error opening input file");
        return 1;
    }

    yyparse();  // Run the parser on the input file

    if(complete_flag){
        printf("Program Executed Succesfully\n");
    }
    else{
        printf("Invalid Program Structure / Semantic Error\n");
    }

    fclose(yyin);  // Close the input file
    return 0;
}