;; 2.28
(define x '((1 2) (3 4)))

(define (fringe tree)
  (cond [(null? tree) ()]
	[(not (pair? tree)) (list tree)]
	[else (append (fringe (car tree)) (fringe (cdr tree)))]))
(fringe x)
(fringe (list x x))
