#ifndef ZFN_H
#define ZFN_H

typedef vector<vector<int>> vvi;
typedef vector<vector<vector<int>>> vvvi;
vvvi power_subset(int n);
vvi smaller_subsets(vvi subsets);

int ZFN_top_down(const Graph& graph, const vvvi& subsets);
int ZFN_top_down_subsets(const Graph& graph, const vvvi& subsets);
int ZFN_binary_search(const Graph& graph, const vvvi& subsets);

#endif