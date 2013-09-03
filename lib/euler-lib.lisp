; Euler utility functions

(defpackage :euler-lib
  (:use :common-lisp)
  (:export :primep
           :primes-before-gen
           :debug-mode
           :dbg
           :range
           :sum))

(in-package :euler-lib)

(defparameter debug-mode t)

(defun dbg (&rest args)
  (when debug-mode
    (let ((format (concatenate 'string "~&" (first args)))
          (args (rest args)))
      (apply #'format (cons t (cons format args))))))

(defun primep (n &optional (i 2))
  "returns t if n is prime, nil otherwise"
  (declare (optimize (speed 3))
           (fixnum n i))
  (cond
    ((< n 2)                nil)
    ((> i (floor (sqrt n))) t)
    ((zerop (mod n i))      nil)
    (t                      (primep n (1+ i)))))

(defun primes-before-gen ()
  "returns a memoized primes generator"
  (let ((prime-cache (list 2)))
    (lambda (n)
      (when (> n (car prime-cache))
        (loop for i from (1+ (car prime-cache)) to n
           when (primep i)
           do (push i prime-cache)))
      (let ((ret prime-cache))
        (loop
           (when (null ret)
             (return ret))
           (when (<= (car ret) n)
             (return ret))
           (setf ret (cdr ret)))))))

(defun range (a b)
  "returns a list of numbers from a to b, inclusive"
  (loop for i from a to b collecting i))

(defun sum (l)
  (reduce #'+ l))
