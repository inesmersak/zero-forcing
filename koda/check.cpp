#include <assert.h>
#include <chrono>
#include <iostream>
#include <queue>
#include <thread>
#include <unordered_set>
#include <vector>
#include "Graph.hpp"
#include "utils.hpp"

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

bool check_zero_forcing_set_queue_set(const Graph& graph, const vector<int>& zfs) {
    vector<int> colouring(graph.vertices_num(), 1);
    vector<int> forces(graph.vertices_num(), -2);  // -2 means the vertex hasn't been forced yet
    for (int u : zfs) {
        assert(u >= 0  && "zero-forcing set should contain vertex labels greater or equal to 0");
        assert(u < graph.vertices_num() && "zero-forcing set should contain vertex labels smaller than graph size");
        colouring[u] = 0;  // 0 means the vertex is coloured / black
        forces[u] = -1;  // u is in starting set
    }

    queue<int> q;
    vector<unordered_set<int>> white_neighbours;
    // Preprocessing
    for (int u=0; u < graph.vertices_num(); ++u) {
        auto neighbours = find_white_neighbours(graph, u, colouring);
        white_neighbours.emplace_back(neighbours.begin(), neighbours.end());
        if (colouring[u] == 0 && white_neighbours[u].size() == 1) {
            int v = pop(white_neighbours[u]);
            if (forces[v] == -2) {
                q.push(v);
                forces[v] = u;
            }
        }
    }

    while (q.size() > 0) {
        int u = q.front();
        q.pop();
        colouring[u] = 0;
        for (int v : graph.adjacency_lists[u]) {
            white_neighbours[v].erase(u);
            if (colouring[v] == 0 && white_neighbours[v].size() == 1) {
                int w = pop(white_neighbours[v]);
                if (forces[w] == -2) {
                    q.push(w);
                    forces[w] = v;
                }
            }
        }
    }

    return all_vertices_coloured(colouring);
}

int main () {
/*     Graph K5 = Graph::complete_graph(24);
    Graph C4 = Graph::cycle(4);
    Graph P6 = Graph::path(6);

    bool r = timeit(check_zero_forcing_set_naive, K5, vector<int> {1,2,3,4}); */

    double p = 0.6;
    vector<int> Ns = {10, 22, 46, 100, 215, 464, 1000, 2154, 4642, 10000};
    vector<Graph> graphs;
    vector<vector<int>> zfs;
    for (int N : Ns) {
        graphs.push_back(Graph::random_erdos_renyi(N, p));
        zfs.push_back(generate_random_zfs(N));
    }

    for (int i=0; i < Ns.size(); ++i) {
        cout << "---------------------\n";
        cout << "Graph size: " << Ns[i];
        /* cout << graphs[i]; */
        timeit(check_zero_forcing_set_naive, graphs[i], zfs[i]);
        timeit(check_zero_forcing_set_queue_set, graphs[i], zfs[i]);
    }

    return 0;
}