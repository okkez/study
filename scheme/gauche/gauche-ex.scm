;; p.68
(use srfi-1)
(define (for-each-numbers proc lis)
  (for-each proc (filter number? lis)))
(for-each-numbers print '(1 2 #f 3 4 #t))

(define (map-numbers proc lis)
  (map proc (filter number? lis)))
(map-numbers (lambda (x) (* x 2)) '(1 2 #f 3 4 #t))

(define (numbers-only walker)
  (lambda (proc lis) (walker proc (filter number? lis))))

;; p.74
(define (list . a)
  a)

;; FizzBuzz
(map (lambda (x)
       (cond [(= (modulo x 15) 0) 'FizzBuzz]
	     [(= (modulo x  5) 0) 'Buzz]
	     [(= (modulo x  3) 0) 'Fizz]
	     [else x]))
 (iota 100 1))


;; p.101
(define (every-pred . preds)
  (lambda (x)
    (every (lambda (pred) (pred x)) preds)))

(positive-integer? 4)
(positive-integer? -1)

(define (any-pred . preds)
  (lambda (x)
    (any (lambda (pred) (pred x)) preds)))

; ちゃんと動かない
(define (any-pred . preds)
  (if (null? preds)
      (lambda (x) #t)
      (lambda (x)
	(or ((car preds) x)
	    (apply any-pred (cdr preds) x)))))

; by yhara
(define (every-pred . preds)
  (if (null? preds)
      (lambda (x) #t)
      (lambda (x)
	(and ((car preds) x)
	     ((apply every-pred (cdr preds)) x))))) 

(define (member1 elt lis . options)
  (let-optionals* options ((cmp-fn equal?))
		  (cond [(null? lis) #f]
			[(cmp-fn elt (car lis)) lis]
			[else (member elt (cdr lis) cmp-fn)])))
(define (member2 elt lis . options)
  (let-optionals* options ((cmp-fn equal?))
		  (define (loop lis)
		    (cond [(null? lis) #f]
			  [(cmp-fn elt (car lis)) lis]
			  [else (loop (cdr lis))]))
		  (loop lis)))
(use srfi-1)

(define *long-list* (make-list 1000000 #f))


;; p.112 途中
(define (delete-1 elt lis)
  (if (null? lis)
      lis
      (if (equal? elt (car lis))
	  ()
	  (delete-1 elt (cdr lis)))))
;; 残骸
(define (delete-1 elt lis . options)
  (let-optionals* options ((cmp-fn equal?))
		  (define (loop lis)
		    (cond [(null? lis) lis]
			  [(cmp-fn elt (car lis)) (cdr lis)]
			  [else (cons ]))

;; by yoppi
(define (no-copy-delete-1 item lis . options)
  (let-optionals* options ((opr equal?))
    (define (iter lis)
      (cond [(null? lis) '()]
            [(opr item (car lis)) (cdr lis)]
            [else (cons (car lis) (iter (cdr lis)))]))
    (if (member item lis opr)
      (iter lis)
      lis)))

;; 写経 no copy ver.
(define (delete-1 elt lis . options)
  (let-optionals* options ((cmp-fn equal?))
		  (define (loop lis)
		    (cond [(null? lis) '()]
			  [(cmp-fn elt (car lis)) (cdr lis)]
			  [else (cons (car lis) (loop (cdr lis)))]))
		  (if (member elt lis cmp-fn)
		      (loop lis) lis)))

(use gauche.test)
(let ((data (list 1 2 3 4 5)))
  (test* "non-copy delete-1" data (delete-1 6 data) eq?))



;; 14.3
(define (write-to-string obj)
  (call-with-output-string (cut write obj <>)))

(define (read-from-string str)
  (call-with-input-string str read))

(write-to-string '#(3 4 5))   ; "#(3 4 5)"
(read-from-string "#(3 4 5)") ;  #(3 4 5)

;; p.205
(use gauche.charconv)
(with-input-from-file "sicp.scm"
  (lambda ()
    (port-fold (lambda (line count)
		 (format #t "~3d ~a\n" count line)
		 (+ count 1))
	       1 read-line))  :encoding "euc-jp")


;; p.208

;; p.226
(use util.stream)
(define fib (stream-cons 0
			 (stream-cons 1
				      (stream-map + fib (stream-cdr fib)))))
(stream->list (stream-take fib 10))
(stream-ref fib 10000)
(stream->list (stream-take-while (lambda (x) (< x 1000)) fib))

;; p.250 -
(define-class <logger-generic> (<generic>) ())
(define-generic add :class <logger-generic>)
(class-of add)

(define-method apply-generic ((gf <logger-generic>) args)
  (format #t "args: ~s\n" args)
  (let ((return-value (next-method)))
    (format #t "result: ~s\n" return-value)
    return-value))

(define-method add ((num1 <number>) (num2 <number>))
  (+ num1 num2))

(use gauche.time)

(define-class <profiler-generic> (<logger-generic>)
  ((counter :init-value 0)
   (time    :init-form (make <real-time-counter>))))

(define-generic sub :class <profiler-generic>)

(define-method apply-generic ((gf <profiler-generic>) args)
  (inc! (ref gf 'counter))
  (with-time-counter (ref gf 'time) (next-method)))

(define-method sub ((num1 <number>) (num2 <number>))
  (- num1 num2))

(define-method get-profile ((gf <profiler-generic>))
  (format #t "~s: ~d times called and spent time ~d\n"
	  (ref gf 'name) (ref gf 'counter) (time-counter-value (ref gf 'time))))

(define-method init-profile ((gf <profiler-generic>))
  (set! (ref gf 'counter) 0)
  (set! (ref gf 'time) (make <real-time-counter>)))

(use srfi-1)

(map sub (iota 10000 100 3) (iota 10000 300 5))

(get-profile sub)

(init-profile sub)

(define val (with-output-to-string
	      (lambda () (map sub
			      (iota 10000 100 3)
			      (iota 10000 300 5)))))
(get-profile sub)

;; p.254
(define-class <profiler-generic> (<generic>)
  ((counter :init-value 0)
   (time    :init-form (make <real-time-counter>))))
(define-class <logger-profiler-generic>
  (<logger-generic> <profiler-generic>) ())

(define-generic mul :class <logger-profiler-generic>)

(define-method mul ((num1 <number>) (num2 <number>))
  (* num1 num2))

(map mul (iota 10000 100 3) (iota 10000 300 5))
(get-profile mul)

(init-profile mul)

(define val (with-output-to-string
	      (lambda () (map mul
			      (iota 10000 100 3)
			      (iota 10000 300 5)))))

(get-profile mul)

;; p.255 まだできてない。
(define-class <logger-generic> (<generic>)
  ((output :init-value #f)))
(define-class <profiler-generic> (<generic>)
  ((counter :init-value 0)
   (time    :init-form (make <real-time-counter>))))
(define-method apply-generic ((gf <logger-generic>) args)
    (if (ref gf 'output)
	(format #t "args: ~s\n" args)
	(let ((return-value (next-method)))
	  (format (ref gf 'output) "result: ~s\n" return-value)
	  return-value)))
(define-method apply-generic ((gf <profiler-generic>) args)
  (inc! (ref gf 'counter))
  (with-time-counter (ref gf 'time) (next-method)))

(define-generic sub :class <profiler-generic>)
(define-method get-profile ((gf <profiler-generic>))
  (format #t "~s: ~d times called and spent time ~d\n"
	  (ref gf 'name) (ref gf 'counter) (time-counter-value (ref gf 'time))))

(define-method init-profile ((gf <profiler-generic>))
  (set! (ref gf 'counter) 0)
  (set! (ref gf 'time) (make <real-time-counter>)))

(init-profile sub)
(map sub (iota 10000 100 3) (iota 10000 300 5))
(get-profile sub)


;; p.289 - 290
(define-syntax block
  (syntax-rules ()
    [(_ escape body ...)
     (call/cc (lambda (escape) body ...))]))
(block escape-top
       (block escape-1st
	      (block escape-2nd
		     ;(escape-1st 1)
		     (print 'NG!2nd))
	      (print 'NG!1st))
       (print 'OK))

(+ 1 2 (block return
	      (print 'one)
	      (print 'two)
	      (return 3)
	      (print 'four)) 4)


;; p.290 - 291
(define-syntax for-each-ext
  (syntax-rules ()
    [(_ break next lambda-expr arg-list ...)
     (let ((arg1 (list arg-list ...)))
       (call/cc (lambda (break)
		  (apply for-each
			 (lambda arg
			   (call/cc (lambda (next)
				      (apply lambda-expr arg))))
			 arg1))))]))

(for-each-ext break1 next1
	      (lambda (x)
		(for-each-ext break2 next2
			      (lambda (y)
				(format #t "~2d " (* x y)))
			      '(1 2 3 4 5 6 7 8 9))
		(newline))
	      '(1 2 3 4 5 6 7 8 9))

(for-each-ext break1 next1
	      (lambda (x)
		(for-each-ext break2 next2
			      (lambda (y)
				(cond [(not (number? x)) (next1 x)]
				      [(not (number? y)) (next2 y)]
				      [(< x y) (break2 x)]
				      [(>= x 100) (break1 'done)]
				      [else (format #t "~2d " (* x y))]))
		'(1 2 3 a 4 5 b 6 7 c 8 #\a 9 '() 10))
	      (newline))
	      '(#\x 1 2 3 x 4 5 6 y 7 8 9 10 z 100))

;; p.292
(define *signals* '())

(define-syntax catch
  (syntax-rules (finally)
    [(_ (sig body ...) (finally follow ...))
     (let* ((signals-backup *signals*)
	    (val (call/cc (lambda (k)
			    (set! *signals* (cons (cons 'sig k) *signals*))
			    body ...))))
       (set! *signals* signals-backup)
       follow ...
       val)]
    [(_ (sig body ...))
     (catch (sig body ...) (finally))]))

(define-syntax throw
  (syntax-rules ()
    [(_ sig val) ((cdr (assq 'sig *signals*)) val)]))

(define (div n d)
  (if (= d 0)
      (throw DividedZeroError
	     (print #`"ERROR: Dvided Zero Error Occered...\n divide ,n by ZERO\n-----"))
      (/ n d)))

(define (percentage a b)
  (catch (DividedZeroError
	  (print (* (div a b) 100.0) "%"))
	 (finally
	  (print "follow ..."))))
(percentage 10 20)

;; p.294
;; コルーチン
;; モジュールのロード
(use util.queue)

;; タスクキュー
(define *tasks* (make-queue))

;; コルーチン定義構文
(define-syntax define-coroutine
  (syntax-rules ()
    [(_ (routine yield) body ...)
     (define (routine)
       (call/cc (lambda (return)
		  (define (yield)
		    (call/cc (lambda (cont)
			       (enqueue! *tasks* cont)
			       (return))))
		  body ...))
       ((dequeue! *tasks*)))]))
(define (coroutine-init! . rs)
  (set! *tasks* (make-queue))
  (for-each (lambda (r)
	      (enqueue! *tasks* r))
	    rs))

(define-coroutine (three yield)
  (let lp ()
    (print 'one)
    (yield)
    (print 'two)
    (yield)
    (print 'three)
    (yield)
    (lp)))
(define-coroutine (go tsugi)
  (let rupu ()
       (print 'ichi)
       (tsugi)
       (print 'ni)
       (tsugi)
       (print 'san)
       (tsugi)
       (print 'shi)
       (tsugi)
       (print 'go!!)
       (tsugi)
       (rupu)))
(coroutine-init! go)

;; p.296
(define *val* #f)

(define-coroutine (reader yield)
  (define (prompt) (format #t "coroutine> ") (flush))
  (prompt)
  (let lp ((count 0)
	   (exp (read)))
    (inc! count)
    (set! *val* exp)
    (print #`"READ(,count): ,*val*")
    (yield)
    (lp count (read))))
(define-coroutine (evaluateor yield)
  (let lp ((count 0))
    (set! *val* (eval *val* (current-module)))
    (inc! count)
    (print #`"EVAL(,count): ,*val*")
    (yield)
    (lp count)))
(define-coroutine (printer yield)
  (let lp ((count 0))
    (inc! count)
    (set! *val* (print #`"PRINT(,count): ,*val*"))
    (yield)
    (lp count)))
(coroutine-init! evaluateor printer)


