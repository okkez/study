;; 問題1.8
(define (cube-route x)
  (define (cube-route-iter guess x)
    (define (improve guess x)
      (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))
    (define (good-enough? guess1 guess2)
      (< (abs (- guess1 guess2)) 0.00000001))
    (if (good-enough? guess (improve guess x))
	guess
	(cube-route-iter (improve guess x)
			 x)))
  (cube-route-iter 1.0 x))


;; factorial
(define (factorial n)
  (if (or (= n 1) (= n 0))
      1
      (* n (factorial (- n 1)))))


;; p.68
(use srfi-1)
(define (for-each-numbers proc list)
  (for-each proc (filter number? list )))
(define (map-numbers proc list)
  (map proc (filter number? list)))
;(define (numbers-only proc list)
;  (proc (filter

;; p.74
(define (list . a) a)
