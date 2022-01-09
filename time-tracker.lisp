;;;; time-tracker.lisp

(in-package #:time-tracker)

(defparameter *server* (make-instance 'easy-routes:easy-routes-acceptor))

(easy-routes:defroute home ("/" :method :get :decorators (easy-routes:@html)) ()
  (with-open-file (in #p"client/index.html")
    (uiop:read-file-string in)))

; Serve static files from client directory
(setf hunchentoot:*dispatch-table*
      `(hunchentoot:dispatch-easy-handlers 
         ,(hunchentoot:create-folder-dispatcher-and-handler "/" #p"client/")))

;; DATABASE

;; TODO Replace this with a real postgres database
(defparameter *projects* nil "Projects database")
(defparameter *last-insert-id* 0 "Last insert id")

(defclass project ()
  ((id :initarg :id :accessor project-id)
   (name :initarg :name :accessor project-name)
   (target-hours :initarg :target-hours :accessor project-target)))

(defmethod jonathan:%to-json ((p project))
  (jonathan:with-object 
    (jonathan:write-key-value "id" (project-id p))
    (jonathan:write-key-value "name" (project-name p))
    (jonathan:write-key-value "targetHours" (project-target p))))

(defun new-project (&key name (target-hours 40))
  (make-instance 'project 
                 :id (incf *last-insert-id*)
                 :name name
                 :target-hours target-hours))

(defun insert-project (project)
  (push project *projects*))

;; API ROUTES
(easy-routes:defroute get-projects ("/api/projects" :method :get :decorators (easy-routes:@json)) ()
  (jonathan:to-json *projects*))
