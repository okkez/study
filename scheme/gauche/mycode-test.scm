;; -*- coding: utf-8 -*-
;; mycode-test.scm
(use gauche.test)
(test-start "mycode.scm")

(load "./mycode.scm")

(test* "last-pair #1" '(3) (last-pair '(1 2 3)))
(test* "last-pair #2" '(1) (last-pair '(1)))
(test* "last-pair #3" '(2 . 3) (last-pair '(1 2 . 3)))
