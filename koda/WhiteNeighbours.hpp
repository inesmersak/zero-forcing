#ifndef WHITE_NEIGHBOURS_H
#define WHITE_NEIGHBOURS_H

#include <iostream>
#include <unordered_set>
#include <vector>
#include "Graph.hpp"


/* Implementation of a data structure for keeping track of white neighbours 
using unordered sets. */
class WhiteNeighboursSet {
private:
    vector<unordered_set<int>> white_neighbours;
public:
    WhiteNeighboursSet(const Graph* graph, const vector<int>* colouring);

    void remove(int u, int v);
    int size(int u);
    int only_white_neighbour(int u);
    friend ostream& operator<<(ostream& out, const WhiteNeighboursSet& wn);
};


/* Implementation of a data structure for keeping track of white neighbours 
using a vector of counts. */
class WhiteNeighboursCount {
private:
    const Graph* graph;
    const vector<int>* colouring;
    vector<int> white_neighbours_count;
public:
    WhiteNeighboursCount(const Graph* p_graph, const vector<int>* p_colouring);

    void remove(int u, int v);
    int size(int u);
    int only_white_neighbour(int u);
    friend ostream& operator<<(ostream& out, const WhiteNeighboursCount& wn);
};

#endif