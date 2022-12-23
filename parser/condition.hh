#ifndef CONDITION_H
#define CONDITION_H

#include "jardinRendering.hh"
#include "avance.hh"
#include "tourneclass.hh"
#include <stdexcept>
#include <iostream>

using id = short;

class condition
{
private:
    JardinRendering* J;

public:
    condition(JardinRendering* J);
    ~condition();
    bool Mur(direction d, id _id)
    bool Vide(direction d, id _id)

};



