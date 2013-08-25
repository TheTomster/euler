;; Euler 44

(defparameter pentagonal-numbers nil)
(defparameter pentagonal-numbers-hash nil)

(defun generate-pentagonals (&optional (n 1000000))
  (setf pentagonal-numbers
        (loop for x from 1 to n
           collecting (/ (- (* 3
                               (* x x))
                            x)
                         2)))
  (setf pentagonal-numbers-hash (make-hash-table))
  (loop for x in pentagonal-numbers
       do (setf (gethash x pentagonal-numbers-hash) t))
  t)

(defun pentagonalp (n)
  (gethash n pentagonal-numbers-hash))

(defun e44-interestingp (x y)
  (every #'pentagonalp
         (list x
               y
               (- (max x y) (min x y))
               (+ x y))))

(defun find-operands (fn n)
  "find pentagonal numbers a and b where fn(a, b) = n"
  (loop for a in pentagonal-numbers
       nconc (loop for b in pentagonal-numbers
                when (= (funcall fn a b) n)
                collect (list a b))))

(defun find-subtractands (n)
  (find-operands #'- n))

(defun find-summands (n)
  (find-operands #'+ n))

(defun e44 ()
  (loop for i in pentagonal-numbers do
       (let ((subtractands (find-subtractands i)))
         (when (not (null subtractands))
           (loop for (a b) in subtractands
              do (when (pentagonalp (+ a b))
                   (format t "~&~a and ~a are interesting!" a b)
                   (format t "~&~a + ~a = ~a" a b (+ a b))
                   (format t "~&~a - ~a = ~a" a b (- a b))))))))
