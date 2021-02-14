--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cardholder; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cardholder (
    customer_id integer NOT NULL,
    customer_name character varying(75)
);


ALTER TABLE public.cardholder OWNER TO postgres;

--
-- Name: cardholder_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cardholder_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cardholder_customer_id_seq OWNER TO postgres;

--
-- Name: cardholder_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cardholder_customer_id_seq OWNED BY public.cardholder.customer_id;


--
-- Name: credit_card; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credit_card (
    credit_card_id integer NOT NULL,
    customer_id integer,
    credit_card_num character varying(20)
);


ALTER TABLE public.credit_card OWNER TO postgres;

--
-- Name: credit_card_credit_card_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.credit_card_credit_card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.credit_card_credit_card_id_seq OWNER TO postgres;

--
-- Name: credit_card_credit_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.credit_card_credit_card_id_seq OWNED BY public.credit_card.credit_card_id;


--
-- Name: merchant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.merchant (
    merchant_id integer NOT NULL,
    merchant_name character varying(100),
    merchant_cat integer
);


ALTER TABLE public.merchant OWNER TO postgres;

--
-- Name: merchant_category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.merchant_category (
    merchant_cat_id integer NOT NULL,
    merchant_industry character varying(50)
);


ALTER TABLE public.merchant_category OWNER TO postgres;

--
-- Name: merchant_category_merchant_cat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.merchant_category_merchant_cat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.merchant_category_merchant_cat_id_seq OWNER TO postgres;

--
-- Name: merchant_category_merchant_cat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.merchant_category_merchant_cat_id_seq OWNED BY public.merchant_category.merchant_cat_id;


--
-- Name: merchant_merchant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.merchant_merchant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.merchant_merchant_id_seq OWNER TO postgres;

--
-- Name: merchant_merchant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.merchant_merchant_id_seq OWNED BY public.merchant.merchant_id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    transaction_id integer NOT NULL,
    date timestamp without time zone,
    amount double precision,
    card character varying(20),
    merchant_id integer
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: top_100_trans_7_9; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.top_100_trans_7_9 AS
 SELECT transactions.transaction_id,
    transactions.date,
    transactions.amount,
    transactions.card
   FROM public.transactions
  WHERE (((transactions.date)::time without time zone >= '07:00:00'::time without time zone) AND ((transactions.date)::time without time zone <= '09:00:00'::time without time zone))
  ORDER BY transactions.amount DESC
 LIMIT 100;


ALTER TABLE public.top_100_trans_7_9 OWNER TO postgres;

--
-- Name: top_5_merchants_hacked; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.top_5_merchants_hacked AS
 SELECT a.merchant_id,
    a.merchant_name,
    count(
        CASE (b.amount <= (2.00)::double precision)
            WHEN true THEN 1
            ELSE 0
        END) AS two_dollar_trans
   FROM ((public.merchant a
     LEFT JOIN public.merchant_category c ON ((a.merchant_cat = c.merchant_cat_id)))
     LEFT JOIN public.transactions b ON ((a.merchant_id = b.merchant_id)))
  GROUP BY a.merchant_id, a.merchant_name
  ORDER BY (count(
        CASE (b.amount <= (2.00)::double precision)
            WHEN true THEN 1
            ELSE 0
        END)) DESC
 LIMIT 5;


ALTER TABLE public.top_5_merchants_hacked OWNER TO postgres;

--
-- Name: transactions_grouped_by_id; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.transactions_grouped_by_id AS
SELECT
    NULL::integer AS customer_id,
    NULL::character varying(75) AS customer_name,
    NULL::character varying(20) AS credit_card_num,
    NULL::integer AS transaction_id,
    NULL::double precision AS amount;


ALTER TABLE public.transactions_grouped_by_id OWNER TO postgres;

--
-- Name: two_dollar_trans_per_cardholder; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.two_dollar_trans_per_cardholder AS
 SELECT a.customer_id,
    a.customer_name,
    b.credit_card_num,
    count(
        CASE (c.amount <= (2.00)::double precision)
            WHEN true THEN 1
            ELSE 0
        END) AS two_dollar_trans
   FROM ((public.cardholder a
     LEFT JOIN public.credit_card b ON ((a.customer_id = b.customer_id)))
     LEFT JOIN public.transactions c ON (((b.credit_card_num)::text = (c.card)::text)))
  GROUP BY a.customer_id, a.customer_name, b.credit_card_num;


ALTER TABLE public.two_dollar_trans_per_cardholder OWNER TO postgres;

--
-- Name: cardholder customer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cardholder ALTER COLUMN customer_id SET DEFAULT nextval('public.cardholder_customer_id_seq'::regclass);


--
-- Name: credit_card credit_card_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_card ALTER COLUMN credit_card_id SET DEFAULT nextval('public.credit_card_credit_card_id_seq'::regclass);


--
-- Name: merchant merchant_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.merchant ALTER COLUMN merchant_id SET DEFAULT nextval('public.merchant_merchant_id_seq'::regclass);


--
-- Name: merchant_category merchant_cat_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.merchant_category ALTER COLUMN merchant_cat_id SET DEFAULT nextval('public.merchant_category_merchant_cat_id_seq'::regclass);


--
-- Name: cardholder cardholder_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cardholder
    ADD CONSTRAINT cardholder_pkey PRIMARY KEY (customer_id);


--
-- Name: credit_card credit_card_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_card
    ADD CONSTRAINT credit_card_pkey PRIMARY KEY (credit_card_id);


--
-- Name: merchant_category merchant_category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.merchant_category
    ADD CONSTRAINT merchant_category_pkey PRIMARY KEY (merchant_cat_id);


--
-- Name: merchant merchant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.merchant
    ADD CONSTRAINT merchant_pkey PRIMARY KEY (merchant_id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (transaction_id);


--
-- Name: transactions_grouped_by_id _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE OR REPLACE VIEW public.transactions_grouped_by_id AS
 SELECT a.customer_id,
    a.customer_name,
    b.credit_card_num,
    c.transaction_id,
    c.amount
   FROM ((public.cardholder a
     LEFT JOIN public.credit_card b ON ((a.customer_id = b.customer_id)))
     LEFT JOIN public.transactions c ON (((b.credit_card_num)::text = (c.card)::text)))
  GROUP BY a.customer_id, b.credit_card_num, c.transaction_id, c.amount;


--
-- Name: credit_card credit_card_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_card
    ADD CONSTRAINT credit_card_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.cardholder(customer_id);


--
-- Name: transactions transactions_merchant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_merchant_id_fkey FOREIGN KEY (merchant_id) REFERENCES public.merchant(merchant_id);


--
-- PostgreSQL database dump complete
--

