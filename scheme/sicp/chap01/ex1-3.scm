; (5 + 4 + (2 - (3 -(6 + 4/5)))) / 3 * (6 -2) * (2 -7)
;
; 演習 1.3
; a1 <= a2 <= a3
(define (square2 a1 a2 a3)
  (define (square x)
    (* x x))
  (cond ((and (<= a1 a2) (<= a1 a3)) (+ (square a2) (square a3)))
	((and (<= a3 a2) (<= a3 a1)) (+ (square a1) (square a2)))
	((and (<= a2 a1) (<= a2 a3)) (+ (square a1) (square a3)))
	(else ()))
  )
