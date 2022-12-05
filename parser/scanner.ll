%{

#include "scanner.hh"
#include <cstdlib>

#define YY_NO_UNISTD_H

using token = yy::Parser::token;

#undef  YY_DECL
#define YY_DECL int Scanner::yylex( yy::Parser::semantic_type * const lval, yy::Parser::location_type *loc )

/* update location on matching */
#define YY_USER_ACTION loc->step(); loc->columns(yyleng);

%}

%option c++
%option yyclass="Scanner"
%option noyywrap

%%

%{
    yylval = lval;
%}


"fin"   {
    return token::END;
}

[0-9]+      {
    yylval->build<int>(std::atoi(yytext));
    return token::NUMBER;
}

"\n"          {
    loc->lines();
    return token::NL;
}

"avance" {
    return token::AVANCE;
}

"recule" {
    return token::RECULE;
}
"droite"    {
    return token::DROITE;
}

"gauche"    {
    return token::GAUCHE;
}

"fois"      {
    return token::FOIS;
}

"@"         {
    return token::AT;
}

"tourne"    {
    return token::TOURNE;
}

[ \t]+          {
    
}

"+" return '+';
"-" return '-';
"*" return '*';
"/" return '/';
"(" return '(';
")" return ')';

%%
