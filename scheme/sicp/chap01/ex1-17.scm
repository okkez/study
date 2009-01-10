(define (double n)
  (+ n n))

(define (halve n)
  (if (odd? n) n
      (/ n 2)))

(define (* a b)
  (define (multi-iter x a b)
    (cond [(or (= a 0) (= b 0)) x]
	  [(even? b) (multi-iter x (double a) (halve b))]
	  [else (multi-iter (+ x a) a (- b 1))]))
  (multi-iter 0 a b))

