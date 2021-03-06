--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.1
-- Dumped by pg_dump version 9.6.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET search_path = public, pg_catalog;

--
-- Name: pg_search_dmetaphone(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pg_search_dmetaphone(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
  SELECT array_to_string(ARRAY(SELECT dmetaphone(unnest(regexp_split_to_array($1, E'\\s+')))), ' ')
$_$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE companies (
    id integer NOT NULL,
    name character varying,
    address character varying,
    city character varying,
    state character varying,
    zip integer,
    country character varying
);


--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE companies_id_seq OWNED BY companies.id;


--
-- Name: companies_materials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE companies_materials (
    id integer NOT NULL,
    material_id integer,
    company_id integer
);


--
-- Name: companies_materials_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE companies_materials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: companies_materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE companies_materials_id_seq OWNED BY companies_materials.id;


--
-- Name: materials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE materials (
    id integer NOT NULL,
    section character varying,
    cat_1 character varying,
    cat_2 character varying,
    cat_3 character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: material_searches; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW material_searches AS
 SELECT materials.id AS searchable_id,
    'Material'::text AS searchable_type,
    materials.section AS term
   FROM materials
UNION
 SELECT materials.id AS searchable_id,
    'Material'::text AS searchable_type,
    materials.cat_1 AS term
   FROM materials
UNION
 SELECT materials.id AS searchable_id,
    'Material'::text AS searchable_type,
    materials.cat_2 AS term
   FROM materials
UNION
 SELECT materials.id AS searchable_id,
    'Material'::text AS searchable_type,
    materials.cat_3 AS term
   FROM materials;


--
-- Name: materials_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE materials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE materials_id_seq OWNED BY materials.id;


--
-- Name: pg_search_documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pg_search_documents (
    id integer NOT NULL,
    content text,
    searchable_type character varying,
    searchable_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pg_search_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pg_search_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pg_search_documents_id_seq OWNED BY pg_search_documents.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: companies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY companies ALTER COLUMN id SET DEFAULT nextval('companies_id_seq'::regclass);


--
-- Name: companies_materials id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY companies_materials ALTER COLUMN id SET DEFAULT nextval('companies_materials_id_seq'::regclass);


--
-- Name: materials id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY materials ALTER COLUMN id SET DEFAULT nextval('materials_id_seq'::regclass);


--
-- Name: pg_search_documents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pg_search_documents ALTER COLUMN id SET DEFAULT nextval('pg_search_documents_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: companies_materials companies_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY companies_materials
    ADD CONSTRAINT companies_materials_pkey PRIMARY KEY (id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: materials materials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY materials
    ADD CONSTRAINT materials_pkey PRIMARY KEY (id);


--
-- Name: pg_search_documents pg_search_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pg_search_documents
    ADD CONSTRAINT pg_search_documents_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_companies_materials_on_company_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_companies_materials_on_company_id ON companies_materials USING btree (company_id);


--
-- Name: index_companies_materials_on_material_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_companies_materials_on_material_id ON companies_materials USING btree (material_id);


--
-- Name: index_materials_on_cat_1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_materials_on_cat_1 ON materials USING gin (to_tsvector('english'::regconfig, (cat_1)::text));


--
-- Name: index_materials_on_cat_2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_materials_on_cat_2 ON materials USING gin (to_tsvector('english'::regconfig, (cat_2)::text));


--
-- Name: index_materials_on_cat_3; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_materials_on_cat_3 ON materials USING gin (to_tsvector('english'::regconfig, (cat_3)::text));


--
-- Name: index_materials_on_section; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_materials_on_section ON materials USING gin (to_tsvector('english'::regconfig, (section)::text));


--
-- Name: index_pg_search_documents_on_searchable_type_and_searchable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pg_search_documents_on_searchable_type_and_searchable_id ON pg_search_documents USING btree (searchable_type, searchable_id);


--
-- Name: companies_materials fk_rails_062af2afe6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY companies_materials
    ADD CONSTRAINT fk_rails_062af2afe6 FOREIGN KEY (material_id) REFERENCES materials(id);


--
-- Name: companies_materials fk_rails_cf71c91e48; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY companies_materials
    ADD CONSTRAINT fk_rails_cf71c91e48 FOREIGN KEY (company_id) REFERENCES companies(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20161130204303'), ('20161130204309'), ('20161130205808'), ('20161130231330'), ('20161201172207'), ('20161201184531'), ('20161201185146');


