
(define (cube n) (* n n n))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
	 (sum term (next a) next b))))

(define (inc n) (+ n 1))

(define (sum-cubes a b)
  (sum cube a inc b))

(define (sum-integers a b)
  (sum (lambda (x) x) a inc b))

(define (pi-sum a b)
  (sum (lambda (x) (/ 1.0 (* x (+ x 2))))
       a
       (lambda (x) (+ x 4))
       b))

(define (integral f a b dx)
  (* (sum f (+ a (/ dx 2.0)) (lambda (x) (+ x dx)) b) dx))


;; 1.29
(define (simpson f a b n)
  (define (h a b n) (/ (- b a) n))
  (define (yk k)
    (cond [(or (= k 0) (= k n)) (* (/ (h a b n) 3) (f (+ a (* k (h a b n)))))]
	  [(even? k) (* (/ (h a b n) 3) (* 2 (f (+ a (* k (h a b n))))))]
	  [else (* (/ (h a b n) 3) (* 4 (f (+ a (* k (h a b n))))))]))
  (sum yk 0 inc n))

;; 1.30
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
	result
	(iter (next a) (+ result (term a)))))
  (iter a 0))

;; 1.31.a
(define (product term a next b)
  (define (iter a result)
    (if (> a b)
	result
	(iter (next a) (* (term a) result))))
    (iter a 1))

;; 1.31.b
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
	 (product term (next a) inc b))))

(define (factorial n)
  (product (lambda (x) x) 1 inc n))

(define (square x) (* x x))

;; pi
(define (pi n)
  (/. (* 2 4
	 (product (lambda (x) (* x x)) 2 (lambda (x) (+ 2 x)) (* 2 n)))
      (product (lambda (x) (* x x)) 3 (lambda (x) (+ 2 x)) (+ (* 2 n) 1))))

(define (pi n)
  (* 2 (/.
	(* (product (lambda (x) (* 2 x)) 1 (lambda (x) (+ 1 x)) n)
	   (product (lambda (x) (* 2 x)) 1 (lambda (x) (+ 1 x)) n))
	(* (product (lambda (x) (- (* 2 x) 1)) 1 (lambda (x) (+ 1 x)) n)
	   (product (lambda (x) (+ (* 2 x) 1)) 1 (lambda (x) (+ 1 x)) n))
	)))
;; 項ごとに計算すると良い
(define (pi n)
  (define (term k)
    (/. (square (* 2 k)) (* (+ (* 2 k) 1) (- (* 2 k) 1))))
  (* 2 (product term 1 inc n)))

;; 1.32

(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
	result
	(iter (next a) (combiner (term a) result))))
    (iter a null-value))

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
		(accumulate combiner null-value term (next a) next b))))

(define (product term a next b)
  (accumulate * 1 term a next b))

(define (filtered-accumulate combiner null-value term a next b prod)
  (define (iter a result prod)
    (cond [(> a b) result]
	  [(prod a) (iter (next a) (combiner (term a) result) prod)]
	  [else (iter (next a) result prod)]))
  (iter a null-value prod))

;; ex.1-21 for prime?
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond [(> (sqrt test-divisor) n) n]
	[(divides? test-divisor n) test-divisor]
	[else (find-divisor n (+ test-divisor 1))]))

(define (divides? a b)
  (= (remainder b a) 0))

;; ex.1-22
 ;; gauche用runtime (microsecを返す)
(define (prime? n)
  (= n (smallest-divisor n)))

;; 1.33 a
(define (sum-prime a b)
  (filtered-accumulate + 0 (lambda (x) (* x x)) a (lambda (x) (+ x 1)) b prime?))

;; 1.33 b
(define (sum-prime2 n)
  (define (prod? i)
    (and (> n i) (= (gcd i n) 1)))
  (filtered-accumulate * 1 (lambda (x) x) 1 (lambda (x) (+ x 1)) n prod?))
