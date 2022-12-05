#include "driver.hh"
#include "jardinHandler.hh"
#include <iostream>

int modulo(int a, int b) {return (a % b + b) % b; };

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

float Driver::Orientation(int i)
{
    return getJardin()->getTortues()[i]->getOrientation();
}

direction Driver::Direction(id _id)
{
    switch (static_cast<int>(Orientation(_id)))
    {
    case 0:
        return direction::DEVANT;
        break;
    case 90:
        return direction::DROITE;
        break;
    case 180:
        return direction::DERRIERE;
        break;
    case 270:
        return direction::GAUCHE;
        break;
    default:
        std::cout << "Erreur dans direction()";
        return direction::DEVANT;
        break;
    }
}

float Driver::getX(id _id)
{
    return getJardin()->getTortues()[_id]->getX();
}

float Driver::getY(id _id)
{
    return getJardin()->getTortues()[_id]->getY();
}

void Driver::avance(id _id, int nbFois = 1)
{
    switch (static_cast<int>(Orientation(_id)))
    {
    case 0:
        getJardin()->changePosition(_id, getX(_id), getY(_id) + x);
        break;
    case 90:
        getJardin()->changePosition(_id, getX(_id) + x, getY(_id));
        break;
    case 180:
        getJardin()->changePosition(_id, getX(_id), getY(_id) - x);
        break;
    case 270:
        getJardin()->changePosition(_id, getX(_id) - x, getY(_id));
        break;
    default:
        break;
    }
}

void Driver::avance(int nbFois = 1)
{
    for (short i = 0; i < getJardin()->nombreTortues(); i++)
    {
        avance(nbFois, i);
    }
}

void Driver::tourne(direction d, id _id, int nbFois=1)
{
    getJardin()->getTortues()[_id]->setOrientation(modulo((static_cast<int>(Orientation(_id)) + static_cast<int>(d) * nbFois), 360));
}

void Driver::tourneTout(direction d, int nbFois = 1)
{
    for (int i = 0; i < getJardin()->nombreTortues(); i++)
    {
        tourne(d, i, nbFois);
    }
}