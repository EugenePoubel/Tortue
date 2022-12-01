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
%token                  AT
%type <int>             mouvement
%type <int>             exp

%left '+'
%left '*'
%precedence NEG


%%

programme:
    NUMBER NL {
        std::cout << "nombre : " << $1 << std::endl;
        driver.setVariable("a",$1);
        std::cout <<driver.getVariable("a") << std::endl;
    } 
    
    //deplacement sur toutes les tortues

    programme
    | GAUCHE  mouvement {
        std::cout << "gauche de " <<$3 <<std::endl;
        driver.tourne($3,direction::gauche);
       
    } programme
    | DROITE mouvement {
        std::cout << "droite de " <<$2<<std::endl;

    }  programme
    | RECULE mouvement {
        std::cout << "reculer de "<<$2 <<std::endl;

    }  programme
    | AVANCE mouvement {
        std::cout << "avance de "<<$2 <<std::endl;
        driver.avance($2);

    }

    //deplacement sur une tortue

    programme
    | GAUCHE  mouvement AT NUMBER NL{
        std::cout <<"tortue numéro "<<$4<<" gauche de " <<$2 <<std::endl;
       
    } programme
    | DROITE mouvement AT NUMBER NL{
        std::cout <<"tortue numéro "<<$4<< " droite de " <<$2<<std::endl;

    }  programme
    | RECULE mouvement AT NUMBER NL{
        std::cout <<"tortue numéro "<<$4<< " reculer de "<<$2 <<std::endl;

    }  programme
    | AVANCE mouvement AT NUMBER NL{
        std::cout <<"tortue numéro "<<$4<< " avance de "<<$2 <<std::endl;
        

    }  
    
    
    programme
    | END NL {
        YYACCEPT;
    }
    

//recuperation d'un calcul 
mouvement:

    NL{
        $$=1;
    }
    |
    exp NL {
        $$=$1;
    }
    |
    exp FOIS NL {
        $$=$1;
    }
    |
    exp {
        $$=$1;
    }
    |
    exp FOIS  {
        $$=$1;
    }

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
