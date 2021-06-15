#include <iostream>
#include <thread>
#include <string>
#include <chrono>
#include <semaphore>
using namespace std::literals;

// std::counting_semaphore<3> sem(0);
//  누군가가 release 해주면 들어오겠다..
//

// mutex와 동일한 동작.
//  lock을 획득한 thread만 unlock 가능하지만, 다른 곳에서 unlock이 가능..
//std::counting_semaphore<1> sem(1); 
std::binary_semaphore sem(1);
// using binary_semaphore = std::counting_semaphore<1>;

void Download(std::string name)
{ 
    sem.acquire(); 
    for (int i = 0; i < 100; i++)
    {
        std::cout << name;
        std::this_thread::sleep_for(30ms);
    }
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
