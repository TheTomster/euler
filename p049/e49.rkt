#lang racket

(require math/number-theory)

(define (permuted? a b)
  (let ([a-ct (make-hash)]
        [b-ct (make-hash)])
    (let loop ([a a]
               [b b])
      (cond
        [(or (= a 0) (= b 0)) (equal? a-ct b-ct)]
        [else (let ([a-digit (modulo a 10)]
                    [b-digit (modulo b 10)])
                (hash-set! a-ct a-digit (add1 (hash-ref a-ct a-digit 0)))
                (hash-set! b-ct b-digit (add1 (hash-ref b-ct b-digit 0)))
                (loop (quotient a 10) (quotient b 10)))]))))

(define 4-digit-primes
  (filter prime? (range 1000 10000)))

(define (e49)
  (for ([a 4-digit-primes])
    (for ([b (filter (lambda (n) (> n a)) 4-digit-primes)])
      (when (permuted? a b)
        (let ([c (+ b (- b a))])
          (when (and (permuted? a c)
                     (prime? c))
            (displayln (list a b c))))))))