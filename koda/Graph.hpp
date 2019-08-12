#ifndef GRAPH_H
#define GRAPH_H

#include <iostream>
#include <vector>

using namespace std;

/* Asymmetrical in case we'll need to implement directed graphs. */
struct Edge {
    int source;
    int destination;

    Edge(int p_source, int p_destination) : source(p_source), destination(p_destination) {};
};

/* Undirected graph implementation using adjacency lists. */
class Graph {
private:
    int N, M;
public:
    Graph(int p_N, const vector<Edge>& edges);
    static Graph complete_graph(int N);
    static Graph cycle(int N);
    static Graph path(int N);
    static Graph random_erdos_renyi(int N, double p);

    vector<vector<int>> adjacency_lists;
    int vertices_num() const { return N; }
    int edges_num() const { return M; }
    friend ostream& operator<<(ostream& out, const Graph& graph);
};

#endif