walker init{
     std.out("Hello World");
}



/*
Run Server:              jsctl

Run File:                jac run filename.jac
Run walker:              walker run walkername


Set Active:              sentinel register Filename.jac -set_active true
API:                     alias list

Create dot file:         jsctl graph get -mode dot -o outputname.dot
Dot File Graphviz:       dot -Tpdf Filename.dot -o outputname.pdf 
                         dot -Tpng go.dot -o go.png


Dot and Jac is case sensitive

.jac
dot -Tpdf
*/