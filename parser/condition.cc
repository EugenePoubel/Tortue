#include "condition.hh"

condition::condition(JardinRendering* J)
{
    J=J;
}

bool condition::Mur(direction d, id _id)
{
    switch ((modulo((static_cast<int>(Orientation(_id)) + static_cast<int>(d)), 360)))
    {
    case 0:
        return J->estMur(getX(_id), getY(_id) + 1);
        break;
    case 90:
        return J->estMur(getX(_id) + 1, getY(_id));
        break;
    case 180:
        return J->estMur(getX(_id), getY(_id) - 1);
        break;
    case 270:
        return J->estMur(getX(_id) - 1, getY(_id));
        break;
    default:
        break;
    }
    throw std::invalid_argument("Erreur Orientation invalide");
}

bool condition::Vide(direction d, id _id)
{
    switch ((modulo((static_cast<int>(Orientation(_id)) + static_cast<int>(d)), 360)))
    {
    case 0:
        return getJardin()->estVide(getX(_id), getY(_id) + 1);
        break;
    case 90:
        return getJardin()->estVide(getX(_id) + 1, getY(_id));
        break;
    case 180:
        return getJardin()->estVide(getX(_id), getY(_id) - 1);
        break;
    case 270:
        return getJardin()->estVide(getX(_id) - 1, getY(_id));
        break;
    default:
        break;
    }
    throw std::invalid_argument("Erreur Orientation invalide");
}