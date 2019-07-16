#include<algorithm>
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
    cout << "Graph (N=" << graph.N << ", M=" << graph.M << "): \n";
    for (size_t i = 0; i < graph.adjacency_lists.size(); ++i) {
        cout << i << " <--> ";
        for (int n: graph.adjacency_lists[i]) {
            cout << n << " ";
        }
        cout << "\n";
    }
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