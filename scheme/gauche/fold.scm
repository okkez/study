
(define (fold proc init lis)
  (if (null? lis)
      init
      (fold proc (proc (car lis) init) #?=(cdr lis))))

(fold + 0 '(1 2 3 4 5))

(define (last-pair lis)
  (if (pair? (cdr lis))
      (last-pair (cdr lis))
      lis))

(define (copy-list lis)
  (if (pair? lis)
      (cons (car lis) (copy-list (cdr lis)))
      lis))


(define (find pred lis)
  (cond [(null? lis) #f]
	[(pred (car lis)) (car lis)]
	[else (find pred (cdr lis))]))

(define (length lis)
  (if (null? lis)
      0
      (+ 1 (length (cdr lis)))))

(define (filter pred lis)
  (cond [(null? lis) '()]
	[(pred (car lis)) (cons (car lis) (filter pred (cdr lis)))]
	[else (filter pred (cdr lis))]))

(define (reverse lis)
  (define (append2 lis1 lis2)
    (if (pair? lis1)
	(cons (car lis1) (append2 (cdr lis1) lis2))
	lis2))
  (if (null? (cdr lis))
      lis
      (append2 (reverse (cdr lis)) (list (car lis)))))

(define (reverse lis)
  (if (null? lis)
      lis
      (cons (reverse (cdr lis)) (car lis))))

(define (reverse lis)
  (define (reverse-rec lis1 lis2)
    (if (null? lis1)
	lis2
	(reverse-rec (cdr lis1) (cons (car lis1) lis2))))
      (reverse-rec lis '()))

(define (reverse lis)
  (define (reverse-helper memo rest)
    (if (null? rest)
	memo
	(reverse-helper (cons (car rest) memo) (cdr rest))))
  (reverse-helper '() lis))

