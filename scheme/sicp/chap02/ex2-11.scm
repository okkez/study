;; 2.11
; Lx Ux Ly Uy
; +  +  +  +  [Lx * Ly, Ux * Uy]
; -  -  -  -  [Lx * Ly, Ux * Uy]
; +  +  -  -  [Ux * Uy, Lx * Ly]
; -  -  +  +  [Ux * Uy, Lx * Ly]
; +  +  -  +  [Ux * Ly, Ux * Uy]
; -  -  -  +  [Ux * Uy, Ux * Ly]
; -  +  +  +  [Lx * Uy, Ux * Uy]
; -  +  -  -  [Ux * Uy, Lx * Uy]
; -  +  -  +  [min(Lx * Uy, Ux * Ly), max(Lx * Ly, Ux * Uy)]
(define (mul-interval x y)
  (use util.match)
  (let* ((lbx (lower-bound x))
	 (ubx (upper-bound x))
	 (lby (upper-bound y))
	 (uby (upper-bound y))
	 (res
	  (match (map positive? (list lbx ubx lby uby))
		 ['(#t #t #t #t) (list (* lbx lby) (* ubx uby))]
		 ['(#f #f #f #f) (list (* lbx lby) (* ubx uby))]
		 ['(#t #t #f #f) (list (* ubx uby) (* lbx lby))]
		 ['(#f #f #t #t) (list (* ubx uby) (* lbx lby))]
		 ['(#t #t #f #t) (list (* ubx lby) (* ubx uby))]
		 ['(#f #f #f #t) (list (* ubx uby) (* ubx lby))]
		 ['(#f #t #t #t) (list (* lbx uby) (* ubx uby))]
		 ['(#f #t #f #f) (list (* ubx uby) (* lbx uby))]
		 ['(#f #t #f #t) (list (min (* lbx uby) (* ubx lby))
				       (max (* lbx lby) (* ubx uby)))])))
    (make-interval (car res) (cadr res))))

(mul-interval (make-interval 1 5) (make-interval 4 6))
(mul-interval (make-interval -1 -5) (make-interval -4 -6))
(mul-interval (make-interval -1 5) (make-interval -4 6))
