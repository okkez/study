;; 2.27
(define x '((1 2) (3 4)))

(define (deep-reverse items)
  (cond [(null? items) '()]
	[(not (pair? items)) items]
	[else (append (deep-reverse (cdr items)) (list (deep-reverse (car items))))]))
(deep-reverse x)
