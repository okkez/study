;; p.47

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
	       (* (numer y) (denom x)))
	    (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
	       (* (numer y) (denom x)))
	    (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
	    (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
	    (* (denom x) (numer y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

; 簡約しない ver.
(define (make-rat n d) (cons n d))
; 簡約する ver. (gcd は Gauche で定義済み)
(define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))
; 2.1 符号を正規化
(define (make-rat n d)
  (let ((g (gcd n d)))
    (if (>= (* n d) 0)
	(cons (/ (abs n) g) (/ (abs d) g))
	(cons (* -1 (/ (abs n) g)) (/ (abs d) g)))))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (print-rat x)
  (format #t "rational: ~s/~s\n" (numer x) (denom x)))


; 遅延評価
(define (numer x)
  (let ((g (gcd (car x) (cdr x))))
    (/ (car x) g)))
(define (denom x)
  (let ((g (gcd (car x) (cdr x))))
    (/ (cdr x) g)))
