;; 1.46
(define (iterative-improve good-enough? improve guess)
  (define (iter guess x)
    (if (good-enough? guess x)
	guess
	(iter (improve guess x) x)))
  (lambda (x) (iter guess x)))

(define (sqrt x)
  ((iterative-improve
   (lambda (guess y) (< (abs (- (* guess guess) y)) 0.0001)) ; good-enough?
   (lambda (guess y) (/ (+ guess (/ y guess)) 2))            ; improve
   1.0) x))

