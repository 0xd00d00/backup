#include <iostream>
#include <thread>
#include <string>
#include <chrono>
#include <semaphore>
using namespace std::literals;

// semaphore의 기본 형태는 counting semaphore이다. MAX_COUNT를 전달해서
// 초기화함.
//
// 최대값이랑 현재 카운터 값을 저장함. 0 <= counter <= MAX 임.
// 조건
//
std::counting_semaphore<3> sem(3); 

/*
 * if (sem.counter > 0) --sem.counter;
 * else wait sem.counter > 0
 * ---- acquire ----- 
 *
 * default 가 1 
 * update = 1
 * sem.counter += update
 * "update < 0 " or
 *   " sem.counter + update < MAX" 라면
 * syd::system error
 *
 * ---- release ---- 
 * */

void Download(std::string name)
{ 
    sem.acquire(); // -- sem.counter

    for (int i = 0; i < 100; i++)
    {
        std::cout << name;
        std::this_thread::sleep_for(30ms);
    }

    sem.release(); // sem.counter += 1
}
int main() 
{
    std::thread t1(Download, "1");
    std::thread t2(Download, "2");
    std::thread t3(Download, "3");
    std::thread t4(Download, "4");
    std::thread t5(Download, "5");

    std::this_thread::sleep_for(2s);
    std::cout << "\n main \n";
    //sem.release();
    sem.release(2);

    t1.join();    t2.join();
    t3.join();    t4.join();
    t5.join();   
}
