#ifndef UTILS_H
#define UTILS_H

#include <iostream>
#include <time.h>
#include <unordered_set>
#include <vector>
#include "Graph.hpp"

#define prn(f, r, t) { std::cout << #f << " = " << r << ", t (ms): " << t << "\n"; }

vector<int> find_white_neighbours(const Graph& graph, int u, const vector<int>& colouring);
bool all_vertices_coloured(const vector<int>& colouring);
vector<int> generate_random_zfs(int N);

template <typename T>
T pop(unordered_set<T>& set) {
    T i = *set.begin();
    set.erase(set.begin());
    return i;
}

template<typename Function, typename... Args>
auto timeit(Function func, Args... args) -> decltype(func(args...)) {
    auto t = clock();
    auto r = func(args...);
    t = clock() - t;
    float t_ms = (float) t / CLOCKS_PER_SEC * 1000;
    prn(func, r, t_ms);
    // cout << "It took me " << t << " clicks (" << (float) t / CLOCKS_PER_SEC * 1000 << " milliseconds).\n";
    return r;
}

#endif