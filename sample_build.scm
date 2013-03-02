(set-classpath ".:./build")

(mkdir "./build")
(javac "./build" "./src")
(java "MyClass")
