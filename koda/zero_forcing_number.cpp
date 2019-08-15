#include <cmath>
#include <set>
#include <vector>
#include "Graph.hpp"
#include "WhiteNeighbours.hpp"
#include "check.hpp"
#include "zero_forcing_number.hpp"

/* Returns all subsets of the set {1, ..., n} ordered by size (from 0 to n). */
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

/* Generates subsets of given sets which are smaller by 1. */
vvi smaller_subsets(vvi sets) {
    set<vector<int>> new_sets;
    for (auto set : sets) {
        size_t n = set.size();
        vvi curr_sets(n);
        for (size_t i=0; i < n; ++i) {
            for (size_t j=0; j < n; ++j) {
                if (j != i) curr_sets[j].push_back(set[i]);
                if (i == n-1) new_sets.insert(move(curr_sets[j]));
            }
        }
    }
    return vvi(new_sets.begin(), new_sets.end());
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

int ZFN_top_down_subsets(const Graph& graph, const vvvi& subsets) {
    int i;
    vvi eligible_subsets = subsets[graph.vertices_num()-1];
    for (i = graph.vertices_num()-1; i >= 0; --i) {
        auto it = eligible_subsets.begin();
        while (it != eligible_subsets.end()) {
            if (check_ZFS_queue<WhiteNeighboursCount>(graph, *it).first) ++it;
            else it = eligible_subsets.erase(it);
        }
        if (eligible_subsets.empty()) break;
        eligible_subsets = smaller_subsets(eligible_subsets);
    }
    return i+1;
}

int ZFN_binary_search(const Graph& graph, const vvvi& subsets) {
    int l = 1; int r = graph.vertices_num();
    for (auto subset : subsets[l]) {
        if (check_ZFS_queue<WhiteNeighboursCount>(graph, subset).first) {
            return l;
        }
    }
    while (l < r) {
        int m = static_cast<int>((l+r)/2);
        if (m == l) break;
        bool zfs_exists_mid = false;
        for (auto subset : subsets[m]) {
            if (check_ZFS_queue<WhiteNeighboursCount>(graph, subset).first) {
                zfs_exists_mid = true;
                break;
            }
        }
        if (zfs_exists_mid) r = m;
        else l = m;
    }
    return r;
}

// graf Zjev v odvisnosti od pjev za nek fiksen n, varianca / min / max
// histogram Zjev za konkreten n, p 

