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
%token                  DIVISE


%%

programme:
    NUMBER NL {
        std::cout << "nombre : " << $1 << std::endl;
        driver.setVariable("a",$1);
        std::cout <<driver.getVariable("a") << std::endl;
    } programme
    | RECULE NUMBER NL{
        std::cout << "reculer avec nombre " <<std::endl;

    }  programme
    | RECULE NL{
        std::cout << "recule " <<std::endl;

    }  programme
    | DROITE NL{
        std::cout << "droite " <<std::endl;

    }  programme
    | GAUCHE  NUMBER NL{
        std::cout << "gauche " <<std::endl;
       
    } programme
    | RECULE NUMBER NL{
        std::cout << "nombre : " <<std::endl;

    }  programme
    | END NL {
        YYACCEPT;
    }

    | NUMBER DIVISE NUMBER NL{
        std::cout << $1<<"/" << $3 <<"=";
        driver.setVariable("a",$1/$3);
        std::cout <<driver.getVariable("a") << std::endl;

    }  programme
    
%%

void yy::Parser::error( const location_type &l, const std::string & err_msg) {
    std::cerr << "Erreur : " << l << ", " << err_msg << std::endl;
}
