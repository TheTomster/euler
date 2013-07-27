;;; Euler 32
;; We shall say that an n-digit number is pandigital if it makes use of all
;; the digits 1 to n exactly once; for example, the 5-digit number, 15234,
;; is 1 through 5 pandigital.
;;
;; The product 7254 is unusual, as the identity, 39 × 186 = 7254,
;; containing multiplicand, multiplier, and product is 1 through 9
;; pandigital.
;;
;; Find the sum of all products whose multiplicand/multiplier/product
;; identity can be written as a 1 through 9 pandigital.
;;
;; HINT: Some products can be obtained in more than one way so be sure to
;; only include it once in your sum.

(defparameter *pandigital-digits* 9)

(defun num-to-list (n &optional (acc ()))
  (if (<= n 0)
    acc
    (num-to-list (floor n 10) (cons (mod n 10) acc))))

(defun pandigitalp (num-list)
  (every (lambda (x) (not (null x)))
         (loop for i from 1 to *pandigital-digits* collecting
           (member i num-list))))

(defun 3n-pandigitalp (multiplicand multiplier product)
  (pandigitalp (append (num-to-list multiplicand)
                       (num-to-list multiplier)
                       (num-to-list product))))

(defmacro increment (sym amount)
  `(setf ,sym (+ ,sym ,amount)))

(defun e32 ()
  (let ((counter 0)
        (counted (make-hash-table)))
    (loop for i from 1 to (expt 10 *pandigital-digits*)
      do (loop for j from 1 to (expt 10 *pandigital-digits*)
           do (when (and (3n-pandigitalp i j (* i j))
                         (not (gethash (* i j) counted)))
                (increment counter (* i j))
                (setf (gethash (* i j) counted) t))))
    counter))

;;; Let's try using permutations of a fixed list, splitting it at various
;;; points and checking the math.

(ql:quickload 'alexandria)

(defparameter *pandigital-digit-list* (list 1 2 3 4 5 6 7 8 9))

(defun seq-to-num (ns)
  (labels ((aux (ns)
             (if (null ns)
               0
               (+ (* 10 (aux (rest ns))) (first ns)))))
    (aux (reverse ns))))

(defun gen-sublists (ns)
  (apply #'append
         (loop for i from 1 to (- (length ns) 2)
           collecting (loop for j from (+ i 1) to (- (length ns) 1)
                        collecting (list (subseq ns 0 i)
                                         (subseq ns i j)
                                         (subseq ns j))))))

(defun check-lists-prod (is js ps)
  (let ((i (seq-to-num is))
        (j (seq-to-num js))
        (p (seq-to-num ps)))
    (list (eql (* i j) p) p)))

(defun check-sublists (digits)
  (let* ((sublists (gen-sublists digits))
         (checked-prods (mapcar (lambda (args) (apply #'check-lists-prod
                                                      args))
                                sublists)))
    (remove-if (lambda (pair) (null (first pair)))
               checked-prods)))

(defun extract-products (ns)
  (if (null ns)
    nil
    (cons (cadaar ns) (acc-uniques (cdr ns)))))

(defun e32-permutations ()
  (let ((acc ()))
    (alexandria:map-permutations (lambda (ns)
                                   (setf acc (cons (check-sublists ns) acc)))
                                 *pandigital-digit-list*)
    (setf acc (remove-if #'null acc))
    (setf acc (extract-products acc))
    (setf acc (remove-duplicates acc))
    (apply #'+ acc)))
