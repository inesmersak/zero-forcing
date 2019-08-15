#include <cmath>
#include <vector>
#include "Graph.hpp"
#include "WhiteNeighbours.hpp"
#include "check.hpp"
#include "zero_forcing_number.hpp"

/* Returns all subsets of the set {1, ..., n} ordered by size. */
vvvi power_subset(int n) {
    vvvi subsets(n+1);
    for (int i=0; i < (1 << n); ++i) {
        vector<int> subset;
        for (int j=0; j < n; ++j) {
            if ((i & (1 << j)) != 0) {
                subset.push_back(j);
            }
        }
        subsets[subset.size()].push_back(move(subset));
    }
    return subsets;
}

int ZFN_top_down(const Graph& graph, const vvvi& subsets) {
    int i;
    for (i = graph.vertices_num()-1; i >= 0; --i) {
        bool zfs_exists = false;
        for (auto subset : subsets[i]) {
            if (check_ZFS_queue<WhiteNeighboursCount>(graph, subset).first) {
                zfs_exists = true;
                break;
            }
        }
        if (!zfs_exists) break;
    }
    return i+1;
}