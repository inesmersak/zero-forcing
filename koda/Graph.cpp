#include "Graph.h"

Graph::Graph(int p_N, const vector<Edge> &edges) : N(p_N)
{
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

int Graph::vertices_num() {
    return N;
}

int Graph::edges_num() {
    return M;
}

ostream& operator<< (ostream &out, const Graph &graph) {
    for (size_t i = 0; i < graph.adjacency_lists.size(); ++i) {
        cout << "Neighbours of vertex " << i << ":\n";
        for (int n: graph.adjacency_lists[i]) {
            cout << n << " ";
        }
        cout << "\n";
    }
}