#include "utils.hpp"

vector<int> find_white_neighbours(const Graph& graph, int u, const vector<int>& colouring) {
    vector<int> neighbours;
    for (int v : graph.adjacency_lists[u]) {
        if (colouring[v] == 1) neighbours.push_back(v);  // v is a white (non-coloured) neighbour of u
    }
    return neighbours;
}

bool all_vertices_coloured(const vector<int>& colouring) {
    for (int c : colouring) {
        if (c == 1) return false;  // we found a white vertex
    }
    return true;  // no white vertices were found
}