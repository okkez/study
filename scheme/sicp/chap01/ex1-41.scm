;; 1.41
(define (double f)
  (lambda (x) (f (f x))))

(define (inc x)
  (+ x 1))
(((double (double double)) inc) 5) ; 16 + 5
(((double (double (double double))) inc) 5)\ ; 256 + 5
