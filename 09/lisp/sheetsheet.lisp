(setq x 10)
(setq y 34.567)
(setq ch nil)
(setq n 123.78)
(setq bg 11.0e+4)
(setq r 124/2)

(print x)
(print y)
(print n)
(print ch)
(print bg)
(print r)

(write "---")
(print (type-of x))
(print (type-of y))
(print (type-of n))
(print (type-of ch))
(print (type-of bg))
(print (type-of r))

(defmacro setTo10(num)
(setq num 10)(print num))

(setq x 25)
(print x)
(setTo10 x)

(defvar x 234)
(write x)

(setq x 10)
(setq y 20)
(format t "x = ~2d y = ~2d ~%" x y)

(setq x 100)
(setq y 200)
(format t "x = ~2d y = ~2d" x y)

(print "--")
(setq a 9)
(print (cond ((< a 10) (* 10 2))
      ((< a 20) (* 20 2))
      ((>= a 20) (* 30 2))))
(print "--")

(print (if (< 11 10) (* 11 2)
  (* 10 2)))
(print (if (< 10 11) (* 11 2))) ; nur wenn es nicht fehlschlägt ; returnt nichts
(print (when (< 10 11) (* 11 2))) ; nur wenn es nicht fehlschlägt ; returnt den wert der action oder nil

(setq day 4)
(case day
  (1 (print "Mo"))
  (2 (print "Di"))
  (3 (print "Mi"))
  (4 (print "Do"))
  (5 (print "Fr"))
  (6 (print "Sa"))
  (7 (print "So")))

(setq a 10)
(loop
  (incf a 1)
  (print "hallo")
  (when (> a 17) (return a)))

(dolist (n '(1 2 3 4 5 6))
  (print (* n n)))

(print "++")
(loop for x in '(1 2 3 4 5 6)
      do (print x))

(dotimes (n 11)
  (print (* n n)))

(do ((x 0 (+ 2 x))
     (y 20 (- y 2)))
  ((= x y)(- x y))
  (print x)
  )

(defun averagenum (n1 n2 n3 n4)
  (/ (+ n1 n2 n3 n4) 4))
(print(averagenum 10 20 30 40))

; arrays
(setf my-array (make-array '(10)))
(setf (aref my-array 9) 20)
(write my-array)

(setf x (make-array '(3 3)
                    :initial-contents '((0 1 2) (3 4 5) (6 7 8))))
(print x)


(setq a (make-array '(4 3)))
(dotimes (i 4)
   (dotimes (j 3)
      (setf (aref a i j) (list i 'x j '= (* i j)))
   )
)



(dotimes (i 4)
   (dotimes (j 3)
      (print (aref a i j))
   )
)

(setq x (vector 'a 'b 'c 'd 'e))
(print(length x))
(print(elt x 3))  ; access drittes element

; alternative:
(setq x #(a b c d e))
(print(length x))
(print(elt x 3))  ; access drittes element


(list 1 2 3)
(list 'a 'b)
(setq x (list :title "der title" :author "ich"))
(write (getf x :title))
