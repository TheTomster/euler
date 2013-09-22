#lang racket

(require math/number-theory)

(provide main)

(define (factor-candidates n)
  (map inexact->exact (range (floor (sqrt n)) 1 -1)))

(define (n-factors? i n)
  (= n  (length (prime-divisors i))))

(define (interesting? i n)
  (let loop ([i i]
             [count n])
    (if (<= count 0)
        #t
        (and (n-factors? i n) (loop (add1 i) (sub1 count))))))

(define (e47 n)
  (let loop ([i 2])
    (if (interesting? i n)
        i
        (loop (add1 i)))))

(define (main)
  (e47 4))