;; 1.40
(define dx 0.0001)
(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x)) dx)))
(define (newtons-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))
(define (newtons-method g guess)
  (fixed-point (newtons-transform g) guess))

(define (sqrt x)
  (newtons-method (lambda (y) (- (* y y) x)) 1.0))

(define (cubic a b c)
  (lambda (x)
    (+ (expt x 3)
       (* a (expt x 2))
       (* b x)
       c)))

(newtons-method (cubic 1 1 1) 1.0)
(newtons-method (cubic 1 2 1) 1.0)
