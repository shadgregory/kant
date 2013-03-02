(define classpath (org.apache.tools.ant.types.Path p ".:./build"))

(mkdir "./build")
(javac "./build" "./src" classpath)
(java "MyClass" classpath)
