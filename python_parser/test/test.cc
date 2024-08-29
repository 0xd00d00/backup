#include <iostream>
#include <iostream>
#include <ranges>

int main()
{
  std::vector v = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };

  std::ranges::rever_view rv(v);
  drp_view dv(rv, 3);

  for (auto e : dv)
    std::cout << e << ", ";
}
