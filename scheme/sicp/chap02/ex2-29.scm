;; 2.29
; a
(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cadr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cadr branch))

; b

(define (total-weight mobile)
  (if (number? (branch-structure mobile))
      (branch-structure mobile)
      (+ (total-weight (left-branch mobile))
	 (total-weight (right-branch mobile)))))

; c

(define (total-length mobile)
  (if (number? (branch-length mobile))
      (branch-length mobile)
      (+ (total-length (left-branch mobile))
	 (total-length (right-branch mobile)))))

(define (balanced? mobile)
  (= (* (total-length (left-branch mobile))
	(total-weight (left-branch mobile)))
     (* (total-length (right-branch mobile))
	(total-weight (right-branch mobile)))))
  

; d
; cadr -> cdr に変更すればいいだけのはず。


; for test
(define x (make-mobile
	   (make-branch 1 10)
	   (make-branch 2 20)))
(define y (make-mobile x x))
(define z (make-mobile
	   (make-branch 1 60)
	   y))

(left-branch x)
(right-branch x)
(branch-length (left-branch x))
(branch-structure (left-branch x))
(total-weight x)
(balanced? y)
(balanced? z)
