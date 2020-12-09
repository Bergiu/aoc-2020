(defun read-file(filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          while line
          collect (parse-integer line))))

(defun find-in-list (the-list element) "Returned True wenn das Element in der Liste ist."
  (if (= (length the-list) 0)
    NIL
    (if (= (car the-list) element)
      t
      (find-in-list (cdr the-list) element))
    )
  )

(defun find-pair(preamble sum) "Returned True wenn es zwei Zahlen in der Preamble gibt, die addiert die Summe ergeben."
  (block find-loop
         (dolist (num preamble)
           (let ((found (find-in-list preamble (- sum num))))
             (if found
               (return-from find-loop t))
             ))
         NIL
         )
  )

(defun find-wrong-pair(lines preamble-length) "Finde die Zahl, in dessen Vorgänger kein Paar enthalten ist, welche in der Summe die Zahl ergibt."
  (setq i 0)
  (block find-wrong-loop
         (dolist (line (subseq (copy-seq lines) preamble-length (length lines)))
           (setq preamble (subseq (copy-seq lines) i (+ i preamble-length)))
           (if (not (find-pair preamble line))
             (return-from find-wrong-loop line)
             )
           (incf i 1)
           )
         ))

(defun find-sum-set(lines num)
  (let ((sum 0)
        (sum-set '()))
    (block find-sum-set-loop
           (dolist (line lines)
             (incf sum line)
             (push line sum-set)
             (if (= sum num) (return-from find-sum-set-loop sum-set))
             (if (>= sum num)
               (return-from find-sum-set-loop
                            (find-sum-set (subseq (copy-seq lines) 1 (length lines)) num))
               )
             ))
    ))

(defun part1(filename sum)
  (print "Part 1")
  (print (find-wrong-pair (read-file filename) sum))
  )

(defun part2(filename sum)
  (print "Part 2")
  (setq lines (read-file filename))
  (setq num (find-wrong-pair (copy-seq lines) sum))
  (setq sum-set (find-sum-set lines num))
  (print (+ (apply 'min sum-set) (apply 'max sum-set)))
  )

(defun main()
  (part1 "input.txt" 25)
  (part2 "input.txt" 25))

(main)
