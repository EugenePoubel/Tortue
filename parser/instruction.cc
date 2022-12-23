#include "instruction.hh"

instruction::instruction(JardinRendering* J)
{
    J=J;
}

float instruction::Orientation(int i)
{
    return J->getTortues()[i]->getOrientation();
}

direction instruction::Direction(id _id)
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

void instruction::tourne(direction d, id _id, int nbFois = 1)
{
    J->getTortues()[_id]->setOrientation(modulo((static_cast<int>(Orientation(_id)) + static_cast<int>(d) * nbFois), 360));
}

void instruction::tourneTout(direction d, int nbFois = 1)
{
    for (int i = 0; i < J->nombreTortues(); i++)
    {
        tourne(d, i, nbFois);
    }
}

instruction::avance(JardinRendering* J)
{
    J=J;
}

float instruction::getX(id _id)
{
    return J->getTortues()[_id]->getX();
}

float instruction::getY(id _id)
{
    return J->getTortues()[_id]->getY();
}

void instruction::avancer(id _id, int nbFois = 1)
{
    switch (static_cast<int>(Orientation(_id)))
    {
    case 0:
        J->changePosition(_id, getX(_id), getY(_id) + nbFois);
        break;
    case 90:
        J->changePosition(_id, getX(_id) + nbFois, getY(_id));
        break;
    case 180:
        J->changePosition(_id, getX(_id), getY(_id) - nbFois);
        break;
    case 270:
        J->changePosition(_id, getX(_id) - nbFois, getY(_id));
        break;
    default:
        break;
    }
}

void instruction::avanceTout(int nbFois = 1)
{
    for (short i = 0; i < J->nombreTortues(); i++)
    {
        avance(nbFois, i);
    }
}


