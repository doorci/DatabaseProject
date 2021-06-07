Create database covid ;
Use covid ;
-- USER DATABASE
USE covid ;


-- DROP TABLES IF ALREADY EXISTS

DROP TABLE if EXISTS community_transmission cascade ;
DROP TABLE if EXISTS locality cascade ;
DROP TABLE if EXISTS city cascade ;
DROP TABLE if EXISTS declaration cascade ;


-- CREATE ALL TABLES

CREATE TABLE declaration(
    id int primary key auto_increment,
    nom varchar(255) not null,
    url varchar(255),
    date_publication date UNIQUE not null,
    nombre_tests int not null,
    nombre_cas_positifs int not null,
    nombre_cas_contacts int not null,
    nombre_cas_importes int not null,
    nombre_cas_graves int not null,
    nombre_patients int not null,
    nombre_deces int not null
) ENGINE=InnoDB ;

CREATE TABLE community_transmission(
    id int primary key auto_increment,
    nombre_cas int not null,
    declaration_id int not null,
    localite_id int not null
) ENGINE=InnoDB ;

CREATE TABLE city(
    id int primary key auto_increment,
    nom varchar(255) not null UNIQUE
) ENGINE=InnoDB ;

CREATE TABLE locality(
    id int primary key auto_increment,
    nom varchar(255) UNIQUE not null,
    ville_id int NOT NULL
) ENGINE=InnoDB ;

-- CREATE CONSTRAINTS CONSTRAINTS
ALTER TABLE locality add constraint fk_locality_city foreign key (city_id) references city(id) ON DELETE CASCADE;
ALTER TABLE community_transmission add constraint fk_tc_locality foreign key (locality_id) references locality(id) ON DELETE CASCADE;
ALTER TABLE community_transmission add constraint fk_tc_declaration foreign key (declaration_id) references declaration(id) ON DELETE CASCADE;
