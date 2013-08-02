; Euler 38
;
; Pandigital products:
; 9 x 1 = 9
; 9 x 2 = 18
; 9 x 3 = 27
; 9 x 4 = 36
; 9 x 5 = 45
; concatenated = 918273645
;
; Find highest number that can be created in this manner

(defun num-to-digits (n &optional (acc ()))
  (if (<= n 0)
    acc
    (num-to-digits (floor n 10) (cons (mod n 10) acc))))

(defun digits-to-num (digits &optional (acc 0))
  (if (null digits)
    acc
    (digits-to-num (rest digits) (+ (* 10 acc) (first digits)))))

(defun product-digits (n i)
  (num-to-digits (* n i)))

(defun duplicate-digit-p (n)
  (labels ((aux (digits) (or (member (first digits) (rest digits))
			     (aux (rest digits)))))
    (aux (num-to-digits n))))

(defun get-pdp (n)
  (labels ((aux (n i digits)
             (if (eql (length digits) 9)
		 (digits-to-num digits)
		 (let* ((new-digits (product-digits n i)))
		   (if (or (some (lambda (x) (member x digits)) new-digits)
			   (member 0 new-digits))
		       nil
		       (aux n (1+ i) (append digits new-digits)))))))
    (if (duplicate-digit-p n)
	nil
	(aux n 2 (num-to-digits n)))))

(defun e38 (&optional (upper-limit (expt 10 9)))
  (let ((largest-pdp 0))
    (loop for n from upper-limit downto 1
      do (let ((pdp (get-pdp n)))
           (cond
            ((null pdp) nil)
            ((> pdp largest-pdp)
             (setf largest-pdp pdp)))))
    largest-pdp))
