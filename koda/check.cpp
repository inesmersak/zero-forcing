#include <chrono>
#include <iostream>
#include <queue>
#include <thread>
#include <unordered_set>
#include <utility>
#include <vector>
#include "Graph.hpp"
#include "WhiteNeighbours.hpp"
#include "utils.hpp"


pair<bool,int> check_ZFS_naive(const Graph& graph, const vector<int>& zfs) {
    vector<int> colouring(graph.vertices_num(), WHITE);
    for (int u : zfs) {
        assert_vertex_label_correctness(graph, u);
        colouring[u] = BLACK;
    }
    bool change = true;
    int iter = 0;
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
        ++iter;
    }
    return pair<bool,int> (all_vertices_black(colouring), iter);
}

template <typename T>
pair<bool,int> check_ZFS_queue(const Graph& graph, const vector<int>& zfs) {
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

    int iter = 0;
    while (!q.empty()) {
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
        ++iter;
    }

    return pair<bool,int> (all_vertices_black(colouring), iter);
}

int main () {
    double p = 0.01;  // random graph density

    vector<int> Ns = {100, 128, 163, 207, 264, 336, 429, 546, 696, 886, 1129, 1439, 1833, 2336, 2977, 3793, 4833, 6159, 7848, 10000};
    vector<Graph> graphs;
    vector<vector<int>> zfs;
    for (int N : Ns) {
        graphs.push_back(Graph::random_erdos_renyi(N, p));
        zfs.push_back(generate_random_zfs(N));
        // graphs.push_back(Graph::path(N));
        // zfs.push_back({0});
    }

    for (int i=0; i < Ns.size(); ++i) {
        cout << "---------------------\n";
        cout << "Graph size: " << Ns[i] << "\n";
        // cout << graphs[i];
        // cout << "ZFS: " << zfs[i];
        cout << "naive -> ";
        timeit(check_ZFS_naive, graphs[i], zfs[i]);
        cout << "queue_set -> ";
        timeit(check_ZFS_queue<WhiteNeighboursSet>, graphs[i], zfs[i]);
        cout << "queue_count -> ";
        timeit(check_ZFS_queue<WhiteNeighboursCount>, graphs[i], zfs[i]);
    }

    return 0;
}