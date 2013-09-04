; Euler 4

(defun palindrome-p (ns)
  (equal ns (reverse ns)))

(defun num-to-list (n &key (base 10) (acc ()))
  (if (<= n 0)
    acc
    (num-to-list (floor n base) :base base :acc (cons (mod n base) acc))))

(defun e4 ()
  (loop for a from 111 to 999
     maximize (loop for b from 111 to 999
                 when (palindrome-p (num-to-list (* a b)))
                 maximize (* a b))))
