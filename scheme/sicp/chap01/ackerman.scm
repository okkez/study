(define (A x y)
  (cond [(= y 0) 0]
	[(= x 0) (* 2 y)]
	[(= y 1) 2]
	[else (A (- x 1) (A x (- y 1)))]))

(define (f n) (A 0 n))
; (* 2 n)

(define (g n) (A 1 n))
; (A (- 1 1) (A 1 (- n 1)))
; (A 0 (A 1 (- n 1)))
; (* 2 (A 1 (- n 1)))
; 2**n

(define (h n) (A 2 n))
; (A (- 2 1) (A 2 (- n 1)))
; (A -1 (A 2 (- n 1)))
