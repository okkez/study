;; 1.45
(define (average-damp f)
  (lambda (x) (/ (+ x (f x)) 2)))

(define (cube-root x)
  (fixed-point (average-damp (lambda (y) (/ x (* y y)))) 1.0))

(define (q-root x)
  (fixed-point
   ((repeated average-damp 2) (lambda (y) (/ x (expt y 3)))) 1.0))

(define (q-root x)
  (fixed-point
   (average-damp (lambda (y) (/ x (expt y 3)))) 1.0))


(q-root 16) ; 2
