#include "driver.hh"
#include "jardinHandler.hh"
#include <stdexcept>
#include <iostream>

int modulo(int a, int b) { return (a % b + b) % b; }; // Le calcul % initial dans C++ rend un résultat incorrect mathématiquement dans les négatif

Driver::Driver(JardinHandler *J)
{
    monJardin = J;
}

Driver::~Driver()
{
    delete monJardin;
}

const Contexte &Driver::getContexte() const
{
    return variables;
}

double Driver::getVariable(const std::string &name) const
{
    return variables.get(name);
}

void Driver::setVariable(const std::string &name, double value)
{
    variables[name] = value;
}

JardinRendering *Driver::getJardin()
{
    return monJardin->getJardinRendering();
}