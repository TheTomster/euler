;; Convert the numbers from 1 - 1000 into words.
;; How many letters (not counting spaces or hyphens) do you use?
;; Note the format should be similar to
;;    143 ↝ One Hundred and Forty-Three

(defun wordify (i)
  (labels ((wordify-tens (i)
             (if (< i 100)
                 (let ((tens (floor (/ i 10)))
                       (ones (mod i 10)))
                   (concatenate 'string
                                (case tens
                                  (2 "twenty")
                                  (3 "thirty")
                                  (4 "forty")
                                  (5 "fifty")
                                  (6 "sixty")
                                  (7 "seventy")
                                  (8 "eighty")
                                  (9 "ninety"))
                                (if (equal ones 0)
                                    ""
                                    (concatenate 'string
                                                 "-"
                                                 (wordify  ones)))))
                 (wordify-hundreds i)))
           (wordify-hundreds (i)
             (if (< i 1000)
                 (let ((hundreds (floor (/ i 100)))
                       (rest (mod i 100)))
                   (concatenate 'string
                                (wordify hundreds)
                                " hundred"
                                (if (equal rest 0)
                                    ""
                                    (concatenate 'string
                                                 " and " 
                                                 (wordify rest)))))
                 (wordify-thousand i)))
           (wordify-thousand (i)
             (if (equal i 1000)
                 "one thousand"
                 (error "number too large to wordify"))))
    (if (and (<=  i 20) (>= i 1))
        (case i
          (1 "one")
          (2 "two")
          (3 "three")
          (4 "four")
          (5 "five")
          (6 "six")
          (7 "seven")
          (8 "eight")
          (9 "nine")
          (10 "ten")
          (11 "eleven")
          (12 "twelve")
          (13 "thirteen")
          (14 "fourteen")
          (15 "fifteen")
          (16 "sixteen")
          (17 "seventeen")
          (18 "eighteen")
          (19 "nineteen")
          (20 "twenty"))
        (wordify-tens i))))

(defun count-valid-letters (w)
  (length (remove #\  (remove #\- w))))

(defparameter max-num 1000)

(defun euler17 ()
  (let ((acc 0))
    (do ((i 1 (+ i 1)))
        ((> i max-num) acc)
      (incf acc (count-valid-letters (print (wordify i)))))))