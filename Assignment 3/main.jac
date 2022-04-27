import {*} with "./graph.jac";
import {*} with "./walkers.jac";

walker init {

    root {
        spawn here --> graph::main_graph;
        spawn --> walker::talker;
    }
}





/*
Run Server:              jsctl

Run File:                jac run main.jac
Run walker:              walker run walkername


Set Active:              jsctl sentinel register main.jac -set_active true
API:                     alias list

Create dot file:         jsctl graph get -mode dot -o .main.dot
Dot File Graphviz:       dot -Tpdf .main.dot -o .main.pdf 
                         dot -Tpng .main.dot -o .main.png

load jaseci_kit         actions load module jaseci_kit.use_qa

Dot and Jac is case sensitive

.jac
dot -Tpdf

*/