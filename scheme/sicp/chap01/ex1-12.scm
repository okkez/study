; Pascal の三角形

(define (pascal n)
  (define (combination a b)
    (if (or (= b 1) (= a b)) 1
	(+ (combination (- a 1) b) (combination (- a 1) (- b 1)))))
  (define (make-list n)
    (if (= n 1) '(1)
	(cons n (make-list (- n 1)))))
  (define (line n)
    (map (cut combination n <>) (make-list n)))
  (map line (make-list n)))

      '(1)
     '(1 1)
    '(1 2 1)
   '(1 3 3 1)
  '(1 4 6 4 1)
