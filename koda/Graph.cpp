#include <algorithm>
#include <assert.h>
#include <chrono>
#include <random>
#include "Graph.hpp"


Graph::Graph(int p_N, const vector<Edge>& edges) : N(p_N) {
    M = 0; 
    adjacency_lists.resize(N);
    for (auto edge : edges) {
        adjacency_lists[edge.source].push_back(edge.destination);
        adjacency_lists[edge.destination].push_back(edge.source);  // undirected graph
        M++;
    }
    for (auto neighbours : adjacency_lists) {
        sort(neighbours.begin(), neighbours.end());
    }
}

ostream& operator<<(ostream& out, const Graph& graph) {
    out << "Graph (N=" << graph.N << ", M=" << graph.M << "): \n";
    for (size_t i = 0; i < graph.adjacency_lists.size(); ++i) {
        out << i << " <--> ";
        for (int n: graph.adjacency_lists[i]) {
            out << n << " ";
        }
        out << "\n";
    }
    return out;
}

Graph Graph::complete_graph(int N) {
    vector<Edge> edges;
    for (int i=0; i < N; ++i) {
        for (int j=i+1; j < N; ++j) {
            edges.emplace_back(i, j);
        }
    }
    return Graph(N, edges);
}

Graph Graph::cycle(int N) {
    vector<Edge> edges;
    for (int i=0; i < N; ++i) {
        edges.emplace_back(i, (i+1) % N);
    }
    return Graph(N, edges);
}

Graph Graph::path(int N) {
    vector<Edge> edges;
    for (int i=0; i < N-1; ++i) {
        edges.emplace_back(i, i+1);
    }
    return Graph(N, edges);
}

Graph Graph::random_erdos_renyi(int N, double p) {
    assert(p > 0 && "p should be greater than zero");
    assert(p < 1 && "p should be smaller than one");
    vector<Edge> edges;
    unsigned seed = chrono::system_clock::now().time_since_epoch().count();
    mt19937 gen(seed);
    uniform_real_distribution<double> dist(0.0, 1.0);
    for (int i=0; i < N; ++i) {
        for (int j=i+1; j < N; ++j) {
            if (dist(gen) <= p) edges.emplace_back(i, j);
        }
    }

    return Graph(N, edges);
}