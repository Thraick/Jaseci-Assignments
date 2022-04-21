walker talker {
    has utterance;

    if(here.name == "Quit"): disengage;
    utterance = std.input("> ");

    state {
        if (here.name == "Greeting"){
            take -[transition(intent == utterance)]-> node::state else {
                take here;
            }
        }
        elif(utterance == "back"){
            take -[transition(intent == utterance)]-> node::state else {
                take here;
            }
        }
        else{
            take -[transition(intent == utterance)]-> node::aboutstate else {
                take here;
                
            }
        }
    }

    aboutstate{
        take -[transition(intent == utterance)]-> node::state else {
            take here;
        }
    }

}
