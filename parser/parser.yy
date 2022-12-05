%skeleton "lalr1.cc"
%require "3.0"

%defines
%define parser_class_name { Parser }
%define api.value.type variant
%define parse.assert

%locations

%code requires{
    #include "contexte.hh"
    #include "expressionBinaire.hh"
    #include "expressionUnaire.hh"
    #include "constante.hh"
    #include "variable.hh"
    
    class Scanner;
    class Driver;
}

%parse-param { Scanner &scanner }
%parse-param { Driver &driver }

%code{
    #include <iostream>
    #include <string>
    
    #include "scanner.hh"
    #include "driver.hh"

    #undef  yylex
    #define yylex scanner.yylex
}

%token                  NL
%token                  END
%token <int>            NUMBER
%token                  RECULE
%token                  AVANCE
%token                  GAUCHE
%token                  DROITE
%token                  FOIS
%token                  TOURNE
%token                  AT
%type <int>             mouvement
%type <int>             exp

%left '+'
%left '*'
%precedence NEG


%%

programme:    
    //deplacement sur toutes les tortues

    programme
    |  TOURNE GAUCHE NL {
        std::cout << "tourne à gauche "<<std::endl;
       
    } programme
    | TOURNE DROITE NL{
        std::cout << "tourne à droite "<<std::endl;

    }  programme
    | RECULE mouvement NL {
        std::cout << "reculer de "<<$2 <<std::endl;

    }  programme
    | AVANCE mouvement NL{
        std::cout << "avance de "<<$2 <<std::endl;

    }
    //deplacement sur une tortue

    programme
    | TOURNE GAUCHE AT NUMBER NL{
        std::cout <<"tortue numéro "<<$4<<" tourne à gauche "<<std::endl;
       
    } programme
    | TOURNE DROITE AT NUMBER NL{
        std::cout <<"tortue numéro "<<$4<< " tourne à droite "<<std::endl;

    }  programme
    | RECULE mouvement AT NUMBER NL{
        std::cout <<"tortue numéro "<<$4<< " reculer de "<<$2<<std::endl;

    }  programme
    | AVANCE mouvement AT NUMBER NL{
        std::cout <<"tortue numéro "<<$4<< " avance de "<<$2<<std::endl;
        

    }  
    
    
    programme
    | END NL {
        YYACCEPT;
    }
    

 
mouvement:

    NL{
        $$=1;
    }
    |
    exp {
        $$=$1;
    }
    |
    exp FOIS {
        $$=$1;
    }

//recuperation d'un calcul

exp :
        NUMBER
    |   exp '+' exp {
        $$ = $1 + $3;
    }
    |   exp '*' exp {
        $$ = $1 * $3;
    }
    |   '(' exp ')' {
        $$ = $2;
    }
    |   '-' exp  %prec  NEG  {
        $$ = -$2;
    }
    |   exp '/' exp {
        $$ = $1 / $3;
    }
%%

void yy::Parser::error( const location_type &l, const std::string & err_msg) {
    std::cerr << "Erreur : " << l << ", " << err_msg << std::endl;
}
