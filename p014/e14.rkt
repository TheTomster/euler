#lang racket

(define (next-collatz n)
  (cond
    [(even? n) (floor (/ n 2))]
    [else (+ 1 (* 3 n))]))

(define (collatz-count n)
  (define (aux n acc)
    (cond
      [(= 1 n) acc]
      [else (aux (next-collatz n) (+ acc 1))]))
  (aux n 1))

(define (e14)
  (apply max (map collatz-count (range 1 1000000))))
