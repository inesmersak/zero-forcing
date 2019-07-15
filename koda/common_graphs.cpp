#include "common_graphs.h"

Graph complete_graph(int N) {
    vector<Edge> edges;
    for (int i=0; i < N; ++i) {
        for (int j=i+1; j < N; ++j) {
            edges.emplace_back(i, j);
        }
    }
    return Graph(N, edges);
}

Graph cycle(int N) {
    vector<Edge> edges;
    for (int i=0; i < N; ++i) {
        edges.emplace_back(i, (i+1) % N);
    }
    return Graph(N, edges);
}

Graph path(int N) {
    vector<Edge> edges;
    for (int i=0; i < N-1; ++i) {
        edges.emplace_back(i, i+1);
    }
    return Graph(N, edges);
}