%{
#include <string.h>
#include "parser.tab.h"
void yyerror(const char *s);
%}

%option noyywrap

%%

"let"           { return LET; }
"print"         { return PRINT; }
"input"         { return INPUT; }
"if"            { return IF; }
"else"          { return ELSE; }
"unless"        { return UNLESS; }
"while"         { return WHILE; }

[a-zA-Z_][a-zA-Z0-9_]* { 
    yylval.sval = strdup(yytext); 
    return IDENTIFIER; 
}

[0-9]+(\.[0-9]+)? { 
    yylval.fval = atof(yytext); 
    return NUMBER; 
}

\"([^\"\\]|\\.)*\" {
    yylval.sval = strdup(yytext);
    return STRING;
}

"=="            { return EQ; }
"!="            { return NEQ; }
"<="            { return LE; }
">="            { return GE; }
"<"             { return LT; }
">"             { return GT; }

"//"[^\n]*      ; /* Skip line comments */
[ \t\n\r]+      ; /* Skip whitespace */
.               { return yytext[0]; }

%%
