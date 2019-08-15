#include "check.hpp"
#include "zero_forcing_number.hpp"

void test_check() {
    double p = 0.7;  // random graph density

    vector<int> Ns = {100, 128, 163, 207, 264, 336, 429, 546, 696, 886, 1129, 1439, 1833, 2336, 2977, 3793, 4833, 6159, 7848, 10000};
    vector<Graph> graphs;
    vector<vector<int>> zfs;
    for (int N : Ns) {
        graphs.push_back(Graph::random_erdos_renyi(N, p));
        zfs.push_back(generate_random_zfs(N));
        // graphs.push_back(Graph::path(N));
        // zfs.push_back({0});
    }

    for (int i=0; i < Ns.size(); ++i) {
        cout << "---------------------\n";
        cout << "Graph size: " << Ns[i] << "\n";
        // cout << graphs[i];
        // cout << "ZFS: " << zfs[i];
        cout << "naive -> ";
        timeit(check_ZFS_naive, graphs[i], zfs[i]);
        cout << "queue_set -> ";
        timeit(check_ZFS_queue<WhiteNeighboursSet>, graphs[i], zfs[i]);
        cout << "queue_count -> ";
        timeit(check_ZFS_queue<WhiteNeighboursCount>, graphs[i], zfs[i]);
    }
}

void test_zfn() {
    
}

int main () {
    test_zfn();

    return 0;
}