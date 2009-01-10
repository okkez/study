; 問題1.5
(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))

; Newton way
(define (sqrt-iter guess x)
  (define (improve guess x)
    (define (average x y)
      (/ (+ x y) 2))
    (average guess (/ x guess)))
  (define (good-enough? guess x)
    (define (square x)
      (* x x))
    (< (abs (- (square guess) x)) 0.001))
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
		 x)))
(define (sqrt x)
  (sqrt-iter 1.0 x))
