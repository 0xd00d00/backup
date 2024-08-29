#include <iostream>
#include <ranges>
#include <vector>

template<std::ranges::view R>
requires std::ranges::input_range<R>
class drop_view : public std::ranges::view_interface<drop_view<R>> {
private:
    R base;
    std::ranges::range_difference_t<R> count;
    using iterator = std::ranges::iterator_t<R>;

public:
    drop_view(R base, std::ranges::range_difference_t<R> count)
        : base(std::move(base)), count(count) {}

    iterator begin() {
        auto it = std::ranges::begin(base);
        std::ranges::advance(it, count);
        return it;
    }

    iterator end() {
        return std::ranges::end(base);
    }
};

int main() {
    std::vector<int> v = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

    std::ranges::reverse_view rv(v);
    drop_view dv(rv, 3);

    for (auto e : dv)
        std::cout << e << ", ";
}
