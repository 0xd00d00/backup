#include <iostream>
#include <thread>
#include <atomic>

struct Point   { int x, y; };
struct Point3D { int x, y, z; };

std::atomic<int>     at1;
std::atomic<Point>   at2; // at2.load(), at2.store()
std::atomic<Point3D> at3;

int main()
{
    ++at1; // lock xadd ... 
		// cpu level의 명령어를 사용해서 좀 더 효율적임
		// 동기화 할때 운영체제 레벨을 사용하지 않고 CPU 레벨의 명령 사용
		// lock-free <- 운영체제의 lock
		//

		// 구조체도 lock free가 되나?
		//	load, store는 사용가능
		//		store 멀티코어에 안전하게 저장해달라.
		//
		//	is_lock_free 는 가능하다. 대부분의 64비트는 가능
		//	64 비트 환경에서 한번에 올릴 수 있나 없나 체크

    std::cout << at1.is_lock_free() << std::endl; // 1
    std::cout << at2.is_lock_free() << std::endl; // 1 ok
    std::cout << at3.is_lock_free() << std::endl; // 0 
}

