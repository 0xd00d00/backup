#include <iostream>
#include <thread>
#include <chrono>
#include <future>
using namespace std::literals;

int add(int a, int b)
{
    std::this_thread::sleep_for(2s);
    return a + b;
}
int main()
{
     //add(10, 20); // 동기 호출 => 2초간 기다림. 비동기로 바꾸기 위해선 새로운
		 //thread를 만들어 시켜야함.
     std::future<int> ft = std::async(add, 10, 20);
		 // 기존에 작성함 함수를 간단하게 thread로 수행할 수 있다.
		 // async가 내부적으로 thread를 만듬
		 //		thread pool로 구현되어져 있음
		 //		일반적인 구현은 thread pool
		 //
		 //		thread id 넣어서 출력해보자

     std::cout << "continue main" << std::endl;
     int ret = ft.get();
     std::cout << "result : " << ret << std::endl;
}


/*
 * 비동기 함수 개념
 *
 * 일반함수들은 동기 (synchronous function) 함수이다.
 *  foo가 종료됐음을 보장받을 수 있음
 * 비동기 함수
 *  foo가 종료됐음을 보장할 수 없다.
 *
 *  비동기 함수는 2가지로 나눠 생각가능
 *		- I/O 작업을 수행 하는 비동기 함수
 *			- send(sock, data, ...)
 *			- 운영체제에서는 전송해야하는 데이터가 너무 클때 사용자에게는 다른일
 *			수행하라고 전달하고 백그라운드로 해당 일을 실행함.
 *			- threa를 만들기 보단, OS의 시스템 콜을 활용 (IOCP, EPOLL 등)
 *			- 사용자가 직접 thread를 만들기 보다는 system thread에 의존함.
 *
 *	- "연산을 수행"하는 비동기함수
 *		- foo가 내부적으로 복잡한 작업을 수행할때..
 *		- 사용자가 thread를 만들어 작업함.
 *
 *	- C++ thread 만드는 방법
 *		- std::thread
 *		- std::jthread (c++20)
 *		- std::async 사용
 *
 *
 * */

