node state {
    has name;
    has message;
    has prompts;
}

node infodata {
    has name;
    has message = "Please confirm if that is correct.";
    has room;
    has window;
    has door;
    has prompts = ["correct", "this is totally wrong"];

    can speak with entry{
        std.out("Please tell us how much room, window and door you would like.");
        room = std.input("Room: ");
        window = std.input("Window: ");
        door = std.input("Door: ");
    }

}

edge transition{
    has intent;
} 

graph main_graph {
    has anchor main_root;

    spawn{
        main_root = spawn node::state(
                                name="Greeting",
                                message="Welcome! What kind of house would you like to build?",
                                prompts=["flat house","two story house","three story house"]
        );

        flat_node = spawn main_root -[transition(intent="flat house")]-> node::infodata(
                                name="Flat house"
        );
        two_story_node = spawn main_root -[transition(intent="two story house")]-> node::infodata(
                                name="two story house"
        );
        three_story_node = spawn main_root -[transition(intent="three story house")]-> node::infodata(
                                name="three story house"
        );

        flat_node -[transition(intent="go back")]->main_root;
        two_story_node -[transition(intent="go back")]->main_root;
        three_story_node -[transition(intent="go back")]->main_root;
        

        other_node = spawn node::state(
                                name="other question",
                                message="Is there any thing else that I can help you with?",
                                prompts=["i don't need help","i need help"]
        );

        flat_node -[transition(intent="this is totally wrong")]->flat_node;
        two_story_node -[transition(intent="this is totally wrong")]->two_story_node;
        three_story_node -[transition(intent="this is totally wrong")]->three_story_node;

        flat_node -[transition(intent="correct")]->other_node;
        two_story_node -[transition(intent="correct")]->other_node;
        three_story_node -[transition(intent="correct")]->other_node;


        thank_node = spawn other_node -[transition(intent="i don't need help")]->node::state(
                                name="thank you",
                                message="Thank you for choosing us. Have a good day!!",
                                prompts=["quit"]
                            );

        remain_root = spawn other_node -[transition(intent="i need help")]-> node::state(
                                name="Greeting",
                                message="What kind of house would you like to build?",
                                prompts=["flat house","two story house","three story house"]
                            );

        remain_root -[transition(intent="flat house")]-> flat_node;
        remain_root -[transition(intent="two story house")]-> two_story_node;
        remain_root -[transition(intent="three story house")]-> three_story_node;
    }
    
}
