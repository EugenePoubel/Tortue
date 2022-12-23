#ifndef TOURNECLASS_H
#define TOURNECLASS_H
#include "jardinHandler.hh"
#include <stdexcept>
#include <iostream>

using coord = float; /*Les coordonnées sont des flottant Nous aurions aussi pu avoir un unsigned int ou un
                    short unsigned int*/

class tourneClass {
private:
    JardinRendering* J;
public:
    tourneClass(JardinRendering* J);
    ~tourneClass();
    float Orientation(int i);
    direction Direction(id _id);
    void tournerClass::tourneTout(direction d, int nbFois = 1);
    void tourne(direction d, id _id, int nbFois = 1);

};

#endif