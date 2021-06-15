#include <iostream>
#include <thread>
#include <chrono>
using namespace std::literals;

void foo(int a, double d)
{
	std::cout << "start foo" << std::endl;
	std::this_thread::sleep_for(2s);
	std::cout << "finish foo" << std::endl;
}

class mythread
{
	std::thread th;
public:
	template<typename F, typename ... ARGS> 
	explicit mythread(F&& f, ARGS&& ... args)
		: th(std::forward<F>(f), std::forward<ARGS>(args)...) {}

	~mythread()
	{
		if (th.joinable())
			th.join();
	}
};

int main()
{
    std::jthread t(foo, 10, 3.4);

//    mythread t(foo, 10, 3.4);
//	std::thread t(foo, 10, 3.4);
//    t.join();
}

/*
 * 표준 std::thread를 사용하려면 반드시 join 또는 detach해야함.
 * 매번 join이 귀찮을 수 있다.
 * class만들면서 join을 소멸될 때 자동으로 하면 편하지 않을까?
 *
 * C++20 부터는 자동으로 join되는 thread를 제공함. <thread> 헤더에
 * 포함되어져있음
 * std::jthread!
 *
 * 문서에서 보면 -> jthread = cooperatively interruptible + joining thread 
 * */



