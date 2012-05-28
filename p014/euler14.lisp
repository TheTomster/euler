;;; The following iterative sequence is defined for the set of
;;; positive integers:

;;; n → n/2 (n is even)
;;; n → 3n + 1 (n is odd)

;;; Using the rule above and starting with 13, we generate the
;;; following sequence:

;;; 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1

;;; It can be seen that this sequence (starting at 13 and finishing at
;;; 1) contains 10 terms. Although it has not been proved yet (Collatz
;;; Problem), it is thought that all starting numbers finish at 1.

;;; Which starting number, under one million, produces the longest chain?

(defun range (start end)
  "Creates a list of numbers from start (inclusive) to end (exclusive)."
  (loop for i from start below end collect i))

(defparameter test-n 1000000)

(defun collatz-count (n)
  (let ((acc 0))
    (do ((x n (collatz x)))
        ((equal x 1) (incf acc))
      (incf acc))))

(defun collatz-seq (n)
  (let (acc)
    (do ((x n (collatz x)))
        ((equal x 1) (push x acc))
      (push x acc))
    (nreverse acc)))

(defun collatz (n)
  (cond ((evenp n) (/ n 2))
        ((oddp n) (+ 1 (* 3 n)))))

(defun longest-collatz ()
  (do ((i 1 (+ i 1))
       (highest 0)
       (highest-i)
       (cc 1 (collatz-count (+ i 1))))
      ((equal i test-n) highest-i)
    (if (> cc highest)
        (progn 
          (setf highest cc)
          (setf highest-i i)))))

(format t "~&~S~%" (longest-collatz))

;;; Result: 837,799 gives the longest sequence, with length 525
;;; Evaluation took:
;;;   7.054 seconds of real time
;;;   7.040440 seconds of total run time (7.040440 user, 0.000000 system)
;;;   99.80% CPU
;;;   14,779,706,077 processor cycles
;;;   0 bytes consed
