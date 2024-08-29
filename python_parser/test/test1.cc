#include <iostream>
#include <ranges>
#include <vector>

template<std::ranges::view R>
requires std::ranges::input_range<R>
class drop_view : public std::ranges::view_interface<drop_view<R>> {
private:
    R base;
    std::ranges::range_difference_t<R> count;

    // 내부 이터레이터 타입 정의
    using iterator = std::ranges::iterator_t<R>;

public:
    // 생성자
    drop_view(R base, std::ranges::range_difference_t<R> count)
        : base(std::move(base)), count(count) {}

    // 시작 이터레이터
    iterator begin() {
        auto it = std::ranges::begin(base);
        std::ranges::advance(it, count);
        return it;
    }

    // 종료 이터레이터
    iterator end() {
        return std::ranges::end(base);
    }
};

int main() {
    std::vector<int> v = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};

    // 원본 벡터를 역순으로 만든 뷰
    std::ranges::reverse_view rv(v);

    // drop_view로 3개의 요소를 제외한 뷰 생성
    drop_view dv(rv, 3);

    // 출력
    for (auto e : dv) {
        std::cout << e << ", ";
    }

    return 0;
}
