%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);

// Simple symbol table for variables
struct Symbol {
    char name[50];
    double value;
};
struct Symbol symtab[100];
int symcount = 0;

void set_val(char *name, double val) {
    for(int i = 0; i < symcount; i++) {
        if(strcmp(symtab[i].name, name) == 0) {
            symtab[i].value = val;
            return;
        }
    }
    strcpy(symtab[symcount].name, name);
    symtab[symcount].value = val;
    symcount++;
}

double get_val(char *name) {
    for(int i = 0; i < symcount; i++) {
        if(strcmp(symtab[i].name, name) == 0) {
            return symtab[i].value;
        }
    }
    fprintf(stderr, "Undefined variable: %s\n", name);
    return 0.0;
}
%}

%union {
    double fval;
    char *sval;
}

%token <sval> IDENTIFIER STRING
%token <fval> NUMBER
%token LET PRINT INPUT IF ELSE UNLESS WHILE EQ NEQ LE GE LT GT

%type <fval> expr

%left '+' '-'
%left '*' '/'
%nonassoc EQ NEQ LT GT LE GE

%%

program:
    /* empty */
    | program statement
    ;

statement:
    LET IDENTIFIER '=' expr ';' { set_val($2, $4); }
    | IDENTIFIER '=' expr ';' { set_val($1, $3); }
    | PRINT expr ';' { printf("%.2f\n", $2); }
    | PRINT STRING ';' { 
        char *str = $2;
        str[strlen(str)-1] = '\0';
        printf("%s\n", str + 1); 
    }
    | IF '(' expr ')' '{' program '}' { }
    | UNLESS '(' expr ')' '{' program '}' { }
    | WHILE '(' expr ')' '{' program '}' { }
    ;

expr:
    NUMBER          { $$ = $1; }
    | IDENTIFIER    { $$ = get_val($1); }
    | expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr { $$ = $1 / $3; }
    | expr EQ expr  { $$ = ($1 == $3); }
    | expr NEQ expr { $$ = ($1 != $3); }
    | expr LT expr { $$ = ($1 < $3); }
    | expr GT expr { $$ = ($1 > $3); }
    | '(' expr ')'  { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("AuraScript v1.0 Interpreter Initialized.\n");
    yyparse();
    return 0;
}