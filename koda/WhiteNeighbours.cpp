#include "assert.h"
#include "WhiteNeighbours.hpp"
#include "utils.hpp"

WhiteNeighboursSet::WhiteNeighboursSet(const Graph* graph, 
const vector<int>* colouring) {
    for (int u=0; u < graph->vertices_num(); ++u) {
        auto neighbours = find_white_neighbours(*graph, u, *colouring);
        white_neighbours.emplace_back(neighbours.begin(), neighbours.end());
    }
}

ostream& operator<<(ostream& out, const WhiteNeighboursSet& wn) {
    for (size_t u=0; u < wn.white_neighbours.size(); ++u) {
        out << u << ": ";
        for (int v: wn.white_neighbours[u]) {
            out << v << " ";
        }
        out << "\n";
    }
    return out;
}

/* Removes v from white neighbours of u. */
void WhiteNeighboursSet::remove(int u, int v) {
    white_neighbours[u].erase(v);
}

int WhiteNeighboursSet::size(int u) {
    return static_cast<int>(white_neighbours[u].size());
}

int WhiteNeighboursSet::only_white_neighbour(int u) {
    assert(size(u) == 1 && "vertex does not have exactly one white neighbour");
    return pop(white_neighbours[u]);
}

WhiteNeighboursCount::WhiteNeighboursCount(const Graph* p_graph,
const vector<int>* p_colouring): graph(p_graph), colouring(p_colouring) {
    for (int u=0; u < graph->vertices_num(); ++u) {
        auto neighbours = find_white_neighbours(*graph, u, *colouring);
        white_neighbours_count.push_back(neighbours.size());
    }
}

ostream& operator<<(ostream& out, const WhiteNeighboursCount& wnc) {
    for (size_t u=0; u < wnc.white_neighbours_count.size(); ++u) {
        out << u << ": " << wnc.white_neighbours_count[u] << "\n";
    }
    return out;
}

/* Removes v from white neighbour count of u. */
void WhiteNeighboursCount::remove(int u, int v) {
    --white_neighbours_count[u];
}

int WhiteNeighboursCount::size(int u) {
    return white_neighbours_count[u];
}

int WhiteNeighboursCount::only_white_neighbour(int u) {
    assert(size(u) == 1 && "vertex does not have exactly one white neighbour");
    auto neighbours = find_white_neighbours(*graph, u, *colouring);
    return neighbours[0];
}

