create database PI;
use PI;

create table Beneficent(
	document varchar(11) not null primary key,
    `name` varchar(80) not null,
    telephone bigint not null,
    bornDate date not null,
    psedonym varchar(50),
    isActive boolean not null,
    address_id_address bigint not null,
    prescription_id_prescription bigint,
    login_id_login bigint not null
)ENGINE = innodb;    

create table GlassesStore(
	id_glassesStore bigint not null auto_increment primary key,
	document varchar(15) not null,
	`name` varchar(100) not null,
	telephone bigint not null,
    isActive boolean,
	address_id_address bigint not null,
	login_id_login bigint not null
)ENGINE = innodb;

create table Benefited(
	document varchar(11) not null primary key,
	`name`varchar(80) not null,
    bornDate date not null,
    nis varchar(11) not null,
    telephone bigint not null,
    amountDependent int,
	limitDependent int,
    isActive boolean,
    address_id_address bigint not null,
    login_id_login bigint not null
)ENGINE = innodb;

create table Dependent(
	document varchar(15) not null primary key,
    `name` varchar(80) not null,
    bornDate date not null,
    kinship varchar(10) not null,
    isActive boolean,
    `date`date,
    benefited_document varchar(11) not null
)ENGINE = innodb;

create table Prescription(
		id_prescription bigint not null auto_increment primary key,
        `Date` date not null,
        examAttach varchar(150) not null,
        comments varchar(255),
        dependent_document varchar(15) not null,
        far_id_degree bigint,
        near_id_degree bigint
)ENGINE = innodb;

create table Degree(
	id_degree bigint not null auto_increment primary key,
	sphere_R varchar(10) not null,
    cylinde_R varchar(10) not null,
    axis_R varchar(10) not null,
    pd_R varchar(10) not null,
	sphere_L varchar(10) not null,
    cylinde_L varchar(10) not null,
    axis_L varchar(10) not null,
    pd_L varchar(10) not null
);    

create table Address(
	id_address bigint not null auto_increment primary key,
    streetAddress varchar(50) not null,
    `number` int not null,
    neighborhood varchar(45) not null,
    city varchar(45) not null,
    state varchar(30) not null,
    `reference` varchar(150) not null,
    postalAddressCode varchar(8) not null,
    complement varchar (45)
);    

create table Login(
	id_Login bigint not null auto_increment primary key,
    email varchar(100) not null,
    `password` varchar(40) not null
)ENGINE = innodb;    

create table Donation(
	id_donation bigint not null auto_increment primary key,
    `date`date not null,
    amount float not null,
    deductedAmount float not null,
    beneficent_document varchar(11) not null
)ENGINE = innodb;    

create table Payment(
	id_payment bigint not null auto_increment primary key,
    `date`timestamp not null,
    paymentMethod varchar(15) not null,
    amount float not null
)ENGINE = innodb;

create table PaymentRecord(
    payment_id_payment bigint not null,
    record_id_record bigint not null
)ENGINE = innodb;

create table Glasses(
	id_glasses bigint not null auto_increment primary key,
    price float not null,
    glassesStore_id_glassesStore bigint not null,
    dependent_document varchar(15)
)ENGINE = innodb;

create table Record(
	id_record bigint not null auto_increment primary key,
	`status` varchar(100) not null,
    `date`timestamp not null,
    glasses_id_glasses bigint not null,
    donation_id_donation bigint not null
)ENGINE = innodb;

alter table beneficent 
	add constraint fk_beneficent_address 
		foreign key (address_id_address) 
        references Address (id_address);
alter table beneficent 
	add constraint fk_beneficent_prescription 
		foreign key (prescription_id_prescription) 
        references Prescription (id_prescription);  
alter table beneficent 
	add constraint fk_beneficent_login 
		foreign key (login_id_login) 
        references Login (id_login);        
alter table glassesStore 
	add constraint fk_glassesStore_address 
		foreign key (address_id_address) 
        references Address (id_address);
alter table glassesStore 
	add constraint fk_glassesStore_login
		foreign key (login_id_login) 
        references Login (id_login);
alter table benefited 
	add constraint fk_benefited_address 
		foreign key (address_id_address) 
		references Address (id_address);
alter table benefited 
	add constraint fk_benefited_login
		foreign key (login_id_login) 
        references Login (id_login);
alter table dependent 
	add constraint fk_dependent_benefited 
		foreign key (benefited_document) 
        references benefited (document);
alter table prescription 
	add constraint fk_prescription_dependent 
		foreign key (dependent_document) 
		references dependent (document);
alter table prescription 
	add constraint fk_prescription_degreeFar 
		foreign key (far_id_degree) 
        references degree (id_degree);
alter table prescription 
	add constraint fk_prescription_degreeNear 
		foreign key (near_id_degree) 
        references degree (id_degree);     
alter table donation 
	add constraint fk_donation_beneficent 
		foreign key (beneficent_document) 
        references beneficent (document);
alter table paymentRecord 
	add constraint fk_paymentRecord_record 
		foreign key (record_id_record) 
        references record (id_record);
alter table paymentRecord 
	add constraint fk_paymentRecord_payment 
		foreign key (payment_id_payment) 
        references payment (id_payment);        
alter table glasses
	add constraint fk_glasses_glassesStore 
		foreign key (glassesStore_id_glassesStore) 
        references glassesStore (id_glassesStore);
alter table glasses 
	add constraint fk_glasses_dependent 
		foreign key (dependent_document) 
        references Dependent (document);    
alter table Record 
	add constraint fk_record_donation 
		foreign key (donation_id_donation) 
        references donation (id_donation);
alter table Record 
	add constraint fk_record_glasses 
		foreign key (glasses_id_glasses) 
        references glasses (id_glasses);
