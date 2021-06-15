#include <iostream>
#include <thread>
#include <chrono>
#include <future>
using namespace std::literals;

int add(int a, int b)
{
    std::cout << "add : " << std::this_thread::get_id() << std::endl;    
    std::this_thread::sleep_for(2s);
    return a + b;
}
int main()
{
    std::future<int> ft = std::async( std::launch::async,    add, 10, 20);
//    std::future<int> ft = std::async( std::launch::deferred, add, 10, 20); // 지연된 실행
//    std::future<int> ft = std::async( std::launch::async | std::launch::deferred , add, 10, 20);
//    std::future<int> ft = std::async( add, 10, 20);

    std::cout << "continue main : " << std::this_thread::get_id() << std::endl;    
    std::this_thread::sleep_for(2s);
    int ret = ft.get();

    std::cout << "result : " << ret << std::endl;
}

// async를 사용하기 위해선 launch option을 줄 수 있다!
// launch async옵션을 주면 비동기로 해달라 -> 새로운 thread 만들어서 해주라.
// deferred launch를 할 경우 지연된 실행.
//	새로운 함수를 바로 만드는 것이 아니라, 결과가 필요할 때 실행해라 ->
//	그럼 결과가 필요할 때가 언제인가? => get()를 호출할 때 (동일 thread)이다.
//
//	async | deferred를 같이 넘기게 될 경우 새로운 thread가 결과 요청될
//	때실행된다?
//	 -> 표준 문서에 보면 환경에 따라 다르다고 나타나있음.
//		=> embeded, pc, mobile에 따라 async할수도 deferred할수도 있다.
//
//	아무옵션을 주지 않을 경우  async | deferred 옵션이 들어감
//		-> 환경에 따라 달라짐
//
//	새로운 thread를 명확하게 쓰고 싶다면 std::launch::async 을 명시적으로 해주는
//	것이 제일 좋음.
