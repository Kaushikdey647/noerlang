#include "tokens.h"

//Keyword specifications
/**
 * @brief Keyword structure
 * 
 * The words written here will be as spoken by senor Kaushik Dey on 02-08-2023 and
 * will be used to identify the keywords in the input string. All decisions taken here
 * are full and final and will be implemented with an iron fist.
 * 
 * Keyword List
 * 
 * 1. var
 * 2. func
 * 3. if
 * 4. elseif
 * 5. else
 * 6. while
 * 7. for
 * 8. foreach
 * 9. switch
*/

const char* keywords[MAX_KEYWORDS] = {
    "var",
    "func",
    "if",
    "elseif",
    "else",
    "while",
    "for",
    "foreach",
    "switch",
     "break",      
    "continue",    
    "return",      
    "true",        
    "false",       
    "null",       
    // ADD MORE IF NEEDED
};

const char* arithmetic_ops[MAX_ARITHMETIC_OPS] ={
    "+",
    "-",
    "*",
    "/",
    "%",
    "^",   
    "++",  
    "--",  
    // ADD MORE IF NEEDED
};

const char* relational_ops[MAX_RELATIONAL_OPS] ={
    "==",
    "<>",
    ">",
    "<",
    ">=",
    "<=",
    "!=",  
    "&&",  
    "||",  
    // ADD MORE IF NEEDED
};