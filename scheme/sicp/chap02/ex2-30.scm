;; 2.30
(define (square-tree tree)
  (cond [(null? tree) '()]
	[(not (pair? tree)) (* tree tree)]
	[else (cons (square-tree (car tree))
		    (square-tree (cdr tree)))]))
(define (square-tree tree)
  (map (lambda (sub-tree)
	 (if (pair? sub-tree)
	     (square-tree sub-tree)
	     (* sub-tree sub-tree))) tree))

(square-tree '(1 (2 (3 4) 5) (6 7)))
