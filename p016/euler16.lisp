;;; 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

;;; What is the sum of the digits of the number 2^1000?

(defun sum-digits (d)
  (labels ((rec (n acc)
             (if (<= n 0)
                 acc
                 (rec (floor (/ n 10)) (+ acc (mod n 10))))))
    (rec d 0)))

(format t "~&~S~%" (sum-digits (expt 2 1000)))