;; 2.2

(define (print-point p)
  (format #t "(~s, ~s)\n" (x-point p) (y-point p)))

(define (make-segment p1 p2) (cons p1 p2))
(define (start-segment seg) (car seg))
(define (end-segment seg) (cdr seg))
(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))
(define (midpoint-segment s)
  (let ((p1 (start-segment s))
	(p2 (end-segment s)))
    (make-point
     (/ (+ (x-point p1) (x-point p2)) 2)
     (/ (+ (y-point p1) (y-point p2)) 2))))

(print-point (midpoint-segment (make-segment (make-point 2 4)
					     (make-point 4 2))))
