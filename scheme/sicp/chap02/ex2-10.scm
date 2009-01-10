;; 2.10

(div-interval (make-interval 1 10) (make-interval -10 10))

(define (div-interval x y)
  (define (check-interval z)
    (if (< (* (lower-bound z) (upper-bound z)) 0)
	(error "invalid interval")))
  (check-interval y)
  (mul-interval x
		(make-interval (/ 1.0 (upper-bound y))
			       (/ 1.0 (lower-bound y)))))
