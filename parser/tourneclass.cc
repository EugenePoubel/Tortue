#include "tourneclass.hh"

tourneClass::tourneClass(JardinRendering* J)
{
    J=J;
}

float tourneClass::Orientation(int i)
{
    return J->getTortues()[i]->getOrientation();
}

direction tourneClass::Direction(id _id)
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

void tournerCLass::tourne(direction d, id _id, int nbFois = 1)
{
    J->getTortues()[_id]->setOrientation(modulo((static_cast<int>(Orientation(_id)) + static_cast<int>(d) * nbFois), 360));
}

void tournerClass::tourneTout(direction d, int nbFois = 1)
{
    for (int i = 0; i < J->nombreTortues(); i++)
    {
        tourne(d, i, nbFois);
    }
}


