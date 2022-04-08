node salon_options: has name;
node salon_general_business: has name;
node salon_appointment: has name;
node salon_service: has name;



walker init{
    
    root{
        spawn here walker::Build_Questions;
        take -->;
    }

    salon_options {
        spawn here walker::walker_name_build;
    }

}

walker walker_name_build{
    salon_options{
        spawn here walker::walker_name;
        take -->;
    }
    salon_general_business{
        spawn here walker::walker_name;
        take -->;
    }
    salon_appointment{
        spawn here walker::walker_name;
        take -->;
    }
    salon_service{
        spawn here walker::walker_name;
        take -->;
    }
}

walker walker_name{
    std.out(here.name);
    take -->;
}


walker Build_Questions{

    General_Node = spawn here --> node::salon_options(name="salon_general_business");
    Office_hours = spawn General_Node --> node::salon_general_business(name = "Office_hours");
    Payment_Method = spawn General_Node --> node::salon_general_business(name="Payment_Method");
    Phone_Number = spawn General_Node --> node::salon_general_business(name="Phone_Number");
    Email_Address = spawn General_Node --> node::salon_general_business(name="Email_Address");
    Promotions = spawn General_Node --> node::salon_general_business(name="Promotions");
    
    Appointment_Node = spawn here --> node::salon_options(name="salon_appointment");
    Cancel_Appointment = spawn Appointment_Node --> node::salon_appointment(name="Cancel_Appointment");
    Reschedule_Appointment = spawn Appointment_Node --> node::salon_appointment(name="Reschedule_Appointment");
    Refunds = spawn Appointment_Node --> node::salon_appointment(name="Refunds");
    Feedback = spawn Appointment_Node --> node::salon_appointment(name="Feedback");

    Service_Node = spawn here --> node::salon_options(name="salon_service");
    Manicure = spawn Service_Node --> node::salon_service(name="Manicure");
    Haircuts = spawn Service_Node --> node::salon_service(name="Haircuts");
    Wedding_Makeup = spawn Service_Node --> node::salon_service(name="Wedding_Makeup");
    Eye_Brows = spawn Service_Node --> node::salon_service(name="Eye_Brows");
    Facial_Treatment = spawn Service_Node --> node::salon_service(name="Facial_Treatment");
    Spa = spawn Service_Node --> node::salon_service(name="Spa");
    Pedicure = spawn Service_Node --> node::salon_service(name="Pedicure");
    Hair_Streaming = spawn Service_Node --> node::salon_service(name="Hair_Streaming");
}



/*
jsctl sentinel register AcmeSalon.jac -set_active true
jsctl graph get -mode dot -o AcmeSalon.dot
dot -Tpng AcmeSalon.dot -o AcmeSalon.png

*/
