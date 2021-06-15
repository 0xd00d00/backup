#include <iostream>
#include <thread>
#include <mutex>
#include <chrono>
#include <condition_variable>
using namespace std::literals;
  
std::mutex m;
std::condition_variable cv;
bool data_ready = false;
int shared_data = 0;

void consumer()
{       
    std::this_thread::sleep_for(2s);
		// cond variable을 사용하는 가장 기본적 형태
    std::unique_lock<std::mutex> ul(m);  
    
		// 조건자는 함수를 넘겨야하는데 람다를 넘기면 됨..
    cv.wait( ul, [] { return data_ready;} );

    std::cout << "consume : " << shared_data << std::endl;
}

void producer()
{      
//    std::this_thread::sleep_for(2s);
    {
        std::lock_guard<std::mutex> lg(m);        
        shared_data = 100;
        data_ready = true;
        std::cout << "produce : " << shared_data << std::endl;    
    }
    cv.notify_one();
}

int main()
{
    std::thread t1(producer);
    std::thread t2(consumer);
    t1.join(); t2.join();
}
