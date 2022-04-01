node Food: has name, cost;
node Payment: has name;
node Delivery: has name, cost;

walker init{
    
    root{
        spawn here walker::build_example;
        take -->;
    }

    Food{
        spawn here walker::walker_name;
        disengage;
    }

}

walker walker_name{
    std.out(here.name);
    take -->;
}

walker build_example{
    // node1 = spawn here --> node::option(name="Options");

    node2 = spawn here --> node::Payment(name="Payment");
    node2_2 = spawn node2 --> node::Payment(name="Credit");
    node2_1 = spawn node2 --> node::Payment(name="Cash");

    node3 = spawn here --> node::Delivery(name="Delivery");
    node3_1 = spawn node3 --> node::Delivery(name="Pick Up");
    node3_2 = spawn node3 --> node::Delivery(name="Deliver");

    node4 = spawn here --> node::Food(name="Food");
    node4_1 = spawn node4 --> node::Food(name="rice");

    node4_2 = spawn node4 --> node::Food(name="curry");
    node4_2_1 = spawn node4_2 --> node::Food(name="chicken curry");
    node4_2_2 = spawn node4_2 --> node::Food(name="duck curry");
    node4_2_3 = spawn node4_2 --> node::Food(name="egg curry");

    node4_3 = spawn node4 --> node::Food(name="fried rice");
    node4_3_1 = spawn node4_3 --> node::Food(name="chicken fried rice");
    node4_3_2 = spawn node4_3 --> node::Food(name="mixed fried rice");
    node4_3_3 = spawn node4_3 --> node::Food(name="vege fried rice");

    node4_4 = spawn node4 --> node::Food(name="chow mein");
    
    
    // node3_1 --> node2_1; node3_1 --> node2_2;
    // node3_2 --> node2_1; node3_2 --> node2_2;


}