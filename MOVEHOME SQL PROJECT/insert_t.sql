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
