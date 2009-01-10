;; 2.25
(define x '(1 3 (5 7) 9))
(cadr (caddr x))
(define x '((7)))
(caar x)
(define x '(1 (2 (3 (4 (5 (6 (7))))))))
(car (cadadr (cadadr (cadadr x))))
