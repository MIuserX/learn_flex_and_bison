%{
    int chars = 0;
    int words = 0;
    int lines = 0;
%}
%%
[a-zA-Z]+  { words++; chars+=strlen(yytext); }
\n         { chars++; lines++; }
.          { chars++; }
%%
int main(int argc, char **argv) {
    FILE * fp;

    if ( argc > 1 ) {
        fp = fopen(argv[1], "r");
        if ( fp == NULL ) {
            fprintf(stderr, "open `%s` failed, err=`%s`\n", argv[1], strerror(errno));
            return 1;
        }
        yyin = fp;
    }

    yylex();
    printf("chars=%d, words=%d, lines=%d\n", chars, words, lines);
    return 0;
}
