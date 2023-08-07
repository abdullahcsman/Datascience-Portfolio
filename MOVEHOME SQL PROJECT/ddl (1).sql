Set Echo on
Set Verify on

DROP TABLE Customer CASCADE CONSTRAINTS PURGE;
DROP TABLE Owner CASCADE CONSTRAINTS PURGE;
DROP TABLE Buyer CASCADE CONSTRAINTS PURGE;
DROP TABLE Tenant CASCADE CONSTRAINTS PURGE;
DROP TABLE Property CASCADE CONSTRAINTS PURGE;
DROP TABLE PropertyAccommodation CASCADE CONSTRAINTS PURGE;
DROP TABLE sold_property CASCADE CONSTRAINTS PURGE;
DROP TABLE RentProperty CASCADE CONSTRAINTS PURGE;
DROP TABLE EstateAgent CASCADE CONSTRAINTS PURGE;
DROP TABLE Branch CASCADE CONSTRAINTS PURGE;
DROP TABLE Staff CASCADE CONSTRAINTS PURGE;
DROP TABLE ViewProperty CASCADE CONSTRAINTS PURGE;



CREATE TABLE Customer(
        cust_id CHAR(2) NOT NULL,
        name VARCHAR(30),
        email VARCHAR(30),
        phone_number NUMBER(11),
        gender VARCHAR(2) CONSTRAINT check_gender CHECK(gender IN ('Male', 'Female'))
        date_of_birth DATE,
        address_line VARCHAR(30),
        post_code VARCHAR(10) NOT NULL,
        city VARCHAR(20) NOT NULL,
        state VARCHAR(20),
        CONSTRAINT pk_customer Primary Key(cust_id));

CREATE TABLE Owner(
        owner_id CHAR(2) NOT NULL
        CONSTRAINT unique_owner_id UNIQUE
        CONSTRAINT fk_owner REFERENCES Customer(cust_id));

CREATE TABLE Buyer(
        buyer_id CHAR(2) NOT NULL
        CONSTRAINT unique_buyer_id UNIQUE
        CONSTRAINT fk_buyer REFERENCES Customer(cust_id));

CREATE TABLE Tenant(
        tenant_id CHAR(2) NOT NULL
        CONSTRAINT unique_tenant_id UNIQUE
        CONSTRAINT fk_tenant REFERENCES Customer(cust_id));

CREATE TABLE EstateAgent(
        est_id CHAR(2) NOT NULL,
        name VARCHAR(30),
        email VARCHAR(30),
        phone_number NUMBER(11),
        headquarter VARCHAR(20),
        address_line VARCHAR(30),
        post_code VARCHAR(10) NOT NULL,
        city VARCHAR(20) NOT NULL,
        state VARCHAR(20),
        CONSTRAINT pk_estagent Primary Key(est_id));

CREATE TABLE Manager(
        manager_id CHAR(2) NOT NULL,
        name VARCHAR(50),
        phone_number NUMBER(11),
        email VARCHAR(20) NOT NULL,
        CONSTRAINT pk_manager Primary Key(manager_id));

CREATE TABLE Branch(
        code CHAR(2) NOT NULL,
        agent_id CHAR(2) NOT NULL
        CONSTRAINT uniq_agent_id_branch UNIQUE
        CONSTRAINT branch_fk_agent_id REFERENCES EstateAgent(est_id),
        manager CHAR(2) NOT NULL
        CONSTRAINT manager_fk_manager REFERENCES MANAGER(manager_id),
        phone_number NUMBER(11),
        address_line VARCHAR(30),
        post_code VARCHAR(10) NOT NULL,
        city VARCHAR(20) NOT NULL,
        state VARCHAR(20),
        CONSTRAINT pk_branch Primary Key(code));

CREATE TABLE Staff(
        staff_id CHAR(2) NOT NULL,
        branch_id CHAR(2) NOT NULL
        CONSTRAINT staff_fk_branch_id REFERENCES Branch(code),
        name VARCHAR(30),
        phone_number NUMBER(13),
        address VARCHAR(20) NOT NULL,
        email VARCHAR(20),
        CONSTRAINT pk_staff Primary Key(staff_id));


CREATE TABLE Property(
        property_id CHAR(2) NOT NULL,
        owner_id CHAR(2) NOT NULL
        CONSTRAINT property_fk_owner_id REFERENCES Owner(owner_id),
        branch_id CHAR(2) NOT NULL
        CONSTRAINT property_fk_branch_id REFERENCES Branch(code),
        post_code VARCHAR(10) NOT NULL,
        city VARCHAR(20) NOT NULL,
        state VARCHAR(20),
        location VARCHAR(20),
        number_of_rooms NUMBER(2)
        CONSTRAINT min_max_no 
        CHECK (no_of_rooms >= 1 AND no_of_rooms <=10),
        rental_demand NUMBER(10)
        CONSTRAINT min_rental_demand 
        CHECK (rental_demand > 0),
        asking_price NUMBER(10)
        CONSTRAINT min_asking_price 
        CHECK (asking_price > 0),
        type VARCHAR(30)
             CONSTRAINT property_type CHECK (type IN
            ('FLATS', 'DETACHED', 'SEMI-DETACHED', 'TERRACED', 'COTTAGE', 'BUNGALOWS')),
        status CHAR(15) CONSTRAINT property_status CHECK (status                               IN('FOR-SALE', 'FOR-RENT', 'SOLD', 'RENTED')),
        added_at DATETIME2(3) 
        CONSTRAINT property_added_time DEFAULT (SYSDATETIME()),
        CONSTRAINT pk_property Primary Key(id));

CREATE TABLE Accommodation(
        acc_id CHAR(2) NOT NULL,
        property_id CHAR(2) NOT NULL
        CONSTRAINT property_acc_fk_property_id REFERENCES Property(property_id),
        length NUMBER(3) CONSTRAINT check_length CHECK(length > 0),
        width NUMBER(3) CONSTRAINT check_width CHECK(width > 0),
        area NUMBER(10) CONSTRAINT check_area CHECK(area > 0), 
        description VARCHAR(20),
        CONSTRAINT pkey_property_accommodation Primary Key(acc_id));

CREATE TABLE SoldProperty(
        sold_id CHAR(2) NOT NULL,
        property_id CHAR(2) NOT NULL
        CONSTRAINT sold_property_fk_property_id REFERENCES property(id),
        buyer_id CHAR(2) NOT NULL
        CONSTRAINT sold_property_fk_buyer_id REFERENCES buyer(buyer_id),
        selling_price NUMBER(10) CONSTRAINT check_selling_price CHECK(selling_price > 0),
        stump_duty NUMBER(10),
        cm_paid NUMBER(4),
        selling_date DATE,
        CONSTRAINT pk_sold_property Primary Key(sold_id));

CREATE TABLE RentProperty(
        rent_id CHAR(2) NOT NULL,
        property_id CHAR(2) NOT NULL
        CONSTRAINT rented_property_fk_property_id REFERENCES property(id),
        tenant_id CHAR(2) NOT NULL
        CONSTRAINT sold_property_fk_tenant_id REFERENCES Tenant(tenant_id),
        rent NUMBER(10) CONSTRAINT check_rent CHECK(rent > 0 AND rent < 1000),
        adv_paid NUMBER(10),
        date_tenancy_commenced DATE,
        date_tenancy_finished DATE,
        commission NUMBER(4),
        CONSTRAINT date_tenancy_finished_not_before_start
				CHECK(date_tenancy_finished >= date_tenancy_commenced),
        CONSTRAINT pkey_rented_property Primary Key(id));


CREATE TABLE ViewProperty(
        view_id CHAR(2) NOT NULL,
        customer_id CHAR(2) NOT NULL
        CONSTRAINT view_property_request_fk_customer_id REFERENCES Customer(cust_id),
        property_id CHAR(2) NOT NULL
        CONSTRAINT view_property_request_fk_property_id REFERENCES Property(property_id),
        date DATE,
        time TIME,
        customer_type CHAR(15)
             CONSTRAINT customer_type CHECK (customer_type IN
            ('buyer', 'tenant')),
        status CHAR(15)
             CONSTRAINT status_view_property_request CHECK (status IN ('not-viewed', 'viewed')),
        CONSTRAINT pk_view_property_request Primary Key(view_id));



Insert QUERIES:

Customer:
INSERT INTO Customer
    VALUES ('C1', 'Edward Smith', 'edward@gmail.com', 07878941774, 'Male', '12-FEB-1989', '60 Hersham Close', 'NE3 2TN', 'Newcastle', 'England');
INSERT INTO Customer
    VALUES ('C2', 'Eden Hazard', 'eden@gmail.com', 07878941775, 'Male', '23-AUG-1999', 'Alexandra Park', 'SK3 2EY', 'Sutherland', 'England');
INSERT INTO Customer
    VALUES ('C3', 'Muhammad Abdullah', 'ab@gmail.com', 07878941776, 'Male', '12-SEP-1994', '12 street Gatehead', 'NE4 2YZ', 'Newcastle', 'England');
INSERT INTO Customer
    VALUES ('C4', 'Babar Azam', 'babar@gmail.com', 07878941777, 'Male', '11-OCT-1996', 'Coventry Club street','DH6 2XY', 'Durham', 'England');
INSERT INTO Customer
    VALUES ('C5', 'Joe Root', 'joe@gmail.com', 07878941778, 'Male', '19-MAR-1992', 'City Center','NE4 2TN', 'Newcastle', 'England');
INSERT INTO Customer
    VALUES ('C6', 'Alex Hales', 'alex@gmail.com', 07878941779, 'Male', '09-MAY-1986', 'Scotfield road','SK10 4XN', 'Sutherland', 'England');
INSERT INTO Customer
    VALUES ('C7', 'Steve Smith', 'steve@gmail.com', 07878941784, 'Male', '23-NOV-1999', 'Riverlake Bypass', 'DH6 2AB', 'Durham', 'England');
INSERT INTO Customer
    VALUES ('C8', 'Jason', 'jason@gmail.com', 07878977784, 'Male', '11-DEC-1998', 'Fawdon', 'NH6 2AB', 'Durham', 'England');
INSERT INTO Customer
    VALUES ('C9', 'Karen', 'karen@gmail.com', 07878998784, 'Female', '23-JAN-1999', 'Skull Rpad', 'SK 2AB', 'Sutherland', 'England');
INSERT INTO Customer
    VALUES ('C0', 'Daria', 'steveki@gmail.com', 07878941454, 'Female', '23-NOV-1999', 'Riverlake Bypass', 'DH6 2AC', 'Durham', 'England');


Owner, Buyer and Tenant:
INSERT INTO OWNER
    VALUES ('C1');
INSERT INTO OWNER
    VALUES ('C2');
INSERT INTO OWNER
    VALUES ('C3');

INSERT INTO Buyer
    VALUES ('C4');
INSERT INTO Buyer
    VALUES ('C5');
INSERT INTO Buyer
    VALUES ('C6');

INSERT INTO Tenant
    VALUES ('C7');
INSERT INTO Tenant
    VALUES ('C8');
INSERT INTO Tenant
    VALUES ('C9');
INSERT INTO Tenant
    VALUES ('C0');


Estate Agent:
INSERT INTO EstateAgent
    VALUES ('E1', 'Manson Jack', 'edward@gmail.com', 07878941774, 'Manson Property Consultants', '49 Hersham Close', 'NE3 2TN', 'Newcastle', 'England');

INSERT INTO EstateAgent
    VALUES ('E2', 'Jan Forster', 'jan@gmail.com', 07876641774, 'Jan Forster Estates', '21 Ring Gateshead','NE32 1HE', 'Newcastle', 'England');

INSERT INTO EstateAgent
    VALUES ('E3', 'JW Woods', 'jw@gmail.com', 07879941774, 'JW Estate Durham', 'Jackson Park hill road','DH1 3HL', 'Durham', 'England');

INSERT INTO EstateAgent
    VALUES ('E4', 'Mike Robinson', 'mike@gmail.com', 07879941774', 'Robinsons Estate Agent', 'Hall lane houghton', 'DH5 4HA', 'Durham', 'England');

INSERT INTO EstateAgent
    VALUES ('E5', 'Aseon King', 'asi@gmail.com', 07872241774', 'King's Estate Sutherland', 'blackturn sillway', 'SK23 0HP', 'Sutherland', 'England');

MANAGER:

INSERT INTO Manager
    VALUES ('M1', 'Adam Callum', 07878955156, 'ad@gmail.com');
INSERT INTO Manager
    VALUES ('M2', 'Charles', 07878954136, 'charles@gmail.com');
INSERT INTO Manager
    VALUES ('M3', 'Joe', 07878355116, 'joe@gmail.com');
INSERT INTO Manager
    VALUES ('M4', 'Ben', 07878945116, 'ben@gmail.com');
INSERT INTO Manager
    VALUES ('M5', 'Daria', 07878919156, 'daria@gmail.com');
INSERT INTO Manager
    VALUES ('M6', 'Lion', 07878975116, 'li@gmail.com');
INSERT INTO Manager
    VALUES ('M7', 'Jacob', 07878154156, 'jacob@gmail.com');
INSERT INTO Manager
    VALUES ('M8', 'Iris', 07878911656, 'iris@gmail.com');


Branch:
INSERT INTO Branch
    VALUES ('B1', 'E1', 'M1', 'edwardb1@gmail.com', 07878941714, '60 Hersham Close', 'NE3 2TN', 'Newcastle', 'England);

INSERT INTO Branch
    VALUES ('B2', 'E1', 'M2', 'edwardb1@gmail.com', 07878941725, '62 Gateshead', 'NE32 2EY', 'Newcastle', 'England);

INSERT INTO Branch
    VALUES ('B3', 'E2', 'M3', 'jan@gmail.com', 07878941736, , 'City Center Mall', 'NE4 2YZ', 'Newcastle', 'England');

INSERT INTO Branch
    VALUES ('B4', 'E3', 'M4', 'jw@gmail.com', 07878941747, 'White House Crescent', 'DH6 2XY', 'Durham', 'England');

INSERT INTO Branch
    VALUES ('B5', 'E4', 'M5', 'rebestate@gmail.com', 07878941758, 'South Hetton', 'DH4 2TN', 'Durham', 'England');

INSERT INTO Branch
    VALUES ('B6', 'E4', 'M6', 'robestate@gmail.com', 07878941769, 'The Avenue', 'DH1 4XN', 'Durham', 'England');

INSERT INTO Branch
VALUES ('B7', 'E5', 'M7', 'aseon@gmail.com', 07878941789 , 'Chapel Frith', 'SK23 0GP', 'Sutherland', 'England');

INSERT INTO Branch
    VALUES ('B8', 'E5', 'M8', 'aseon@gmail.com', 07878941799, 'Prestbury', 'SK10 4XN', 'Sutherland', 'England');

STAFF:

INSERT INTO Staff
    VALUES ('S1', 'B1', 'Haris', '07878951226', 'Hilton Park NE32 2WE', 'haris@gmail.com');

INSERT INTO Staff
    VALUES ('S2', 'B2', 'Ben', '07878891226', 'City Center NE4 2XY', 'ben@gmail.com');

INSERT INTO Staff
    VALUES ('S3', 'B3', 'Karen', '07875551226', 'Airport Road DH3 2WE', 'karen@gmail.com');

INSERT INTO Staff
    VALUES ('S4', 'B4', 'Paul', '07878456226', 'Coventry club SK4 3NE', 'paul@gmail.com');

INSERT INTO Staff
    VALUES ('S5', 'B5', 'Logan', '07870981226', 'Riverside NE32 2XY', 'logan@gmail.com');

INSERT INTO Staff
    VALUES ('S6', 'B6', 'Hyman', '07878987226', 'Crosside road DH1 4ER', 'hyman@gmail.com');

INSERT INTO Staff
    VALUES ('S7', 'B7', 'Ali', '07877871226', 'Houghton SK11 2WE', 'ali@gmail.com');

INSERT INTO Staff
    VALUES ('S8', 'B8', 'Kumar', '07878909826', '49 Hersham NE3 2WE', 'kumar@gmail.com');

Property:

INSERT INTO PROPERTY
    VALUES ('P1', 'C1', 'B1', 'NE32 2t3', 'Newcastle', 'England', 'Jesmond', 3, '200', '150000', 'DETACHED', 'FOR-SALE', '21-NOV-2021');
INSERT INTO PROPERTY
    VALUES ('P2', 'C2', 'B2', 'NE3 2TN', 'Newcastle', 'England', 'Jesmond', 3, '590', '250000', 'DETACHED', 'FOR-SALE', '11-NOV-2021');
INSERT INTO PROPERTY
    VALUES ('P3', 'C3', 'B4', 'DH3 2AV', 'Durham', 'England', 'City Center', 2, '400', '150000', 'SEMI-DETACHED', 'SOLD', '19-NOV-2019');
INSERT INTO PROPERTY
    VALUES ('P4', 'C1', 'B6', 'DH6 2AB', 'Durham', 'England', 'City Center', 4, '900', '250000', 'SEMI-DETACHED', 'SOLD', '10-SEP-2020');
INSERT INTO PROPERTY
    VALUES ('P5', 'C2', 'B7', 'SK3 2AB', 'Sutherland', 'England', 'Houghton', 3, '600', '350000', 'SEMI-DETACHED', 'SOLD', '12-NOV-2021');

INSERT INTO PROPERTY
    VALUES ('P6', 'C3', 'B4', 'DH3 2t3', 'Durham', 'England', 'City Center', 2, '900', '250000', 'BUNGALOWS', 'RENTED', '19-AUG-2021');
INSERT INTO PROPERTY
    VALUES ('P7', 'C1', 'B4', 'DH3 2t3', 'Durham', 'England', 'City Center', 2, '400', '150000', 'SEMI-DETACHED', 'Rented', '19-NOV-2021');
INSERT INTO PROPERTY
    VALUES ('P8', 'C2', 'B1', 'NE4 2t3', 'Newcastle', 'England', 'Fawdon', 2, '400', '200000', 'Flats', 'FOR-SALE', '19-NOV-2021');
INSERT INTO PROPERTY
    VALUES ('P9', 'C3', 'B3', 'NE3 2TN', 'Newcastle', 'England', 'Jesmond', 2, '400', '175000', 'DETACHED', 'FOR-SALE', '15-NOV-2021');
INSERT INTO PROPERTY
    VALUES ('P0', 'C1', 'B8', 'SK3 2YZ', 'Sutherland', 'England', 'City Center', 2, '600', '150000', 'SEMI-DETACHED', 'FOR_SALE', '09-MAY-2021');

Property Accomodation:
INSERT INTO Accomodation
    VALUES ('1', 'P1', 20, 10,  200,'Comfortable rooms');
INSERT INTO Accomodation
    VALUES ('2', 'P1', 20, 20,  400,'Backyard');
INSERT INTO Accomodation
    VALUES ('3', 'P2', 20, 10,  200,'Comfortable rooms');
INSERT INTO Accomodation
    VALUES ('4', 'P3', 20, 10,  200,'Comfortable rooms');
INSERT INTO Accomodation
    VALUES ('5', 'P4', 20, 10,  200,'Comfortable rooms');

Sold Property:
INSERT INTO SoldProperty
    VALUES ('S3', 'P3', 'C6', 150000, 40, 1000, '19-NOV-2019');
INSERT INTO SoldProperty
    VALUES ('S4', 'P4', 'C4', 186000, 40, 1000, '10-NOV-2020');
INSERT INTO SoldProperty
    VALUES ('S5', 'P5', 'C5', 125000, 20, 800, '12-NOV-2021');

Rent Property:
INSERT INTO RentProperty
    VALUES ('R1', 'P6', 'C7', 400, 800, '27-JAN-2019', '27-FEB-2023', 20);
INSERT INTO RentProperty
    VALUES ('R2', 'P7', 'C8', 600, 800, '25-FEB-2020', '25-FEB-2023', 20);
INSERT INTO RentProperty
    VALUES ('R5', 'P0', 'C7', 400, 800, '07-MAR-2019', '07-MAR-2023', 20);


ViewProperty:
INSERT INTO ViewProperty
    VALUES ('V1', 'P6', 'C7', '27-JAN-2021', 'time', 'tenant', 'viewed', 'Nice house');
INSERT INTO ViewProperty
    VALUES ('V2', 'P7', 'C8', '27-JAN-2022', 'time', 'tenant', 'not-viewed', '');
INSERT INTO ViewProperty
    VALUES ('V3', 'P1', 'C4', '22-NOV-2021', 'time', 'buyer', 'viewed', 'Nice house');
INSERT INTO ViewProperty
    VALUES ('V4', 'P2', 'C5', '02-JAN-2022', 'time', 'buyer', 'not-viewed', 'Nice house');
INSERT INTO ViewProperty
    VALUES ('V5', 'P3', 'C6', '11-AUG-2021', 'time', 'buyer', 'viewed', 'Nice house');


First Query:

SELECT property_id,owner_id,city,location,number_of_rooms,asking_price,type,added_at,status from Property where type = 'SEMI-DETACHED' and number_of_rooms >= 3 and city = 'Newcastle'
and area = 'Jesmond' and status = 'FOR_SALE' and added_at >= sysdate -14;

p property_id, owner_id, city, location, number_of_rooms, asking_price, type, added_at, status( s type <= 'SEMI-DETACHED' And number_of_rooms >= 3 and city = 'Newcastle' and area = 'Jsesmond' and status = 'FOR_SALE' and added_at = sysdate - 14 (Property) )




Second Query:

SELECT p.property_id,p.owner_id,p.city,p.location,p.number_of_rooms, sp.selling_price, sp.stump_duty, sp.commission_paid, sp.selling_date
from Property p INNER JOIN SoldProperty sp ON Property.property_id=SoldProperty.property_id
where property.city IN ('Newcastle', 'Sutherland', 'Durhum', 'Gateshead')
AND sp.selling_price >= 157000 AND sp.selling_price <= 279000
AND EXTRACT(YEAR FROM TO_DATE(sold_property.selling_date, 'DD-MON-RR')) IN (2019,2020);

R(property_id, owner_id, city, location, number_of_rooms, selling_price, stump_duty, commission_paid, selling_date)   ß property_id, owner_id, city, location, number_of_rooms, selling_price, stump_duty, commission_paid, selling_date ( s city IN ('Newcastle', 'Sutherland', 'Durham', 'Gateshead') AND selling_price >= 157000 AND selling_price <= 279000 AND selling_date IN (2019, 2020)) ( Property  ?  property_id = property_id SoldProperty))





