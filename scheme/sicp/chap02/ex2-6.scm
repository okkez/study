;; 2.6

(define zero
  (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
(define zero (lambda (f) (lambda (x) x)))
(define one  (lambda (f) (lambda (x) (f x))))
(define two  (lambda (f) (lambda (x) (f (f x)))))
(define three (lambda (f) (lambda (x) (f (f (f x))))))

(add-1 zero)
; (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))
; (lambda (f) (lambda (x) (f ((lambda (x) (lambda (x) x)) x))))
; (lambda (f) (lambda (x) (f (lambda (x) x)))))
; (lambda (f) (lambda (x) (f x))))

(define (to-s z)
  (define (inc n)
    (+ n 1))
  ((z inc) 0))
; 掛け算
(define (add a b)
  (lambda (f) (a (b f))))

; べき乗
(define (add a b)
  (lambda (f) ((a b) f)))

; 足し算
(define (add a b)
  (lambda (f)
    (lambda (x)
      ((a f) ((b f) x)))))
