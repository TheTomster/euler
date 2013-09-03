; Euler 2

(load #P"../lib/euler-lib.lisp")

(defpackage :e2
  (:use :cl :euler-lib))

(in-package :e2)

(defun fibs-before (n)
  (labels ((aux (n acc)
             (let ((next (apply #'+ (subseq acc 0 2))))
               (if (> next n)
                 acc
                 (aux n (cons next acc))))))
    (nreverse (aux n (list 2 1)))))

(defun e2 ()
  (sum (remove-if #'oddp (fibs-before 4000000))))
