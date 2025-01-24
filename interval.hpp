#pragma once

#include <iostream>
#include <cassert>
#include <algorithm>

class interval {
private:
    double _a, _b;
    bool _is_empty = true;
public:
    static constexpr float PI = 3.14159;
    static constexpr int ZERO = 0;
    static constexpr int ONE = 1;

    interval(); // inf
    interval(const double& val1);
    interval(const double& val1, const double& val2);
    interval(const interval& other);

    interval operator+(const interval& obj);
    interval operator-(const interval& obj);
    interval operator*(const interval& obj);
    interval operator/(const interval& obj);
    bool operator==(const interval& obj);
    bool operator!=(const interval& obj);

    friend std::ostream& operator<<(std::ostream& os, const interval& other);
};
