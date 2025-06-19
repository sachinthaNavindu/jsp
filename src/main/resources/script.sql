create table employee
(
    NIC       varchar(12)  not null
        primary key,
    name      varchar(100) null,
    adrs      varchar(255) null,
    contactNo varchar(15)  null,
    jobrole   varchar(50)  null
);

create table complains
(
    compl_id           varchar(20)  not null
        primary key,
    NIC                varchar(12)  null,
    date               date         null,
    time               time         null,
    description        text         null,
    status             varchar(50)  null,
    complaint_category varchar(100) null,
    constraint complains_ibfk_1
        foreign key (NIC) references employee (NIC)
);

create index NIC
    on complains (NIC);

create table complaint_solution
(
    solution_id int auto_increment
        primary key,
    compl_id    varchar(20) null,
    solution    text        null,
    constraint complaint_solution_ibfk_1
        foreign key (compl_id) references complains (compl_id)
);

create index compl_id
    on complaint_solution (compl_id);

create table credentials
(
    userName varchar(50)  not null
        primary key,
    NIC      varchar(12)  null,
    gmail    varchar(100) null,
    pw       varchar(100) null,
    constraint credentials_ibfk_1
        foreign key (NIC) references employee (NIC)
);

create index NIC
    on credentials (NIC);


