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

(defun unsimp-fract-numerator (fract)
  (first fract))

(defun unsimp-fract-denominator (fract)
  (second fract))

(defun to-rational (fract)
  (/ (unsimp-fract-numerator fract)
     (unsimp-fract-denominator fract)))

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

(defun remove-first (l ns)
  "removes first item from ns found in l"
  (if (null l)
    nil
    (let ((head (first l)))
      (if (member (first l) ns)
        (rest l)
        (cons head (remove-first (rest l) ns))))))

(defun remove-common-digits (fract)
  (let* ((n-digits (num-to-list (unsimp-fract-numerator fract)))
         (d-digits (num-to-list (unsimp-fract-denominator fract)))
         (common-digits (loop for digit in n-digits
                          when (member digit d-digits) collect digit)))
    (if (null common-digits)
      fract
      (list
       (list-to-num (remove-first n-digits common-digits))
       (list-to-num (remove-first d-digits common-digits))))))

(defun digit-simplify-p (fract)
  (let ((digits-removed (remove-common-digits fract)))
    (and (not (eql fract digits-removed))
         (not (zerop (unsimp-fract-denominator digits-removed)))
         (eql (to-rational fract) 
              (to-rational digits-removed)))))

(defun trivial-p (fract)
  (let ((n (unsimp-fract-numerator fract))
        (d (unsimp-fract-denominator fract)))
    (or (eql n d)
        (and (zerop (mod n 10))
             (zerop (mod d 10))))))

(defun e33 ()
  (let ((all-digit-simp
         (apply #'append (loop for numerator from 11 to 99 collect
                           (loop for denominator from numerator to 99
                             when (digit-simplify-p
                                   (list numerator denominator))
                             collect (list numerator denominator))))))
    (multiply-and-get-denom (mapcar #'to-rational
                                    (remove-if #'trivial-p all-digit-simp)))))
