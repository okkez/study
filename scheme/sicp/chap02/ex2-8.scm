;; 2.8

(define (sub-interval x y)
  (make-interval (- (lower-bound y) (upper-bound x))
		 (- (upper-bound y) (lower-bound x))))

(sub-interval (make-interval 1 10) (make-interval 2 5))
(sub-interval (make-interval 2 5) (make-interval 1 10))
