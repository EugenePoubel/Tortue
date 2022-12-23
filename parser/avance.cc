#include "avance.hh"

avance::avance(JardinRendering* J)
{
    J=J;
}

float avance::getX(id _id)
{
    return J->getTortues()[_id]->getX();
}

float avance::getY(id _id)
{
    return J->getTortues()[_id]->getY();
}

void avance::avancer(id _id, int nbFois = 1)
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

void avance::avanceTout(int nbFois = 1)
{
    for (short i = 0; i < J->nombreTortues(); i++)
    {
        avance(nbFois, i);
    }
}
