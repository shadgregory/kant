(define p (org.apache.tools.ant.Project))
(define classpath (org.apache.tools.ant.types.Path p ".:./build"))

(mkdir "./build")
(javac p "./build" "./src" classpath)
(java p "MyClass" classpath)
