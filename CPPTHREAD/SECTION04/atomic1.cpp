#include <iostream>
#include <thread>
#include <mutex>
#include <windows.h>

std::mutex m;
long x = 0; // 모든 스레드가 공유.

// ++ x의 어셈코드
// mov eax, x
// add eax, 1
// mov x, eax
//
// 이렇게 만들어짐 보통
//
// 해결책 1
//  OS가 제공하는 동기화 도구 -> lock
//	1을 증가 시키기 위해서 OS의 동기화도구를 사용하기는 무겁다
//
// 해결책 2
//	CPU가 제공하는 thread에 안전한 명령어가 있다.
//
//	ASM을 CPU가 제공하는 걸로 변경해보자.
//	 인텔 CPU의 경우 "lock" prefix사용
//

void foo()
{
    for ( int i = 0; i < 100000; ++i)
    {
//        m.lock();
//        ++x;
//        m.unlock();

// 인라인 어셈블리
// 쪼갤수 없는 연산 -> atomic oper

//        __asm
//        {
//            lock inc x
//        }
//        windows 환경에서 위의 명령어를 제공해주는 함수!ㅐ
//
//        windows 전용 linux가면 쓸 수 없음 -> 운영체제가 아니라 C++ 언어단에서
//        환경에 맞게 처리하도록 해줘야함. -> atomic
        InterlockedIncrement(&x); //
    }
}

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
