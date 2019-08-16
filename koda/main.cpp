#include "check.hpp"
#include "utils.hpp"
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

    for (size_t i=0; i < Ns.size(); ++i) {
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
    // int n = 20;  // 25 -> 33 mio, maybe doable
    // Graph graph = Graph::cycle(n);
    // vvvi subsets = power_subset(n);
    // timeit(ZFN_top_down, graph, subsets);
    // timeit(ZFN_top_down_subsets, graph, subsets);

    int N = 100;
    vector<int> ns = {18};
    // vector<double> ps = {0.01, 0.4, 0.7};
    for (int n : ns) {
        vvvi subsets = power_subset(n);
        for (int j = 1; j < 100; ++j ) {
            double p = j / 100.0;
            cerr << p << "\n";
            // cout << "-----------------------\n";
            // cout << "n = " << n << ", p = " << p << "\n";
            for (int i=0; i < N; ++i) {
                if (i % 100 == 0) cerr << i << ", p = " << p << "\n";
                Graph graph = Graph::random_erdos_renyi(n, p);
                // cout << "top_down -> ";
                timeit(ZFN_top_down, graph, subsets);
                // cout << "top_down_subsets -> ";
                // timeit(ZFN_top_down_subsets, graph, subsets);
                // cout << "binary_search -> ";
                // timeit(ZFN_binary_search, graph, subsets);
            }
        }
    }
}

int main () {
    test_zfn();

    return 0;
}