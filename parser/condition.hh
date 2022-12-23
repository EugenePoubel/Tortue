#ifndef CONDITION_H
#define CONDITION_H

#include "jardinRendering.hh"
#include "avance.hh"
#include "instruction.hh"
#include <stdexcept>
#include <iostream>

using id = short;

class condition
{
private:
    JardinRendering* J;

public:
    condition(JardinRendering* J);
    ~condition()=default;
    bool Mur(direction d, id _id);
    bool Vide(direction d, id _id);
    float getX(id _id);
    float getY(id _id);
    float Orientation(int i);

};

#endif

