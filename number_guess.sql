--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE guesses;
--
-- Name: guesses; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE guesses WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE guesses OWNER TO freecodecamp;

\connect guesses

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
-- Name: guesses; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.guesses (
    id integer NOT NULL,
    name character varying(22) NOT NULL,
    best_game integer DEFAULT 0,
    games_played integer DEFAULT 0
);


ALTER TABLE public.guesses OWNER TO freecodecamp;

--
-- Name: guesses_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.guesses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guesses_id_seq OWNER TO freecodecamp;

--
-- Name: guesses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.guesses_id_seq OWNED BY public.guesses.id;


--
-- Name: guesses id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.guesses ALTER COLUMN id SET DEFAULT nextval('public.guesses_id_seq'::regclass);


--
-- Data for Name: guesses; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.guesses VALUES (10, 'user_1734433356530', 472, 2);
INSERT INTO public.guesses VALUES (9, 'user_1734433356531', 58, 5);
INSERT INTO public.guesses VALUES (27, 'user_1734433618596', 140, 2);
INSERT INTO public.guesses VALUES (12, 'user_1734433405810', 150, 2);
INSERT INTO public.guesses VALUES (26, 'user_1734433618597', 13, 5);
INSERT INTO public.guesses VALUES (11, 'user_1734433405811', 97, 5);
INSERT INTO public.guesses VALUES (15, 'user_1734433470683', 181, 2);
INSERT INTO public.guesses VALUES (14, 'user_1734433470684', 159, 5);
INSERT INTO public.guesses VALUES (29, 'user_1734433626473', 188, 2);
INSERT INTO public.guesses VALUES (17, 'user_1734433512050', 694, 2);
INSERT INTO public.guesses VALUES (28, 'user_1734433626474', 29, 5);
INSERT INTO public.guesses VALUES (30, 'user_1734433657112', 0, 0);
INSERT INTO public.guesses VALUES (16, 'user_1734433512051', 207, 5);
INSERT INTO public.guesses VALUES (31, 'user_1734433657111', 0, 0);
INSERT INTO public.guesses VALUES (32, 'user_1734433659118', 0, 0);
INSERT INTO public.guesses VALUES (33, 'user_1734433659117', 0, 0);
INSERT INTO public.guesses VALUES (19, 'user_1734433523294', 222, 2);
INSERT INTO public.guesses VALUES (34, 'user_1734433678127', 0, 0);
INSERT INTO public.guesses VALUES (35, 'user_1734433678126', 0, 0);
INSERT INTO public.guesses VALUES (18, 'user_1734433523295', 148, 5);
INSERT INTO public.guesses VALUES (36, 'user_1734433707301', 0, 0);
INSERT INTO public.guesses VALUES (37, 'user_1734433707300', 0, 0);
INSERT INTO public.guesses VALUES (38, 'user_1734433720843', 0, 0);
INSERT INTO public.guesses VALUES (21, 'user_1734433531861', 364, 2);
INSERT INTO public.guesses VALUES (39, 'user_1734433720842', 0, 0);
INSERT INTO public.guesses VALUES (40, 'user_1734433745881', 0, 0);
INSERT INTO public.guesses VALUES (20, 'user_1734433531862', 534, 5);
INSERT INTO public.guesses VALUES (41, 'user_1734433745880', 0, 0);
INSERT INTO public.guesses VALUES (42, 'user_1734433804369', 0, 0);
INSERT INTO public.guesses VALUES (43, 'user_1734433804368', 0, 0);
INSERT INTO public.guesses VALUES (23, 'user_1734433538775', 566, 2);
INSERT INTO public.guesses VALUES (13, 'new', 10, 3);
INSERT INTO public.guesses VALUES (22, 'user_1734433538776', 92, 5);
INSERT INTO public.guesses VALUES (25, 'user_1734433558037', 450, 2);
INSERT INTO public.guesses VALUES (45, 'user_1734433852754', 47, 2);
INSERT INTO public.guesses VALUES (24, 'user_1734433558038', 52, 5);
INSERT INTO public.guesses VALUES (44, 'user_1734433852755', 26, 5);
INSERT INTO public.guesses VALUES (47, 'user_1734434021588', 217, 2);
INSERT INTO public.guesses VALUES (46, 'user_1734434021589', 405, 5);
INSERT INTO public.guesses VALUES (49, 'user_1734434044355', 376, 2);
INSERT INTO public.guesses VALUES (48, 'user_1734434044356', 447, 5);
INSERT INTO public.guesses VALUES (52, 'user_1734434103395', 800, 2);
INSERT INTO public.guesses VALUES (53, 'user_1734434104789', 122, 2);
INSERT INTO public.guesses VALUES (50, 'user_1734434103396', 71, 5);
INSERT INTO public.guesses VALUES (51, 'user_1734434104790', 187, 5);


--
-- Name: guesses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.guesses_id_seq', 53, true);


--
-- Name: guesses guesses_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.guesses
    ADD CONSTRAINT guesses_name_key UNIQUE (name);


--
-- Name: guesses guesses_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.guesses
    ADD CONSTRAINT guesses_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

