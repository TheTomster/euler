#lang racket

(require math/number-theory)

(provide main)

(define (num->digits n)
  (let loop ([n n]
             [acc '()])
    (cond
      [(zero? n) acc]
      [else (loop (quotient n 10)
                  (cons (modulo n 10) acc))])))

(define (permuted? a b)
  (let ([a-digits (num->digits a)]
        [b-digits (num->digits b)])
    (equal? (sort a-digits <) (sort b-digits <))))

(define 4-digit-primes
  (filter prime? (range 1000 10000)))

(define (step a b)
  (+ b (- b a)))

(define (interesting? a b)
  (cond 
   [(permuted? a b) (let ([c (step a b)])
                      (and (permuted? a c)
                           (prime? c)))]
   [else #f]))

(define (e49)
  (for ([a 4-digit-primes])
    (for ([b (filter (lambda (n) (> n a)) 4-digit-primes)])
      (when (interesting? a b)
        (displayln (list a b (step a b)))))))

(define (main)
  (e49))
