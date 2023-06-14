(define main-procedure
    (lambda (tripleList)
        (if (or (null? tripleList) (not (list? tripleList)))
            (error "ERROR305: the input should be a list full of triples")
            (if (check-triple? tripleList)
                (sort-area (filter-pythagorean (filter-triangle
                (sort-all-triples tripleList))))
                (error "ERROR305: the input should be a list full of triples")
            )
        )
    )
)


(define check-triple?
  (lambda (tripleList)
    (andmap
      (lambda (triple)
        (and (check-length? triple 3)
             (check-sides? triple)))
      tripleList)))


(define check-length?
  (lambda (inTriple count)
    (= (length inTriple) count)))


(define check-sides?
  (lambda (inTriple)
    (and (number? (car inTriple))
             (number? (cadr inTriple))
             (number? (caddr inTriple))
             (> (car inTriple) 0)
             (> (cadr inTriple) 0)
             (> (caddr inTriple) 0))))


(define sort-all-triples
  (lambda (tripleList)
    (map sort-triple tripleList)))


(define sort-triple
  (lambda (inTriple)
    (list (apply min inTriple)
          (apply median inTriple)
          (apply max inTriple))))


(define median
  (lambda (a b c)
    (cond ((and (<= a b) (<= b c)) b)
          ((and (<= a c) (<= c b)) c)
          (else a))))


(define filter-triangle
  (lambda (tripleList)
    (filter triangle? tripleList)))


(define triangle?
  (lambda (triple)
    (let ((a (car triple))
          (b (cadr triple))
          (c (caddr triple)))
      (and (> (+ a b) c)
           (> (+ b c) a)
           (> (+ c a) b)))))


(define filter-pythagorean
  (lambda (tripleList)
    (filter pythagorean-triangle? tripleList)))


(define pythagorean-triangle?
  (lambda (triple)
    (let ((a (car triple))
          (b (cadr triple))
          (c (caddr triple)))
      (= (+ (* a a) (* b b)) (* c c)))))


(define sort-area
  (lambda (tripleList)
    (sort tripleList
          (lambda (triple1 triple2)
            (< (get-area triple1) (get-area triple2))))))


(define get-area
  (lambda (triple)
    (let ((a (car triple))
          (b (cadr triple))
          (c (caddr triple)))
      (/ (* a b) 2))))

