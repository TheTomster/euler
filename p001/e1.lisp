; Euler 1

(defun divides (x y)
  (zerop (mod y x)))

(defun sum (l)
  (reduce #'+ l))

(defun range (a b)
  (loop for i from a to b collecting i))

(defun e1 ()
  (sum (remove-if (lambda (n) (not (or (divides 3 n)
                                       (divides 5 n))))
                  (range 1 999))))
