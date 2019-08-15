#ifndef CHECK_H
#define CHECK_H

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


inline pair<bool,int> check_ZFS_naive(const Graph& graph, const vector<int>& zfs) {
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

#endif