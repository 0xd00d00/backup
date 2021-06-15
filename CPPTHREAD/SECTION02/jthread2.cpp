#include <chrono>
#include <iostream>
#include <thread>
using namespace std::literals;

void foo()
{
    for( int i = 0; i < 10; i++)
    {
        std::this_thread::sleep_for(500ms);
        std::cout << "foo : " << i << std::endl;
    }
}
void goo( std::stop_token token ) 
{     
    for( int i = 0; i < 10; i++)
    {
        if ( token.stop_requested() )
        {
            std::cout << "중지요청" << std::endl;
            return ;
        }

        std::this_thread::sleep_for(500ms);
        std::cout << "goo : " << i << std::endl;
    }
}
int main() 
{
    std::jthread j1(foo);
    std::jthread j2(goo);
    std::this_thread::sleep_for(2s);

    j1.request_stop();
		// 준다고 해서 바로 멈추는 것 아님
		// 한쪽에서 멈춘다고 해서 멈추는게아니라 받는 쪽에서 어떤 처리를 해줘야함 ->
		// 협력적인 관계
		//
		// stop_token을 가지고 있을 함수에서 가질 경우 인자를 가진 놈이 만들어진다.
		// jthread는 인자가 없는 것도 만들 수 있고, 인자에 stop_token이 있을 경우
		// 그것 또한 처리할 수 있도록 만들 수 있다.
    j2.request_stop();
}
