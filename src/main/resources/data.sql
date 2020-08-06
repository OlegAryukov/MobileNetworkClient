-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.1
-- PostgreSQL version: 10.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: new_database | type: DATABASE --
-- -- DROP DATABASE IF EXISTS new_database;
-- CREATE DATABASE new_database;
-- -- ddl-end --
--

-- object: mobile | type: SCHEMA --
-- DROP SCHEMA IF EXISTS mobile CASCADE;
--CREATE SCHEMA mobile;
-- ddl-end --
--ALTER SCHEMA mobile OWNER TO postgres;
-- ddl-end --

--SET search_path TO pg_catalog,public,mobile;
-- ddl-end --

-- object: public.client | type: TABLE --
-- DROP TABLE IF EXISTS public.client CASCADE;
CREATE TABLE public.client (
  id uuid NOT NULL,
  name varchar NOT NULL,
  second_name varchar NOT NULL,
  birth_date date NOT NULL,
  passport varchar NOT NULL,
  address varchar NOT NULL,
  email varchar,
  password varchar NOT NULL,
  CONSTRAINT client_pk PRIMARY KEY (id)

);
-- ddl-end --
--ALTER TABLE public.client OWNER TO postgres;
-- ddl-end --

-- object: public.tarif | type: TABLE --
-- DROP TABLE IF EXISTS public.tarif CASCADE;
CREATE TABLE public.tarif (
  id uuid NOT NULL,
  name varchar NOT NULL,
  price int2 NOT NULL,
  CONSTRAINT tarif_pk PRIMARY KEY (id)

);
-- ddl-end --
--ALTER TABLE public.tarif OWNER TO postgres;
-- ddl-end --

-- object: public.option | type: TABLE --
-- DROP TABLE IF EXISTS public.option CASCADE;
CREATE TABLE public.option (
  id uuid NOT NULL,
  name varchar NOT NULL,
  connect_cost int2 NOT NULL,
  CONSTRAINT option_pk PRIMARY KEY (id)

);
-- ddl-end --
--ALTER TABLE public.option OWNER TO postgres;
-- ddl-end --

-- object: public.many_tarif_has_many_option | type: TABLE --
-- DROP TABLE IF EXISTS public.many_tarif_has_many_option CASCADE;
CREATE TABLE public.many_tarif_has_many_option (
  id_tarif uuid NOT NULL,
  id_option uuid NOT NULL,
  CONSTRAINT many_tarif_has_many_option_pk PRIMARY KEY (id_tarif, id_option)

);
-- ddl-end --

-- object: tarif_fk | type: CONSTRAINT --
--ALTER TABLE public.many_tarif_has_many_option DROP CONSTRAINT IF EXISTS tarif_fk CASCADE;
ALTER TABLE public.many_tarif_has_many_option ADD CONSTRAINT tarif_x_option_fk FOREIGN KEY (id_tarif)
REFERENCES public.tarif (id)
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: option_fk | type: CONSTRAINT --
--ALTER TABLE public.many_tarif_has_many_option DROP CONSTRAINT IF EXISTS option_fk CASCADE;
ALTER TABLE public.many_tarif_has_many_option ADD CONSTRAINT option_x_tarif_fk FOREIGN KEY (id_option)
REFERENCES public.option (id)
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: public.contract | type: TABLE --
-- DROP TABLE IF EXISTS public.contract CASCADE;
CREATE TABLE public.contract (
  id uuid NOT NULL,
  phone_number int8 NOT NULL,
  tarif uuid NOT NULL,
  id_tarif uuid,
  id_client uuid,
  CONSTRAINT contract_pk PRIMARY KEY (id)

);
-- ddl-end --
--ALTER TABLE public.contract OWNER TO postgres;
-- ddl-end --

-- object: public.many_contract_has_many_option | type: TABLE --
-- DROP TABLE IF EXISTS public.many_contract_has_many_option CASCADE;
CREATE TABLE public.many_contract_has_many_option (
  id_contract uuid NOT NULL,
  id_option uuid NOT NULL,
  CONSTRAINT many_contract_has_many_option_pk PRIMARY KEY (id_contract, id_option)

);
-- ddl-end --

-- object: contract_fk | type: CONSTRAINT --
--ALTER TABLE public.many_contract_has_many_option DROP CONSTRAINT IF EXISTS contract_fk CASCADE;
ALTER TABLE public.many_contract_has_many_option ADD CONSTRAINT contract_fk FOREIGN KEY (id_contract)
REFERENCES public.contract (id)
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: option_fk | type: CONSTRAINT --
--ALTER TABLE public.many_contract_has_many_option DROP CONSTRAINT IF EXISTS option_fk CASCADE;
ALTER TABLE public.many_contract_has_many_option ADD CONSTRAINT option_x_contract_fk FOREIGN KEY (id_option)
REFERENCES public.option (id)
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: tarif_fk | type: CONSTRAINT --
--ALTER TABLE public.contract DROP CONSTRAINT IF EXISTS tarif_fk CASCADE;
ALTER TABLE public.contract ADD CONSTRAINT contract_x_tarif_fk FOREIGN KEY (id_tarif)
REFERENCES public.tarif (id)
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: client_fk | type: CONSTRAINT --
--ALTER TABLE public.contract DROP CONSTRAINT IF EXISTS client_fk CASCADE;
ALTER TABLE public.contract ADD CONSTRAINT client_fk FOREIGN KEY (id_client)
REFERENCES public.client (id)
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --