; Euler 41
;
; We shall say that an n-digit number is pandigital if it makes use of
; all the digits 1 to n exactly once. For example, 2143 is a 4-digit
; pandigital and is also prime.
;
; What is the largest n-digit pandigital prime that exists?

(ql:quickload :alexandria)

(defun primep (n &optional (i 2))
  (cond
   ((< n 2)           nil)
   ((> i (sqrt n))    t)
   ((zerop (mod n i)) nil)
   (t                 (primep n (1+ i)))))

(defun digits-to-num (digits &optional (acc 0))
  (cond
    ((null digits) acc)
    ((> (first digits) 9) (error "digit > 9"))
    (t (digits-to-num (rest digits) (+ (* 10 acc) (first digits))))))

(defun primes-before (n)
  (loop for i from 1 to n when (primep i) collect i))

(defun prime-pandigitals (n)
  (let ((digits (loop for i from 1 to n collect i))
        (result (list)))
    (alexandria:map-permutations (lambda (digits)
                                   (let ((n (digits-to-num digits)))
                                     (when (primep n)
                                       (push n result))))
                                 digits)
    result))

(defun e41 ()
  (apply #'max
         (loop for i from 1 to 9
            append (prime-pandigitals i))))
