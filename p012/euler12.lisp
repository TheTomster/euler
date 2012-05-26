;;; Project Euler Problem 12
;;;
;;; The sequence of triangle numbers is generated by adding the
;;; natural numbers. So the 7th triangle number would be 1 + 2 + 3 + 4
;;; + 5 + 6 + 7 = 28. The first ten terms would be:
;;;
;;; 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
;;;
;;; Let us list the factors of the first seven triangle numbers:
;;;
;;;      1: 1
;;;      3: 1,3
;;;      6: 1,2,3,6
;;;     10: 1,2,5,10
;;;     15: 1,3,5,15
;;;     21: 1,3,7,21
;;;     28: 1,2,4,7,14,28
;;;
;;; We can see that 28 is the first triangle number to have over five divisors.
;;;
;;; What is the value of the first triangle number to have over five
;;; hundred divisors?

(defun triangle (n)
  (labels ((rec (n acc)
             (if (<= n 0)
                 acc
                 (rec (- n 1) (+ acc n)))))
    (rec n 0)))

(defun factors (n)
  (let (factors)
    (dolist (i (range 1 (+ 1 (sqrt n))))
      (if (equal 0 (mod n i))
          (progn
            (pushnew i factors)
            (pushnew (floor (/ n i)) factors))))
    factors))

(defun find-tri-over-500 ()
  (do ((i 2 (+ i 1)))
      ((> (length (factors (triangle i))) 500)
       (triangle i))))