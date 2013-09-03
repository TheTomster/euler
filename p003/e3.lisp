; Euler 3
; What is the largest prime factor of 600851475143

(load "../lib/euler-lib.lisp")

(defpackage :e3
  (:use :cl :euler-lib)
  (:export :e3))

(in-package :e3)

(defun factors (n)
  (let ((half-factors (remove-if (lambda (i) (not (zerop (mod n i))))
                                 (range 2 (floor (sqrt n))))))
    (mapcan (lambda (i) (list i (/ n i)))
            half-factors)))

(defun e3 ()
  (let ((n 600851475143))
    (reduce #'max (remove-if (complement #'primep)
                             (factors n)))))
