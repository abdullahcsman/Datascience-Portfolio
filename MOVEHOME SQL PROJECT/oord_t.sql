Drop Type Branch_t force;
Drop Type Staff_nt_type force;
Drop Type Manager_t force;

Drop table Branch_Tab;
Drop table Staff_tab;
Drop table Manager_Tab;


CREATE Type Branch_t
/



CREATE Type Staff_t AS Object
(staff_id CHAR(2),
name VARCHAR(10),
email VARCHAR(20),
phone_number NUMBER(11),
address VARCHAR(20),
Works_for REF Branch_t)
/



CREATE TYPE Staff_nt_type as Table of REF Staff_t
/



CREATE Type Manager_t as Object
(id CHAR(2),
 name VARCHAR(20),
 email VARCHAR(20),
 phone_number NUMBER(11)
)
/



CREATE OR REPLACE Type Branch_t as Object
(code CHAR(2),
manager_ref REF Manager_t,
email VARCHAR(20),
phone_number NUMBER(11),
headquater VARCHAR(20),
Staff Staff_nt_type)
/



Create Table Branch_Tab of Branch_t
(primary key (code))
 Nested Table Staff Store As Branch_Staff_NTab;

Create Table Manager_Tab of Manager_t
(primary key (id))
/

Create Table Staff_Tab of Staff_t
(primary key (staff_id))
/



Alter table Staff_tab Add constraint Branch_REF_FK Foreign Key (works_for) References Branch_Tab
/


// Inserting values
Insert into Manager_Tab values ('1', 'Karen', 'karen@gmail.com', 07878951344);
Insert into Manager_Tab values ('2', 'Paul', 'paul@gmail.com', 07678951344);
Insert into Manager_Tab values ('3', 'Lawson', 'lawson@gmail.com', 07678871344);
Insert into Manager_Tab values ('4', 'Jack', 'jack@gmail.com', 07678809344);

Insert into Staff_Tab values ('1', 'Abdullah', 'ab@gmail.com', 07878965432, 'Kingston', NULL);
Insert into Staff_Tab values ('2', 'Roy', 'roy@gmail.com', 07878923432, 'Fenham', NULL);
Insert into Staff_Tab values ('3', 'Mike Tyson', 'mike@gmail.com', 07878345432, 'Gateshead', NULL);
Insert into Staff_Tab values ('4', 'Talib', 'talib@gmail.com', 07878234122, 'Durham City', NULL);
Insert into Staff_Tab values ('5', 'Ben', 'ben@gmail.com', 07878123432, 'Fountain', NULL);

Insert into Branch_Tab values ('1', (select REF(m) from Manager_Tab m where m.id = '1'), 'abestates@gmail.com', 07878965432, 'Kingston Park', Staff_nt_type());
Insert into Branch_Tab values ('2', (select REF(m) from Manager_Tab m where m.id = '2'), 'durham@gmail.com', 07878965412, 'Fenham street', Staff_nt_type());
Insert into Branch_Tab values ('3', (select REF(m) from Manager_Tab m where m.id = '3'), 'johnest@gmail.com', 07878945432, 'Gateshead', Staff_nt_type());
Insert into Branch_Tab values ('4', (select REF(m) from Manager_Tab m where m.id = '14'), 'mkestates@gmail.com', 07878967732, 'South hilton', Staff_nt_type());

// Updating Staff
Update Staff_Tab 
Set 
Works_for = (select ref(b) from Branch_Tab b where b.code = '1') where staff_id = '1';
Update Staff_Tab 
Set 
Works_for = (select ref(b) from Branch_Tab b where b.code = '1') where staff_id = '2';
Update Staff_Tab 
Set 
Works_for = (select ref(b) from Branch_Tab b where b.code = '2') where staff_id = '3';
Update Staff_Tab 
Set 
Works_for = (select ref(b) from Branch_Tab b where b.code = '3') where staff_id = '4';
Update Staff_Tab 
Set 
Works_for = (select ref(b) from Branch_Tab b where b.code = '4') where staff_id = '5';

INSERT INTO TABLE (Select b.Staff from Branch_Tab b where b.code = '1')
SELECT REF(e) from Staff_Tab e where e.works_for.code = '1';

INSERT INTO TABLE (Select b.Staff from Branch_Tab b where b.code = '2')
SELECT REF(e) from Staff_Tab e where e.works_for.code = '2';

INSERT INTO TABLE (Select b.Staff from Branch_Tab b where b.code = '3')
SELECT REF(e) from Staff_Tab e where e.works_for.code = '3';

INSERT INTO TABLE (Select b.Staff from Branch_Tab b where b.code = '4')
SELECT REF(e) from Staff_Tab e where e.works_for.code = '4';



