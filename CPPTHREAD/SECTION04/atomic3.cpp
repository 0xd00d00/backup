#include <iostream>
#include <thread>
#include <atomic>

std::atomic<int> x{0};

void foo()
{
    for ( int i = 0; i < 100000; ++i)
    {
        //++x; // x.operator++()    
        //x.fetch_add(1);
				// 메모리 오더를 인자로 넘길 수 있음
				//  메모리 오더링을 변경해 좀 더 효율적으로 사용가능
        x.fetch_add(1, std::memory_order_relaxed);

				// memory_oreder
				//	- memory_oreder_releaxed
				//	- memory_order_consume
				//	- memory_order_acquire
				//	- memory_order_release
				//	- memory_order_acq_ref
				//	- memory_order_seq_cst
				//	  - default.. operator 재정의는 모두 이거이고 변경 불가능
    }
}

// std::atomic
//  다양한 atomic operation 을 제공하는 템플릿
//  <atomic>
//
// std::atomic 연산
//	연산자 재정의 함수 -> operator++ etc.
//	멤버함수 -> fetch_add, fetch_sub etc.

int main()
{
    std::thread t1(foo);
    std::thread t2(foo);
    std::thread t3(foo);
    t1.join();
    t2.join();
    t3.join();
    std::cout << x << std::endl;
}

