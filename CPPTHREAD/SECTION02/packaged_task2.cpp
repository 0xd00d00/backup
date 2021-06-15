#include <iostream>
#include <thread>
#include <future>

int add(int a, int b)
{
    std::cout << "add" << std::endl;
    return a + b;
		// 우리는 set value 사용 불가
}
int main()
{
    std::packaged_task<int(int, int)> task(add);
		// task 는 객체다. 해당 함수를 부르도록 설계
    std::future<int> ft = task.get_future();

    //task(10, 20); // add(10, 20)
    std::thread t(std::move(task), 10, 20);
    std::cout << "continue main" << std::endl;
    int ret = ft.get();
    std::cout << ret << std::endl;
    t.join();
}

// 멀티 thread를 고려하지 않고 작성된 함수를 "비동기로 실행하기 위해서는" =>
// packaged task를 이용하면 됨
// callable object (함수 함수 객체 람다 등)을 비동기 호출 (thread 호출) 할 수
// 있도록 래퍼를 만드는 도구

// 함수 모양이 망가지지 않아서 좋음 가장 널리 사용되는건 async이다.
