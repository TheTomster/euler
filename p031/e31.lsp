;;; Euler 31
;
; In England the currency is made up of pound, £, and pence, p, and there are
; eight coins in general circulation:
;
;     1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
;
; It is possible to make £2 in the following way:
;     
;     1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
;     
; How many different ways can £2 be made using any number of coins?

(ql:quickload 'fare-memoization)

(defparameter *british-coins* '(200 100 50 20 10 5 2 1))

(defun pack (remainder coin-set)
  (let ((big-coin (first coin-set)))
    (cond
     ((eql remainder 0) 1)
     ((null coin-set) 0)
     ((<= big-coin remainder) (+ (pack (- remainder big-coin) coin-set)
                                (pack remainder (rest coin-set))))
     (t (+ (pack remainder (rest coin-set)))))))
(fare-memoization:memoize 'pack)

(defun e31 (target coins)
  (pack target (sort coins #'>)))
