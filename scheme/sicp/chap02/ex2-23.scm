;; 2.23
(define (for-each proc items)
  (if (null? items)
      #t
      ((lambda ()
	 (proc (car items))
	 (for-each proc (cdr items))))))
(for-each (lambda (x) (newline) (display x)) '(1 2 3 4 5))
