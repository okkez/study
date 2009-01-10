;; 1.44

(define (smooth f)
  (define dx 0.00001)
  (lambda (x)
    (/ (+ (f (- x dx))
	  (f x)
	  (f (+ x dx)))
       3)))

((smooth square) 5)

; ???
(define (nsmooth f n)
  (repeated (smooth f) n))
((nsmooth square 3) 5)
