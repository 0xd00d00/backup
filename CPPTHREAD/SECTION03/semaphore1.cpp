#include <iostream>
#include <mutex>
#include <thread>
#include <string>
#include <chrono>
#include <semaphore>
using namespace std::literals;

// 몇개 까지 한정할거냐를 설정
std::counting_semaphore<3> sem(3); 
std::mutex m;

// semaphore c++ 20 부터 지원
// mutex는 자원에 대한 독점 -> 화장실 문을 통째로 잠궈버림
// semaphore는 counting 좀 더 작게
//
// 자원독점이 아닌 한정적 공유하고 싶을 때 semaphore 사용

void Download(std::string name)
{ 
    sem.acquire();
    //m.lock();
    for (int i = 0; i < 100; i++)
    {
        std::cout << name;
        std::this_thread::sleep_for(30ms);
    }
    //m.unlock();
    sem.release();
}
int main() 
{
    std::thread t1(Download, "1");
    std::thread t2(Download, "2");
    std::thread t3(Download, "3");
    std::thread t4(Download, "4");
    std::thread t5(Download, "5");

    t1.join();    t2.join();
    t3.join();    t4.join();
    t5.join();   
}
