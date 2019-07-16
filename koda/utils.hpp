#ifndef UTILS_H
#define UTILS_H

#include<vector>
#include "Graph.hpp"

vector<int> find_white_neighbours(const Graph& graph, int u, const vector<int>& colouring);
bool all_vertices_coloured(const vector<int>& colouring);

#endif