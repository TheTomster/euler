;; Euler 42
;;
;; The nth term of the sequence of triangle numbers is given by,
;;
;;     tn = 0.5 * n * (n+1)
;;
;; so the first ten triangle numbers are:
;;
;; 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
;;
;; By converting each letter in a word to a number corresponding to
;; its alphabetical position and adding these values we form a word
;; value. For example, the word value for SKY is 19 + 11 + 25 = 55 =
;; t10. If the word value is a triangle number then we shall call the
;; word a triangle word.
;;
;; Using words.txt, a 16K text file containing nearly two-thousand
;; common English words, how many are triangle words?

(defparameter words (read (open (merge-pathnames "words.lisp"))))

(defun word-value (word)
  (let ((letter-vals (loop
                        for val from 1 to 26
                        for letter in (coerce "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                                              'list)
                        collect (cons letter val))))
    (loop for c in (coerce word 'list)
       summing (cdr (assoc c letter-vals)))))

(defun triangle-nump (n)
  (zerop (mod (/ (- (sqrt (+ (* 8 n) 1)) 1) 2)
              1)))

(defun triangle-wordp (word)
  (triangle-nump (word-value word)))

(defun e42 ()
  (loop for word in words counting (triangle-wordp word)))
