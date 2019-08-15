#ifndef UTILS_H
#define UTILS_H

#include <iostream>
#include <time.h>
#include <unordered_set>
#include <vector>
#include "Graph.hpp"

#define prn(r, t) { std::cout << "res = " << r.first << ", iter = " << r.second << ", t (ms): " << t << "\n"; }

// some constants describing vertex colour / state
#define BLACK 0
#define WHITE 1
#define IN_ZFS -1
#define NOT_FORCED -2

vector<int> find_white_neighbours(const Graph& graph, int u, const vector<int>& colouring);
bool all_vertices_black(const vector<int>& colouring);
vector<int> generate_random_zfs(int N);
void assert_vertex_label_correctness(const Graph& graph, int u);

template <typename T>
ostream& operator<<(ostream& out, const vector<T>& vec) {
    out << "{";
    for (T u : vec) {
        out << u << ",";
    }
    out << "}\n";

    return out;
}

template <typename T1, typename T2>
ostream& operator<<(ostream& out, const pair<T1, T2>& pair) {
    out << "p{" << pair.first << ", " << pair.second << "}";
    return out;
}

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
    // prn(r, t_ms);
    cout << "res = " << r << ", t (ms): " << t_ms << "\n";
    return r;
}

#endif