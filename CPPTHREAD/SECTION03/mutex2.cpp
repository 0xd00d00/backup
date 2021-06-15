#include <iostream>
#include <thread>
#include <chrono>
#include <mutex>
using namespace std::literals;

std::mutex m;
// mutex사용해서 보호할 거다.
int share_data = 0;

void foo()
{
		// 첫번째 thread가 들어와서 일을 할동안 두번째 thread는 대기
    //m.lock();
    if ( m.try_lock() )
    {
        share_data = 100;
        std::cout << "using share_data" << std::endl;
        m.unlock();
    }
    else
    {
        std::cout << "뮤텍스 획득 실패" << std::endl;
    }
}
int main()
{
	std::thread t1(foo);
	// 공유자원 사용이 짧기때문에 20ms정도만 delay해도 둘다 잡아서 사용가능
    std::this_thread::sleep_for(20ms);
    std::thread t2(foo);
	t1.join();
	t2.join();

    // mutex 의 native handle을 얻는 코드
    std::mutex::native_handle_type h = m.native_handle();
		// 운영체제 레벨에서 사용하는 hanlde을 얻을 수 있다. 이게 왜 좋을까?
		// handle의 데이터 타입이 다르다.
		//
		// mutex는 복사와 move rk 안된다.

//    std::mutex m2 = m; // error
}



