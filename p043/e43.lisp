;; Euler 43
;; The number, 1406357289, is a 0 to 9 pandigital number because it is
;; made up of each of the digits 0 to 9 in some order, but it also has
;; a rather interesting sub-string divisibility property.
;;
;; Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this
;; way, we note the following:
;;
;;     d2d3d4=406 is divisible by 2
;;     d3d4d5=063 is divisible by 3
;;     d4d5d6=635 is divisible by 5
;;     d5d6d7=357 is divisible by 7
;;     d6d7d8=572 is divisible by 11
;;     d7d8d9=728 is divisible by 13
;;     d8d9d10=289 is divisible by 17
;;
;; Find the sum of all 0 to 9 pandigital numbers with this property.

(ql:quickload 'alexandria)

(defparameter substr-specs '((1 . 2)
                             (2 . 3)
                             (3 . 5)
                             (4 . 7)
                             (5 . 11)
                             (6 . 13)
                             (7 . 17)))

(defun digits-to-num (digits &optional (acc 0))
  (cond
    ((null digits) acc)
    ((> (first digits) 9) (error "digit > 9"))
    (t (digits-to-num (rest digits) (+ (* 10 acc) (first digits))))))

(defun substr-prime-divp (digits)
  (dolist (spec substr-specs)
    (let* ((subseq-start (car spec))
           (subseq-end (+ 3 subseq-start))
           (substr (subseq digits subseq-start subseq-end))
           (prime (cdr spec)))
      (when (not (zerop (mod (digits-to-num substr) prime)))
        (return-from substr-prime-divp nil))))
  t)

(defun e43 ()
  (let ((digits (list 0 1 2 3 4 5 6 7 8 9))
        (sum 0))
    (alexandria:map-permutations (lambda (ds)
                                   (when (substr-prime-divp ds)
                                     (incf sum (digits-to-num ds))))
                                 digits)
    sum))
