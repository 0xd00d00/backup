; Listing generated by Microsoft (R) Optimizing Compiler Version 19.29.30031.0 

	TITLE	A:\CPP\05_CONCURRENT\ONLINE\SECTION04\test3.obj
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB LIBCMT
INCLUDELIB OLDNAMES

PUBLIC	?x@@3U?$atomic@J@std@@A				; x
_BSS	SEGMENT
?x@@3U?$atomic@J@std@@A DD 01H DUP (?)			; x
_BSS	ENDS
CONST	SEGMENT
?_Fake_alloc@std@@3U_Fake_allocator@1@B	ORG $+1		; std::_Fake_alloc
CONST	ENDS
PUBLIC	?join@thread@std@@QAEXXZ			; std::thread::join
PUBLIC	?foo@@YAXXZ					; foo
PUBLIC	_main
PUBLIC	??$_Atomic_address_as@JU?$_Atomic_padded@J@std@@@std@@YAPCJAAU?$_Atomic_padded@J@0@@Z ; std::_Atomic_address_as<long,std::_Atomic_padded<long> >
PUBLIC	??$_Start@A6AXXZ$$V@thread@std@@AAEXA6AXXZ@Z	; std::thread::_Start<void (__cdecl&)(void)>
PUBLIC	??$make_unique@V?$tuple@P6AXXZ@std@@A6AXXZ$0A@@std@@YA?AV?$unique_ptr@V?$tuple@P6AXXZ@std@@U?$default_delete@V?$tuple@P6AXXZ@std@@@2@@0@A6AXXZ@Z ; std::make_unique<std::tuple<void (__cdecl*)(void)>,void (__cdecl&)(void),0>
PUBLIC	??$_Invoke@V?$tuple@P6AXXZ@std@@$0A@@thread@std@@CGIPAX@Z ; std::thread::_Invoke<std::tuple<void (__cdecl*)(void)>,0>
EXTRN	??2@YAPAXI@Z:PROC				; operator new
EXTRN	??3@YAXPAXI@Z:PROC				; operator delete
EXTRN	_terminate:PROC
EXTRN	__Thrd_join:PROC
EXTRN	__Thrd_id:PROC
EXTRN	__Cnd_do_broadcast_at_thread_exit:PROC
EXTRN	?_Throw_Cpp_error@std@@YAXH@Z:PROC		; std::_Throw_Cpp_error
EXTRN	__beginthreadex:PROC
; Function compile flags: /Odtp
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\thread
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\xmemory
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\type_traits
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\thread
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\thread
;	COMDAT ??$_Invoke@V?$tuple@P6AXXZ@std@@$0A@@thread@std@@CGIPAX@Z
_TEXT	SEGMENT
$T1 = -28						; size = 4
$T2 = -24						; size = 4
__Ptr$ = -20						; size = 4
__Tup$ = -16						; size = 4
__Ptr$ = -12						; size = 4
_this$ = -8						; size = 4
__FnVals$ = -4						; size = 4
__RawVals$ = 8						; size = 4
??$_Invoke@V?$tuple@P6AXXZ@std@@$0A@@thread@std@@CGIPAX@Z PROC ; std::thread::_Invoke<std::tuple<void (__cdecl*)(void)>,0>, COMDAT

; 51   :     static unsigned int __stdcall _Invoke(void* _RawVals) noexcept /* terminates */ {

	push	ebp
	mov	ebp, esp
	sub	esp, 28					; 0000001cH

; 52   :         // adapt invoke of user's callable object to _beginthreadex's thread procedure
; 53   :         const unique_ptr<_Tuple> _FnVals(static_cast<_Tuple*>(_RawVals));

	mov	eax, DWORD PTR __RawVals$[ebp]
	mov	DWORD PTR __Ptr$[ebp], eax
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory

; 3155 :     explicit unique_ptr(pointer _Ptr) noexcept : _Mypair(_Zero_then_variadic_args_t{}, _Ptr) {}

	lea	ecx, DWORD PTR __FnVals$[ebp]
	mov	DWORD PTR _this$[ebp], ecx
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\xmemory

; 1370 :         : _Ty1(), _Myval2(_STD forward<_Other2>(_Val2)...) {}

	mov	edx, DWORD PTR _this$[ebp]
	mov	eax, DWORD PTR __Ptr$[ebp]
	mov	DWORD PTR [edx], eax
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory

; 3225 :         return *_Mypair._Myval2;

	mov	ecx, DWORD PTR __FnVals$[ebp]
	mov	DWORD PTR __Tup$[ebp], ecx
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\type_traits

; 1585 :     return static_cast<_Callable&&>(_Obj)();

	mov	edx, DWORD PTR __Tup$[ebp]
	mov	eax, DWORD PTR [edx]
	call	eax
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\thread

; 56   :         _Cnd_do_broadcast_at_thread_exit(); // TRANSITION, ABI

	call	__Cnd_do_broadcast_at_thread_exit

; 57   :         return 0;

	mov	DWORD PTR $T1[ebp], 0
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory

; 3211 :         if (_Mypair._Myval2) {

	cmp	DWORD PTR __FnVals$[ebp], 0
	je	SHORT $LN17@Invoke

; 3212 :             _Mypair._Get_first()(_Mypair._Myval2);

	mov	ecx, DWORD PTR __FnVals$[ebp]
	mov	DWORD PTR __Ptr$[ebp], ecx

; 3102 :         delete _Ptr;

	mov	edx, DWORD PTR __Ptr$[ebp]
	mov	DWORD PTR $T2[ebp], edx
	push	4
	mov	eax, DWORD PTR $T2[ebp]
	push	eax
	call	??3@YAXPAXI@Z				; operator delete
	add	esp, 8
$LN17@Invoke:
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\thread

; 57   :         return 0;

	mov	eax, DWORD PTR $T1[ebp]

; 58   :     }

	mov	esp, ebp
	pop	ebp
	ret	4
??$_Invoke@V?$tuple@P6AXXZ@std@@$0A@@thread@std@@CGIPAX@Z ENDP ; std::thread::_Invoke<std::tuple<void (__cdecl*)(void)>,0>
_TEXT	ENDS
; Function compile flags: /Odtp
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\tuple
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\xmemory
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\utility
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\xmemory
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory
;	COMDAT ??$make_unique@V?$tuple@P6AXXZ@std@@A6AXXZ$0A@@std@@YA?AV?$unique_ptr@V?$tuple@P6AXXZ@std@@U?$default_delete@V?$tuple@P6AXXZ@std@@@2@@0@A6AXXZ@Z
_TEXT	SEGMENT
$T1 = -56						; size = 4
__Ptr$ = -52						; size = 4
$T2 = -48						; size = 4
_this$ = -44						; size = 4
__Old_val$3 = -40					; size = 4
$T4 = -36						; size = 4
__Ptr$ = -32						; size = 4
_this$ = -28						; size = 4
$T5 = -24						; size = 4
_this$6 = -20						; size = 4
__Val$7 = -16						; size = 4
tv79 = -12						; size = 4
$T8 = -8						; size = 4
$T9 = -4						; size = 4
___$ReturnUdt$ = 8					; size = 4
_<_Args_0>$ = 12					; size = 4
??$make_unique@V?$tuple@P6AXXZ@std@@A6AXXZ$0A@@std@@YA?AV?$unique_ptr@V?$tuple@P6AXXZ@std@@U?$default_delete@V?$tuple@P6AXXZ@std@@@2@@0@A6AXXZ@Z PROC ; std::make_unique<std::tuple<void (__cdecl*)(void)>,void (__cdecl&)(void),0>, COMDAT

; 3397 : _NODISCARD unique_ptr<_Ty> make_unique(_Types&&... _Args) { // make a unique_ptr

	push	ebp
	mov	ebp, esp
	sub	esp, 56					; 00000038H

; 3398 :     return unique_ptr<_Ty>(new _Ty(_STD forward<_Types>(_Args)...));

	push	4
	call	??2@YAPAXI@Z				; operator new
	add	esp, 4
	mov	DWORD PTR $T9[ebp], eax
	cmp	DWORD PTR $T9[ebp], 0
	je	SHORT $LN3@make_uniqu
	mov	eax, DWORD PTR _<_Args_0>$[ebp]
	mov	DWORD PTR $T5[ebp], eax
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\tuple

; 258  :         : _Mybase(_Exact_args_t{}, _STD forward<_Rest2>(_Rest_arg)...), _Myfirst(_STD forward<_This2>(_This_arg)) {}

	mov	ecx, DWORD PTR $T9[ebp]
	mov	DWORD PTR _this$6[ebp], ecx

; 170  :     constexpr _Tuple_val(_Other&& _Arg) : _Val(_STD forward<_Other>(_Arg)) {}

	mov	edx, DWORD PTR _this$6[ebp]
	mov	eax, DWORD PTR $T5[ebp]
	mov	DWORD PTR [edx], eax
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory

; 3398 :     return unique_ptr<_Ty>(new _Ty(_STD forward<_Types>(_Args)...));

	mov	ecx, DWORD PTR $T9[ebp]
	mov	DWORD PTR tv79[ebp], ecx
	jmp	SHORT $LN4@make_uniqu
$LN3@make_uniqu:
	mov	DWORD PTR tv79[ebp], 0
$LN4@make_uniqu:
	mov	edx, DWORD PTR tv79[ebp]
	mov	DWORD PTR __Ptr$[ebp], edx

; 3155 :     explicit unique_ptr(pointer _Ptr) noexcept : _Mypair(_Zero_then_variadic_args_t{}, _Ptr) {}

	lea	eax, DWORD PTR $T8[ebp]
	mov	DWORD PTR _this$[ebp], eax
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\xmemory

; 1370 :         : _Ty1(), _Myval2(_STD forward<_Other2>(_Val2)...) {}

	mov	ecx, DWORD PTR _this$[ebp]
	mov	edx, DWORD PTR __Ptr$[ebp]
	mov	DWORD PTR [ecx], edx
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory

; 3241 :         return _STD exchange(_Mypair._Myval2, nullptr);

	mov	DWORD PTR $T4[ebp], 0
	lea	eax, DWORD PTR $T8[ebp]
	mov	DWORD PTR __Val$7[ebp], eax
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\utility

; 616  :     _Ty _Old_val = static_cast<_Ty&&>(_Val);

	mov	ecx, DWORD PTR __Val$7[ebp]
	mov	edx, DWORD PTR [ecx]
	mov	DWORD PTR __Old_val$3[ebp], edx

; 617  :     _Val         = static_cast<_Other&&>(_New_val);

	mov	eax, DWORD PTR __Val$7[ebp]
	mov	ecx, DWORD PTR $T4[ebp]
	mov	DWORD PTR [eax], ecx
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory

; 3170 :         : _Mypair(_One_then_variadic_args_t{}, _STD forward<_Dx>(_Right.get_deleter()), _Right.release()) {}

	mov	edx, DWORD PTR __Old_val$3[ebp]
	mov	DWORD PTR $T2[ebp], edx
	mov	eax, DWORD PTR ___$ReturnUdt$[ebp]
	mov	DWORD PTR _this$[ebp], eax
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\xmemory

; 1375 :         : _Ty1(_STD forward<_Other1>(_Val1)), _Myval2(_STD forward<_Other2>(_Val2)...) {}

	mov	ecx, DWORD PTR _this$[ebp]
	mov	edx, DWORD PTR $T2[ebp]
	mov	DWORD PTR [ecx], edx
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory

; 3211 :         if (_Mypair._Myval2) {

	cmp	DWORD PTR $T8[ebp], 0
	je	SHORT $LN43@make_uniqu

; 3212 :             _Mypair._Get_first()(_Mypair._Myval2);

	mov	eax, DWORD PTR $T8[ebp]
	mov	DWORD PTR __Ptr$[ebp], eax

; 3102 :         delete _Ptr;

	mov	ecx, DWORD PTR __Ptr$[ebp]
	mov	DWORD PTR $T1[ebp], ecx
	push	4
	mov	edx, DWORD PTR $T1[ebp]
	push	edx
	call	??3@YAXPAXI@Z				; operator delete
	add	esp, 8
$LN43@make_uniqu:

; 3398 :     return unique_ptr<_Ty>(new _Ty(_STD forward<_Types>(_Args)...));

	mov	eax, DWORD PTR ___$ReturnUdt$[ebp]

; 3399 : }

	mov	esp, ebp
	pop	ebp
	ret	0
??$make_unique@V?$tuple@P6AXXZ@std@@A6AXXZ$0A@@std@@YA?AV?$unique_ptr@V?$tuple@P6AXXZ@std@@U?$default_delete@V?$tuple@P6AXXZ@std@@@2@@0@A6AXXZ@Z ENDP ; std::make_unique<std::tuple<void (__cdecl*)(void)>,void (__cdecl&)(void),0>
_TEXT	ENDS
; Function compile flags: /Odtp
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\thread
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\utility
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\xmemory
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\thread
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\thread
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\utility
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\thread
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\thread
;	COMDAT ??$_Start@A6AXXZ$$V@thread@std@@AAEXA6AXXZ@Z
_TEXT	SEGMENT
__Old_val$1 = -72					; size = 4
$T2 = -68						; size = 4
__Ptr$ = -64						; size = 4
$T3 = -60						; size = 4
__Invoker_proc$ = -56					; size = 4
$T4 = -52						; size = 4
$T5 = -48						; size = 4
__Ptr$ = -44						; size = 4
$T6 = -40						; size = 4
_this$ = -36						; size = 4
__Old_val$7 = -32					; size = 4
$T8 = -28						; size = 4
__Right$ = -24						; size = 4
__Val$ = -20						; size = 4
$T9 = -16						; size = 4
__Val$10 = -12						; size = 4
__Decay_copied$ = -8					; size = 4
_this$ = -4						; size = 4
__Fx$ = 8						; size = 4
??$_Start@A6AXXZ$$V@thread@std@@AAEXA6AXXZ@Z PROC	; std::thread::_Start<void (__cdecl&)(void)>, COMDAT
; _this$ = ecx

; 66   :     void _Start(_Fn&& _Fx, _Args&&... _Ax) {

	push	ebp
	mov	ebp, esp
	sub	esp, 72					; 00000048H
	mov	DWORD PTR _this$[ebp], ecx

; 67   :         using _Tuple                 = tuple<decay_t<_Fn>, decay_t<_Args>...>;
; 68   :         auto _Decay_copied           = _STD make_unique<_Tuple>(_STD forward<_Fn>(_Fx), _STD forward<_Args>(_Ax)...);

	mov	eax, DWORD PTR __Fx$[ebp]
	push	eax
	lea	ecx, DWORD PTR $T9[ebp]
	push	ecx
	call	??$make_unique@V?$tuple@P6AXXZ@std@@A6AXXZ$0A@@std@@YA?AV?$unique_ptr@V?$tuple@P6AXXZ@std@@U?$default_delete@V?$tuple@P6AXXZ@std@@@2@@0@A6AXXZ@Z ; std::make_unique<std::tuple<void (__cdecl*)(void)>,void (__cdecl&)(void),0>
	add	esp, 8
	mov	DWORD PTR __Right$[ebp], eax
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory

; 3241 :         return _STD exchange(_Mypair._Myval2, nullptr);

	mov	DWORD PTR $T8[ebp], 0
	mov	edx, DWORD PTR __Right$[ebp]
	mov	DWORD PTR __Val$10[ebp], edx
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\utility

; 616  :     _Ty _Old_val = static_cast<_Ty&&>(_Val);

	mov	eax, DWORD PTR __Val$10[ebp]
	mov	ecx, DWORD PTR [eax]
	mov	DWORD PTR __Old_val$7[ebp], ecx

; 617  :     _Val         = static_cast<_Other&&>(_New_val);

	mov	edx, DWORD PTR __Val$10[ebp]
	mov	eax, DWORD PTR $T8[ebp]
	mov	DWORD PTR [edx], eax
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory

; 3170 :         : _Mypair(_One_then_variadic_args_t{}, _STD forward<_Dx>(_Right.get_deleter()), _Right.release()) {}

	mov	ecx, DWORD PTR __Old_val$7[ebp]
	mov	DWORD PTR $T6[ebp], ecx
	lea	edx, DWORD PTR __Decay_copied$[ebp]
	mov	DWORD PTR _this$[ebp], edx
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\xmemory

; 1375 :         : _Ty1(_STD forward<_Other1>(_Val1)), _Myval2(_STD forward<_Other2>(_Val2)...) {}

	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR $T6[ebp]
	mov	DWORD PTR [eax], ecx
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory

; 3211 :         if (_Mypair._Myval2) {

	cmp	DWORD PTR $T9[ebp], 0
	je	SHORT $LN25@Start

; 3212 :             _Mypair._Get_first()(_Mypair._Myval2);

	mov	edx, DWORD PTR $T9[ebp]
	mov	DWORD PTR __Ptr$[ebp], edx

; 3102 :         delete _Ptr;

	mov	eax, DWORD PTR __Ptr$[ebp]
	mov	DWORD PTR $T5[ebp], eax
	push	4
	mov	ecx, DWORD PTR $T5[ebp]
	push	ecx
	call	??3@YAXPAXI@Z				; operator delete
	add	esp, 8
$LN25@Start:
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\thread

; 69   :         constexpr auto _Invoker_proc = _Get_invoke<_Tuple>(make_index_sequence<1 + sizeof...(_Args)>{});

	mov	DWORD PTR __Invoker_proc$[ebp], OFFSET ??$_Invoke@V?$tuple@P6AXXZ@std@@$0A@@thread@std@@CGIPAX@Z ; std::thread::_Invoke<std::tuple<void (__cdecl*)(void)>,0>
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory

; 3233 :         return _Mypair._Myval2;

	mov	edx, DWORD PTR __Decay_copied$[ebp]
	mov	DWORD PTR $T4[ebp], edx
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\thread

; 75   :         _Thr._Hnd =

	mov	eax, DWORD PTR _this$[ebp]
	add	eax, 4
	push	eax
	push	0
	mov	ecx, DWORD PTR $T4[ebp]
	push	ecx
	mov	edx, DWORD PTR __Invoker_proc$[ebp]
	push	edx
	push	0
	push	0
	call	__beginthreadex
	add	esp, 24					; 00000018H
	mov	ecx, DWORD PTR _this$[ebp]
	mov	DWORD PTR [ecx], eax

; 76   :             reinterpret_cast<void*>(_CSTD _beginthreadex(nullptr, 0, _Invoker_proc, _Decay_copied.get(), 0, &_Thr._Id));
; 77   : #pragma warning(pop)
; 78   : 
; 79   :         if (_Thr._Hnd) { // ownership transferred to the thread

	mov	edx, DWORD PTR _this$[ebp]
	cmp	DWORD PTR [edx], 0
	je	SHORT $LN2@Start
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory

; 3241 :         return _STD exchange(_Mypair._Myval2, nullptr);

	mov	DWORD PTR $T3[ebp], 0
	lea	eax, DWORD PTR __Decay_copied$[ebp]
	mov	DWORD PTR __Val$[ebp], eax
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\utility

; 616  :     _Ty _Old_val = static_cast<_Ty&&>(_Val);

	mov	ecx, DWORD PTR __Val$[ebp]
	mov	edx, DWORD PTR [ecx]
	mov	DWORD PTR __Old_val$1[ebp], edx

; 617  :     _Val         = static_cast<_Other&&>(_New_val);

	mov	eax, DWORD PTR __Val$[ebp]
	mov	ecx, DWORD PTR $T3[ebp]
	mov	DWORD PTR [eax], ecx
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\thread

; 81   :         } else { // failed to start thread

	jmp	SHORT $LN3@Start
$LN2@Start:

; 82   :             _Thr._Id = 0;

	mov	edx, DWORD PTR _this$[ebp]
	mov	DWORD PTR [edx+4], 0

; 83   :             _Throw_Cpp_error(_RESOURCE_UNAVAILABLE_TRY_AGAIN);

	push	6
	call	?_Throw_Cpp_error@std@@YAXH@Z		; std::_Throw_Cpp_error
$LN3@Start:
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\memory

; 3211 :         if (_Mypair._Myval2) {

	cmp	DWORD PTR __Decay_copied$[ebp], 0
	je	SHORT $LN4@Start

; 3212 :             _Mypair._Get_first()(_Mypair._Myval2);

	mov	eax, DWORD PTR __Decay_copied$[ebp]
	mov	DWORD PTR __Ptr$[ebp], eax

; 3102 :         delete _Ptr;

	mov	ecx, DWORD PTR __Ptr$[ebp]
	mov	DWORD PTR $T2[ebp], ecx
	push	4
	mov	edx, DWORD PTR $T2[ebp]
	push	edx
	call	??3@YAXPAXI@Z				; operator delete
	add	esp, 8
$LN4@Start:
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\thread

; 85   :     }

	mov	esp, ebp
	pop	ebp
	ret	4
??$_Start@A6AXXZ$$V@thread@std@@AAEXA6AXXZ@Z ENDP	; std::thread::_Start<void (__cdecl&)(void)>
_TEXT	ENDS
; Function compile flags: /Odtp
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\xatomic.h
;	COMDAT ??$_Atomic_address_as@JU?$_Atomic_padded@J@std@@@std@@YAPCJAAU?$_Atomic_padded@J@0@@Z
_TEXT	SEGMENT
__Source$ = 8						; size = 4
??$_Atomic_address_as@JU?$_Atomic_padded@J@std@@@std@@YAPCJAAU?$_Atomic_padded@J@0@@Z PROC ; std::_Atomic_address_as<long,std::_Atomic_padded<long> >, COMDAT

; 98   : _NODISCARD volatile _Integral* _Atomic_address_as(_Ty& _Source) noexcept {

	push	ebp
	mov	ebp, esp

; 99   :     // gets a pointer to the argument as an integral type (to pass to intrinsics)
; 100  :     static_assert(is_integral_v<_Integral>, "Tried to reinterpret memory as non-integral");
; 101  :     return &reinterpret_cast<volatile _Integral&>(_Source);

	mov	eax, DWORD PTR __Source$[ebp]

; 102  : }

	pop	ebp
	ret	0
??$_Atomic_address_as@JU?$_Atomic_padded@J@std@@@std@@YAPCJAAU?$_Atomic_padded@J@0@@Z ENDP ; std::_Atomic_address_as<long,std::_Atomic_padded<long> >
_TEXT	ENDS
; Function compile flags: /Odtp
; File A:\CPP\05_CONCURRENT\ONLINE\SECTION04\test3.cpp
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\thread
; File A:\CPP\05_CONCURRENT\ONLINE\SECTION04\test3.cpp
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\thread
; File A:\CPP\05_CONCURRENT\ONLINE\SECTION04\test3.cpp
_TEXT	SEGMENT
_t$ = -12						; size = 8
tv142 = -4						; size = 4
_main	PROC

; 18   : {

	push	ebp
	mov	ebp, esp
	sub	esp, 12					; 0000000cH
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\thread

; 90   :         _Start(_STD forward<_Fn>(_Fx), _STD forward<_Args>(_Ax)...);

	push	OFFSET ?foo@@YAXXZ			; foo
	lea	ecx, DWORD PTR _t$[ebp]
	call	??$_Start@A6AXXZ$$V@thread@std@@AAEXA6AXXZ@Z ; std::thread::_Start<void (__cdecl&)(void)>
; File A:\CPP\05_CONCURRENT\ONLINE\SECTION04\test3.cpp

; 21   :     t.join();

	lea	ecx, DWORD PTR _t$[ebp]
	call	?join@thread@std@@QAEXXZ		; std::thread::join
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\thread

; 118  :         return _Thr._Id != 0;

	cmp	DWORD PTR _t$[ebp+4], 0
	je	SHORT $LN65@main
	mov	DWORD PTR tv142[ebp], 1
	jmp	SHORT $LN63@main
$LN65@main:
	mov	DWORD PTR tv142[ebp], 0
$LN63@main:

; 94   :         if (joinable()) {

	movzx	eax, BYTE PTR tv142[ebp]
	test	eax, eax
	je	SHORT $LN1@main

; 95   :             _STD terminate();

	call	_terminate
$LN1@main:
; File A:\CPP\05_CONCURRENT\ONLINE\SECTION04\test3.cpp

; 22   : }

	jmp	SHORT $LN69@main
$LN67@main:
	jmp	SHORT $LN68@main
$LN69@main:
	xor	eax, eax
$LN68@main:
	mov	esp, ebp
	pop	ebp
	ret	0
_main	ENDP
_TEXT	ENDS
; Function compile flags: /Odtp
; File A:\CPP\05_CONCURRENT\ONLINE\SECTION04\test3.cpp
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\atomic
; File A:\CPP\05_CONCURRENT\ONLINE\SECTION04\test3.cpp
_TEXT	SEGMENT
__Result$1 = -4						; size = 4
?foo@@YAXXZ PROC					; foo

; 10   : {

	push	ebp
	mov	ebp, esp
	push	ecx
	push	esi
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\atomic

; 1553 :         _ATOMIC_CHOOSE_INTRINSIC(_Order, _Result, _InterlockedExchangeAdd, _Atomic_address_as<long>(this->_Storage),

	mov	esi, 1
	push	OFFSET ?x@@3U?$atomic@J@std@@A		; x
	call	??$_Atomic_address_as@JU?$_Atomic_padded@J@std@@@std@@YAPCJAAU?$_Atomic_padded@J@0@@Z ; std::_Atomic_address_as<long,std::_Atomic_padded<long> >
	add	esp, 4
	lock xadd DWORD PTR [eax], esi
	mov	DWORD PTR __Result$1[ebp], esi
; File A:\CPP\05_CONCURRENT\ONLINE\SECTION04\test3.cpp

; 15   : }

	pop	esi
	mov	esp, ebp
	pop	ebp
	ret	0
?foo@@YAXXZ ENDP					; foo
_TEXT	ENDS
; Function compile flags: /Odtp
; File C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\VC\Tools\MSVC\14.29.30031\include\thread
;	COMDAT ?join@thread@std@@QAEXXZ
_TEXT	SEGMENT
$T1 = -16						; size = 8
tv87 = -8						; size = 4
_this$ = -4						; size = 4
?join@thread@std@@QAEXXZ PROC				; std::thread::join, COMDAT
; _this$ = ecx

; 121  :     void join() {

	push	ebp
	mov	ebp, esp
	sub	esp, 16					; 00000010H
	mov	DWORD PTR _this$[ebp], ecx

; 118  :         return _Thr._Id != 0;

	mov	eax, DWORD PTR _this$[ebp]
	cmp	DWORD PTR [eax+4], 0
	je	SHORT $LN8@join
	mov	DWORD PTR tv87[ebp], 1
	jmp	SHORT $LN6@join
$LN8@join:
	mov	DWORD PTR tv87[ebp], 0
$LN6@join:

; 122  :         if (!joinable()) {

	movzx	ecx, BYTE PTR tv87[ebp]
	test	ecx, ecx
	jne	SHORT $LN2@join

; 123  :             _Throw_Cpp_error(_INVALID_ARGUMENT);

	push	1
	call	?_Throw_Cpp_error@std@@YAXH@Z		; std::_Throw_Cpp_error
$LN2@join:

; 124  :         }
; 125  : 
; 126  :         if (_Thr._Id == _Thrd_id()) {

	call	__Thrd_id
	mov	edx, DWORD PTR _this$[ebp]
	cmp	DWORD PTR [edx+4], eax
	jne	SHORT $LN3@join

; 127  :             _Throw_Cpp_error(_RESOURCE_DEADLOCK_WOULD_OCCUR);

	push	5
	call	?_Throw_Cpp_error@std@@YAXH@Z		; std::_Throw_Cpp_error
$LN3@join:

; 128  :         }
; 129  : 
; 130  :         if (_Thrd_join(_Thr, nullptr) != _Thrd_success) {

	push	0
	mov	eax, DWORD PTR _this$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	push	ecx
	mov	edx, DWORD PTR [eax]
	push	edx
	call	__Thrd_join
	add	esp, 12					; 0000000cH
	test	eax, eax
	je	SHORT $LN4@join

; 131  :             _Throw_Cpp_error(_NO_SUCH_PROCESS);

	push	2
	call	?_Throw_Cpp_error@std@@YAXH@Z		; std::_Throw_Cpp_error
$LN4@join:

; 132  :         }
; 133  : 
; 134  :         _Thr = {};

	xor	eax, eax
	mov	DWORD PTR $T1[ebp], eax
	mov	DWORD PTR $T1[ebp+4], eax
	mov	ecx, DWORD PTR _this$[ebp]
	mov	edx, DWORD PTR $T1[ebp]
	mov	eax, DWORD PTR $T1[ebp+4]
	mov	DWORD PTR [ecx], edx
	mov	DWORD PTR [ecx+4], eax
$LN5@join:

; 135  :     }

	mov	esp, ebp
	pop	ebp
	ret	0
?join@thread@std@@QAEXXZ ENDP				; std::thread::join
_TEXT	ENDS
END
