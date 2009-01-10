;;p.57
(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))
(list-ref (list 1 4 9 16 25) 3)

;; 2.17
(define (last-pair items)
  (if (null? items)
      '()
      (if (= (length items) 1)
	  items
	  (last-pair (cdr items)))))
