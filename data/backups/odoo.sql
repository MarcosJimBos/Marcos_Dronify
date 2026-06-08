--
-- PostgreSQL database dump
--

\restrict mlRS85kzcXMrkyUtDFvLwTkOeDG4iPBc7STHmLmVB68MUUxc9ecUofLDeggZxmX

-- Dumped from database version 15.15 (Debian 15.15-1.pgdg13+1)
-- Dumped by pg_dump version 15.15 (Debian 15.15-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_passkey_key; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.auth_passkey_key (
    id integer NOT NULL,
    sign_count integer,
    create_uid integer,
    write_uid integer,
    name character varying NOT NULL,
    credential_identifier character varying NOT NULL,
    create_date timestamp without time zone,
    write_date timestamp without time zone,
    public_key character varying
);


ALTER TABLE public.auth_passkey_key OWNER TO odoo;

--
-- Name: TABLE auth_passkey_key; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.auth_passkey_key IS 'Passkey';


--
-- Name: COLUMN auth_passkey_key.sign_count; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_passkey_key.sign_count IS 'Sign Count';


--
-- Name: COLUMN auth_passkey_key.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_passkey_key.create_uid IS 'Create Uid';


--
-- Name: COLUMN auth_passkey_key.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_passkey_key.write_uid IS 'Last Updated by';


--
-- Name: COLUMN auth_passkey_key.name; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_passkey_key.name IS 'Name';


--
-- Name: COLUMN auth_passkey_key.credential_identifier; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_passkey_key.credential_identifier IS 'Credential Identifier';


--
-- Name: COLUMN auth_passkey_key.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_passkey_key.create_date IS 'Created on';


--
-- Name: COLUMN auth_passkey_key.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_passkey_key.write_date IS 'Last Updated on';


--
-- Name: auth_passkey_key_create; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.auth_passkey_key_create (
    id integer NOT NULL,
    create_uid integer,
    write_uid integer,
    name character varying NOT NULL,
    create_date timestamp without time zone,
    write_date timestamp without time zone
);


ALTER TABLE public.auth_passkey_key_create OWNER TO odoo;

--
-- Name: TABLE auth_passkey_key_create; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.auth_passkey_key_create IS 'Create a Passkey';


--
-- Name: COLUMN auth_passkey_key_create.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_passkey_key_create.create_uid IS 'Created by';


--
-- Name: COLUMN auth_passkey_key_create.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_passkey_key_create.write_uid IS 'Last Updated by';


--
-- Name: COLUMN auth_passkey_key_create.name; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_passkey_key_create.name IS 'Name';


--
-- Name: COLUMN auth_passkey_key_create.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_passkey_key_create.create_date IS 'Created on';


--
-- Name: COLUMN auth_passkey_key_create.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_passkey_key_create.write_date IS 'Last Updated on';


--
-- Name: auth_passkey_key_create_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.auth_passkey_key_create_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_passkey_key_create_id_seq OWNER TO odoo;

--
-- Name: auth_passkey_key_create_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.auth_passkey_key_create_id_seq OWNED BY public.auth_passkey_key_create.id;


--
-- Name: auth_passkey_key_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.auth_passkey_key_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_passkey_key_id_seq OWNER TO odoo;

--
-- Name: auth_passkey_key_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.auth_passkey_key_id_seq OWNED BY public.auth_passkey_key.id;


--
-- Name: auth_totp_device; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.auth_totp_device (
    id integer NOT NULL,
    name character varying NOT NULL,
    user_id integer NOT NULL,
    scope character varying,
    expiration_date timestamp without time zone,
    index character varying(8),
    key character varying,
    create_date timestamp without time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
    CONSTRAINT auth_totp_device_index_check CHECK ((char_length((index)::text) = 8))
);


ALTER TABLE public.auth_totp_device OWNER TO odoo;

--
-- Name: auth_totp_device_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.auth_totp_device_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_totp_device_id_seq OWNER TO odoo;

--
-- Name: auth_totp_device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.auth_totp_device_id_seq OWNED BY public.auth_totp_device.id;


--
-- Name: auth_totp_rate_limit_log; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.auth_totp_rate_limit_log (
    id integer NOT NULL,
    user_id integer NOT NULL,
    create_uid integer,
    write_uid integer,
    ip character varying,
    limit_type character varying,
    create_date timestamp without time zone,
    write_date timestamp without time zone
);


ALTER TABLE public.auth_totp_rate_limit_log OWNER TO odoo;

--
-- Name: TABLE auth_totp_rate_limit_log; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.auth_totp_rate_limit_log IS 'TOTP rate limit logs';


--
-- Name: COLUMN auth_totp_rate_limit_log.user_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_totp_rate_limit_log.user_id IS 'User';


--
-- Name: COLUMN auth_totp_rate_limit_log.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_totp_rate_limit_log.create_uid IS 'Created by';


--
-- Name: COLUMN auth_totp_rate_limit_log.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_totp_rate_limit_log.write_uid IS 'Last Updated by';


--
-- Name: COLUMN auth_totp_rate_limit_log.ip; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_totp_rate_limit_log.ip IS 'Ip';


--
-- Name: COLUMN auth_totp_rate_limit_log.limit_type; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_totp_rate_limit_log.limit_type IS 'Limit Type';


--
-- Name: COLUMN auth_totp_rate_limit_log.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_totp_rate_limit_log.create_date IS 'Created on';


--
-- Name: COLUMN auth_totp_rate_limit_log.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_totp_rate_limit_log.write_date IS 'Last Updated on';


--
-- Name: auth_totp_rate_limit_log_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.auth_totp_rate_limit_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_totp_rate_limit_log_id_seq OWNER TO odoo;

--
-- Name: auth_totp_rate_limit_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.auth_totp_rate_limit_log_id_seq OWNED BY public.auth_totp_rate_limit_log.id;


--
-- Name: auth_totp_wizard; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.auth_totp_wizard (
    id integer NOT NULL,
    user_id integer NOT NULL,
    create_uid integer,
    write_uid integer,
    secret character varying NOT NULL,
    url character varying,
    create_date timestamp without time zone,
    write_date timestamp without time zone,
    qrcode bytea
);


ALTER TABLE public.auth_totp_wizard OWNER TO odoo;

--
-- Name: TABLE auth_totp_wizard; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.auth_totp_wizard IS '2-Factor Setup Wizard';


--
-- Name: COLUMN auth_totp_wizard.user_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_totp_wizard.user_id IS 'User';


--
-- Name: COLUMN auth_totp_wizard.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_totp_wizard.create_uid IS 'Created by';


--
-- Name: COLUMN auth_totp_wizard.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_totp_wizard.write_uid IS 'Last Updated by';


--
-- Name: COLUMN auth_totp_wizard.secret; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_totp_wizard.secret IS 'Secret';


--
-- Name: COLUMN auth_totp_wizard.url; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_totp_wizard.url IS 'Url';


--
-- Name: COLUMN auth_totp_wizard.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_totp_wizard.create_date IS 'Created on';


--
-- Name: COLUMN auth_totp_wizard.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_totp_wizard.write_date IS 'Last Updated on';


--
-- Name: COLUMN auth_totp_wizard.qrcode; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.auth_totp_wizard.qrcode IS 'Qrcode';


--
-- Name: auth_totp_wizard_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.auth_totp_wizard_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_totp_wizard_id_seq OWNER TO odoo;

--
-- Name: auth_totp_wizard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.auth_totp_wizard_id_seq OWNED BY public.auth_totp_wizard.id;


--
-- Name: base_document_layout; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.base_document_layout (
    id integer NOT NULL,
    company_id integer NOT NULL,
    report_layout_id integer,
    create_uid integer,
    write_uid integer,
    create_date timestamp without time zone,
    write_date timestamp without time zone
);


ALTER TABLE public.base_document_layout OWNER TO odoo;

--
-- Name: TABLE base_document_layout; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.base_document_layout IS 'Company Document Layout';


--
-- Name: COLUMN base_document_layout.company_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_document_layout.company_id IS 'Company';


--
-- Name: COLUMN base_document_layout.report_layout_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_document_layout.report_layout_id IS 'Report Layout';


--
-- Name: COLUMN base_document_layout.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_document_layout.create_uid IS 'Created by';


--
-- Name: COLUMN base_document_layout.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_document_layout.write_uid IS 'Last Updated by';


--
-- Name: COLUMN base_document_layout.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_document_layout.create_date IS 'Created on';


--
-- Name: COLUMN base_document_layout.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_document_layout.write_date IS 'Last Updated on';


--
-- Name: base_document_layout_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.base_document_layout_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_document_layout_id_seq OWNER TO odoo;

--
-- Name: base_document_layout_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.base_document_layout_id_seq OWNED BY public.base_document_layout.id;


--
-- Name: base_enable_profiling_wizard; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.base_enable_profiling_wizard (
    id integer NOT NULL,
    create_uid integer,
    write_uid integer,
    duration character varying,
    expiration timestamp without time zone,
    create_date timestamp without time zone,
    write_date timestamp without time zone
);


ALTER TABLE public.base_enable_profiling_wizard OWNER TO odoo;

--
-- Name: TABLE base_enable_profiling_wizard; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.base_enable_profiling_wizard IS 'Enable profiling for some time';


--
-- Name: COLUMN base_enable_profiling_wizard.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_enable_profiling_wizard.create_uid IS 'Created by';


--
-- Name: COLUMN base_enable_profiling_wizard.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_enable_profiling_wizard.write_uid IS 'Last Updated by';


--
-- Name: COLUMN base_enable_profiling_wizard.duration; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_enable_profiling_wizard.duration IS 'Enable profiling for';


--
-- Name: COLUMN base_enable_profiling_wizard.expiration; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_enable_profiling_wizard.expiration IS 'Enable profiling until';


--
-- Name: COLUMN base_enable_profiling_wizard.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_enable_profiling_wizard.create_date IS 'Created on';


--
-- Name: COLUMN base_enable_profiling_wizard.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_enable_profiling_wizard.write_date IS 'Last Updated on';


--
-- Name: base_enable_profiling_wizard_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.base_enable_profiling_wizard_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_enable_profiling_wizard_id_seq OWNER TO odoo;

--
-- Name: base_enable_profiling_wizard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.base_enable_profiling_wizard_id_seq OWNED BY public.base_enable_profiling_wizard.id;


--
-- Name: base_import_import; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.base_import_import (
    id integer NOT NULL,
    create_uid integer,
    write_uid integer,
    res_model character varying,
    file_name character varying,
    file_type character varying,
    create_date timestamp without time zone,
    write_date timestamp without time zone,
    file bytea
);


ALTER TABLE public.base_import_import OWNER TO odoo;

--
-- Name: TABLE base_import_import; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.base_import_import IS 'Base Import';


--
-- Name: COLUMN base_import_import.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_import.create_uid IS 'Created by';


--
-- Name: COLUMN base_import_import.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_import.write_uid IS 'Last Updated by';


--
-- Name: COLUMN base_import_import.res_model; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_import.res_model IS 'Model';


--
-- Name: COLUMN base_import_import.file_name; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_import.file_name IS 'File Name';


--
-- Name: COLUMN base_import_import.file_type; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_import.file_type IS 'File Type';


--
-- Name: COLUMN base_import_import.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_import.create_date IS 'Created on';


--
-- Name: COLUMN base_import_import.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_import.write_date IS 'Last Updated on';


--
-- Name: COLUMN base_import_import.file; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_import.file IS 'File';


--
-- Name: base_import_import_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.base_import_import_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_import_import_id_seq OWNER TO odoo;

--
-- Name: base_import_import_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.base_import_import_id_seq OWNED BY public.base_import_import.id;


--
-- Name: base_import_mapping; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.base_import_mapping (
    id integer NOT NULL,
    create_uid integer,
    write_uid integer,
    res_model character varying,
    column_name character varying,
    field_name character varying,
    create_date timestamp without time zone,
    write_date timestamp without time zone
);


ALTER TABLE public.base_import_mapping OWNER TO odoo;

--
-- Name: TABLE base_import_mapping; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.base_import_mapping IS 'Base Import Mapping';


--
-- Name: COLUMN base_import_mapping.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_mapping.create_uid IS 'Created by';


--
-- Name: COLUMN base_import_mapping.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_mapping.write_uid IS 'Last Updated by';


--
-- Name: COLUMN base_import_mapping.res_model; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_mapping.res_model IS 'Res Model';


--
-- Name: COLUMN base_import_mapping.column_name; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_mapping.column_name IS 'Column Name';


--
-- Name: COLUMN base_import_mapping.field_name; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_mapping.field_name IS 'Field Name';


--
-- Name: COLUMN base_import_mapping.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_mapping.create_date IS 'Created on';


--
-- Name: COLUMN base_import_mapping.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_mapping.write_date IS 'Last Updated on';


--
-- Name: base_import_mapping_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.base_import_mapping_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_import_mapping_id_seq OWNER TO odoo;

--
-- Name: base_import_mapping_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.base_import_mapping_id_seq OWNED BY public.base_import_mapping.id;


--
-- Name: base_import_module; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.base_import_module (
    id integer NOT NULL,
    create_uid integer,
    write_uid integer,
    state character varying,
    import_message text,
    modules_dependencies text,
    force boolean,
    with_demo boolean,
    create_date timestamp without time zone,
    write_date timestamp without time zone,
    module_file bytea NOT NULL
);


ALTER TABLE public.base_import_module OWNER TO odoo;

--
-- Name: TABLE base_import_module; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.base_import_module IS 'Import Module';


--
-- Name: COLUMN base_import_module.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_module.create_uid IS 'Created by';


--
-- Name: COLUMN base_import_module.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_module.write_uid IS 'Last Updated by';


--
-- Name: COLUMN base_import_module.state; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_module.state IS 'Status';


--
-- Name: COLUMN base_import_module.import_message; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_module.import_message IS 'Import Message';


--
-- Name: COLUMN base_import_module.modules_dependencies; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_module.modules_dependencies IS 'Modules Dependencies';


--
-- Name: COLUMN base_import_module.force; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_module.force IS 'Force init';


--
-- Name: COLUMN base_import_module.with_demo; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_module.with_demo IS 'Import demo data of module';


--
-- Name: COLUMN base_import_module.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_module.create_date IS 'Created on';


--
-- Name: COLUMN base_import_module.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_module.write_date IS 'Last Updated on';


--
-- Name: COLUMN base_import_module.module_file; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_import_module.module_file IS 'Module .ZIP file';


--
-- Name: base_import_module_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.base_import_module_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_import_module_id_seq OWNER TO odoo;

--
-- Name: base_import_module_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.base_import_module_id_seq OWNED BY public.base_import_module.id;


--
-- Name: base_language_export; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.base_language_export (
    id integer NOT NULL,
    model_id integer,
    create_uid integer,
    write_uid integer,
    name character varying,
    lang character varying NOT NULL,
    format character varying NOT NULL,
    export_type character varying NOT NULL,
    domain character varying,
    state character varying,
    create_date timestamp without time zone,
    write_date timestamp without time zone,
    data bytea
);


ALTER TABLE public.base_language_export OWNER TO odoo;

--
-- Name: TABLE base_language_export; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.base_language_export IS 'Language Export';


--
-- Name: COLUMN base_language_export.model_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_export.model_id IS 'Model to Export';


--
-- Name: COLUMN base_language_export.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_export.create_uid IS 'Created by';


--
-- Name: COLUMN base_language_export.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_export.write_uid IS 'Last Updated by';


--
-- Name: COLUMN base_language_export.name; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_export.name IS 'File Name';


--
-- Name: COLUMN base_language_export.lang; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_export.lang IS 'Language';


--
-- Name: COLUMN base_language_export.format; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_export.format IS 'File Format';


--
-- Name: COLUMN base_language_export.export_type; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_export.export_type IS 'Export Type';


--
-- Name: COLUMN base_language_export.domain; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_export.domain IS 'Model Domain';


--
-- Name: COLUMN base_language_export.state; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_export.state IS 'State';


--
-- Name: COLUMN base_language_export.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_export.create_date IS 'Created on';


--
-- Name: COLUMN base_language_export.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_export.write_date IS 'Last Updated on';


--
-- Name: COLUMN base_language_export.data; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_export.data IS 'File';


--
-- Name: base_language_export_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.base_language_export_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_language_export_id_seq OWNER TO odoo;

--
-- Name: base_language_export_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.base_language_export_id_seq OWNED BY public.base_language_export.id;


--
-- Name: base_language_import; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.base_language_import (
    id integer NOT NULL,
    create_uid integer,
    write_uid integer,
    name character varying NOT NULL,
    code character varying NOT NULL,
    filename character varying NOT NULL,
    overwrite boolean,
    create_date timestamp without time zone,
    write_date timestamp without time zone,
    data bytea NOT NULL
);


ALTER TABLE public.base_language_import OWNER TO odoo;

--
-- Name: TABLE base_language_import; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.base_language_import IS 'Language Import';


--
-- Name: COLUMN base_language_import.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_import.create_uid IS 'Created by';


--
-- Name: COLUMN base_language_import.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_import.write_uid IS 'Last Updated by';


--
-- Name: COLUMN base_language_import.name; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_import.name IS 'Language Name';


--
-- Name: COLUMN base_language_import.code; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_import.code IS 'ISO Code';


--
-- Name: COLUMN base_language_import.filename; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_import.filename IS 'File Name';


--
-- Name: COLUMN base_language_import.overwrite; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_import.overwrite IS 'Overwrite Existing Terms';


--
-- Name: COLUMN base_language_import.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_import.create_date IS 'Created on';


--
-- Name: COLUMN base_language_import.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_import.write_date IS 'Last Updated on';


--
-- Name: COLUMN base_language_import.data; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_import.data IS 'File';


--
-- Name: base_language_import_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.base_language_import_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_language_import_id_seq OWNER TO odoo;

--
-- Name: base_language_import_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.base_language_import_id_seq OWNED BY public.base_language_import.id;


--
-- Name: base_language_install; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.base_language_install (
    id integer NOT NULL,
    create_uid integer,
    write_uid integer,
    overwrite boolean,
    create_date timestamp without time zone,
    write_date timestamp without time zone
);


ALTER TABLE public.base_language_install OWNER TO odoo;

--
-- Name: TABLE base_language_install; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.base_language_install IS 'Install Language';


--
-- Name: COLUMN base_language_install.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_install.create_uid IS 'Created by';


--
-- Name: COLUMN base_language_install.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_install.write_uid IS 'Last Updated by';


--
-- Name: COLUMN base_language_install.overwrite; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_install.overwrite IS 'Overwrite Existing Terms';


--
-- Name: COLUMN base_language_install.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_install.create_date IS 'Created on';


--
-- Name: COLUMN base_language_install.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_language_install.write_date IS 'Last Updated on';


--
-- Name: base_language_install_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.base_language_install_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_language_install_id_seq OWNER TO odoo;

--
-- Name: base_language_install_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.base_language_install_id_seq OWNED BY public.base_language_install.id;


--
-- Name: base_module_uninstall; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.base_module_uninstall (
    id integer NOT NULL,
    create_uid integer,
    write_uid integer,
    show_all boolean,
    create_date timestamp without time zone,
    write_date timestamp without time zone
);


ALTER TABLE public.base_module_uninstall OWNER TO odoo;

--
-- Name: TABLE base_module_uninstall; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.base_module_uninstall IS 'Module Uninstall';


--
-- Name: COLUMN base_module_uninstall.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_module_uninstall.create_uid IS 'Created by';


--
-- Name: COLUMN base_module_uninstall.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_module_uninstall.write_uid IS 'Last Updated by';


--
-- Name: COLUMN base_module_uninstall.show_all; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_module_uninstall.show_all IS 'Show All';


--
-- Name: COLUMN base_module_uninstall.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_module_uninstall.create_date IS 'Created on';


--
-- Name: COLUMN base_module_uninstall.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_module_uninstall.write_date IS 'Last Updated on';


--
-- Name: base_module_uninstall_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.base_module_uninstall_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_module_uninstall_id_seq OWNER TO odoo;

--
-- Name: base_module_uninstall_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.base_module_uninstall_id_seq OWNED BY public.base_module_uninstall.id;


--
-- Name: base_module_uninstall_ir_module_module_rel; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.base_module_uninstall_ir_module_module_rel (
    base_module_uninstall_id integer NOT NULL,
    ir_module_module_id integer NOT NULL
);


ALTER TABLE public.base_module_uninstall_ir_module_module_rel OWNER TO odoo;

--
-- Name: TABLE base_module_uninstall_ir_module_module_rel; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.base_module_uninstall_ir_module_module_rel IS 'RELATION BETWEEN base_module_uninstall AND ir_module_module';


--
-- Name: base_module_update; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.base_module_update (
    id integer NOT NULL,
    updated integer,
    added integer,
    create_uid integer,
    write_uid integer,
    state character varying,
    create_date timestamp without time zone,
    write_date timestamp without time zone
);


ALTER TABLE public.base_module_update OWNER TO odoo;

--
-- Name: TABLE base_module_update; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.base_module_update IS 'Update Module';


--
-- Name: COLUMN base_module_update.updated; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_module_update.updated IS 'Number of modules updated';


--
-- Name: COLUMN base_module_update.added; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_module_update.added IS 'Number of modules added';


--
-- Name: COLUMN base_module_update.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_module_update.create_uid IS 'Created by';


--
-- Name: COLUMN base_module_update.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_module_update.write_uid IS 'Last Updated by';


--
-- Name: COLUMN base_module_update.state; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_module_update.state IS 'Status';


--
-- Name: COLUMN base_module_update.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_module_update.create_date IS 'Created on';


--
-- Name: COLUMN base_module_update.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_module_update.write_date IS 'Last Updated on';


--
-- Name: base_module_update_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.base_module_update_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_module_update_id_seq OWNER TO odoo;

--
-- Name: base_module_update_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.base_module_update_id_seq OWNED BY public.base_module_update.id;


--
-- Name: base_module_upgrade; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.base_module_upgrade (
    id integer NOT NULL,
    create_uid integer,
    write_uid integer,
    module_info text,
    create_date timestamp without time zone,
    write_date timestamp without time zone
);


ALTER TABLE public.base_module_upgrade OWNER TO odoo;

--
-- Name: TABLE base_module_upgrade; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.base_module_upgrade IS 'Upgrade Module';


--
-- Name: COLUMN base_module_upgrade.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_module_upgrade.create_uid IS 'Created by';


--
-- Name: COLUMN base_module_upgrade.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_module_upgrade.write_uid IS 'Last Updated by';


--
-- Name: COLUMN base_module_upgrade.module_info; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_module_upgrade.module_info IS 'Apps to Update';


--
-- Name: COLUMN base_module_upgrade.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_module_upgrade.create_date IS 'Created on';


--
-- Name: COLUMN base_module_upgrade.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_module_upgrade.write_date IS 'Last Updated on';


--
-- Name: base_module_upgrade_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.base_module_upgrade_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_module_upgrade_id_seq OWNER TO odoo;

--
-- Name: base_module_upgrade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.base_module_upgrade_id_seq OWNED BY public.base_module_upgrade.id;


--
-- Name: base_partner_merge_automatic_wizard; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.base_partner_merge_automatic_wizard (
    id integer NOT NULL,
    number_group integer,
    current_line_id integer,
    dst_partner_id integer,
    maximum_group integer,
    create_uid integer,
    write_uid integer,
    state character varying NOT NULL,
    group_by_email boolean,
    group_by_name boolean,
    group_by_is_company boolean,
    group_by_vat boolean,
    group_by_parent_id boolean,
    exclude_contact boolean,
    exclude_journal_item boolean,
    create_date timestamp without time zone,
    write_date timestamp without time zone
);


ALTER TABLE public.base_partner_merge_automatic_wizard OWNER TO odoo;

--
-- Name: TABLE base_partner_merge_automatic_wizard; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.base_partner_merge_automatic_wizard IS 'Merge Partner Wizard';


--
-- Name: COLUMN base_partner_merge_automatic_wizard.number_group; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_automatic_wizard.number_group IS 'Group of Contacts';


--
-- Name: COLUMN base_partner_merge_automatic_wizard.current_line_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_automatic_wizard.current_line_id IS 'Current Line';


--
-- Name: COLUMN base_partner_merge_automatic_wizard.dst_partner_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_automatic_wizard.dst_partner_id IS 'Destination Contact';


--
-- Name: COLUMN base_partner_merge_automatic_wizard.maximum_group; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_automatic_wizard.maximum_group IS 'Maximum of Group of Contacts';


--
-- Name: COLUMN base_partner_merge_automatic_wizard.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_automatic_wizard.create_uid IS 'Created by';


--
-- Name: COLUMN base_partner_merge_automatic_wizard.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_automatic_wizard.write_uid IS 'Last Updated by';


--
-- Name: COLUMN base_partner_merge_automatic_wizard.state; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_automatic_wizard.state IS 'State';


--
-- Name: COLUMN base_partner_merge_automatic_wizard.group_by_email; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_automatic_wizard.group_by_email IS 'Email';


--
-- Name: COLUMN base_partner_merge_automatic_wizard.group_by_name; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_automatic_wizard.group_by_name IS 'Name';


--
-- Name: COLUMN base_partner_merge_automatic_wizard.group_by_is_company; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_automatic_wizard.group_by_is_company IS 'Is Company';


--
-- Name: COLUMN base_partner_merge_automatic_wizard.group_by_vat; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_automatic_wizard.group_by_vat IS 'VAT';


--
-- Name: COLUMN base_partner_merge_automatic_wizard.group_by_parent_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_automatic_wizard.group_by_parent_id IS 'Parent Company';


--
-- Name: COLUMN base_partner_merge_automatic_wizard.exclude_contact; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_automatic_wizard.exclude_contact IS 'A user associated to the contact';


--
-- Name: COLUMN base_partner_merge_automatic_wizard.exclude_journal_item; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_automatic_wizard.exclude_journal_item IS 'Journal Items associated to the contact';


--
-- Name: COLUMN base_partner_merge_automatic_wizard.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_automatic_wizard.create_date IS 'Created on';


--
-- Name: COLUMN base_partner_merge_automatic_wizard.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_automatic_wizard.write_date IS 'Last Updated on';


--
-- Name: base_partner_merge_automatic_wizard_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.base_partner_merge_automatic_wizard_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_partner_merge_automatic_wizard_id_seq OWNER TO odoo;

--
-- Name: base_partner_merge_automatic_wizard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.base_partner_merge_automatic_wizard_id_seq OWNED BY public.base_partner_merge_automatic_wizard.id;


--
-- Name: base_partner_merge_automatic_wizard_res_partner_rel; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.base_partner_merge_automatic_wizard_res_partner_rel (
    base_partner_merge_automatic_wizard_id integer NOT NULL,
    res_partner_id integer NOT NULL
);


ALTER TABLE public.base_partner_merge_automatic_wizard_res_partner_rel OWNER TO odoo;

--
-- Name: TABLE base_partner_merge_automatic_wizard_res_partner_rel; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.base_partner_merge_automatic_wizard_res_partner_rel IS 'RELATION BETWEEN base_partner_merge_automatic_wizard AND res_partner';


--
-- Name: base_partner_merge_line; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.base_partner_merge_line (
    id integer NOT NULL,
    wizard_id integer,
    min_id integer,
    create_uid integer,
    write_uid integer,
    aggr_ids character varying NOT NULL,
    create_date timestamp without time zone,
    write_date timestamp without time zone
);


ALTER TABLE public.base_partner_merge_line OWNER TO odoo;

--
-- Name: TABLE base_partner_merge_line; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.base_partner_merge_line IS 'Merge Partner Line';


--
-- Name: COLUMN base_partner_merge_line.wizard_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_line.wizard_id IS 'Wizard';


--
-- Name: COLUMN base_partner_merge_line.min_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_line.min_id IS 'MinID';


--
-- Name: COLUMN base_partner_merge_line.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_line.create_uid IS 'Created by';


--
-- Name: COLUMN base_partner_merge_line.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_line.write_uid IS 'Last Updated by';


--
-- Name: COLUMN base_partner_merge_line.aggr_ids; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_line.aggr_ids IS 'Ids';


--
-- Name: COLUMN base_partner_merge_line.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_line.create_date IS 'Created on';


--
-- Name: COLUMN base_partner_merge_line.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.base_partner_merge_line.write_date IS 'Last Updated on';


--
-- Name: base_partner_merge_line_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.base_partner_merge_line_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.base_partner_merge_line_id_seq OWNER TO odoo;

--
-- Name: base_partner_merge_line_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.base_partner_merge_line_id_seq OWNED BY public.base_partner_merge_line.id;


--
-- Name: bus_bus; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.bus_bus (
    id integer NOT NULL,
    create_uid integer,
    write_uid integer,
    channel character varying,
    message character varying,
    create_date timestamp without time zone,
    write_date timestamp without time zone
);


ALTER TABLE public.bus_bus OWNER TO odoo;

--
-- Name: TABLE bus_bus; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.bus_bus IS 'Communication Bus';


--
-- Name: COLUMN bus_bus.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.bus_bus.create_uid IS 'Created by';


--
-- Name: COLUMN bus_bus.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.bus_bus.write_uid IS 'Last Updated by';


--
-- Name: COLUMN bus_bus.channel; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.bus_bus.channel IS 'Channel';


--
-- Name: COLUMN bus_bus.message; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.bus_bus.message IS 'Message';


--
-- Name: COLUMN bus_bus.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.bus_bus.create_date IS 'Created on';


--
-- Name: COLUMN bus_bus.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.bus_bus.write_date IS 'Last Updated on';


--
-- Name: bus_bus_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.bus_bus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bus_bus_id_seq OWNER TO odoo;

--
-- Name: bus_bus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.bus_bus_id_seq OWNED BY public.bus_bus.id;


--
-- Name: change_password_own; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.change_password_own (
    id integer NOT NULL,
    create_uid integer,
    write_uid integer,
    new_password character varying,
    confirm_password character varying,
    create_date timestamp without time zone,
    write_date timestamp without time zone
);


ALTER TABLE public.change_password_own OWNER TO odoo;

--
-- Name: TABLE change_password_own; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.change_password_own IS 'User, change own password wizard';


--
-- Name: COLUMN change_password_own.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.change_password_own.create_uid IS 'Created by';


--
-- Name: COLUMN change_password_own.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.change_password_own.write_uid IS 'Last Updated by';


--
-- Name: COLUMN change_password_own.new_password; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.change_password_own.new_password IS 'New Password';


--
-- Name: COLUMN change_password_own.confirm_password; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.change_password_own.confirm_password IS 'New Password (Confirmation)';


--
-- Name: COLUMN change_password_own.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.change_password_own.create_date IS 'Created on';


--
-- Name: COLUMN change_password_own.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.change_password_own.write_date IS 'Last Updated on';


--
-- Name: change_password_own_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.change_password_own_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.change_password_own_id_seq OWNER TO odoo;

--
-- Name: change_password_own_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.change_password_own_id_seq OWNED BY public.change_password_own.id;


--
-- Name: change_password_user; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.change_password_user (
    id integer NOT NULL,
    wizard_id integer NOT NULL,
    user_id integer NOT NULL,
    create_uid integer,
    write_uid integer,
    user_login character varying,
    new_passwd character varying,
    create_date timestamp without time zone,
    write_date timestamp without time zone
);


ALTER TABLE public.change_password_user OWNER TO odoo;

--
-- Name: TABLE change_password_user; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.change_password_user IS 'User, Change Password Wizard';


--
-- Name: COLUMN change_password_user.wizard_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.change_password_user.wizard_id IS 'Wizard';


--
-- Name: COLUMN change_password_user.user_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.change_password_user.user_id IS 'User';


--
-- Name: COLUMN change_password_user.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.change_password_user.create_uid IS 'Created by';


--
-- Name: COLUMN change_password_user.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.change_password_user.write_uid IS 'Last Updated by';


--
-- Name: COLUMN change_password_user.user_login; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.change_password_user.user_login IS 'User Login';


--
-- Name: COLUMN change_password_user.new_passwd; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.change_password_user.new_passwd IS 'New Password';


--
-- Name: COLUMN change_password_user.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.change_password_user.create_date IS 'Created on';


--
-- Name: COLUMN change_password_user.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.change_password_user.write_date IS 'Last Updated on';


--
-- Name: change_password_user_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.change_password_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.change_password_user_id_seq OWNER TO odoo;

--
-- Name: change_password_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.change_password_user_id_seq OWNED BY public.change_password_user.id;


--
-- Name: change_password_wizard; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.change_password_wizard (
    id integer NOT NULL,
    create_uid integer,
    write_uid integer,
    create_date timestamp without time zone,
    write_date timestamp without time zone
);


ALTER TABLE public.change_password_wizard OWNER TO odoo;

--
-- Name: TABLE change_password_wizard; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.change_password_wizard IS 'Change Password Wizard';


--
-- Name: COLUMN change_password_wizard.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.change_password_wizard.create_uid IS 'Created by';


--
-- Name: COLUMN change_password_wizard.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.change_password_wizard.write_uid IS 'Last Updated by';


--
-- Name: COLUMN change_password_wizard.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.change_password_wizard.create_date IS 'Created on';


--
-- Name: COLUMN change_password_wizard.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.change_password_wizard.write_date IS 'Last Updated on';


--
-- Name: change_password_wizard_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.change_password_wizard_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.change_password_wizard_id_seq OWNER TO odoo;

--
-- Name: change_password_wizard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.change_password_wizard_id_seq OWNED BY public.change_password_wizard.id;


--
-- Name: decimal_precision; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.decimal_precision (
    id integer NOT NULL,
    digits integer NOT NULL,
    create_uid integer,
    write_uid integer,
    name character varying NOT NULL,
    create_date timestamp without time zone,
    write_date timestamp without time zone
);


ALTER TABLE public.decimal_precision OWNER TO odoo;

--
-- Name: TABLE decimal_precision; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.decimal_precision IS 'Decimal Precision';


--
-- Name: COLUMN decimal_precision.digits; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.decimal_precision.digits IS 'Digits';


--
-- Name: COLUMN decimal_precision.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.decimal_precision.create_uid IS 'Created by';


--
-- Name: COLUMN decimal_precision.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.decimal_precision.write_uid IS 'Last Updated by';


--
-- Name: COLUMN decimal_precision.name; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.decimal_precision.name IS 'Usage';


--
-- Name: COLUMN decimal_precision.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.decimal_precision.create_date IS 'Created on';


--
-- Name: COLUMN decimal_precision.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.decimal_precision.write_date IS 'Last Updated on';


--
-- Name: decimal_precision_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.decimal_precision_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.decimal_precision_id_seq OWNER TO odoo;

--
-- Name: decimal_precision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.decimal_precision_id_seq OWNED BY public.decimal_precision.id;


--
-- Name: dronify_dron; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.dronify_dron (
    id integer NOT NULL,
    bateria integer,
    create_uid integer,
    write_uid integer,
    name character varying NOT NULL,
    estado character varying,
    create_date timestamp without time zone,
    write_date timestamp without time zone,
    capacidad_max double precision NOT NULL
);


ALTER TABLE public.dronify_dron OWNER TO odoo;

--
-- Name: TABLE dronify_dron; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.dronify_dron IS 'Gestión de drones';


--
-- Name: COLUMN dronify_dron.bateria; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.dronify_dron.bateria IS 'Nivel de batería (%)';


--
-- Name: COLUMN dronify_dron.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.dronify_dron.create_uid IS 'Created by';


--
-- Name: COLUMN dronify_dron.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.dronify_dron.write_uid IS 'Last Updated by';


--
-- Name: COLUMN dronify_dron.name; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.dronify_dron.name IS 'Nombre del dron';


--
-- Name: COLUMN dronify_dron.estado; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.dronify_dron.estado IS 'Estado';


--
-- Name: COLUMN dronify_dron.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.dronify_dron.create_date IS 'Created on';


--
-- Name: COLUMN dronify_dron.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.dronify_dron.write_date IS 'Last Updated on';


--
-- Name: COLUMN dronify_dron.capacidad_max; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.dronify_dron.capacidad_max IS 'Capacidad máxima (kg)';


--
-- Name: dronify_dron_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.dronify_dron_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dronify_dron_id_seq OWNER TO odoo;

--
-- Name: dronify_dron_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.dronify_dron_id_seq OWNED BY public.dronify_dron.id;


--
-- Name: dronify_paquete; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.dronify_paquete (
    id integer NOT NULL,
    cliente_id integer NOT NULL,
    vuelo_id integer,
    create_uid integer,
    write_uid integer,
    codigo character varying,
    name character varying NOT NULL,
    create_date timestamp without time zone,
    write_date timestamp without time zone,
    peso double precision NOT NULL
);


ALTER TABLE public.dronify_paquete OWNER TO odoo;

--
-- Name: TABLE dronify_paquete; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON TABLE public.dronify_paquete IS 'Paquetes a transportar';


--
-- Name: COLUMN dronify_paquete.cliente_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.dronify_paquete.cliente_id IS 'Cliente';


--
-- Name: COLUMN dronify_paquete.vuelo_id; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.dronify_paquete.vuelo_id IS 'Vuelo asignado';


--
-- Name: COLUMN dronify_paquete.create_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.dronify_paquete.create_uid IS 'Created by';


--
-- Name: COLUMN dronify_paquete.write_uid; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.dronify_paquete.write_uid IS 'Last Updated by';


--
-- Name: COLUMN dronify_paquete.codigo; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.dronify_paquete.codigo IS 'Código';


--
-- Name: COLUMN dronify_paquete.name; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.dronify_paquete.name IS 'Descripción';


--
-- Name: COLUMN dronify_paquete.create_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.dronify_paquete.create_date IS 'Created on';


--
-- Name: COLUMN dronify_paquete.write_date; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.dronify_paquete.write_date IS 'Last Updated on';


--
-- Name: COLUMN dronify_paquete.peso; Type: COMMENT; Schema: public; Owner: odoo
--

COMMENT ON COLUMN public.dronify_paquete.peso IS 'Peso (kg)';


--
-- Name: dronify_paquete_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.dronify_paquete_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dronify_paquete_id_seq OWNER TO odoo;

--
-- Name: dronify_paquete_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.dronify_paquete_id_seq OWNED BY public.dronify_paquete.id;


--
-- Name: orm_signaling_assets; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.orm_signaling_assets (
    id integer NOT NULL,
    date timestamp without time zone DEFAULT now()
);


ALTER TABLE public.orm_signaling_assets OWNER TO odoo;

--
-- Name: orm_signaling_assets_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.orm_signaling_assets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orm_signaling_assets_id_seq OWNER TO odoo;

--
-- Name: orm_signaling_assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.orm_signaling_assets_id_seq OWNED BY public.orm_signaling_assets.id;


--
-- Name: orm_signaling_default; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.orm_signaling_default (
    id integer NOT NULL,
    date timestamp without time zone DEFAULT now()
);


ALTER TABLE public.orm_signaling_default OWNER TO odoo;

--
-- Name: orm_signaling_default_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.orm_signaling_default_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orm_signaling_default_id_seq OWNER TO odoo;

--
-- Name: orm_signaling_default_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.orm_signaling_default_id_seq OWNED BY public.orm_signaling_default.id;


--
-- Name: orm_signaling_groups; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.orm_signaling_groups (
    id integer NOT NULL,
    date timestamp without time zone DEFAULT now()
);


ALTER TABLE public.orm_signaling_groups OWNER TO odoo;

--
-- Name: orm_signaling_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.orm_signaling_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orm_signaling_groups_id_seq OWNER TO odoo;

--
-- Name: orm_signaling_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.orm_signaling_groups_id_seq OWNED BY public.orm_signaling_groups.id;


--
-- Name: orm_signaling_registry; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.orm_signaling_registry (
    id integer NOT NULL,
    date timestamp without time zone DEFAULT now()
);


ALTER TABLE public.orm_signaling_registry OWNER TO odoo;

--
-- Name: orm_signaling_registry_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.orm_signaling_registry_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orm_signaling_registry_id_seq OWNER TO odoo;

--
-- Name: orm_signaling_registry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.orm_signaling_registry_id_seq OWNED BY public.orm_signaling_registry.id;


--
-- Name: orm_signaling_routing; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.orm_signaling_routing (
    id integer NOT NULL,
    date timestamp without time zone DEFAULT now()
);


ALTER TABLE public.orm_signaling_routing OWNER TO odoo;

--
-- Name: orm_signaling_routing_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.orm_signaling_routing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orm_signaling_routing_id_seq OWNER TO odoo;

--
-- Name: orm_signaling_routing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.orm_signaling_routing_id_seq OWNED BY public.orm_signaling_routing.id;


--
-- Name: orm_signaling_stable; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.orm_signaling_stable (
    id integer NOT NULL,
    date timestamp without time zone DEFAULT now()
);


ALTER TABLE public.orm_signaling_stable OWNER TO odoo;

--
-- Name: orm_signaling_stable_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.orm_signaling_stable_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orm_signaling_stable_id_seq OWNER TO odoo;

--
-- Name: orm_signaling_stable_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.orm_signaling_stable_id_seq OWNED BY public.orm_signaling_stable.id;


--
-- Name: orm_signaling_templates; Type: TABLE; Schema: public; Owner: odoo
--

CREATE TABLE public.orm_signaling_templates (
    id integer NOT NULL,
    date timestamp without time zone DEFAULT now()
);


ALTER TABLE public.orm_signaling_templates OWNER TO odoo;

--
-- Name: orm_signaling_templates_id_seq; Type: SEQUENCE; Schema: public; Owner: odoo
--

CREATE SEQUENCE public.orm_signaling_templates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orm_signaling_templates_id_seq OWNER TO odoo;

--
-- Name: orm_signaling_templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: odoo
--

ALTER SEQUENCE public.orm_signaling_templates_id_seq OWNED BY public.orm_signaling_templates.id;


--
-- Name: orm_signaling_assets id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.orm_signaling_assets ALTER COLUMN id SET DEFAULT nextval('public.orm_signaling_assets_id_seq'::regclass);


--
-- Name: orm_signaling_default id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.orm_signaling_default ALTER COLUMN id SET DEFAULT nextval('public.orm_signaling_default_id_seq'::regclass);


--
-- Name: orm_signaling_groups id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.orm_signaling_groups ALTER COLUMN id SET DEFAULT nextval('public.orm_signaling_groups_id_seq'::regclass);


--
-- Name: orm_signaling_registry id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.orm_signaling_registry ALTER COLUMN id SET DEFAULT nextval('public.orm_signaling_registry_id_seq'::regclass);


--
-- Name: orm_signaling_routing id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.orm_signaling_routing ALTER COLUMN id SET DEFAULT nextval('public.orm_signaling_routing_id_seq'::regclass);


--
-- Name: orm_signaling_stable id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.orm_signaling_stable ALTER COLUMN id SET DEFAULT nextval('public.orm_signaling_stable_id_seq'::regclass);


--
-- Name: orm_signaling_templates id; Type: DEFAULT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.orm_signaling_templates ALTER COLUMN id SET DEFAULT nextval('public.orm_signaling_templates_id_seq'::regclass);


--
-- Data for Name: auth_passkey_key; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.auth_passkey_key (id, sign_count, create_uid, write_uid, name, credential_identifier, create_date, write_date, public_key) FROM stdin;
\.


--
-- Data for Name: auth_passkey_key_create; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.auth_passkey_key_create (id, create_uid, write_uid, name, create_date, write_date) FROM stdin;
\.


--
-- Data for Name: auth_totp_device; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.auth_totp_device (id, name, user_id, scope, expiration_date, index, key, create_date) FROM stdin;
\.


--
-- Data for Name: auth_totp_rate_limit_log; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.auth_totp_rate_limit_log (id, user_id, create_uid, write_uid, ip, limit_type, create_date, write_date) FROM stdin;
\.


--
-- Data for Name: auth_totp_wizard; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.auth_totp_wizard (id, user_id, create_uid, write_uid, secret, url, create_date, write_date, qrcode) FROM stdin;
\.


--
-- Data for Name: base_document_layout; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.base_document_layout (id, company_id, report_layout_id, create_uid, write_uid, create_date, write_date) FROM stdin;
\.


--
-- Data for Name: base_enable_profiling_wizard; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.base_enable_profiling_wizard (id, create_uid, write_uid, duration, expiration, create_date, write_date) FROM stdin;
\.


--
-- Data for Name: base_import_import; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.base_import_import (id, create_uid, write_uid, res_model, file_name, file_type, create_date, write_date, file) FROM stdin;
\.


--
-- Data for Name: base_import_mapping; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.base_import_mapping (id, create_uid, write_uid, res_model, column_name, field_name, create_date, write_date) FROM stdin;
\.


--
-- Data for Name: base_import_module; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.base_import_module (id, create_uid, write_uid, state, import_message, modules_dependencies, force, with_demo, create_date, write_date, module_file) FROM stdin;
\.


--
-- Data for Name: base_language_export; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.base_language_export (id, model_id, create_uid, write_uid, name, lang, format, export_type, domain, state, create_date, write_date, data) FROM stdin;
\.


--
-- Data for Name: base_language_import; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.base_language_import (id, create_uid, write_uid, name, code, filename, overwrite, create_date, write_date, data) FROM stdin;
\.


--
-- Data for Name: base_language_install; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.base_language_install (id, create_uid, write_uid, overwrite, create_date, write_date) FROM stdin;
\.


--
-- Data for Name: base_module_uninstall; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.base_module_uninstall (id, create_uid, write_uid, show_all, create_date, write_date) FROM stdin;
\.


--
-- Data for Name: base_module_uninstall_ir_module_module_rel; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.base_module_uninstall_ir_module_module_rel (base_module_uninstall_id, ir_module_module_id) FROM stdin;
\.


--
-- Data for Name: base_module_update; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.base_module_update (id, updated, added, create_uid, write_uid, state, create_date, write_date) FROM stdin;
\.


--
-- Data for Name: base_module_upgrade; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.base_module_upgrade (id, create_uid, write_uid, module_info, create_date, write_date) FROM stdin;
\.


--
-- Data for Name: base_partner_merge_automatic_wizard; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.base_partner_merge_automatic_wizard (id, number_group, current_line_id, dst_partner_id, maximum_group, create_uid, write_uid, state, group_by_email, group_by_name, group_by_is_company, group_by_vat, group_by_parent_id, exclude_contact, exclude_journal_item, create_date, write_date) FROM stdin;
\.


--
-- Data for Name: base_partner_merge_automatic_wizard_res_partner_rel; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.base_partner_merge_automatic_wizard_res_partner_rel (base_partner_merge_automatic_wizard_id, res_partner_id) FROM stdin;
\.


--
-- Data for Name: base_partner_merge_line; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.base_partner_merge_line (id, wizard_id, min_id, create_uid, write_uid, aggr_ids, create_date, write_date) FROM stdin;
\.


--
-- Data for Name: bus_bus; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.bus_bus (id, create_uid, write_uid, channel, message, create_date, write_date) FROM stdin;
\.


--
-- Data for Name: change_password_own; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.change_password_own (id, create_uid, write_uid, new_password, confirm_password, create_date, write_date) FROM stdin;
\.


--
-- Data for Name: change_password_user; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.change_password_user (id, wizard_id, user_id, create_uid, write_uid, user_login, new_passwd, create_date, write_date) FROM stdin;
\.


--
-- Data for Name: change_password_wizard; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.change_password_wizard (id, create_uid, write_uid, create_date, write_date) FROM stdin;
\.


--
-- Data for Name: decimal_precision; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.decimal_precision (id, digits, create_uid, write_uid, name, create_date, write_date) FROM stdin;
\.


--
-- Data for Name: dronify_dron; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.dronify_dron (id, bateria, create_uid, write_uid, name, estado, create_date, write_date, capacidad_max) FROM stdin;
\.


--
-- Data for Name: dronify_paquete; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.dronify_paquete (id, cliente_id, vuelo_id, create_uid, write_uid, codigo, name, create_date, write_date, peso) FROM stdin;
\.


--
-- Data for Name: orm_signaling_assets; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.orm_signaling_assets (id, date) FROM stdin;
1	2026-06-08 06:51:30.922146
\.


--
-- Data for Name: orm_signaling_default; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.orm_signaling_default (id, date) FROM stdin;
1	2026-06-08 06:51:30.922146
\.


--
-- Data for Name: orm_signaling_groups; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.orm_signaling_groups (id, date) FROM stdin;
1	2026-06-08 06:51:30.922146
\.


--
-- Data for Name: orm_signaling_registry; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.orm_signaling_registry (id, date) FROM stdin;
1	2026-06-08 06:51:30.922146
\.


--
-- Data for Name: orm_signaling_routing; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.orm_signaling_routing (id, date) FROM stdin;
1	2026-06-08 06:51:30.922146
\.


--
-- Data for Name: orm_signaling_stable; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.orm_signaling_stable (id, date) FROM stdin;
1	2026-06-08 06:51:30.922146
\.


--
-- Data for Name: orm_signaling_templates; Type: TABLE DATA; Schema: public; Owner: odoo
--

COPY public.orm_signaling_templates (id, date) FROM stdin;
1	2026-06-08 06:51:30.922146
\.


--
-- Name: auth_passkey_key_create_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.auth_passkey_key_create_id_seq', 1, false);


--
-- Name: auth_passkey_key_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.auth_passkey_key_id_seq', 1, false);


--
-- Name: auth_totp_device_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.auth_totp_device_id_seq', 1, false);


--
-- Name: auth_totp_rate_limit_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.auth_totp_rate_limit_log_id_seq', 1, false);


--
-- Name: auth_totp_wizard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.auth_totp_wizard_id_seq', 1, false);


--
-- Name: base_document_layout_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.base_document_layout_id_seq', 1, false);


--
-- Name: base_enable_profiling_wizard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.base_enable_profiling_wizard_id_seq', 1, false);


--
-- Name: base_import_import_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.base_import_import_id_seq', 1, false);


--
-- Name: base_import_mapping_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.base_import_mapping_id_seq', 1, false);


--
-- Name: base_import_module_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.base_import_module_id_seq', 1, false);


--
-- Name: base_language_export_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.base_language_export_id_seq', 1, false);


--
-- Name: base_language_import_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.base_language_import_id_seq', 1, false);


--
-- Name: base_language_install_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.base_language_install_id_seq', 1, false);


--
-- Name: base_module_uninstall_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.base_module_uninstall_id_seq', 1, false);


--
-- Name: base_module_update_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.base_module_update_id_seq', 1, false);


--
-- Name: base_module_upgrade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.base_module_upgrade_id_seq', 1, false);


--
-- Name: base_partner_merge_automatic_wizard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.base_partner_merge_automatic_wizard_id_seq', 1, false);


--
-- Name: base_partner_merge_line_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.base_partner_merge_line_id_seq', 1, false);


--
-- Name: bus_bus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.bus_bus_id_seq', 1, false);


--
-- Name: change_password_own_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.change_password_own_id_seq', 1, false);


--
-- Name: change_password_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.change_password_user_id_seq', 1, false);


--
-- Name: change_password_wizard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.change_password_wizard_id_seq', 1, false);


--
-- Name: decimal_precision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.decimal_precision_id_seq', 1, false);


--
-- Name: dronify_dron_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.dronify_dron_id_seq', 1, false);


--
-- Name: dronify_paquete_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.dronify_paquete_id_seq', 1, false);


--
-- Name: orm_signaling_assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.orm_signaling_assets_id_seq', 1, true);


--
-- Name: orm_signaling_default_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.orm_signaling_default_id_seq', 1, true);


--
-- Name: orm_signaling_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.orm_signaling_groups_id_seq', 1, true);


--
-- Name: orm_signaling_registry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.orm_signaling_registry_id_seq', 1, true);


--
-- Name: orm_signaling_routing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.orm_signaling_routing_id_seq', 1, true);


--
-- Name: orm_signaling_stable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.orm_signaling_stable_id_seq', 1, true);


--
-- Name: orm_signaling_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: odoo
--

SELECT pg_catalog.setval('public.orm_signaling_templates_id_seq', 1, true);


--
-- Name: orm_signaling_assets orm_signaling_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.orm_signaling_assets
    ADD CONSTRAINT orm_signaling_assets_pkey PRIMARY KEY (id);


--
-- Name: orm_signaling_default orm_signaling_default_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.orm_signaling_default
    ADD CONSTRAINT orm_signaling_default_pkey PRIMARY KEY (id);


--
-- Name: orm_signaling_groups orm_signaling_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.orm_signaling_groups
    ADD CONSTRAINT orm_signaling_groups_pkey PRIMARY KEY (id);


--
-- Name: orm_signaling_registry orm_signaling_registry_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.orm_signaling_registry
    ADD CONSTRAINT orm_signaling_registry_pkey PRIMARY KEY (id);


--
-- Name: orm_signaling_routing orm_signaling_routing_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.orm_signaling_routing
    ADD CONSTRAINT orm_signaling_routing_pkey PRIMARY KEY (id);


--
-- Name: orm_signaling_stable orm_signaling_stable_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.orm_signaling_stable
    ADD CONSTRAINT orm_signaling_stable_pkey PRIMARY KEY (id);


--
-- Name: orm_signaling_templates orm_signaling_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: odoo
--

ALTER TABLE ONLY public.orm_signaling_templates
    ADD CONSTRAINT orm_signaling_templates_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

\unrestrict mlRS85kzcXMrkyUtDFvLwTkOeDG4iPBc7STHmLmVB68MUUxc9ecUofLDeggZxmX

