#include <algorithm>
#include <iostream>
#include <string>
#include <vector>
using namespace std;

int main() {
    vector<string> vect;
    int number_of_items, length;
    cin >> number_of_items >> length;
    for (int i = 0; i < number_of_items; i++) {
        string x;
        cin >> x;
        vect.push_back(x);
    }
    sort(vect.begin(), vect.end());
    int cnt = 0;
    vector<int> counter;
    for(int index = 0; index < number_of_items-1; index++) {
        int common = 0;
        for(int char_index = 0; char_index < length; char_index++) {
            if(vect[index][char_index] == vect[index+1][char_index]) {
                common++;
            } else {
                common++;
                break;
            }
        }
        counter.push_back(common);
    }
    cnt+=counter[0];
    cnt+=counter[number_of_items-2];
    for(int index = 1; index < number_of_items-1; index++) {
        cnt += max(counter[index-1], counter[index]);
    }
    cout << cnt << '\n';
    return 0;
}