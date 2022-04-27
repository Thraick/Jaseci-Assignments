node state {
    has name;
    has message;
    has prompts;

    can speak with entry {
        std.out(message + "  " + prompts.str);
    }
}

node aboutstate {
    has name;

    can speak with entry {
        std.out("I am currently at "+name);
    }
}

edge transition {
    has intent;
}

graph main_graph {
    has anchor main_root;

    spawn{

        // Greetings //
        main_root = spawn node::state(
                                name = "Greeting",
                                message = "What would you like to do?",
                                prompts = ["General business", "Service", "Appointment", "Quit"]
        );

        // quit_node = spawn node::state(name="Quit", message="Quitting...", prompts="");
        // main_root -[transition(intent="quit")]->quit_node;


        // General Business Queries //
        general_business_node = spawn main_root -[transition(intent="general business")]-> node::state(
                                name = "General Business Querries",
                                message = "How can I help you?",
                                prompts = ["back", "Office Hour", "Phone Number", "Email Address"]
        );

        general_business_node -[transition(intent="back")]->main_root;
        
        office_hours = spawn general_business_node -[transition(intent="office_hours")]->
            node::aboutstate(name="Office Hours");
        payment_method = spawn general_business_node -[transition(intent="payment_method")]->
            node::aboutstate(name="Payment Method");
        phone_number = spawn general_business_node -[transition(intent="phone_number")]->
            node::aboutstate(name="Phone Number");
        email_address = spawn general_business_node -[transition(intent="email_address")]->
            node::aboutstate(name="Email Address");
        promotions = spawn general_business_node -[transition(intent="promotions")]->
            node::aboutstate(name="Promotions");        

        office_hours -[transition(intent="back")]->general_business_node;
        payment_method -[transition(intent="back")]->general_business_node;
        phone_number -[transition(intent="back")]->general_business_node;
        email_address -[transition(intent="back")]->general_business_node;
        promotions -[transition(intent="back")]->general_business_node;



        // Service Related Queries //
        service_node = spawn main_root -[transition(intent="service")]-> node::state(
                                name = "Service",
                                message ="Which service would you like to request?",
                                prompts=["back","Manicures","Haircuts","Wedding Makeup","Eyebrows","Facial Treatments","Spa","Pedicures","Hair Steaming"]
        );

        service_node -[transition(intent="back")]->main_root;

        manicures = spawn service_node -[transition(intent="manicures")]->
            node::aboutstate(name="About manicures");
        haircuts = spawn service_node -[transition(intent="haircuts")]->
            node::aboutstate(name="About Haircuts");
        wedding_makeup = spawn service_node -[transition(intent="wedding_makeup")]->
            node::aboutstate(name="About Wedding Makeup");
        eyebrows = spawn service_node -[transition(intent="eyebrows")]->
            node::aboutstate(name="About Eyebrows");
        facial_treatments = spawn service_node -[transition(intent="facial_treatments")]->
            node::aboutstate(name="About Facial Treatments");
        spa = spawn service_node -[transition(intent="spa")]->
            node::aboutstate(name="About Spa");
        pedicures = spawn service_node -[transition(intent="pedicures")]->
            node::aboutstate(name="About Pedicures");
        hair_steaming = spawn service_node -[transition(intent="hair_steaming")]->
            node::aboutstate(name="Hair Steaming");

        manicures -[transition(intent="back")]->service_node;
        haircuts -[transition(intent="back")]->service_node;
        wedding_makeup -[transition(intent="back")]->service_node;
        eyebrows -[transition(intent="back")]->service_node;
        facial_treatments -[transition(intent="back")]->service_node;
        spa -[transition(intent="back")]->service_node;
        pedicures -[transition(intent="back")]->service_node;
        hair_steaming -[transition(intent="back")]->service_node;



        // Appointment Related Question //
        appt_node = spawn main_root -[transition(intent="appointment")]-> node::state(
                                name = "Appointment",
                                message = "How can I help you with your appointment?",
                                prompts =["back","Cancel", "Reschedule", "Refund", "Feedback"]
        );

        appt_node -[transition(intent="back")]->main_root;

        cancel = spawn appt_node -[transition(intent="cancel")]->
            node::aboutstate(name="Cancel Appointment");
        reschedule = spawn appt_node -[transition(intent="reschedule")]->
            node::aboutstate(name="Reschedule Appointment");
        refund = spawn appt_node -[transition(intent="refund")]->
            node::aboutstate(name="Refund");
        feedback = spawn appt_node -[transition(intent="feedback")]->
            node::aboutstate(name="Feedback");

        cancel -[transition(intent="back")]->appt_node;
        reschedule -[transition(intent="back")]->appt_node;
        refund -[transition(intent="back")]->appt_node;
        feedback -[transition(intent="back")]->appt_node;


    }
}

// graph abouy {

//     spawn service_node -[transition(intent="cut")]->
//         node::aboutstate(name="cut test");
// }