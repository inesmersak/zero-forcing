#include <algorithm>
#include <assert.h>
#include "utils.hpp"

vector<int> find_white_neighbours(const Graph& graph, int u, const vector<int>& colouring) {
    vector<int> neighbours;
    for (int v : graph.adjacency_lists[u]) {
        if (colouring[v] == WHITE) neighbours.push_back(v);
    }
    return neighbours;
}

bool all_vertices_coloured(const vector<int>& colouring) {
    for (int c : colouring) {
        if (c == WHITE) return false;
    }
    return true;  // no white vertices were found
}

vector<int> generate_random_zfs(int N) {
    vector<int> zfs;
    for (int i=0; i < N; ++i) {
        zfs.push_back(i);
    }
    random_shuffle(zfs.begin(), zfs.end());
    zfs.resize(static_cast<int>(N/2));
    return zfs;
}

void assert_vertex_label_correctness(const Graph& graph, int u) {
    assert(u >= 0  && "zero-forcing set should contain vertex labels "
        "greater or equal to 0");
    assert(u < graph.vertices_num() && "zero-forcing set should contain "
        "vertex labels smaller than graph size");
}