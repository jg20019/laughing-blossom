;;;; time-tracker.asd

(asdf:defsystem #:time-tracker
  :description "Describe time-tracker here"
  :author "John Gibson"
  :license  "MIT"
  :version "0.0.1"
  :serial t
  :depends-on (#:hunchentoot #:easy-routes #:jonathan #:postmodern)
  :components ((:file "package")
               (:file "time-tracker")))
