#include <iostream>
#include <thread>
#include <chrono>
#include <future>
using namespace std::literals;

int add(int a, int b)
{
    std::cout << "start add" << std::endl;    
    std::this_thread::sleep_for(2s);
    std::cout << "finish add" << std::endl;    
    return a + b;
}
int main()
{
//    std::future<int> ft = std::async( std::launch::async, add, 10, 20);
    
    std::async( std::launch::async, add, 10, 20);
//    std::async( std::launch::async, add, 10, 20);

    std::cout << "continue main " << std::endl;    

//    int ret = ft.get();
}

// std::async의 반환값 은 future이다. 만약 get을 안하게 될 경우 어떻게 될까?
//
// future의 소멸자에서 get()을 호출 함. 따라서, 새로운 thread가 종료될때까지
// 대기해버림...
//
// std::async의 반환값을 받지 않을 경우 어떻게 될까?
//	반환값을 안받는다고 없는게 아니다. 값으로 반환하기 때문에 임시객체이다.
//	임시객체는 문장의 끝에서 파괴 되는데.. 임시객체 내에서 get을 호출함.
//	반환값을 안받으면 밑으로 내려갈 수 없고.. 끝날때 까지 대기해버림.

