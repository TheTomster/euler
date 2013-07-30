;;; Euler #33
;; The fraction 49/98 is a curious fraction, as an inexperienced
;; mathematician in attempting to simplify it may incorrectly believe that
;; 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.

;; We shall consider fractions like, 30/50 = 3/5, to be trivial examples.

;; There are exactly four non-trivial examples of this type of fraction,
;; less than one in value, and containing two digits in the numerator and
;; denominator.

;; If the product of these four fractions is given in its lowest common
;; terms, find the value of the denominator.

; A `fract` is a two-item list of the form '(numerator denominator)
(defun to-rational (fract)
  "converts a `(numerator denominator) to a rational"
  (/ (first fract) (second fract)))

(defun multiply-and-get-denom (ns)
  (denominator (apply #'* ns)))

(defun num-to-list (n &optional (acc ()))
  (if (<= n 0)
    acc
    (num-to-list (floor n 10) (cons (mod n 10) acc))))

(defun list-to-num (ns)
  (labels ((aux (ns)
             (if (null ns)
               0
               (+ (* 10 (aux (rest ns))) (first ns)))))
    (aux (reverse ns))))

(defun remove-first (ns l)
  "removes first item from ns found in l"
  (if (null l)
    nil
    (if (member (first l) ns)
      (rest l)
      (cons (first l) (remove-first ns (rest l))))))

(defun remove-common-digits (fract)
  (let* ((n-digits (num-to-list (first fract)))
         (d-digits (num-to-list (second fract)))
         (common-digits (loop for digit in n-digits
                          when (member digit d-digits) collect digit)))
    (if (null common-digits)
      fract
      (list (list-to-num (remove-first common-digits n-digits))
            (list-to-num (remove-first common-digits d-digits))))))

(defun digit-simplify-p (fract)
  (let ((digits-removed (remove-common-digits fract)))
    ; check that the lists are not equal, that the denominator with common
    ; digits removed isn't 0, and that the fractions simplify to the same
    ; thing
    (and (not (eql fract digits-removed))
         (not (zerop (second digits-removed)))
         (eql (to-rational fract) 
              (to-rational digits-removed)))))

(defun trivial-p (fract)
  "removes 'trivial' examples.
   Any case where the numerator and denominator are equal, and any case
   where they are both multiples of 10."
  (let ((n (first fract))
        (d (second fract)))
    (or (eql n d)
        (and (zerop (mod n 10))
             (zerop (mod d 10))))))

(defun e33 ()
  (let* ((all-digit-simp    (loop for numerator from 11 to 99 nconc
                              (loop for denominator from numerator to 99
                                when (digit-simplify-p
                                      (list numerator denominator))
                                collect (list numerator denominator))))
         (trivials-removed  (remove-if #'trivial-p all-digit-simp))
         (rationals         (mapcar #'to-rational trivials-removed)))
    (multiply-and-get-denom rationals)))
