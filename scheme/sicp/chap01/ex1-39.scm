;; 1.39

(define (cont-frac2 n d k)
  (define (iter i)
    (if (= i k)
	(/ (n i) (d i))
	(/ (n i) (- (d i) (iter (+ i 1))))))
  (iter 1))
(define (tan-cf x k)
  (cont-frac2 (lambda (i) 1.0)
	      (lambda (i) (- (* 2 i) 1)) ; 2 * n - 1
	      k))
