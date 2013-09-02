;; Euler 46

(defparameter debug-mode t)
(defun dbg (&rest args)
  (when debug-mode
    (let ((format (concatenate 'string "~&" (first args)))
          (args (rest args)))
      (apply #'format (cons t (cons format args))))))

(defun primep (n &optional (i 2))
  (declare (optimize (speed 3))
           (fixnum n i))
  (cond
    ((< n 2)                nil)
    ((> i (floor (sqrt n))) t)
    ((zerop (mod n i))      nil)
    (t                      (primep n (1+ i)))))

(defun primes-before-gen ()
  (let ((prime-cache (list 2)))
    (lambda (n)
      (when (> n (car prime-cache))
        (loop for i from (1+ (car prime-cache)) to n
           when (primep i)
           do (push i prime-cache)))
      (let ((ret prime-cache))
        (loop
           (when (null ret)
             (return ret))
           (when (<= (car ret) n)
             (return ret))
           (setf ret (cdr ret)))))))

(defparameter primes-before (primes-before-gen))

(defun e46p (n)
  (loop for p in (funcall primes-before n)
     do (let* ((x (- n p))
               (xd (floor (/ x 2)))
               (sr (floor (sqrt xd))))
          (when (> sr 0)
            (when (= (* sr sr) xd)
              (dbg "~a = ~a + 2 * ~a^2" n p sr)
              (return-from e46p t)))))
  nil)

(defun e46p-fast (n)
  (loop for p in (funcall primes-before n)
     do (let* ((x (- n p)))
          (when (not (zerop (mod x 2)))
            (return-from e46p-fast t))))
  nil)

(defun e46 ()
  (loop for n = 3 then (+ n 2)
     when (and (not (primep n))
               (not (e46p n)))
     return n))
