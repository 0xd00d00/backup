C++ 표준이 제공하는 mutex의 종류는 총 6가지이다.

std::mutex -> c++11
std::recursive_mutex -> c++11
std::shared_mutex -> c++17

std::timed_mutex -> c++11
std::recursive_timed_mutex -> c++11
std::shared_timed_mutex -> c++14

timed 유무 차이..

mutex와 timed 개념 차이를 알아야함.

mutex2.cpp코드 보면서 이해.

mutex member function
- lock
	- block되서 대기
- try_lock
	- mutex 획득하지 못할 경우 false return해서 다른 작업을 할 수 있게 함.
- unlock
- native_handle


member type
- native_handle_type

std::mutex vs std::timed_mutex

timed mutex는 두가지의 멤버를 더 가지고 있음
- try_lock_for
- try_lock_util

특정 시간 동안 / 까지 대기하고 try할 수 있도록 추가함.


Shared mutex c++14 부터 추가됨

- 공유된 데이터.
하나의 thread가 데이터를 쓰고 다른 thread가 읽는다고 가정해보자.
mutex를 이용해서 보호를 해야함.
아무 문제 없이 잘 쓰고 읽는다.

만약 reader thread를 2개를 더 만들어보자.
실행해도 문제는 안됨.

thread 쓰는 동안에는 읽으면 안된다.
읽는 동안에는 쓸 수 없어야한다.
이게 핵심 (성능개선)
하나의 thread가 읽는 동안에는 다른 thread도 읽을 수 있어야한다!

mutex 하나 놓고 경쟁하니까 읽는 thread에서도 동기화를 해버림.

이런 문제를 해결하는게 std::shared_mutex를 사용
shared mutex는 header가 별도로 존재함.

write하는동안에는 아무도 접근하면 안됨..

m.lock_shared라는걸 사용하면 shared ownership이라고 해서 Reader 끼리는 공유가
가능해짐.


