#include <algorithm>
#include <vector>
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>

using namespace std;

vector<vector<int>> n_tree;

void read_tree()
{
    n_tree.clear();
    ifstream ifs("big.txt");
    while (!ifs.eof()) {
        string line;
        vector<int> row;
        getline(ifs, line);
        if(line == "\n" || line == "") continue;
        stringstream ss(line);
        while (!ss.eof()) {
            int i;
            ss >> i;
            row.push_back(i);
        }
        n_tree.push_back(row);
    }
}

int score(int r, int c)
{
    int n = n_tree[r][c];
    int left_c = c;
    int right_c = c + 1;
    int next_r = r + 1;
    if (next_r >= n_tree.size()) {
        return n;
    }
    return n + max(score(next_r, left_c), score(next_r, right_c));
}

int main()
{
    read_tree();
    for (auto row = n_tree.begin(); row != n_tree.end(); ++row) {
        for (auto col = row->begin(); col != row->end(); ++col) {
            cout << *col << " ";
        }
        cout << endl;
    }
    int i = score(0, 0);
    cout << i << endl;
}

