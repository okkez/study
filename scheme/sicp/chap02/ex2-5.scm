;; 2.5
; 数学的帰納法、背理法、素因数分解
; http://www.serendip.ws/archives/520
(define (cons a b)
  (* (expt 2 a) (expt 3 b)))
(define (car x)
  (define (iter x n a)
    (if (= (remainder x n) 0)
	(iter (/ x n) n (+ a 1))
	a))
  (iter x 2 0))

(define (cdr x)
  (define (iter x n a)
    (if (= (remainder x n) 0)
	(iter (/ x n) n (+ a 1))
	a))
  (iter x 3 0))
