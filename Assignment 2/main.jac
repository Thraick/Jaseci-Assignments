import {node::{state, aboutstate}, edge::{transition}, graph::{main_graph}} with "./graph.jac";
import {*} with "./walkers.jac";

walker init {

    root {
        spawn here --> graph::main_graph;
        spawn --> walker::talker;
    }
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