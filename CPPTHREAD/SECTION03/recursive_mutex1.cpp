#include <iostream>
#include <thread>
#include <chrono>
#include <mutex>
using namespace std::literals;

//std::mutex m;
std::recursive_mutex m;
int share_data = 0;

void foo()
{
    m.lock();
    m.lock(); // 2회 소유
    share_data = 100;
    std::cout << "using share_data" << std::endl;
    m.unlock();
    m.unlock();
}
int main()
{
	std::thread t1(foo);
    std::thread t2(foo);
	t1.join();
	t2.join();
}

// 어떤 걸 생각해보냐면
//  하나의 thread가 먼저 도착했을 때, lock을 통해서 획득해. 일반적으로
//   뮤텍스를 한번 더 소유할 수 있느냐? 이걸 생각해보자.
//
//  std::mutex는 한번만 소유할 수 있다.
//  std::recursive_mutex는 하나의 thread가 여러번의 mutex 소유 가능 단, 소유한
//  횟수만큼 unlock해줘야함.
//
//  일반 thread로 lock을 두번할 경우 통과하지 못하고 deadlock걸림.
//  내부적으로 횟수를 관리함.

// 하나의 thread가 2번 소유해서 뭐합니까?
//  멤버함수는 자기들 끼리 호출 가능. -> lock한상태로 lock을 부름.. 
//  2번 lock이 되야함.
//
// recursive mutex가 없다면 member함수 상호호출 불가능!!
//
