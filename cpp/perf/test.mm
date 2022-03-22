#import <vector>

int useIndex(const std::vector<int>& v) {
    return v[1];
}

int useAt(const std::vector<int>& v) {
    return v.at(1);
}