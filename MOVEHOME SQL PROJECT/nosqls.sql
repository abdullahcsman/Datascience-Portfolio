db.createCollection("branch");
db.branch.insert(
{ _id: "1", 
  agent_id: "1", 
  manager: {name: 'Smith', email: 'sm@gmail.com', phone_number: '07878952166' },
  staff:
  [ {id: "1", name: 'Harry', phone_number: "07878952166",  postal_code: 'ne32w3', city: "London", state: 'England'},
    {id: "2", name: 'Toe', phone_number: "07872952166",  postal_code: 'ne32w3', city: "Newcastle", state: 'England'},
    {id: "3", name: 'Kim', phone_number: "07872252166",  postal_code: 'ne32w3', city: "Newcastle", state: 'England'} ],
  branch_contact_details:
  [ {phone_number: "07876725556",  email: 'a1@gmail.com'} ],
  postal_code: 'ne32t3',
  city: 'Newcastle',
  state: 'England'

});

db.branch.insert(
{ _id: "2", 
  agent_id: "2", 
  manager: {name: 'Chris', email: 'ch@gmail.com', phone_number: '07838952166' },
  staff:
  [ {id: "1", name: 'Finch', phone_number: "07872262166",  postal_code: 'ne32w3', city: "Newcastle", state: 'England'}],
  branch_contact_details:
  [ {phone_number: "07876725556",  email: 'a2@gmail.com'} ],
  postal_code: 'ne32t3',
  city: 'Bradford',
  state: 'England'

});

db.createCollection("view_property_request");
db.view_property_request.insert(
{ _id: "1", 
  customer_id: "c3",
  branch_id: "1",
  property_id: "5" ,
  customer_type: "buyer",
  status: "approved",
  comments:
  [ {id: "1", text: 'good one'} ],

});

db.view_property_request.insert(
{ _id: "2", 
  customer_id: "c4",
  branch_id: "1",
  property_id: "5" ,
  customer_type: "buyer",
  status: "viewed",
  comments:
  [ {id: "1", text: 'best architechture'} ],

});

db.createCollection("property");
db.property.insert(
{ _id: "1", 
  l_id: "c1", 
  branch_id: "1",
  postal_code: "ne32t3",
  city: "Newcastle",
  state: "England",
  area: "Jesmond",
  no_of_rooms: 4,
  rental_demand: null ,
  asking_price: 170000,
  type: "semi-detached",
  status: "sold",
  added_at: ISODate("2019-02-23"),

  sold_property: {b_id: 'c3', selling_price: 170000, stump_duty: 20, commission_paid: 2000, sold_date:  ISODate("2019-02-26")},

});

db.property.insert(
{ _id: "2", 
  l_id: "c2", 
  branch_id: "1",
  postal_code: "ne32t3",
  city: "Durhum",
  state: "England",
  area: "Jesmond",
  no_of_rooms: 4,
  rental_demand: null ,
  asking_price: 200000,
  type: "semi-detached",
  status: "sold",
  added_at: ISODate("2020-02-23"),

  sold_property: {b_id: 'c4', selling_price: 200000, stump_duty: 20, commission_paid: 3000, sold_date:  ISODate("2020-02-28")},

});

db.property.insert(
{ _id: "3", 
  l_id: "c2", 
  branch_id: "1",
  postal_code: "ne32t3",
  city: "Sunderland",
  state: "England",
  area: "Jesmond",
  no_of_rooms: 3,
  rental_demand: null ,
  asking_price: 180000,
  type: "semi-detached",
  status: "sold",
  added_at: ISODate("2019-10-23"),

  sold_property: {b_id: 'c4', selling_price: 180000, stump_duty: 20, commission_paid: 3000, sold_date:  ISODate("2019-10-28")},

});

db.property.insert(
{ _id: "4", 
  l_id: "c2", 
  branch_id: "3",
  postal_code: "ne32t3",
  city: "London",
  state: "England",
  area: "Central",
  no_of_rooms: 3,
  rental_demand: 600 ,
  asking_price: null,
  type: "detached",
  status: "rented",
  added_at: ISODate("2019-10-26"),

  rented_property: {t_id: 'c5', rent_per_month: 600, advance_paid: 2000, date_tenancy_commenced: ISODate("2019-10-28"), date_tenancy_finished:  ISODate("2023-02-26"), commission_paid: 200},

});

db.property.insert(
{ _id: "5", 
  l_id: "c1", 
  branch_id: "1",
  postal_code: "ne32t3",
  city: "Newcastle",
  state: "England",
  area: "Monument",
  no_of_rooms: 2,
  rental_demand: null ,
  asking_price: 110000,
  type: "detached",
  status: "for_sale",
  added_at: ISODate("2021-11-22"),
});

db.property.find(
     { 
     status: 'sold', area: 'Jesmond', city: 'Newcastle',
     'sold_property.sold_date': { $gt: new Date('2019-01-01'), $lt: new Date('2020-01-01') }
     } );

db.view_property_request.find(
     { 
     status: 'viewed'
     } );

db.branch.find(
     { 
     city: 'Newcastle'
     },
     {staff: 1, city: 1}
      );

db.branch.find();
{ "_id" : "1", "agent_id" : "1", "manager" : { "name" : "Smith", "email" : "sm@gmail.com", "phone_number" : "07878952166" }, "staff" : [ { "id" : "1", "name" : "Harry", "phone_number" : "07878952166", "postal_code" : "ne32w3", "city" : "London", "state" : "England" }, { "id" : "2", "name" : "Toe", "phone_number" : "07872952166", "postal_code" : "ne32w3", "city" : "Newcastle", "state" : "England" }, { "id" : "3", "name" : "Kim", "phone_number" : "07872252166", "postal_code" : "ne32w3", "city" : "Newcastle", "state" : "England" } ], "branch_contact_details" : [ { "phone_number" : "07876725556", "email" : "a1@gmail.com" } ], "postal_code" : "ne32t3", "city" : "Newcastle", "state" : "England" }
{ "_id" : "2", "agent_id" : "2", "manager" : { "name" : "Chris", "email" : "ch@gmail.com", "phone_number" : "07838952166" }, "staff" : [ { "id" : "1", "name" : "Finch", "phone_number" : "07872262166", "postal_code" : "ne32w3", "city" : "Newcastle", "state" : "England" } ], "branch_contact_details" : [ { "phone_number" : "07876725556", "email" : "a2@gmail.com" } ], "postal_code" : "ne32t3", "city" : "Bradford", "state" : "England" }


db.view_property_request.find();
{ "_id" : "1", "customer_id" : "c3", "branch_id" : "1", "property_id" : "5", "customer_type" : "buyer", "status" : "approved", "comments" : [ { "id" : "1", "text" : "good one" } ] }
{ "_id" : "2", "customer_id" : "c4", "branch_id" : "1", "property_id" : "5", "customer_type" : "buyer", "status" : "viewed", "comments" : [ { "id" : "1", "text" : "best architechture" } ] }

db.view_property_request.find();
{ "_id" : "1", "customer_id" : "c3", "branch_id" : "1", "property_id" : "5", "customer_type" : "buyer", "status" : "approved", "comments" : [ { "id" : "1", "text" : "good one" } ] }
{ "_id" : "2", "customer_id" : "c4", "branch_id" : "1", "property_id" : "5", "customer_type" : "buyer", "status" : "viewed", "comments" : [ { "id" : "1", "text" : "best architechture" } ] }

db.property.find();
{ "_id" : "1", "l_id" : "c1", "branch_id" : "1", "postal_code" : "ne32t3", "city" : "Newcastle", "state" : "England", "area" : "Jesmond", "no_of_rooms" : 4, "rental_demand" : null, "asking_price" : 170000, "type" : "semi-detached", "status" : "sold", "added_at" : ISODate("2019-02-23T00:00:00Z"), "sold_property" : { "b_id" : "c3", "selling_price" : 170000, "stump_duty" : 20, "commission_paid" : 2000, "sold_date" : ISODate("2019-02-26T00:00:00Z") } }
{ "_id" : "2", "l_id" : "c2", "branch_id" : "1", "postal_code" : "ne32t3", "city" : "Durhum", "state" : "England", "area" : "Jesmond", "no_of_rooms" : 4, "rental_demand" : null, "asking_price" : 200000, "type" : "semi-detached", "status" : "sold", "added_at" : ISODate("2020-02-23T00:00:00Z"), "sold_property" : { "b_id" : "c4", "selling_price" : 200000, "stump_duty" : 20, "commission_paid" : 3000, "sold_date" : ISODate("2020-02-28T00:00:00Z") } }
{ "_id" : "3", "l_id" : "c2", "branch_id" : "1", "postal_code" : "ne32t3", "city" : "Sunderland", "state" : "England", "area" : "Jesmond", "no_of_rooms" : 3, "rental_demand" : null, "asking_price" : 180000, "type" : "semi-detached", "status" : "sold", "added_at" : ISODate("2019-10-23T00:00:00Z"), "sold_property" : { "b_id" : "c4", "selling_price" : 180000, "stump_duty" : 20, "commission_paid" : 3000, "sold_date" : ISODate("2019-10-28T00:00:00Z") } }
{ "_id" : "4", "l_id" : "c2", "branch_id" : "3", "postal_code" : "ne32t3", "city" : "London", "state" : "England", "area" : "Central", "no_of_rooms" : 3, "rental_demand" : 600, "asking_price" : null, "type" : "detached", "status" : "rented", "added_at" : ISODate("2019-10-26T00:00:00Z"), "rented_property" : { "t_id" : "c5", "rent_per_month" : 600, "advance_paid" : 2000, "date_tenancy_commenced" : ISODate("2019-10-28T00:00:00Z"), "date_tenancy_finished" : ISODate("2023-02-26T00:00:00Z"), "commission_paid" : 200 } }
{ "_id" : "5", "l_id" : "c1", "branch_id" : "1", "postal_code" : "ne32t3", "city" : "Newcastle", "state" : "England", "area" : "Monument", "no_of_rooms" : 2, "rental_demand" : null, "asking_price" : 110000, "type" : "detached", "status" : "for_sale", "added_at" : ISODate("2021-11-22T00:00:00Z") }









// Create a collection for EstateAgent table

db.createCollection("EstateAgent")
// insertion of data in EstateAgent
db.EstateAgent.insertMany( [ { est_id: "E1", name: "Mason Estate", email: "mason@gmail.com", phone_number: 07878951552, headquater: "Masons Headquater", address_line: "Gateshead", city: "Newcastle", state: "England"}, 
	{ est_id: "E2", name: "Ben Estate", email: "ben@gmail.com", phone_number: 07878951252, headquater: "Ben Headquater", address_line: "Jesmond", city: "Newcastle", state: "England" },
	{est_id: "E3", name: "MA Estate", email: "ma@gmail.com", phone_number: 07878951232, headquater: "MA Headquater", address_line: "Gateshead", city: "Durham", state: "England"}]);


// to create a collection for Branch table

db.createCollection("Branch")
db.Branch.insertMany( [ { code: "B1", agent_id: "E1", manager: "Mason", phone_number: 07878951552, headquater: "Masons Headquater", address_line: "Gateshead", city: "Newcastle", state: "England"}, 
	{ code: "B2", agent_id: "E2", manager: "Ben", phone_number: 07878916752, headquater: "Ben Headquater", address_line: "Gateshead", city: "Newcastle", state: "England"},
	{ code: "B3", agent_id: "E3", manager: "Karen", phone_number: 07878934552, headquater: "Karen Headquater", address_line: "Durham City", city: "Durham", state: "England"}]);



// to create a collection for Staff table

db.createCollection("Staff")

db.Staff.insertMany( [ { staff_id: "1", name: "Emel", branch_id: "B1", phone_number: 07878951552, address_line: "Gateshead", city: "Newcastle", state: "England"}, 
	{ staff_id: "2", name: "Joe", branch_id: "B2", phone_number: 07878951552, address_line: "Gateshead", city: "Newcastle", state: "England"},
	{ staff_id: "3", name: "Imran", branch_id: "B3", phone_number: 07878951552, address_line: "Durham City", city: "Durham", state: "England"}]);
    
    
    
db.createView (
   "Staff_Br",
   "Staff",
   [
     { $lookup: { from: "Branch",
       localField: "branch_id",
       foreignField: "code",
       as: "brs"}}
   ]
);
db.Staff_Br.find({}, {name: 1, city: 1, state: 1, "brs.headquater": 1});


// We can create a collection of EstateAgent, Branch and Staff altogether

db.createCollection("EstateAgents");
db.EstateAgents.insert(
{ est_id: "E2", name: "Ben Estate", email: "ben@gmail.com", phone_number: 07878951252, headquater: "Ben Headquater", address_line: "Jesmond", city: "Newcastle", state: "England",
  branch: // embedded branches
  [ { code: "B1", agent_id: "E1", manager: "Mason", phone_number: 07878951552, headquater: "Masons Headquater", address_line: "Gateshead", city: "Newcastle", state: "England", staff: [ { staff_id: "1", name: "Emel", branch_id: "B1", phone_number: 07878951552, address_line: "Gateshead", city: "Newcastle", state: "England"}, 
	{ staff_id: "2", name: "Joe", branch_id: "B1", phone_number: 07878951552, address_line: "Gateshead", city: "Newcastle", state: "England"}]}, 
	{ code: "B2", agent_id: "E2", manager: "Ben", phone_number: 07878916752, headquater: "Ben Headquater", address_line: "Gateshead", city: "Newcastle", state: "England", staff: [ { staff_id: "3", name: "Eman", branch_id: "B2", phone_number: 07878951552, address_line: "Gateshead", city: "Newcastle", state: "England"}, 
	{ staff_id: "4", name: "Abdul", branch_id: "B2", phone_number: 07878951552, address_line: "Gateshead", city: "Newcastle", state: "England"}]}]
});


// project department name and staff details where the Employee with Emp_Id = "E1" works

db.EstateAgents.find(
    {"branch": { $elemMatch: {"code": "B1"}}},
    {name: 1,
     phone_number: 1,
     email: 1,
     headquater: 1,
     "branch.code": 1,
     }
);



// Collection for ViewProperty
db.createCollection("ViewProperty");
db.ViewProperty.insert(
{ _id: "V1", 
  customer_id: "C1",
  property_id: "P2" ,
  date: ISODate("2020-04-20"),
  customer_type: "buyer",
  status: "viewed",
  comments:
  [ {id: "1", text: 'Nice house with balcony'},
{id: "2", text: 'Needs to be refurnished'} ]

});

db.ViewProperty.insert(
{ _id: "V2", 
  customer_id: "C2",
  property_id: "P2" ,
  date: ISODate("2021-12-10"),
  customer_type: "tenant",
  status: "not-viewed",
  comments:
  [ {id: "1", text: 'Still waiting for the date'}]

});

db.ViewProperty.insert(
{ _id: "V3", 
  customer_id: "C3",
  property_id: "P2" ,
  date: ISODate("2019-06-20"),
  customer_type: "buyer",
  status: "viewed",
  comments:
  [ {id: "1", text: 'Nice house with balcony'} ]

});

db.ViewProperty.find( {"customer_type" : "buyer", "status" : "viewed"});



// Creating collection for Property and inserting data

db.createCollection("Property");
db.Property.insert(
{ property_id: "P1", 
  owner_id: "C1", 
  branch_id: "B1",
  city: "Newcastle",
  state: "England",
  postal_code: "NE3 2TN", 
  location: "Jesmond",
  number_of_rooms: 4,
  rental_demand: null ,
  asking_price: 110000,
  type: "semi-detached",
  status: "sold",
  adding_date: ISODate("2020-02-25"),

  SoldProperty: {sold_id: "S1", buyer_id: "C2", selling_price: 120000, stump_duty: 20, cm_paid: 2000, selling_date:  ISODate("2021-04-12")}
});

db.property.insert(
{ property_id: "P2", 
  owner_id: "C3", 
  branch_id: "B2",
  city: "Durham",
  state: "England",
  postal_code: "DH3 2XY", 
  location: "Durham City",
  number_of_rooms: 3,
  rental_demand: null ,
  asking_price: 220000,
  type: "Detached",
  status: "sold",
  adding_date: ISODate("2018-09-01"),

  SoldProperty: {sold_id: "S2", buyer_id: "C4", selling_price: 120000, stump_duty: 20, cm_paid: 2000, selling_date:  ISODate("2021-04-12")}
});

db.property.insert(
{ property_id: "P3", 
  owner_id: "C5", 
  branch_id: "B2",
  city: "Newcastle",
  state: "England",
  postal_code: "NH3 2XY", 
  location: "Gateshead",
  number_of_rooms: 3,
  rental_demand: 500 ,
  asking_price: null,
  type: "Detached",
  status: "FOR-RENT",
  adding_date: ISODate("2019-10-01"),

  Accomodation: [{
   _id : "1", length: 20, width: 20, area: 400, description: "Good"
  }, {
   _id : "2", length: 20, width: 30, area: 460, description: "Need Improvement"
  }],
  RentProperty: {rent_id: 'R1', property_id: 'P1', rent: 300, adv_paid: 120, commission: 30, date_tenancy_commenced:  ISODate("2019-10-28"), date_tenancy_finished: ISODate("2021-10-28")}

});

db.property.insert(
{ property_id: "4", 
  l_id: "c2", 
  branch_id: "3",
  postal_code: "NE3 2TN",
  city: "Newcastle",
  state: "England",
  area: "Central",
  no_of_rooms: 3,
  rental_demand: 600 ,
  asking_price: null,
  type: "Detached",
  status: "FOR-RENT",
  added_at: ISODate("2019-10-26"),

 Accomodation: [{
   _id : "1", length: 20, width: 20, area: 400, description: "Good"
  }, {
   _id : "2", length: 20, width: 30, area: 460, description: "Need Improvement"
  }],
  RentProperty: {rent_id: 'R2', property_id: 'P2', rent: 400, adv_paid: 220, commission: 30, date_tenancy_commenced:  ISODate("2019-10-28"), date_tenancy_finished: ISODate("2021-10-28")}

});

db.property.insert(
{ property_id: "P5", 
  owner_id: "C8", 
  branch_id: "B5",
  city: "Newcastle",
  state: "England",
  postal_code: "NH3 2XY", 
  location: "Gateshead",
  number_of_rooms: 3,
  rental_demand: 500 ,
  asking_price: null,
  type: "Detached",
  status: "FOR-SALE",
  adding_date: ISODate("2019-10-01"),

 Accomodation: [{
   _id : "1", length: 20, width: 20, area: 400, description: "Good"
  }, {
   _id : "2", length: 20, width: 30, area: 460, description: "Need Improvement"
  }]
});


db.property.find({ 
     status: 'FOR-RENT', city: 'Newcastle', type = 'Detached'
     } );


