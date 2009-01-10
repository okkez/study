;; 2.19
(define us-coins '(50 25 10 5 1))
(define uk-coins '(100 50 25 10 5 1 0.5))

(define (cc amount coin-values)
  (cond [(= amount 0) 1]
	[(or (< amount 0) (no-more? coin-values)) 0]
	[else (+ (cc amount (except-first-denomination coin-values))
		 (cc (- amount (first-denomination coin-values)) coin-values))]))

(define (first-denomination coin-values)
  (car coin-values))
(define (no-more? coin-values)
  (null? coin-values))
(define (except-first-denomination coin-values)
  (cdr coin-values))

(cc 100 us-coins)

; リストの要素の順序を入れ替えるとリストの要素順に両替しているため影響がある。
