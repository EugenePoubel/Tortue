#include "condition.hh"
int modulo2(int a, int b) { return (a % b + b) % b; }; // Le calcul % initial dans C++ rend un résultat incorrect mathématiquement dans les négatif
condition::condition(JardinRendering* _J)
{
    J = _J;
}
float condition::getX(id _id)
{
    return J->getTortues()[_id]->getX();
}

float condition::getY(id _id)
{
    return J->getTortues()[_id]->getY();
}

float condition::Orientation(int i)
{
    return J->getTortues()[i]->getOrientation();
}

bool condition::Mur(direction d, id _id)
{
    switch ((modulo2((static_cast<int>(Orientation(_id)) + static_cast<int>(d)), 360)))
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
    switch ((modulo2((static_cast<int>(Orientation(_id)) + static_cast<int>(d)), 360)))
    {
    case 0:
        return J->estVide(getX(_id), getY(_id) + 1);
        break;
    case 90:
        return J->estVide(getX(_id) + 1, getY(_id));
        break;
    case 180:
        return J->estVide(getX(_id), getY(_id) - 1);
        break;
    case 270:
        return J->estVide(getX(_id) - 1, getY(_id));
        break;
    default:
        break;
    }
    throw std::invalid_argument("Erreur Orientation invalide");
}