#include "interval.hpp"
#include <algorithm>

interval::interval(const double& val1) {
    _a = val1;
    _b = val1;
    _is_empty = false;
}

interval::interval(const double& val1, const double& val2) {
    assert(val1 <= val2);
    _a = val1;
    _b = val2;
    _is_empty = false;
}

interval::interval(const interval& other) {
    _a = other._a;
    _b = other._b;
    _is_empty = false;
}

interval interval::operator+(const interval& obj) {
    double tempx = _a + obj._a;
    double tempy = _b + obj._b;
    return interval(tempx, tempy);
}

interval interval::operator-(const interval& obj) {
    double tempx = _a - obj._a;
    double tempy = _b - obj._b;
    return interval(tempx, tempy);
}

interval interval::operator*(const interval& obj) {
    double tempx = std::min({_a*obj._a, _a*obj._b, _b*obj._a, _b*obj._b});
    double tempy = std::max({_a*obj._a, _a*obj._b, _b*obj._a, _b*obj._b});
    return interval(tempx, tempy);
}

interval interval::operator/(const interval& obj) {
    interval t_obj(1/obj._a, 1/obj._b);
    return (*this)*t_obj;
}

bool interval::operator==(const interval& obj) {
    return (_a == obj._a) && (_b == obj._b);
}

bool interval::operator!=(const interval& obj) {
    return (_a != obj._a) && (_b != obj._b);
}

std::ostream& operator<<(std::ostream& os, const interval& other) {
    os << '[' << other._a << ", " << other._b << ']';
    return os;
}