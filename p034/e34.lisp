;;; Euler #34
;;
;; 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
;;
;; Find the sum of all numbers which are equal to the sum of the factorial
;; of their digits.
;;
;; Note: as 1! = 1 and 2! = 2 are not sums they are not included.

(ql:quickload 'alexandria)

(defun num-to-list (n &optional (acc ()))
  (if (<= n 0)
    acc
    (num-to-list (floor n 10) (cons (mod n 10) acc))))

(defun sum-fact-p (n)
  (let* ((digits (num-to-list n))
         (factorials (mapcar #'alexandria:factorial digits))
         (sum (apply #'+ factorials)))
    (eql sum n)))

(defun e34 ()
  (loop for i from 1 to (alexandria:factorial 9)
    when (sum-fact-p i)
    collect i))
