; Euler 37
;
; The number 3797 has an interesting property. Being prime itself, it is
; possible to continuously remove digits from left to right, and remain
; prime at each stage: 3797, 797, 97, and 7. Similarly we can work from
; right to left: 3797, 379, 37, and 3.
;
; Find the sum of the only eleven primes that are both truncatable from
; left to right and right to left.
;
; NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

(defparameter *atoms* (list 1 2 3 4 5 6 7 8 9))

(defun prime-p (n &optional (i 2))
  (cond
   ((< n 2)           nil)
   ((> i (sqrt n))    t)
   ((zerop (mod n i)) nil)
   (t                 (prime-p n (1+ i)))))

(defun next-candidates (primes atoms)
  (apply #'append (loop for p in primes
                    collect (loop for a in atoms
                              collect (+ (* p 10) a)))))

(defun remove-non-primes (candidates)
  (remove-if-not #'prime-p
                 candidates))

(defun next-primes (primes atoms)
  (remove-non-primes (next-candidates primes atoms)))

(defun trim-left-digit (n)
  (if (<= n 0)
    n
    (mod n (expt 10 (floor (log n 10))))))

(defun trim-right-digit (n)
  (floor n 10))

(defun build-candidates (&optional (primes *atoms*) (acc ()))
  (if (null primes)
    acc
    (build-candidates (next-primes primes *atoms*) (nconc primes acc))))

(defmacro make-trim-p (name trim-fn)
  `(defun ,name (n)
     (if (< n 10)
       (prime-p n)
       (and (prime-p n) (,name (funcall ,trim-fn n))))))

(make-trim-p ltrim-p #'trim-left-digit)
(make-trim-p rtrim-p #'trim-right-digit)

(defun ltrim-successes (candidates)
  (remove-if-not #'ltrim-p candidates))

(defun rtrim-successes (candidates)
  (remove-if-not #'rtrim-p candidates))

(defun e37 ()
  (apply #'+ (print (remove-if (lambda (n) (< n 10))
                               (ltrim-successes
                                (rtrim-successes
                                 (build-candidates)))))))