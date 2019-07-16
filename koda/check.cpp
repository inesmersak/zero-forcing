#include<assert.h>
#include<iostream>
#include<vector>
#include "Graph.hpp"
#include "utils.hpp"

#define prn(x) { std::cerr << #x << " = " << (x) << std::endl; }


bool check_zero_forcing_set_naive(const Graph& graph, const vector<int>& zfs) {
    vector<int> colouring(graph.vertices_num(), 1);
    for (int u : zfs) {
        assert(u >= 0  && "zero-forcing set should contain vertex labels greater or equal to 0");
        assert(u < graph.vertices_num() && "zero-forcing set should contain vertex labels smaller than graph size");
        colouring[u] = 0;  // 0 means the vertex is coloured / black
    }
    bool change = true;
    while (change) {
        change = false;
        for (int u=0; u < graph.vertices_num(); ++u) {  // for every vertex
            if (colouring[u] == 0) {
                auto neighbours = find_white_neighbours(graph, u, colouring);
                if (neighbours.size() == 1) {
                    int v = neighbours[0];
                    colouring[v] = 0;
                    change = true;
                }
            }
        }
    }
    return all_vertices_coloured(colouring);
}

int main () {
    Graph K5 = Graph::complete_graph(5);
    Graph C4 = Graph::cycle(4);
    Graph P6 = Graph::path(6);

    cout << K5 << C4 << P6; 
    cout << check_zero_forcing_set_naive(K5, vector<int> {1,2,3,4});

    return 0;
}