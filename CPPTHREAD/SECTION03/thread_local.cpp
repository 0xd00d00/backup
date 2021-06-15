#include <iostream>
#include <thread>
#include <string_view>


// thread당 따로 놓이는 전역변수가 됨
thread_local int x = 0;

// 지역 변수이니까 호출이 끝날때마다 파괴됨
//  static 으로 만들면 됨 -> 3,6,9 가 나오게 하는 것.
//  static으로 만들면 single thread에선 문제 없다.
//
//  multi thread일떈 어떨까?
//  static을 사용하면 공유함.
//
//  A 도 3 6 9
//  B 도 3 6 9 
//  나오게 하려면.. ? 
//
// stack 은 thread당 한 개 함수 호출이 종료되면 파괴됨.
//
// static (data) 모든 thread가 공유됨
//  |  |
//  |  |
//
//  thread 한개 함수 호출이 종료되어도 파괴 되지 않는 메모리 공간 -> 운영체제
//  별로 -> Thred Local Storage ! TLS
//
//  thread 당 하나씩 가지고 있음 함수가 종료되도 파괴가 되지 않음 thread 별로
//  있는 static 공간
//
//  운영체제별로 TLS를 요청하는게 다 달랐음
//		-> linux -> _thread_static int
//		-> windows -> __declspec
//
//	C++11 와서 통합됨 -> thread_local
//
//	해당 하는 변수를 thread local thread에 저장해달라.
int next3times()
{
//	thread_local static int n = 0;
//	static을 표기하지 않아도 암시적으로 static이 됨.
	thread_local int n = 0;
	n = n + 3;
	return n;
}
void foo(std::string_view name)
{
	std::cout << name << " : " << next3times() << std::endl;
	std::cout << name << " : " << next3times() << std::endl;
	std::cout << name << " : " << next3times() << std::endl;
}
int main()
{
//	foo("A");
	std::thread t1(foo, "A");
	std::thread t2(foo, "\tB");

	t1.join();
	t2.join();
}



