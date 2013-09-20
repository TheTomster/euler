#lang racket

;(require racket/fixnum)
;(require racket/unsafe/ops)

(define (pentagonal n)
  (/ (- (* 3
           (* n n))
        n)
     2))

(define (pentagonal? n)
  (let* ([x (+ (* 24 n) 1)]
         [sr (sqrt x)])
    (and (integer? sr)
         (= 5 (modulo sr
                      6)))))

; Finds all of the pentagonal #s between Pn and Pn/2
(define (summands-to-test n)
  (let loop ([p (pentagonal n)]
             [acc null]
             [i (pentagonal (- n 1))])
    (if (< (pentagonal i) (/ n 2))
        acc
        (loop p (cons (pentagonal i) acc) (- i 1)))))

; test if p1 - p2 is pentagonal. if so, then check if the difference
; between p2 and p3 is also pentagonal
(define (check p1 p2)
  (let ([p3 (- p1 p2)])
    (and (pentagonal? p3)
         (pentagonal? (- p2 p3)))))

(define (e44)
  (for* ([i (in-range 1 1000)]
         [to-test (summands-to-test i)])
    (when (check (pentagonal i) to-test)
      (let* ([p1 (pentagonal i)]
             [p2 to-test]
             [p3 (- p1 p2)]
             [p4 (- p2 p3)])
        (format "PASS! ~a ~a ~a ~a"
                p1
                p2
                p3
                p4)))))
