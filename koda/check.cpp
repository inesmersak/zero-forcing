#include <chrono>
#include <iostream>
#include <queue>
#include <thread>
#include <unordered_set>
#include <vector>
#include "Graph.hpp"
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

bool check_ZFS_queue_set(const Graph& graph, const vector<int>& zfs) {
    vector<int> colouring(graph.vertices_num(), WHITE);
    vector<int> forces(graph.vertices_num(), NOT_FORCED);
    for (int u : zfs) {
        assert_vertex_label_correctness(graph, u);
        colouring[u] = BLACK;
        forces[u] = IN_ZFS;
    }

    queue<int> q;
    vector<unordered_set<int>> white_neighbours;
    // Preprocessing
    for (int u=0; u < graph.vertices_num(); ++u) {
        auto neighbours = find_white_neighbours(graph, u, colouring);
        white_neighbours.emplace_back(neighbours.begin(), neighbours.end());
        if (colouring[u] == BLACK && white_neighbours[u].size() == 1) {
            int v = pop(white_neighbours[u]);
            if (forces[v] == NOT_FORCED) {
                q.push(v);
                forces[v] = u;
            }
        }
    }

    while (q.size() > 0) {
        int u = q.front();
        q.pop();
        colouring[u] = BLACK;
        for (int v : graph.adjacency_lists[u]) {
            white_neighbours[v].erase(u);
            if (colouring[v] == BLACK && white_neighbours[v].size() == 1) {
                int w = pop(white_neighbours[v]);
                if (forces[w] == NOT_FORCED) {
                    q.push(w);
                    forces[w] = v;
                }
            }
        }
    }

    return all_vertices_coloured(colouring);
}

bool check_ZFS_queue_count(const Graph& graph, const vector<int>& zfs) {
    vector<int> colouring(graph.vertices_num(), WHITE);
    vector<int> forces(graph.vertices_num(), NOT_FORCED);
    for (int u : zfs) {
        assert_vertex_label_correctness(graph, u);
        colouring[u] = BLACK;
        forces[u] = IN_ZFS;
    }

    queue<int> q;
    vector<int> white_neighbours_cnt(graph.vertices_num(), 0);
    // Preprocessing
    for (int u=0; u < graph.vertices_num(); ++u) {
        auto neighbours = find_white_neighbours(graph, u, colouring);
        white_neighbours_cnt[u] = neighbours.size();
        if (colouring[u] == BLACK && white_neighbours_cnt[u] == 1) {
            int v = neighbours[0];
            if (forces[v] == NOT_FORCED) {
                q.push(v);
                forces[v] = u;
            }
        }
    }

    while (q.size() > 0) {
        int u = q.front();
        q.pop();
        colouring[u] = BLACK;
        for (int v : graph.adjacency_lists[u]) {
            --white_neighbours_cnt[v];
            if (colouring[v] == BLACK && white_neighbours_cnt[v] == 1) {
                auto neighbours = find_white_neighbours(graph, v, colouring);
                int w = neighbours[0];
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
    vector<int> Ns = {10, 22, 46, 100, 215, 464, 1000, 2154, 4642, 10000, 15000};
    vector<Graph> graphs;
    vector<vector<int>> zfs;
    for (int N : Ns) {
        graphs.push_back(Graph::random_erdos_renyi(N, p));
        zfs.push_back(generate_random_zfs(N));
    }

    for (int i=0; i < Ns.size(); ++i) {
        cout << "---------------------\n";
        cout << "Graph size: " << Ns[i] << "\n";
        /* cout << graphs[i]; */
        timeit(check_ZFS_naive, graphs[i], zfs[i]);
        // timeit(check_ZFS_queue_set, graphs[i], zfs[i]);
        timeit(check_ZFS_queue_count, graphs[i], zfs[i]);
    }

    return 0;
}