#include <iostream>
#include <thread>
#include <chrono>
#include <string_view>
#include <mutex>
using namespace std::literals;

std::mutex m;

// 시간 지연하기 위해 만듬
void delay() { std::this_thread::sleep_for(20ms);}

// 두개의 thread를 만들어 foo를 수행하게 함.
void foo(std::string_view name )
{
    //int x = 0;
    static int x = 0;

    for ( int i = 0; i < 10; i++)
    {
        m.lock();
        x = 100; delay();
        x = x+1; delay();
        std::cout << name << " : " << x << std::endl; delay();
        m.unlock();
    }
}

int main()
{
	std::thread t1(foo, "A");
	std::thread t2(foo, "\tB");
	t1.join();
	t2.join();
}


// 함수가 하나 밖에 없을 때 지역 변수 1개가 있을 경우..
//
// local variable은 스택에 놓인다.
// thread당 stack은 하나씩 만들어짐. -> 즉, 지역 변수가 있을 경우 메모리에
// 두개의 local이 만들어진다고 생각하면 됨.
//
// 서로를 간섭하지 않는다. 안전하게 101이 나올 것임.
//
// local variable은 thread에 안전하다.
//
//
// static 지역 변수 혹은 전역변수
//  -> data 메모리에 놓임
//  -> 모든 thread가 공유함.
//
//  출력값이 어떻게 나올지 예측 불가..
// 만약에 파일 열고 쓰고 닫기를 할경우.. -> 다른 thread 가쓰게 되면 무결성이
// 망가짐..
//
// 하나의 thread가 들어와서 다하고 나갈때 까지 다른 thread는 들어오면 안됨. ->
// 임계영역이라고 부른다.
//
// static 지역 변수는 thread에 안전하지 않다. 안전하게 쓸수 있도록 방어를
// 해야함.
//
//
// mutex를 만들어서 lock 과 unlock을 걸면됨.
// 내가 문을 잠그고 들어갈테니 내가 일할동안 방해 노노..
//
// 먼저 thread가 unlock할때까지 기다려야함.
//
// C++ 에서 mutex를 사용하기 위해서는 mutex를 만들고 전역으로 mutex를 잡으면 됨
// 병렬로 내려오다가 한줄씩 나오게 되는 것은 serialization이라고 부른다.
