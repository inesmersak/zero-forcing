#include<iostream>
#include "Graph.h"
#include "common_graphs.h"

int main () {
    Graph K5 = complete_graph(5);
    Graph C4 = cycle(4);
    Graph P6 = path(6);
    
    cout << K5 << C4 << P6; 

    return 0;
}