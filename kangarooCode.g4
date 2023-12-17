grammar kangarooCode;
/** The start rule; begin parsing here. */
program:      (declaration|statement|clazz)* ;
declaration:  'int' NAME SEMICOLON ;
statement:    ifstmt
		|     printstmt
		|     returnstmt
		|     assignstmt
		;	
assignstmt:   NAME '=' expression SEMICOLON
		|     'String' assignstmt
		;
ifstmt:       IF '(' identifier '==' expression ')' (statement)+ ENDIF ;
printstmt:    'print' term SEMICOLON ;
returnstmt:   'return' expression SEMICOLON ;
expression:   term 
		|     (term OPERATOR)+ term
		;
term:         identifier
		|     integer
		;
identifier:   NAME
		|     STRING
		;
clazz:        CLASS identifier OPEN_CURL body CLOSE_CURL ;
body:         declaration method
	    |     (statement)+ (clazz|block)
		;
method:       'int' identifier '()' block ;
block:        OPEN_CURL (statement|block) CLOSE_CURL ;
integer:      INT ;
//Lexer Rules
IF         : 'if' ;               // literal match to 'if'
ENDIF      : 'endif' ;            // literal match to 'endif'
SEMICOLON  : ';' ;                // literal match to a semicolon ';'
OPEN_CURL  : '{' ;                // literal match to an open curly brace '{'
CLOSE_CURL : '}' ;                // literal match to a close curly brace '}'
CLASS      : 'class' ;            // literal match to 'class'
INT        : [0-9] ;              // match 1 digit integers
OPERATOR   : [+\-*/] ;            // match 1 of a set of operators
STRING     : '"'[a-zA-Z ]+'"';    // match quoted strings made of only letters with 1 or more words
NAME       : [a-zA-Z]+ ;          // match a single word made of only letters
WS         : [ \t\n\r]+ ->skip ;  // toss out whitespace