for f in app/views/devise/**/*.erb; do html2haml -e $f ${f%erb}haml && rm $f; done
