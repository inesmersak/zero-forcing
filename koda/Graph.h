#ifndef GRAPH_H
#define GRAPH_H

#include<algorithm>
#include<iostream>
#include<vector>

using namespace std;

struct Edge
/* Asymmetrical in case we'll need to implement directed graphs. */
{
    int source;
    int destination;

    Edge(int p_source, int p_destination) : source(p_source), destination(p_destination) {};
};

class Graph
/* Undirected graph implementation using adjacency lists. */
{
private:
    int N, M;
public:
    Graph(int N, const vector<Edge> &edges);
    vector<vector<int>> adjacency_lists;
    int vertices_num();
    int edges_num();
    friend ostream& operator<< (ostream&, const Graph&);
};

#endif