#lang racket

(require math/number-theory)

(provide main)

(define (from-sequence i)
  (pentagonal-number i))

(define (in-sequence? i)
  (pentagonal-number? i))

; find all valid numbers that are less than n
(define (sequence-before n)
  (let loop ([i 1]
             [acc '()])
    (let ([p (from-sequence i)])
      (cond
        [(>= p n) acc]
        [else (loop (add1 i) (cons p acc))]))))

; remove nulls from n
(define (harvest ns)
  (filter (compose not null?) ns)) 

; find an a and b such that
;     a - b = c
; and a and b are valid
(define (find-subtractands c)
  (harvest (for/list ([b (in-list (sequence-before c))])
             (let ([a (+ b c)])
               (if (in-sequence? a)
                   (list a b)
                   null)))))

(define (add-pair p)
  (apply + p))

(define (sub-pair p)
  (apply - p))

; check whether the sum of the given pair is valid
(define sum-pair? (compose in-sequence? add-pair))

(define (e44)
  (sub-pair (first
    (let loop ([i 1])
      (let* ([p (from-sequence i)]
             [subtractand-pairs (find-subtractands p)]
             [summand-pairs (filter sum-pair?
                                    subtractand-pairs)])
        (if (not (null? summand-pairs))
            summand-pairs
            (loop (add1 i))))))))

(define (main)
  (displayln (e44)))
