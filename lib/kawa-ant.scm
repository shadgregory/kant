(define-alias <kawac> <gnu.kawa.ant.Kawac>)
(define-alias <fileset> <org.apache.tools.ant.types.FileSet>)
(define-alias <javac> <org.apache.tools.ant.taskdefs.Javac>)
(define-alias <java> <org.apache.tools.ant.taskdefs.Java>)
(define-alias <jar> <org.apache.tools.ant.taskdefs.Jar>)
(define-alias <mkdir> <org.apache.tools.ant.taskdefs.Mkdir>)
(define-alias <delete> <org.apache.tools.ant.taskdefs.Delete>)
(define p (org.apache.tools.ant.Project))
(define classpath (org.apache.tools.ant.types.Path p "."))

(define set-classpath 
  (lambda (path)
    (set! classpath (org.apache.tools.ant.types.Path p path))))

(define kawac
  (lambda (prefix dir dest-dir files lang)
    (let ((kawac (gnu.kawa.ant.Kawac))
          (fileset (org.apache.tools.ant.types.FileSet)))
      (invoke (as <kawac> kawac) 'setTaskName "kawac")
      (invoke (as <kawac> kawac) 'setDestdir (java.io.File dest-dir))
      (invoke (as <kawac> kawac) 'setProject p)
      (invoke (as <kawac> kawac) 'setLanguage lang)
      ;(invoke (as <kawac> kawac) 'setClasspath classpath)
      (invoke (as <kawac> kawac) 'setPrefix prefix)
      (invoke (as <fileset> fileset) 'setDir (java.io.File (as <String> dir)))
      (invoke (as <fileset> fileset) 'appendIncludes files)
      (invoke (as <kawac> kawac) 'addFileset fileset)
      (invoke (as <kawac> kawac) 'execute))))

(define javac
  (lambda (destdir srcdir)
    (let ((javac (org.apache.tools.ant.taskdefs.Javac)))
      (invoke (as <javac> javac) 'setProject p)
      (invoke (as <javac> javac) 'setSrcdir 
              (org.apache.tools.ant.types.Path p srcdir))
      (invoke (as <javac> javac) 'setDestdir 
              (java.io.File (as <String> destdir)))
      (invoke (as <javac> javac) 'setClasspath classpath)
      (invoke (as <javac> javac) 'execute))))

(define delete
  (lambda (dir)
    (let ((delete (org.apache.tools.ant.taskdefs.Delete)))
      (invoke (as <delete> delete) 'setProject p)
      (invoke (as <delete> delete) 'setDir (java.io.File (as <String> dir)))
      (invoke (as <delete> delete) 'execute))))

(define java
  (case-lambda 
    ((classname)
     (let ((java (org.apache.tools.ant.taskdefs.Java)))
       (invoke (as <java> java) 'setProject p)
       (invoke (as <java> java) 'setClassname classname)
       (invoke (as <java> java) 'setClasspath classpath)
       (invoke (as <java> java) 'execute)))
    ((classname arg)
     (let ((java (org.apache.tools.ant.taskdefs.Java)))
       (invoke (as <java> java) 'setProject p)
       (invoke (as <java> java) 'setClassname classname)
       (invoke (as <java> java) 'setClasspath classpath)
       (invoke (as <java> java) 'setArgs arg)
       (invoke (as <java> java) 'execute)))))

(define jar
  (lambda (destfile dir includes manifest)
    (let 
        ((jar (org.apache.tools.ant.taskdefs.Jar))
         (fileset (org.apache.tools.ant.types.FileSet)))
      (invoke (as <jar> jar) 'setProject p)
      (invoke (as <jar> jar) 'setDestFile 
              (java.io.File (as <String> destfile)))
      (invoke (as <fileset> fileset) 'setDir 
              (java.io.File (as <String> dir)))
      (invoke (as <fileset> fileset) 'appendIncludes includes)
      (invoke (as <jar> jar) 'setManifest manifest)
      (invoke (as <jar> jar) 'addFileset fileset)
      (invoke (as <jar> jar) 'execute))))

(define mkdir
  (lambda (dir)
    (let ((mkdir (org.apache.tools.ant.taskdefs.Mkdir)))
      (invoke (as <mkdir> mkdir) 'setDir (java.io.File (as <String> dir)))
      (invoke (as <mkdir> mkdir) 'execute))))
