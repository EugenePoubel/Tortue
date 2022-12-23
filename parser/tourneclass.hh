#ifndef TOURNECLASS_H
#define TOURNECLASS_H
#include "jardinRendering.hh"
#include <stdexcept>
#include <iostream>

enum class direction{
    GAUCHE   = -90,
    DERRIERE = 180,
    DEVANT   = 0,
    DROITE   = 90
};

using id = short;
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