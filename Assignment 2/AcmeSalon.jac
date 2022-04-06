node Options: has name;
node General_Business: has name;
node Appointment: has name;
node Service: has name;


walker init{
    
    root{
        spawn here walker::Build_Options;
        take -->;
    }

    Options{
        spawn here walker::Build_Questions;
        take -->;
    }

    report here.context.name;

}

walker Build_Options{
    General_Node = spawn here --> node::Options(name="General_Business");
    Appointment_Node = spawn here --> node::Options(name="Appointment");
    Service_Node = spawn here --> node::Options(name="Service");
}

walker Build_Questions{
    
    if (here.context.name == "General_Business"){
        spawn here --> node::General_Business(name = "Office_hours");
        spawn here --> node::General_Business(name="Payment_Method");
        spawn here --> node::General_Business(name="Phone_Number");
        spawn here --> node::General_Business(name="Email_Address");
        spawn here --> node::General_Business(name="Promotions");
    }
    elif(here.context.name == "Appointment"){
        spawn here --> node::Appointment(name="Cancel_Appointment");
        spawn here --> node::Appointment(name="Reschedule_Appointment");
        spawn here --> node::Appointment(name="Refunds");
        spawn here --> node::Appointment(name="Feedback");

    }
    elif(here.context.name == "Service"){
        spawn here --> node::Service(name="Manicure");
        spawn here --> node::Service(name="Haircuts");
        spawn here --> node::Service(name="Wedding_Makeup");
        spawn here --> node::Service(name="Eye_Brows");
        spawn here --> node::Service(name="Facial_Treatment");
        spawn here --> node::Service(name="Spa");
        spawn here --> node::Service(name="Pedicure");
        spawn here --> node::Service(name="Hair_Streaming");
    }
    
}

/*
jsctl sentinel register AcmeSalon.jac -set_active true
jsctl graph get -mode dot -o AcmeSalon.dot
dot -Tpng AcmeSalon.dot -o AcmeSalon.png

*/