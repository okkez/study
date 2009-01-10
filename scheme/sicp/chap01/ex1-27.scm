
;; 1.27
(define (carmichael n)
  (define (try-it a n)
    (if (= a 0)
	#t
	(if (= (modulo (expt a n) n) (modulo a n))
	    (try-it (- a 1) n)
	    #f)))
  (try-it (- n 1) n))
