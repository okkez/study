;; 2.13
;pass

;; 2.14
(define ia (make-center-percent 5 1))
(define ib (make-center-percent 20 2))

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
		(add-interval r1 r2)))
(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
		  (add-interval (div-interval one r1)
				(div-interval one r2)))))
;; 2.15, 2.16 pass.
