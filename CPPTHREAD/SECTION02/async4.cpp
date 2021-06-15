#include <iostream>
#include <thread>
#include <chrono>
#include <future>
using namespace std::literals;

void foo(std::promise<int>&& p)
{
    std::cout << "start foo" << std::endl;
    std::this_thread::sleep_for(3s);
    std::cout << "finish foo" << std::endl;
    p.set_value(10);
}
int main()
{
    std::promise<int> p;    
    std::future<int> ft = p.get_future();
    
    std::thread t(foo, std::move(p));
    t.detach();
//    ft.get();
}

/*
 * 그럼 모든 future에서 반환값을 받지 않으면 동일하게 임시객체가 파괴 될때
 * thread 를 기다리는건가? -> nono.. async를 사용할때만..
 *
 * future가 소멸자로 인해 대기한 다는 것은 async를 활용해 반환된 future만
 * 그렇다..
 * */
