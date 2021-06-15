#include <iostream>
#include <thread>
#include <mutex>
#include <chrono>

// 신호 기반의 동기화 도구
//  std::condition_variable -> 아래의 헤더 파일 필요
#include <condition_variable>
using namespace std::literals;
  
std::mutex m;
// 전역 하나 만들어야함.
std::condition_variable cv;
int shared_data = 0;

void consumer()
{
		// 생산자가 신호를 먼저 줬는데 아래와 같이 일을 수행하고 있다면 즉,
		// 소비가자 도착하지 않았다면.. -> 영원히 잠들게 되버림..
		//
		// 소비를 못하게 됨.. ㅠㅠ 늦게 도착해서 기다릴 건데.. 먼저 신호를
		// 줘버리면.. 
    std::this_thread::sleep_for(200ms);
    //std::lock_guard<std::mutex> lg(m);  
    std::unique_lock<std::mutex> ul(m);
		// 신호가 올때 까지 대기
		//  rule이 있음
		//  -> condition variable 을 잡기 위해선 mutex 중 unique lock을 사용해야함.
    cv.wait( ul );

		// 이게 어떻게 동작하나면.. -> mutex lock획득 후 wait에 unique lock을
		// 넘겨준다면 lock을 해제하고 신호가 올때까지 대기. 신호가 오면 다시 lock을
		// 획득해서 수행됨.
    std::cout << "consume : " << shared_data << std::endl;
}

void producer()
{
    std::this_thread::sleep_for(10ms);
    {
        std::lock_guard<std::mutex> lg(m);        
        shared_data = 100;
        std::cout << "produce : " << shared_data << std::endl;    
    }

		// 데이터 생성 후 깨어나라 하고 시그널 주면 됨.
		// signal 줄 때 lock이 필요없음!
		//  {} 을 하지 않고 전체적으로 lock을 잡을 경우 즉, signal을 하고 나서
		//  다른일을 할 경우 문제가 됨...
		//
		// 만약 3초를 주면 -> 신호 준 순간 깨어나지 못하고 3초 후에 깨어남..!
		// 데이터가 준비되면 lock 을 갖지말고 바로 풀어줘야함.
    cv.notify_one();
    //std::this_thread::sleep_for(3s);
}




int main()
{
    std::thread t1(producer);
    std::thread t2(consumer);
    t1.join(); t2.join();
}
