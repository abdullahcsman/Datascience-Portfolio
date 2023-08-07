Set Echo on
Set Verify on

DROP TABLE Customer CASCADE CONSTRAINTS PURGE;
DROP TABLE Owner CASCADE CONSTRAINTS PURGE;
DROP TABLE Buyer CASCADE CONSTRAINTS PURGE;
DROP TABLE Tenant CASCADE CONSTRAINTS PURGE;
DROP TABLE Property CASCADE CONSTRAINTS PURGE;
DROP TABLE Accommodation CASCADE CONSTRAINTS PURGE;
DROP TABLE SoldProperty CASCADE CONSTRAINTS PURGE;
DROP TABLE RentProperty CASCADE CONSTRAINTS PURGE;
DROP TABLE EstateAgent CASCADE CONSTRAINTS PURGE;
DROP TABLE MANAGER CASCADE CONSTRAINTS PURGE;
DROP TABLE Branch CASCADE CONSTRAINTS PURGE;
DROP TABLE Staff CASCADE CONSTRAINTS PURGE;
DROP TABLE ViewProperty CASCADE CONSTRAINTS PURGE;



CREATE TABLE Customer(
cust_id CHAR(2) NOT NULL,
name VARCHAR(30),
email VARCHAR(30),
phone_number NUMBER(11),
gender VARCHAR(8) CONSTRAINT check_gender CHECK(gender IN ('Male', 'Female')),
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
CONSTRAINT branch_fk_agent_id REFERENCES EstateAgent(est_id),
manager CHAR(2) NOT NULL
CONSTRAINT manager_fk_manager REFERENCES   MANAGER(manager_id),
email VARCHAR(20),
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
CHECK (number_of_rooms >= 1 AND number_of_rooms <=10),
rental_demand NUMBER(10)
CONSTRAINT min_rental_demand
CHECK (rental_demand > 0),
asking_price NUMBER(10)
CONSTRAINT min_asking_price
CHECK (asking_price > 0),
type VARCHAR(30)
CONSTRAINT property_type CHECK (type IN
('FLATS', 'DETACHED', 'SEMI-DETACHED', 'TERRACED', 'COTTAGE', 'BUNGALOWS')),
status VARCHAR(15) CONSTRAINT property_status CHECK (status IN ('FOR-SALE', 'FOR-RENT', 'SOLD', 'RENTED')),  
adding_date DATE DEFAULT sysdate,
CONSTRAINT pk_property Primary Key(property_id));

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
CONSTRAINT sold_property_fk_property_id REFERENCES property(property_id),
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
CONSTRAINT rented_property_fk_property_id REFERENCES property(property_id),
tenant_id CHAR(2) NOT NULL
CONSTRAINT sold_property_fk_tenant_id REFERENCES Tenant(tenant_id),
rent NUMBER(10) CONSTRAINT check_rent CHECK(rent > 0 AND rent < 1000),
adv_paid NUMBER(10),
date_tenancy_commenced DATE,
date_tenancy_finished DATE,
commission NUMBER(4),
CONSTRAINT date_tenancy_finished_const
CHECK(date_tenancy_finished >= date_tenancy_commenced),
CONSTRAINT pkey_rented_property Primary Key(rent_id));


CREATE TABLE ViewProperty(
view_id CHAR(2) NOT NULL,
customer_id CHAR(2) NOT NULL
CONSTRAINT view_fk_customer_id REFERENCES Customer(cust_id),
property_id CHAR(2) NOT NULL
CONSTRAINT view_fk_property_id REFERENCES Property(property_id),
date_time DATE,
customer_type CHAR(15)
CONSTRAINT customer_type CHECK (customer_type IN
('buyer', 'tenant')),
status CHAR(15)
CONSTRAINT status_view_property_request CHECK (status IN ('not-viewed', 'viewed')),
comments VARCHAR(30),
CONSTRAINT pk_view Primary Key(view_id));
