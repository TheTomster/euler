;;; #53
;;; There are exactly ten ways of selecting three from five, 12345:
;;;
;;;      123, 124, 125, 134, 135, 145, 234, 235, 245, and 345
;;;
;;; In combinatorics, we use the notation, 5C3 = 10.
;;;
;;; In general,
;;;      nCr =
;;;      	n!
;;;      	over
;;;      	r!(n−r)!
;;; ,where r ≤ n, n! = n×(n−1)×...×3×2×1, and 0! = 1.
;;;
;;; It is not until n = 23, that a value exceeds one-million: 23C10 = 1144066.
;;;
;;; How many, not necessarily distinct, values of  nCr, for 1 <= n <= 100, are
;;; greater than one-million?

(defun fact (x)
     (cond
       ((= 0 x) 1)
       (t (* x (fact (- x 1))))))

(defun choose (n r)
  (/ (fact n) (* (fact r) (fact (- n r)))))

(defun e53 ()
  (loop for n from 1 to 100
        summing (loop for r from 1 to n
                 counting (> (choose n r) 1000000))))
