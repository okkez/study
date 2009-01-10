;; 1.37

(define (cont-frac n d k)
  (define (iter i)
    (if (= i k)
	(/ (n i) (d i))
	(/ (n i) (+ (d i) (iter (+ i 1))))))
  (iter 1))

; 反復バージョンはあとで書く

 (/ 1
   (cont-frac (lambda (i) 1.0)
	      (lambda (i) 1.0)
	      10000))

(cont-frac (lambda (i) 1.0)
	   (lambda (i) 1.0)
	   10)
