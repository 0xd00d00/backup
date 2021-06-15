#include <iostream>
#include <thread>
#include <chrono>
#include <mutex>
using namespace std::literals;
// 내부적으로 호출 유무 기록..
// 복사와 이동을 모두 삭제함. 간단한 구조체
// -> 잘못사용하는거 방지
std::once_flag init_flag;
//std::once_flag a = init_flag;// error

void init(int a, double d)
{
    std::cout << "init" << std::endl;
    std::this_thread::sleep_for(2s);
}

void foo()
{
    std::cout << "start foo" << std::endl;
    //init(10, 3.4);    
    std::call_once(init_flag, init, 10, 3.4 );
	std::cout << "finish foo" << std::endl;
}
int main()
{
	// foo는 3번 부르는데.. init은 한번만
	std::thread t1(foo);
	std::thread t2(foo);
    std::thread t3(foo);
	t1.join();
	t2.join();
    t3.join();
}



