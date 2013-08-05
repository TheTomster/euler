; Euler 40

(defun num-to-digits (n &optional (acc ()))
  (if (<= n 0)
    acc
    (num-to-digits (floor n 10) (cons (mod n 10) acc))))

(defun e40 ()
  (let ((digits (make-array 1000000 :initial-element 0 :fill-pointer 0)))
    (loop
       with i = 0
       with n = 1
       do
         (let* ((ds (num-to-digits n)))
           (loop for d in ds do
                (vector-push d digits)
                (incf i)))
         (incf n)
       until (> i 1000000))
    (apply #'* (loop
                  for pow from 0 to 6
                  collect (elt digits (1- (expt 10 pow)))))))
