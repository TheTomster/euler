;;; Starting in the top left corner of a 2×2 grid, there are 6 routes
;;; (without backtracking) to the bottom right corner.

;;; How many routes are there through a 20×20 grid?


(defparameter depth 20)

(defun n-choices ()
  (* 2 depth))

(defun choose (inp)
  (remove-if (lambda (x) (> (abs x) depth))
             (mapcan (lambda (x) (list (1+ x) (1- x))) inp)))

(defun permutations ()
  (labels ((rec (n i)
             (if (<= n 0)
                 i
                 (rec (- n 1) (choose i)))))
    (rec (n-choices) (list 0))))

(defun euler15 ()
  (count 0 (permutations)))

;; 137,846,528,820

;; Used this code to determine the first ~10 and then threw it in
;; wolfram alpha

;; Of course, if I knew more probability I would have seen that the
;; answer is simply 40 choose 20.