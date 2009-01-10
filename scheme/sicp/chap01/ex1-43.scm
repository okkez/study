;; 1.43
(define (repeated f n)
  (if (= n 1)
      f
      (repeated (compose f f) (- n 1))))
((repeated 2) 5) ; 625
