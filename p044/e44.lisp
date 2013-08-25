;; Euler 44

(defparameter pentagonal-numbers nil)
(defparameter pentagonal-numbers-hash nil)

(defun generate-pentagonals (&optional (n 1000000))
  (setf pentagonal-numbers
        (loop for x from 1 to n
           collecting (/ (* x (- (* 3 x) 1)) 2)))
  (setf pentagonal-numbers-hash (make-hash-table))
  (loop for x in pentagonal-numbers
       do (setf (gethash x pentagonal-numbers-hash) t))
  t)

(defun pentagonalp (n)
  (gethash n pentagonal-numbers-hash))

(defun e44-interestingp (x y)
  (every (lambda (n) (gethash n pentagonal-numbers-hash))
         (list x
               y
               (- (max x y) (min x y))
               (+ x y))))

(defun find-subtractands (n)
  "find pentagonal numbers a and b where a - b = n"
  (loop for a in pentagonal-numbers
       nconc (loop for b in pentagonal-numbers
                when (= (- a b) n)
                collect (list a b))))

(defun e44 ()
  (loop for i in pentagonal-numbers do
       (let ((subtractands (find-subtractands i)))
         (when (not (null subtractands))
           (loop for (a b) in subtractands
              do (when (pentagonalp (+ a b))
                   (format t "~&~a and ~a are interesting!" a b)
                   (format t "~&~a + ~a = ~a" a b (+ a b))
                   (format t "~&~a - ~a = ~a" a b (- a b))))))))
