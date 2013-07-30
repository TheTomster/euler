; Euler 36
;
; The decimal number, 585 = 10010010012 (binary), is palindromic in both
; bases.
;
; Find the sum of all numbers, less than one million, which are palindromic
; in base 10 and base 2.
;
; (Please note that the palindromic number, in either base, may not include
; leading zeros.)

(defun palindrome-p (ns)
  (equal ns (reverse ns)))

(defun num-to-list (n &key (base 10) (acc ()))
  (if (<= n 0)
    acc
    (num-to-list (floor n base) :base base :acc (cons (mod n base) acc))))

(defun e36-p (n)
  (let ((digits-10 (num-to-list n))
        (digits-2 (num-to-list n :base 2)))
    (and (palindrome-p digits-10)
         (palindrome-p digits-2))))

(defun e36 ()
  (loop for i from 1 to 1000000
    when (e36-p i) sum i))
