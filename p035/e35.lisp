; Euler 35
;
; The number, 197, is called a circular prime because all rotations of the
; digits: 197, 971, and 719, are themselves prime.
;
; There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37,
; 71, 73, 79, and 97.
;
; How many circular primes are there below one million?

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

(defun prime-p (n &optional (i 2))
  (cond
   ((< n 2)           nil)
   ((> i (sqrt n))    t)
   ((zerop (mod n i)) nil)
   (t                 (prime-p n (1+ i)))))

(defun rotate (ns)
  (append (cdr ns) (list (car ns))))

(defun circular-prime-p (n)
  (if (not (prime-p n))
    nil
    (let ((digits (num-to-list n)))
      (every #'identity 
             (mapcar (lambda (digits) (prime-p (list-to-num digits)))
                     (loop for i from 1 to (length digits)
                       collect digits
                       do (setf digits (rotate digits))))))))

(defun e35 (max)
  (loop for n from 2 to max
    counting (circular-prime-p n)))
