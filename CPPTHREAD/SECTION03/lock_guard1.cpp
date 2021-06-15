#include <iostream>
#include <thread>
#include <mutex>
#include <exception>

std::mutex m;

void goo()
{
    std::lock_guard<std::mutex> lg(m);

//    m.lock();    
    std::cout << "using shared data" << std::endl;

//    throw std::exception();
//    m.unlock();
}

// 메인에서는 foo를 호출함. foo 내에서 goo를 호출하도록 되어져 있음.
// goo 에서는 공유자원 접근 위해서 lock을 이용함.
// 지금은 큰 문제가 없다.
// - 문제가 되는게.. 실수로 unlock을 해줄 수 없음
//	- deadlock 발생
//
// - 예외가 발생할 경우 unlock이 되지 않는다.
//	- throw std::exception() 할 경우 catch로 가고 thread는 대기 해야함.
//
// 사용자가 unlock을 할 경우 불편하고 안정성이 떨어짐 이럴 경우 smart pointer와
// 유사하게 lock_guard라는걸 사용함.
//
// 생성자에서 lock()하고 소멸자에서 unlock -> 간단한 도구 (RAII)
//  lock_guard가 내부적으로 mutex 가지고 있다가 소멸자에서 제거해 버림.
//
// C++ 에서는 예외가 발생하더라도 " 지역 변수 만큼은 안전하게 파괴 (stack
// unwinding)" 되므로 unlock() 이 보장됨.
//
//  mutex를 일찍 unlock하고 싶다면 block {} 을 해주면 됨.
void foo()
{
    try 
    {  
        goo(); 
    }
    catch(...)
    {
        std::cout << "catch exception" << std::endl;
    }
}

int main()
{
	std::thread t1(foo);
	std::thread t2(foo);
	t1.join();
	t2.join();
}



