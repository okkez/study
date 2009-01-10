;; 1.36
(define tolerance 0.0001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      ((lambda ()
	 (display next)
	 (newline)
	 next))
      (if (close-enough? guess next)
	  next
	  (try next))))
  (try first-guess))

(fixed-point (lambda (x) (/ (log 1000) (log x))) 4.5)
; (fixed-point (lambda (x) (/ (expt x x) 1000)) 2.0)

