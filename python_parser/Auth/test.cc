#include <vector>
#include <iostream>
#include <ranges>

template <std::ranges::view V>
class drop_view : public std::ranges::view_interface<drop_view<V>> {
private:
    V base_view;
    std::size_t drop_count;

public:
    // 생성자
    drop_view(V base, std::size_t count) 
        : base_view(std::move(base)), drop_count(count) {}

    // begin() 함수: drop_count 만큼 건너뛴 반복자 반환
    auto begin() {
        return std::ranges::next(base_view.begin(), drop_count, base_view.end());
    }

    // end() 함수: 기본 뷰의 끝 반복자 반환
    auto end() {
        return base_view.end();
    }

    // size() 함수: 뷰의 크기 반환
    auto size() requires std::ranges::sized_range<V> {
        return std::ranges::size(base_view) > drop_count 
            ? std::ranges::size(base_view) - drop_count 
            : 0;
    }
};

int main() {
    std::vector v = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    std::ranges::reverse_view rv(v); // 벡터를 역순으로 뒤집은 뷰
    drop_view dv(rv, 3); // 역순에서 앞의 3개를 제외한 뷰

    for (auto e : dv)
        std::cout << e << " "; // 예상 출력: 7, 6, 5, 4, 3, 2, 1

    return 0;
}
