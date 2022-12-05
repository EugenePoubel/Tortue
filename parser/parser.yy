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

    //déplacement 

instruction:    

    //deplacement sur toutes les tortues

    instruction
    |  TOURNE GAUCHE mouvement NL{
        std::cout << "tourne à gauche "<<$3<<" fois"<<std::endl;
       
    } instruction
    | TOURNE DROITE mouvement NL{
        std::cout << "tourne à droite "<<$3<<" fois"<<std::endl;

    }  instruction
    | RECULE mouvement NL{
        std::cout << "reculer de "<<$2 <<std::endl;

    }  instruction
    | AVANCE mouvement NL{
        std::cout << "avance de "<<$2 <<std::endl;

    }

    //deplacement sur une tortue

    instruction
    | TOURNE GAUCHE mouvement AT NUMBER NL{
        std::cout <<"tortue numéro "<<$5<<" tourne à gauche "<<$3<<" fois"<<std::endl;
       
    } instruction
    | TOURNE DROITE mouvement AT NUMBER NL{
        std::cout <<"tortue numéro "<<$5<< " tourne à droite "<<$3<<" fois"<<std::endl;

    }  instruction
    | RECULE mouvement AT NUMBER NL{
        std::cout <<"tortue numéro "<<$4<< " reculer de "<<$2<<std::endl;

    }  instruction
    | AVANCE mouvement AT NUMBER NL{
        std::cout <<"tortue numéro "<<$4<< " avance de "<<$2<<std::endl;
        

    } 

    instruction
    |END NL {
        YYACCEPT;
    }
   
    //mise en forme d'un mouvement 

mouvement:

    {
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
