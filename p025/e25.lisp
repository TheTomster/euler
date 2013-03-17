; What is the first term in the Fibonacci sequence to contain 1000 digits?

(defparameter *target* 1000)

(defun target-digits ()
    (expt 10 (- *target* 1)))

(defun e25 (&optional (a 1) (b 1) (i 3))
    (let ((next (+ a b)))
        (if (> (/ next (target-digits)) 1)
            i
            (e25 b next (1+ i)))))

