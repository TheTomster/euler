; Euler 39
;
; If p is the perimeter of a right angle triangle with integral length
; sides, {a,b,c}, there are exactly three solutions for p = 120.
;
; {20,48,52}, {24,45,51}, {30,40,50}
;
; For which value of p ≤ 1000, is the number of solutions maximised?

(defun stopping-point (a p)
  (> (max (- (* 2 a) (* (sqrt 2) a))
	  (+ (* (sqrt 2) a) (* 2 a)))
     p))

(defun is-int-rt-solution (a b p)
  (let ((c (sqrt (+ (* a a) (* b b)))))
    (and (zerop (mod c 1))
	 (= (+ a b c) p))))

(defun n-int-rts (p)
  (loop for a from 1 to p
     until (stopping-point a p)
     summing (loop for b from 1 to p
	      counting (is-int-rt-solution a b p))))

(defun e39 (&optional (max 1000))
  (loop
     with highest-n = 0
     with best-p = 0
     with current-n
     for i from 1 to max
     do (setf current-n (n-int-rts i))
     when (> current-n highest-n) do (progn
				       (setf highest-n current-n)
				       (setf best-p i))
     finally (return (list best-p highest-n))))

