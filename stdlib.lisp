(def (not x) (if x #f #t))
(def (null? x) (if (eqv? obj '()) #t #f))

(def (list . objs) objs)

(def (id obj) obj)

(def (flip func) (fn (arg1 arg2) (func arg2 arg1)))

(def (curry func arg1) (fn (arg) (apply func (cons arg1 (list arg)))))
(def (compose f g) (fn (arg) (f (apply g arg))))

(def zero? (curry = 0))
(def positive? (curry < 0))
(def negative? (curry > 0))
(def (odd? num) (= (mod num 2) 1))
(def (even? num) (= (mod num 2) 0))

(def (foldr func end lst)
  (if (null? lst)
      end
      (func (car lst) (foldr func end (cdr lst)))))
(def (foldl func accum lst)
  (if (null? lst)
      accum
      (foldl func (func accum (car lst)) (cdr lst))))

(def fold foldl)
(def reduce fold)

(def (unfold func init pred)
  (if (pred init)
      (cons init '())
      (cons init (unfold func (func init) pred))))

(def (sum . lst) (fold + 0 lst))
(def (product . lst) (fold * 1 lst))
(def (and . lst) (fold and #t lst))
(def (or . lst) (fold or #f lst))

(def (max first . rest) (fold (fn (old new) (if (> old new) old new)) first rest))
(def (min first . rest) (fold (fn (old new) (if (< old new) old new)) first rest))

(def (length list) (fold (fn (x y) (+ x 1)) 0 lst))

(def (reverse list) (fold (flip cons) '() lst))

(def (mem-helper pred op) (fn (acc next) (if (and (not acc) (pred (op next))) next acc)))
(def (memq obj lst) (fold (mem-helper (curry eq? obj) id) #f lst))
(def (memv obj lst) (fold (mem-helper (curry eq? obj) id) #f lst))
(def (member obj lst) (fold (mem-helper (curry equal? obj) id) #f lst))
(def (assq obj alist) (fold (mem-helper (curry eq? obj) car) #f alist))
(def (assv obj alist) (fold (mem-helper (curry eq? obj) car) #f alist))
(def (assoc obj alist) (fold (mem-helper (curry equal? obj) car) #f alist))

(def (map func lst) (foldr (fn (x y) (cons (func x) y) '() lst)))
(def (filter pred lst) (foldr (fn (x y) (if (pred x) (cons x y) y) '() lst)))

