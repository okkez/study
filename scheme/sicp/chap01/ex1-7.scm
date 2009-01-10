; 問題1.7
(define (sqrt-iter guess x)
  (define (improve guess x)
    (define (average x y)
      (/ (+ x y) 2))
    (average guess (/ x guess)))
  (define (good-enough? guess1 guess2)
    (< (abs (- guess1 guess2)) 0.001))
  (if (good-enough? guess (improve guess x))
      guess
      (sqrt-iter (improve guess x)
		 x)))
(define (sqrt x)
  (sqrt-iter 1.0 x))

; 小さい数の場合は収束が早すぎる
; 大きい数の場合は収束が遅すぎる

