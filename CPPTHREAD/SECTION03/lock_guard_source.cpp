template <class _Mutex> class lock_guard 
{ 
public:
    using mutex_type = _Mutex;

    explicit lock_guard(_Mutex& _Mtx)      : _MyMutex(_Mtx) { _MyMutex.lock(); }
    lock_guard(_Mutex& _Mtx, adopt_lock_t) : _MyMutex(_Mtx) {} 
    
    ~lock_guard() noexcept {_MyMutex.unlock(); }

    lock_guard(const lock_guard&) = delete;
    lock_guard& operator=(const lock_guard&) = delete;
private:
    _Mutex& _MyMutex;
};

struct adopt_lock_t 
{ 
    explicit adopt_lock_t() = default;
};
constexpr adopt_lock_t adopt_lock {};

// 대부분 이렇게 구현됨.
// 생성자가 2개이다.
// - mutex 참조 받는 거
// - mutex 참조 + adopt lock 
// adopt lock은 empty class로 되어져 있음
//
// 이미 lock을 획득한 상태의 mutex를 잡겠다.
//  이미 왜 획득하나?
//		- 여러개의 mutex를 한번에 lock... 각각은 lock_guard를 통해서 함.
//
//	lock guard 사용하는 방법 2가지
//	- lock_guard(mutex);
//	- lock_guard(mutex, adopt_lock_t);
//		- 이미 획득한 lock 의 unlock을 수행
//
//	차이점은 생성자에서 lock을 하나의 차이
