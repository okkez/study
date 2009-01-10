;; ex.1-22
;; gauche用runtime (microsecを返す)
(define (prime? n)
  (= n (smallest-divisor n)))
(define (runtime)
  (use srfi-11)
  (let-values (((a b) (sys-gettimeofday)))
	      (+ (* a 1000000) b)))
(define (timed-prime-test n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      ((lambda (_)
	 (newline)
	 (display n)
	 (report-prime (- (runtime) start-time)) #t) ())
      #f))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes n count)
  (if (> count 0)
      (if (timed-prime-test n)
	  (search-for-primes (+ n 2) (- count 1))
	  (search-for-primes (+ n 1) count))
      #t))

(define (find-divisor n test-divisor)
  (cond [(> (sqrt test-divisor) n) n]
	[(divides? test-divisor n) test-divisor]
	[else (find-divisor n (next test-divisor ))]))
(define (next n)
  (if (= n 2)
      3
      (+ n 2)))
  
; (search-for-primes 1000 3)
; 
; 1009 *** 774
; 1013 *** 750
; 1019 *** 757#t
; gosh> (search-for-primes 10000 3)
; 
; 10007 *** 7481
; 10009 *** 7257
; 10037 *** 19597#t
; gosh> (search-for-primes 100000 3)
; 
; 100003 *** 111859
; 100019 *** 114858
; 100043 *** 106431#t
; gosh> (search-for-primes 1000000 3)
; 
; 1000003 *** 947470
; 1000033 *** 877456
; 1000037 *** 858896#t
; 改良版
; (search-for-primes 1000 3)
; 1009 *** 464
; 1013 *** 458
; 1019 *** 446#t
; gosh> (search-for-primes 10000 3)
; 
; 10007 *** 4301
; 10009 *** 4236
; 10037 *** 13464#t
; gosh> (search-for-primes 100000 3)
; 
; 100003 *** 79381
; 100019 *** 71342
; 100043 *** 64464#t
; gosh> (search-for-primes 1000000 3)
; 
; 1000003 *** 509268
; 1000033 *** 564056
; 1000037 *** 530714#t
; Fermat Test
; (search-for-primes 1000 3)
; 1009 *** 9964
; 1013 *** 10450
; 1019 *** 38893#t
; gosh> (search-for-primes 10000 3)
; 
; 10007 *** 22003
; 10009 *** 50074
; 10037 *** 88765#t
; gosh> (search-for-primes 100000 3)
; 
; 100003 *** 72057
; 100019 *** 58501
; 100043 *** 63605#t
; gosh> (search-for-primes 1000000 3)
; 
; 1000003 *** 84683
; 1000033 *** 87169
; 1000037 *** 75471#t
; gosh> 
(define (square n)
  (* n n))
(define (random n)
  (remainder (sys-random) n))
(define (expmod base exp m)
  (cond ((= exp 0) 1)
	((even? exp)
	 (remainder (square (expmod base (/ exp 2) m)) m))
	(else (remainder (* base (expmod base (- exp 1) m)) m ))))
(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))
(define (fast-prime? n times)
  (cond ((= times 0) #t)
	((fermat-test n) (fast-prime? n (- times 1)))
	(else #f)))

(define (start-prime-test n start-time)
  (if (prime? n 1000)
      ((lambda (_)
	 (newline)
	 (display n)
	 (report-prime (- (runtime) start-time)) #t) ())
      #f))
