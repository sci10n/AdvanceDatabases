drop table recommends;
drop table subtopic;
drop table expert_within;
drop table topic;
drop table expert;

create table expert
(
id integer primary key,
name varchar(50),
email varchar(50),
description varchar(50)
);

create table topic
(
 id integer primary key,
 name varchar(50),
 originator integer not null, 
 description varchar(50),
 foreign key (originator) references expert(id)
);

create table subtopic
(
	supertopic integer,
	subtopic integer,
	primary key (supertopic, subtopic),
	foreign key (supertopic) references topic(id),
	foreign key (subtopic) references topic(id)
);

create table expert_within
(
	expert integer,
	topic integer,
	primary key (expert, topic),
	foreign key (expert) references expert(id),
	foreign key (topic) references topic(id)
);

create table recommends
(
	id integer identity(1,1) primary key,
	from_expert integer not null,
	to_expert integer not null,
	justification varchar(50),
	foreign key (from_expert) references expert(id),
	foreign key (to_expert) references expert(id)
);

insert into expert (id, name, email, description) values (1, 'Mr. Smith', 'Smith@sunet.se', 'A geologist');
insert into expert (id, name, email, description) values (2, 'Clark Kent', 'C.Kent@DailyMail.co.uk', 'Works with rays');
insert into expert (id, name, email, description) values (3, 'Maxwell', 'Maxx@gmail.com', 'Magnets and stuff');
insert into expert (id, name, email, description) values (4, 'Expert Expertson', 'exp@gmail.com', 'He is an expert');

insert into topic (id, name, originator, description) values (1, 'Geology', 1, 'Study of rocks'); 
insert into topic (id, name, originator, description) values (2, 'Advanced Geology', 1 , 'Study of advanced rocks');
insert into topic (id, name, originator, description) values (3, 'Pysics', 2, 'Forces and matter');
insert into topic (id, name, originator, description) values (4, 'Electricity', 3, 'Bzzz');

insert into subtopic (supertopic, subtopic) values (1,2);
insert into subtopic (supertopic, subtopic) values (3,4);

insert into expert_within (expert, topic) values (1,1);
insert into expert_within (expert, topic) values (2,1);
insert into expert_within (expert, topic) values (3,1);
insert into expert_within (expert, topic) values (4,1);

insert into recommends (from_expert, to_expert, justification) values (1,2, 'Study advanced geology');
insert into recommends (from_expert, to_expert, justification) values (2,3, 'Drop study geology');
insert into recommends (from_expert, to_expert, justification) values (3,4, 'Start with Bzzz');
insert into recommends (from_expert, to_expert, justification) values (2,4, 'Bla bla');

/*select * from expert;
select name from topic where originator = 1;
select expert from expert_within where topic = 1;*/

/* a) Which are the experts of area X?*/
select expert.name from expert,expert_within where expert_within.topic = 1 and expert_within.expert = expert.id;

/* b) Which are the direct subareas of Y?*/
select topic.name from topic,subtopic where subtopic.supertopic = 1 and topic.id = subtopic.subtopic;

/* c) Show the experts with knowledge in area Y, recommended by expert X;*/
select recommends.to_expert from recommends where recommends.from_expert = 1 and recommends.to_expert in (select expert from expert_within where topic = 1);

/* d) Show the experts with knowledge in area Y, recommended by the experts who are
recommended by expert X;*/
select id=recommends.to_expert from recommends where recommends.from_expert in (select recommends.to_expert from recommends where recommends.from_expert = id) and recommends.to_expert in (select expert from expert_within where topic = 1);

/* e) Same as previous but follow the known links in as many steps as needed*/
SELECT name FROM expert WHERE id IN (
	SELECT expert FROM expert_within WHERE topic=1 AND expert IN (
		SELECT to_expert FROM recommends WHERE to_expert NOT IN (
			SELECT DISTINCT from_expert FROM recommends WHERE from_expert IS NOT NULL)));