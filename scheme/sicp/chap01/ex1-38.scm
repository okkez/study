;; 1.38
; 1 2 1 | 1 4 1 | 1 6 1 |  1   8  1 ...
; 1 2 3 | 4 5 6 | 7 8 9 | 10  11 12
(+ 2
   (cont-frac (lambda (i) 1.0)
	      (lambda (i)
		(if (= 2 (modulo i 3))
		    (- i (quotient i 3))
		    1))
	      100))
