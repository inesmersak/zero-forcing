#include <chrono>
#include <iostream>
#include <queue>
#include <thread>
#include <unordered_set>
#include <vector>
#include "Graph.hpp"
#include "WhiteNeighbours.hpp"
#include "utils.hpp"


bool check_ZFS_naive(const Graph& graph, const vector<int>& zfs) {
    vector<int> colouring(graph.vertices_num(), WHITE);
    for (int u : zfs) {
        assert_vertex_label_correctness(graph, u);
        colouring[u] = BLACK;
    }
    bool change = true;
    while (change) {
        change = false;
        for (int u=0; u < graph.vertices_num(); ++u) {  // for every vertex
            if (colouring[u] == BLACK) {
                auto neighbours = find_white_neighbours(graph, u, colouring);
                if (neighbours.size() == 1) {
                    int v = neighbours[0];
                    colouring[v] = BLACK;
                    change = true;
                }
            }
        }
    }
    return all_vertices_coloured(colouring);
}

template <typename T>
bool check_ZFS_queue(const Graph& graph, const vector<int>& zfs) {
    vector<int> colouring(graph.vertices_num(), WHITE);
    vector<int> forces(graph.vertices_num(), NOT_FORCED);
    for (int u : zfs) {
        assert_vertex_label_correctness(graph, u);
        colouring[u] = BLACK;
        forces[u] = IN_ZFS;
    }

    queue<int> q;
    T white_neighbours = T(&graph, &colouring);
    // Preprocessing
    for (int u=0; u < graph.vertices_num(); ++u) {
        if (colouring[u] == BLACK && white_neighbours.size(u) == 1) {
            int v = white_neighbours.only_white_neighbour(u);
            if (forces[v] == NOT_FORCED) {
                q.push(v);
                forces[v] = u;
            }
        }
    }

    while (! q.empty()) {
        int u = q.front();
        q.pop();
        colouring[u] = BLACK;

        // Check if u has only one white neighbour
        if (white_neighbours.size(u) == 1) {
            int v = white_neighbours.only_white_neighbour(u);
            if (forces[v] == NOT_FORCED) {
                q.push(v);
                forces[v] = u;
            }
        }

        // Remove u from white_neighbours set of all its neighbours and check
        // whether any of those neighbours now have only one white neighbour.
        for (int v : graph.adjacency_lists[u]) {
            white_neighbours.remove(v, u);
            if (colouring[v] == BLACK && white_neighbours.size(v) == 1) {
                int w = white_neighbours.only_white_neighbour(v);
                if (forces[w] == NOT_FORCED) {
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

    bool r = timeit(check_ZFS_naive, K5, vector<int> {1,2,3,4}); */

    double p = 0.6;
    vector<int> Ns = {10, 21, 43, 89, 184, 380, 785, 1624, 3360, 6952, 14385, 
        29764, 61585, 127428, 263666, 545560, 1128838, 2335722, 4832931, 
        10000000};
    vector<Graph> graphs;
    vector<vector<int>> zfs;
    for (int N : Ns) {
        graphs.push_back(Graph::path(N));
        // zfs.push_back(generate_random_zfs(N));
        zfs.push_back({N-1});
    }

    for (int i=0; i < Ns.size(); ++i) {
        cout << "---------------------\n";
        cout << "Graph size: " << Ns[i] << "\n";
        // cout << graphs[i];
        // cout << "ZFS: ";
        // for (int v : zfs[i]) {
        //     cout << v << " ";
        // }
        // cout << "\n";

        timeit(check_ZFS_naive, graphs[i], zfs[i]);
        timeit(check_ZFS_queue<WhiteNeighboursSet>, graphs[i], zfs[i]);
        timeit(check_ZFS_queue<WhiteNeighboursCount>, graphs[i], zfs[i]);
    }

    return 0;
}