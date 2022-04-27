walker talker {
    has utterance;
    can use.enc_question, use.enc_answer;

    std.out(here.message);

    utterance = std.input("> ");

    if(utterance == "quit"): disengage;

    q_enc = use.enc_question(utterance);
    a_enc = use.enc_answer(here.prompts); # can take lists or single strings

    a_scores = {}; #stores a dictionary of prompts and their related scores based on utterance similarity
    cf_threshold = 0.1; #cutoff threshold value; scores below this will be ignored
    max_cf = 0; #max confidence factor score of the question among the encoded answers
    chosen_intent = ""; #holds the intent that scored the highest cf

    for i=0 to i < (here.prompts).length by i += 1 {
        
        cf = vector.cosine_sim(q_enc, a_enc[i]); #confidence factor; the cosine_similarity score

        a_scores[here.prompts[i]] = cf;

        if(cf >= cf_threshold && max_cf < cf) {            
            max_cf = cf;
            chosen_intent = here.prompts[i];
        }
    }

    report {"utterance" : utterance, "chosen_intent": chosen_intent, "scores": a_scores};


    state {
        if (here.name == "Greeting"){
            take -[transition(intent == chosen_intent)]-> node::infodata else {
                take here;
            }

        }
        elif(chosen_intent == "go back"){
            take -[transition(intent == chosen_intent)]-> node::state else {
                take here;
            }
        }
        else{
            take -[transition(intent == chosen_intent)]-> node::state else {
                std.out("Hmm.. not sure what you mean. Here are some options to help: ", here.prompts);
                take here;
                
            }
        }

    }

    infodata {

        if(chosen_intent == "go back"){
            take -[transition(intent == chosen_intent)]-> node::state else {
                take here;
            }
        }
        else{
            take -[transition(intent == chosen_intent)]-> node::state else {
                std.out("Hmm.. not sure what you mean. Here are some options to help: ", here.prompts);
                take here;
                
            }
        }

    }
}