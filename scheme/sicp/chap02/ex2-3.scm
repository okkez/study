;; 2.3

(define (make-rectangle p1 p2)
  (make-segment p1 p2))

(define (width rectangle)
  (abs (- (x-point (start-segment rectangle))
	  (x-point (end-segment rectangle)))))
(define (hight rectangle)
  (abs (- (y-point (start-segment rectangle))
	  (y-point (end-segment rectangle)))))

(define (perimeter-rectangle rectangle)
    (+ (* 2 (hight rectangle)) (* 2 (width rectangle))))

(define (area-rectangle rectangle)
    (* (width rectangle) (hight rectangle)))

; another
(define (make-rectangle width hight)
  (cons width hight))
(define (width rectangle) (car width))
(define (hight rectangle) (cdr hight))
