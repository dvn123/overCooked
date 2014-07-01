--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: frmk; Type: SCHEMA; Schema: -; Owner: lbaw1315
--
--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: usergroupenum; Type: TYPE; Schema: public; Owner: lbaw1315
--

CREATE TYPE usergroupenum AS ENUM (
    'user',
    'moderator',
    'admin'
);


ALTER TYPE public.usergroupenum OWNER TO lbaw1315;

--
-- Name: update_answer_score(); Type: FUNCTION; Schema: public; Owner: lbaw1315
--

CREATE FUNCTION update_answer_score() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF NEW.updown = 1  AND OLD.updown = -1 THEN
             UPDATE webUser SET score = score+2 WHERE idUser = (SELECT idUser FROM answer WHERE idAnswer = NEW.idAnswer);
             UPDATE answer SET score = score+2 WHERE idAnswer = NEW.idAnswer;
        END IF;
        IF NEW.updown = -1  AND OLD.updown = 1 THEN
             UPDATE webUser SET score = score-2 WHERE idUser = (SELECT idUser FROM answer WHERE idAnswer = NEW.idAnswer);
             UPDATE answer SET score = score-2 WHERE idAnswer = NEW.idAnswer;
        END IF;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.update_answer_score() OWNER TO lbaw1315;

--
-- Name: update_answer_score2(); Type: FUNCTION; Schema: public; Owner: lbaw1315
--

CREATE FUNCTION update_answer_score2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF NEW.updown = 1  THEN
            UPDATE webUser SET score = score+2 WHERE idUser = (SELECT idUser FROM answer WHERE idAnswer = NEW.idAnswer);
        END IF;
        UPDATE answer SET score = score+NEW.updown WHERE idAnswer = NEW.idAnswer;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.update_answer_score2() OWNER TO lbaw1315;

--
-- Name: update_answer_score3(); Type: FUNCTION; Schema: public; Owner: lbaw1315
--

CREATE FUNCTION update_answer_score3() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF OLD.updown = 1 THEN
            UPDATE webUser SET score = score-2 WHERE idUser = (SELECT idUser FROM answer WHERE idAnswer = OLD.idAnswer);
        END IF;
        UPDATE answer SET score = score-OLD.updown WHERE idAnswer = OLD.idAnswer;
        RETURN NULL;
    END;
$$;


ALTER FUNCTION public.update_answer_score3() OWNER TO lbaw1315;

--
-- Name: update_best_answer_score(); Type: FUNCTION; Schema: public; Owner: lbaw1315
--

CREATE FUNCTION update_best_answer_score() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF NOT NEW.bestAnswer AND OLD.bestAnswer THEN
            UPDATE webUSer SET score = score-3 WHERE idUser = NEW.idUser;
           END IF;
           IF NEW.bestAnswer AND NOT OLD.bestAnswer THEN
               UPDATE webUSer SET score = score+3 WHERE idUser = NEW.idUser;
           END IF;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.update_best_answer_score() OWNER TO lbaw1315;

--
-- Name: update_best_answer_score_delete(); Type: FUNCTION; Schema: public; Owner: lbaw1315
--

CREATE FUNCTION update_best_answer_score_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE webUser SET numAnswers = numAnswers-1 WHERE idUser = OLD.idUser;
        IF OLD.bestAnswer THEN
            UPDATE webUSer SET score = score-3 WHERE idUser = OLD.idUser;
        END IF;
        RETURN NULL;
    END;
$$;


ALTER FUNCTION public.update_best_answer_score_delete() OWNER TO lbaw1315;

--
-- Name: update_n_answer_comments(); Type: FUNCTION; Schema: public; Owner: lbaw1315
--

CREATE FUNCTION update_n_answer_comments() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE webUser SET numComments = numComments+1 WHERE idUser = NEW.idUser;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.update_n_answer_comments() OWNER TO lbaw1315;

--
-- Name: update_n_answer_comments_delete(); Type: FUNCTION; Schema: public; Owner: lbaw1315
--

CREATE FUNCTION update_n_answer_comments_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE webUser SET numComments = numComments-1 WHERE idUser = OLD.idUser;
        RETURN NULL;
    END;
$$;


ALTER FUNCTION public.update_n_answer_comments_delete() OWNER TO lbaw1315;

--
-- Name: update_n_answers(); Type: FUNCTION; Schema: public; Owner: lbaw1315
--

CREATE FUNCTION update_n_answers() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE webUser SET numAnswers = numAnswers+1 WHERE idUser = NEW.idUser;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.update_n_answers() OWNER TO lbaw1315;

--
-- Name: update_n_question_comments(); Type: FUNCTION; Schema: public; Owner: lbaw1315
--

CREATE FUNCTION update_n_question_comments() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE webUser SET numComments = numComments+1 WHERE idUser = NEW.idUser;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.update_n_question_comments() OWNER TO lbaw1315;

--
-- Name: update_n_question_comments_delete(); Type: FUNCTION; Schema: public; Owner: lbaw1315
--

CREATE FUNCTION update_n_question_comments_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE webUser SET numComments = numComments-1 WHERE idUser = OLD.idUser;
        RETURN NULL;
    END;
$$;


ALTER FUNCTION public.update_n_question_comments_delete() OWNER TO lbaw1315;

--
-- Name: update_n_questions(); Type: FUNCTION; Schema: public; Owner: lbaw1315
--

CREATE FUNCTION update_n_questions() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE webUser SET numQuestions = numQuestions+1 WHERE idUser = NEW.idUser;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.update_n_questions() OWNER TO lbaw1315;

--
-- Name: update_n_questions_delete(); Type: FUNCTION; Schema: public; Owner: lbaw1315
--

CREATE FUNCTION update_n_questions_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE webUser SET numQuestions = numQuestions-1 WHERE idUser = OLD.idUser;
        RETURN NULL;
    END;
$$;


ALTER FUNCTION public.update_n_questions_delete() OWNER TO lbaw1315;

--
-- Name: update_question_score(); Type: FUNCTION; Schema: public; Owner: lbaw1315
--

CREATE FUNCTION update_question_score() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF NEW.updown = 1 AND OLD.updown = -1 THEN
            UPDATE webUser SET score = score+1 WHERE idUser = (SELECT idUser FROM question WHERE idQuestion = NEW.idQuestion);
            UPDATE question SET score = score+2 WHERE idQuestion= NEW.idQuestion;
        END IF;
        IF NEW.updown = -1 AND OLD.updown = 1 THEN
            UPDATE webUser SET score = score-1 WHERE idUser = (SELECT idUser FROM question WHERE idQuestion = NEW.idQuestion);
            UPDATE question SET score = score-2 WHERE idQuestion= NEW.idQuestion;
        END IF;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.update_question_score() OWNER TO lbaw1315;

--
-- Name: update_question_score2(); Type: FUNCTION; Schema: public; Owner: lbaw1315
--

CREATE FUNCTION update_question_score2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF NEW.updown = 1 THEN
            UPDATE webUser SET score = score+1 WHERE idUser = (SELECT idUser FROM question WHERE idQuestion = NEW.idQuestion);
        END IF;
        UPDATE question SET score = score+NEW.updown WHERE idQuestion= NEW.idQuestion;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.update_question_score2() OWNER TO lbaw1315;

--
-- Name: update_question_score3(); Type: FUNCTION; Schema: public; Owner: lbaw1315
--

CREATE FUNCTION update_question_score3() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF OLD.updown = 1 THEN
            UPDATE webUser SET score = score-OLD.updown WHERE idUser = (SELECT idUser FROM question WHERE idQuestion = OLD.idQuestion);
        END IF;
        UPDATE question SET score = score-OLD.updown WHERE idQuestion= OLD.idQuestion;
        RETURN NULL;
    END;
$$;


ALTER FUNCTION public.update_question_score3() OWNER TO lbaw1315;

SET search_path = frmk, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: follows; Type: TABLE; Schema: frmk; Owner: lbaw1315; Tablespace: 
--

CREATE TABLE follows (
    follower character varying NOT NULL,
    followed character varying NOT NULL
);


ALTER TABLE frmk.follows OWNER TO lbaw1315;

--
-- Name: tweets; Type: TABLE; Schema: frmk; Owner: lbaw1315; Tablespace: 
--

CREATE TABLE tweets (
    id integer NOT NULL,
    "time" timestamp without time zone NOT NULL,
    username character varying NOT NULL,
    text text NOT NULL
);


ALTER TABLE frmk.tweets OWNER TO lbaw1315;

--
-- Name: tweets_id_seq; Type: SEQUENCE; Schema: frmk; Owner: lbaw1315
--

CREATE SEQUENCE tweets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE frmk.tweets_id_seq OWNER TO lbaw1315;

--
-- Name: tweets_id_seq; Type: SEQUENCE OWNED BY; Schema: frmk; Owner: lbaw1315
--

ALTER SEQUENCE tweets_id_seq OWNED BY tweets.id;


--
-- Name: users; Type: TABLE; Schema: frmk; Owner: lbaw1315; Tablespace: 
--

CREATE TABLE users (
    username character varying NOT NULL,
    realname character varying NOT NULL,
    password character varying NOT NULL
);


ALTER TABLE frmk.users OWNER TO lbaw1315;

SET search_path = public, pg_catalog;

--
-- Name: answer; Type: TABLE; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE TABLE answer (
    idanswer integer NOT NULL,
    date timestamp without time zone NOT NULL,
    score integer DEFAULT 0 NOT NULL,
    idquestion integer,
    iduser integer,
    bestanswer boolean DEFAULT false NOT NULL
);


ALTER TABLE public.answer OWNER TO lbaw1315;

--
-- Name: answer_idanswer_seq; Type: SEQUENCE; Schema: public; Owner: lbaw1315
--

CREATE SEQUENCE answer_idanswer_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answer_idanswer_seq OWNER TO lbaw1315;

--
-- Name: answer_idanswer_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lbaw1315
--

ALTER SEQUENCE answer_idanswer_seq OWNED BY answer.idanswer;


--
-- Name: answercontent; Type: TABLE; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE TABLE answercontent (
    idanswer integer NOT NULL,
    iduser integer NOT NULL,
    date timestamp without time zone NOT NULL,
    html text NOT NULL
);


ALTER TABLE public.answercontent OWNER TO lbaw1315;

--
-- Name: answer_vw; Type: VIEW; Schema: public; Owner: lbaw1315
--

CREATE VIEW answer_vw AS
    SELECT answer.idanswer, answer.date, answer.score, answer.idquestion, answer.iduser, answer.bestanswer, answercontent.iduser AS lastuser, answercontent.date AS lastdate, answercontent.html FROM answer, answercontent WHERE ((answer.idanswer = answercontent.idanswer) AND (answercontent.date = (SELECT max(answercontent.date) AS max FROM answercontent WHERE (answercontent.idanswer = answer.idanswer))));


ALTER TABLE public.answer_vw OWNER TO lbaw1315;

--
-- Name: answercomment; Type: TABLE; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE TABLE answercomment (
    idcomment integer NOT NULL,
    iduser integer,
    date timestamp without time zone,
    idanswer integer
);


ALTER TABLE public.answercomment OWNER TO lbaw1315;

--
-- Name: answercomment_idcomment_seq; Type: SEQUENCE; Schema: public; Owner: lbaw1315
--

CREATE SEQUENCE answercomment_idcomment_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.answercomment_idcomment_seq OWNER TO lbaw1315;

--
-- Name: answercomment_idcomment_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lbaw1315
--

ALTER SEQUENCE answercomment_idcomment_seq OWNED BY answercomment.idcomment;


--
-- Name: answercommentcontent; Type: TABLE; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE TABLE answercommentcontent (
    idcomment integer NOT NULL,
    iduser integer NOT NULL,
    date timestamp without time zone NOT NULL,
    content text,
    CONSTRAINT answercommentcontent_content_check CHECK ((char_length(content) <= 200))
);


ALTER TABLE public.answercommentcontent OWNER TO lbaw1315;

--
-- Name: answercomment_vw; Type: VIEW; Schema: public; Owner: lbaw1315
--

CREATE VIEW answercomment_vw AS
    SELECT answercomment.idcomment, answercomment.date, answercomment.idanswer, answercomment.iduser, answercommentcontent.date AS lastdate, answercommentcontent.content FROM answercomment, answercommentcontent WHERE ((answercomment.idcomment = answercommentcontent.idcomment) AND (answercommentcontent.date = (SELECT max(answercommentcontent.date) AS max FROM answercommentcontent WHERE (answercommentcontent.idcomment = answercomment.idcomment))));


ALTER TABLE public.answercomment_vw OWNER TO lbaw1315;

--
-- Name: answervote; Type: TABLE; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE TABLE answervote (
    idanswer integer NOT NULL,
    iduser integer NOT NULL,
    updown integer NOT NULL,
    CONSTRAINT answervote_updown_check CHECK (((updown = (-1)) OR (updown = 1)))
);


ALTER TABLE public.answervote OWNER TO lbaw1315;

--
-- Name: country; Type: TABLE; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE TABLE country (
    idcountry integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.country OWNER TO lbaw1315;

--
-- Name: country_idcountry_seq; Type: SEQUENCE; Schema: public; Owner: lbaw1315
--

CREATE SEQUENCE country_idcountry_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.country_idcountry_seq OWNER TO lbaw1315;

--
-- Name: country_idcountry_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lbaw1315
--

ALTER SEQUENCE country_idcountry_seq OWNED BY country.idcountry;


--
-- Name: question; Type: TABLE; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE TABLE question (
    idquestion integer NOT NULL,
    title text NOT NULL,
    date timestamp without time zone NOT NULL,
    score integer DEFAULT 0 NOT NULL,
    hot integer DEFAULT 0 NOT NULL,
    iduser integer
);


ALTER TABLE public.question OWNER TO lbaw1315;

--
-- Name: question_idquestion_seq; Type: SEQUENCE; Schema: public; Owner: lbaw1315
--

CREATE SEQUENCE question_idquestion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_idquestion_seq OWNER TO lbaw1315;

--
-- Name: question_idquestion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lbaw1315
--

ALTER SEQUENCE question_idquestion_seq OWNED BY question.idquestion;


--
-- Name: webuser; Type: TABLE; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE TABLE webuser (
    iduser integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    salt text NOT NULL,
    imagelink text,
    registrationdate timestamp without time zone NOT NULL,
    about text,
    birthdate timestamp without time zone,
    city text,
    email text NOT NULL,
    gender character(1),
    name text NOT NULL,
    numanswers integer DEFAULT 0 NOT NULL,
    numcomments integer DEFAULT 0 NOT NULL,
    numquestions integer DEFAULT 0 NOT NULL,
    score integer DEFAULT 0 NOT NULL,
    idcountry integer,
    usergroup usergroupenum NOT NULL,
    banned boolean DEFAULT false NOT NULL,
    CONSTRAINT gender_ck CHECK ((gender = ANY (ARRAY['F'::bpchar, 'M'::bpchar]))),
    CONSTRAINT webuser_check CHECK ((((numanswers >= 0) AND (numcomments >= 0)) AND (numquestions >= 0)))
);


ALTER TABLE public.webuser OWNER TO lbaw1315;

--
-- Name: question_list_vw; Type: VIEW; Schema: public; Owner: lbaw1315
--

CREATE VIEW question_list_vw AS
    SELECT question.idquestion, question.title, question.date, question.score, question.iduser, webuser.username, question.hot, (SELECT count(*) AS count FROM answer WHERE (question.idquestion = answer.idquestion)) AS numanswers FROM question, webuser WHERE (question.iduser = webuser.iduser) ORDER BY question.idquestion;


ALTER TABLE public.question_list_vw OWNER TO lbaw1315;

--
-- Name: questioncontent; Type: TABLE; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE TABLE questioncontent (
    iduser integer NOT NULL,
    idquestion integer NOT NULL,
    html text NOT NULL,
    date timestamp without time zone NOT NULL
);


ALTER TABLE public.questioncontent OWNER TO lbaw1315;

--
-- Name: question_vw; Type: VIEW; Schema: public; Owner: lbaw1315
--

CREATE VIEW question_vw AS
    SELECT question.idquestion, question.title, question.date, question.score, question.hot, question.iduser, questioncontent.iduser AS lastuser, questioncontent.date AS lastdate, questioncontent.html FROM question, questioncontent WHERE ((question.idquestion = questioncontent.idquestion) AND (questioncontent.date = (SELECT max(questioncontent.date) AS max FROM questioncontent WHERE (questioncontent.idquestion = question.idquestion))));


ALTER TABLE public.question_vw OWNER TO lbaw1315;

--
-- Name: questioncomment; Type: TABLE; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE TABLE questioncomment (
    idcomment integer NOT NULL,
    iduser integer,
    date timestamp without time zone NOT NULL,
    idquestion integer
);


ALTER TABLE public.questioncomment OWNER TO lbaw1315;

--
-- Name: questioncomment_idcomment_seq; Type: SEQUENCE; Schema: public; Owner: lbaw1315
--

CREATE SEQUENCE questioncomment_idcomment_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questioncomment_idcomment_seq OWNER TO lbaw1315;

--
-- Name: questioncomment_idcomment_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lbaw1315
--

ALTER SEQUENCE questioncomment_idcomment_seq OWNED BY questioncomment.idcomment;


--
-- Name: questioncommentcontent; Type: TABLE; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE TABLE questioncommentcontent (
    idcomment integer NOT NULL,
    iduser integer NOT NULL,
    date timestamp without time zone NOT NULL,
    content text,
    CONSTRAINT questioncommentcontent_content_check CHECK ((char_length(content) <= 200))
);


ALTER TABLE public.questioncommentcontent OWNER TO lbaw1315;

--
-- Name: questioncomment_vw; Type: VIEW; Schema: public; Owner: lbaw1315
--

CREATE VIEW questioncomment_vw AS
    SELECT questioncomment.idcomment, questioncomment.date, questioncomment.idquestion, questioncomment.iduser, questioncommentcontent.date AS lastdate, questioncommentcontent.content FROM questioncomment, questioncommentcontent WHERE ((questioncomment.idcomment = questioncommentcontent.idcomment) AND (questioncommentcontent.date = (SELECT max(questioncommentcontent.date) AS max FROM questioncommentcontent WHERE (questioncommentcontent.idcomment = questioncomment.idcomment))));


ALTER TABLE public.questioncomment_vw OWNER TO lbaw1315;

--
-- Name: questionsubscription; Type: TABLE; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE TABLE questionsubscription (
    iduser integer NOT NULL,
    idquestion integer NOT NULL
);


ALTER TABLE public.questionsubscription OWNER TO lbaw1315;

--
-- Name: questiontag; Type: TABLE; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE TABLE questiontag (
    idquestion integer NOT NULL,
    idtag integer NOT NULL
);


ALTER TABLE public.questiontag OWNER TO lbaw1315;

--
-- Name: questionvote; Type: TABLE; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE TABLE questionvote (
    iduser integer NOT NULL,
    idquestion integer NOT NULL,
    updown integer NOT NULL,
    CONSTRAINT questionvote_updown_check CHECK (((updown = (-1)) OR (updown = 1)))
);


ALTER TABLE public.questionvote OWNER TO lbaw1315;

--
-- Name: tag; Type: TABLE; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE TABLE tag (
    idtag integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.tag OWNER TO lbaw1315;

--
-- Name: tag_idtag_seq; Type: SEQUENCE; Schema: public; Owner: lbaw1315
--

CREATE SEQUENCE tag_idtag_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_idtag_seq OWNER TO lbaw1315;

--
-- Name: tag_idtag_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lbaw1315
--

ALTER SEQUENCE tag_idtag_seq OWNED BY tag.idtag;


--
-- Name: webuser_iduser_seq; Type: SEQUENCE; Schema: public; Owner: lbaw1315
--

CREATE SEQUENCE webuser_iduser_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.webuser_iduser_seq OWNER TO lbaw1315;

--
-- Name: webuser_iduser_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lbaw1315
--

ALTER SEQUENCE webuser_iduser_seq OWNED BY webuser.iduser;


SET search_path = frmk, pg_catalog;

--
-- Name: id; Type: DEFAULT; Schema: frmk; Owner: lbaw1315
--

ALTER TABLE ONLY tweets ALTER COLUMN id SET DEFAULT nextval('tweets_id_seq'::regclass);


SET search_path = public, pg_catalog;

--
-- Name: idanswer; Type: DEFAULT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY answer ALTER COLUMN idanswer SET DEFAULT nextval('answer_idanswer_seq'::regclass);


--
-- Name: idcomment; Type: DEFAULT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY answercomment ALTER COLUMN idcomment SET DEFAULT nextval('answercomment_idcomment_seq'::regclass);


--
-- Name: idcountry; Type: DEFAULT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY country ALTER COLUMN idcountry SET DEFAULT nextval('country_idcountry_seq'::regclass);


--
-- Name: idquestion; Type: DEFAULT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY question ALTER COLUMN idquestion SET DEFAULT nextval('question_idquestion_seq'::regclass);


--
-- Name: idcomment; Type: DEFAULT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY questioncomment ALTER COLUMN idcomment SET DEFAULT nextval('questioncomment_idcomment_seq'::regclass);


--
-- Name: idtag; Type: DEFAULT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY tag ALTER COLUMN idtag SET DEFAULT nextval('tag_idtag_seq'::regclass);


--
-- Name: iduser; Type: DEFAULT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY webuser ALTER COLUMN iduser SET DEFAULT nextval('webuser_iduser_seq'::regclass);


SET search_path = frmk, pg_catalog;

--
-- Data for Name: follows; Type: TABLE DATA; Schema: frmk; Owner: lbaw1315
--

INSERT INTO follows VALUES ('mike', 'mary');
INSERT INTO follows VALUES ('mike', 'john');
INSERT INTO follows VALUES ('mary', 'mike');
INSERT INTO follows VALUES ('john', 'mary');


--
-- Data for Name: tweets; Type: TABLE DATA; Schema: frmk; Owner: lbaw1315
--

INSERT INTO tweets VALUES (1, '2013-10-31 10:41:00', 'john', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam magna arcu, dictum et bibendum a, volutpat sed mi. Maecenas facilisis.');
INSERT INTO tweets VALUES (2, '2013-10-31 11:21:00', 'john', 'Nam congue erat eu lectus ullamcorper, sed ornare sapien interdum. Vestibulum rutrum adipiscing sed.');
INSERT INTO tweets VALUES (3, '2013-10-31 12:35:00', 'mary', 'Etiam a arcu vitae augue varius posuere eget vitae lectus. Vivamus diam posuere.');
INSERT INTO tweets VALUES (4, '2013-10-31 14:25:00', 'john', 'Praesent metus augue, suscipit at eleifend nec, pharetra vitae dolor. Morbi sed.');
INSERT INTO tweets VALUES (5, '2013-10-31 14:41:00', 'mike', 'Donec quis augue vitae urna turpis duis.');
INSERT INTO tweets VALUES (6, '2013-10-31 15:12:00', 'mary', 'Praesent a orci vitae urna molestie sed.');
INSERT INTO tweets VALUES (7, '2013-10-31 16:46:00', 'mary', 'Sed sem nibh, facilisis in orci aliquam.');
INSERT INTO tweets VALUES (8, '2013-10-31 16:54:00', 'john', 'Maecenas iaculis ante vel velit pharetra vulputate volutpat.');
INSERT INTO tweets VALUES (9, '2013-10-31 17:39:00', 'john', 'Morbi commodo consequat turpis, vel hendrerit turpis nullam.');
INSERT INTO tweets VALUES (10, '2013-10-31 19:54:00', 'mary', 'Vestibulum eget lectus molestie, convallis velit nec nullam.');
INSERT INTO tweets VALUES (11, '2013-10-31 21:43:00', 'mike', 'Fusce quam lorem, dictum vitae ligula ut, molestie volutpat.');
INSERT INTO tweets VALUES (12, '2013-11-01 09:41:00', 'mary', 'Quisque augue lectus, auctor at bibendum nec, lobortis amet.');
INSERT INTO tweets VALUES (13, '2013-11-01 10:44:00', 'mary', 'Ut et tincidunt orci. Nulla facilisi. Sed egestas neque nec est metus.');
INSERT INTO tweets VALUES (14, '2013-11-01 11:47:00', 'mike', 'Curabitur porttitor sem scelerisque nibh sagittis, ut tristique metus.');
INSERT INTO tweets VALUES (15, '2013-11-01 11:49:00', 'john', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla quis ultricies nunc, eget condimentum nulla. Donec metus.');
INSERT INTO tweets VALUES (16, '2013-11-01 11:55:00', 'mike', 'Etiam porta porttitor tempus. Fusce viverra nisi at tortor ultricies, sit amet consectetur lorem mattis. Maecenas metus.');
INSERT INTO tweets VALUES (17, '2014-04-11 09:38:48', 'mary', 'sempre a fumalas
');
INSERT INTO tweets VALUES (19, '2014-04-22 20:49:11', 'john', 'BENFICA CAMPEÃO!');


--
-- Name: tweets_id_seq; Type: SEQUENCE SET; Schema: frmk; Owner: lbaw1315
--

SELECT pg_catalog.setval('tweets_id_seq', 21, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: frmk; Owner: lbaw1315
--

INSERT INTO users VALUES ('john', 'John Doe', '098f6bcd4621d373cade4e832627b4f6');
INSERT INTO users VALUES ('mary', 'Mary Jane', '098f6bcd4621d373cade4e832627b4f6');
INSERT INTO users VALUES ('mike', 'Mike Tyson', '098f6bcd4621d373cade4e832627b4f6');
INSERT INTO users VALUES ('tiago', 'tiago', 'a94a8fe5ccb19ba61c4c0873d391e987982fbbd3');


SET search_path = public, pg_catalog;

--
-- Data for Name: answer; Type: TABLE DATA; Schema: public; Owner: lbaw1315
--

INSERT INTO answer VALUES (3, '2014-06-04 20:01:02', 3, 4, 5, true);
INSERT INTO answer VALUES (6, '2014-06-04 20:57:57', 1, 6, 2, false);
INSERT INTO answer VALUES (5, '2014-06-04 20:52:16', 2, 6, 6, true);
INSERT INTO answer VALUES (9, '2014-06-07 19:01:02', 1, 10, 12, false);
INSERT INTO answer VALUES (12, '2014-06-07 19:12:31', 0, 9, 14, false);
INSERT INTO answer VALUES (14, '2014-06-07 19:17:29', 1, 14, 11, true);
INSERT INTO answer VALUES (15, '2014-06-07 19:19:17', 0, 13, 13, false);
INSERT INTO answer VALUES (16, '2014-06-07 19:20:22', 0, 12, 13, false);
INSERT INTO answer VALUES (19, '2014-06-07 19:26:11', 0, 15, 12, false);
INSERT INTO answer VALUES (22, '2014-06-07 19:32:50', 0, 17, 13, false);
INSERT INTO answer VALUES (23, '2014-06-07 19:34:01', 0, 16, 13, false);
INSERT INTO answer VALUES (25, '2014-06-07 19:36:19', 0, 16, 15, false);
INSERT INTO answer VALUES (26, '2014-06-07 19:36:53', 0, 16, 14, false);
INSERT INTO answer VALUES (27, '2014-06-07 19:38:08', 0, 17, 14, false);
INSERT INTO answer VALUES (28, '2014-06-07 19:39:56', 0, 17, 17, false);
INSERT INTO answer VALUES (30, '2014-06-07 19:42:10', 0, 17, 16, false);
INSERT INTO answer VALUES (31, '2014-06-07 19:44:35', 0, 18, 18, false);
INSERT INTO answer VALUES (32, '2014-06-07 19:44:53', 0, 16, 18, false);
INSERT INTO answer VALUES (33, '2014-06-07 19:46:25', 0, 19, 17, false);
INSERT INTO answer VALUES (35, '2014-06-07 19:47:19', 0, 18, 16, false);
INSERT INTO answer VALUES (36, '2014-06-07 19:49:13', 0, 19, 19, false);
INSERT INTO answer VALUES (37, '2014-06-07 19:49:44', 0, 18, 19, false);
INSERT INTO answer VALUES (38, '2014-06-07 19:50:33', 0, 18, 15, false);
INSERT INTO answer VALUES (40, '2014-06-07 19:53:36', 0, 20, 13, false);
INSERT INTO answer VALUES (41, '2014-06-08 12:51:39', 0, 22, 21, false);
INSERT INTO answer VALUES (42, '2014-06-08 12:52:21', 0, 23, 21, false);
INSERT INTO answer VALUES (44, '2014-06-08 12:53:40', 0, 22, 11, false);
INSERT INTO answer VALUES (45, '2014-06-08 12:54:17', 0, 23, 12, false);
INSERT INTO answer VALUES (46, '2014-06-08 12:55:06', 0, 22, 12, false);
INSERT INTO answer VALUES (47, '2014-06-08 12:56:13', 0, 23, 13, false);
INSERT INTO answer VALUES (48, '2014-06-08 12:56:52', 0, 23, 14, false);
INSERT INTO answer VALUES (50, '2014-06-08 13:00:02', 0, 23, 15, false);
INSERT INTO answer VALUES (51, '2014-06-08 13:01:02', 0, 23, 16, false);
INSERT INTO answer VALUES (52, '2014-06-08 13:01:20', 0, 22, 16, false);
INSERT INTO answer VALUES (53, '2014-06-08 13:02:11', 0, 23, 17, false);
INSERT INTO answer VALUES (54, '2014-06-08 13:02:38', 0, 23, 18, false);
INSERT INTO answer VALUES (7, '2014-06-06 23:56:03', 2, 7, 8, false);
INSERT INTO answer VALUES (8, '2014-06-07 11:26:47', 2, 8, 5, true);
INSERT INTO answer VALUES (10, '2014-06-07 19:02:30', 2, 10, 13, true);
INSERT INTO answer VALUES (11, '2014-06-07 19:07:46', 1, 11, 11, false);
INSERT INTO answer VALUES (13, '2014-06-07 19:14:06', 1, 11, 14, false);
INSERT INTO answer VALUES (17, '2014-06-07 19:22:25', 2, 12, 15, true);
INSERT INTO answer VALUES (18, '2014-06-07 19:25:41', 1, 15, 14, false);
INSERT INTO answer VALUES (20, '2014-06-07 19:26:40', 1, 15, 13, false);
INSERT INTO answer VALUES (21, '2014-06-07 19:27:49', 1, 15, 11, false);
INSERT INTO answer VALUES (29, '2014-06-07 19:40:17', 1, 16, 17, false);
INSERT INTO answer VALUES (24, '2014-06-07 19:35:28', 1, 17, 15, false);
INSERT INTO answer VALUES (34, '2014-06-07 19:46:55', 2, 19, 16, false);
INSERT INTO answer VALUES (39, '2014-06-07 19:52:24', 1, 20, 12, false);
INSERT INTO answer VALUES (49, '2014-06-08 12:57:12', 1, 22, 14, false);
INSERT INTO answer VALUES (43, '2014-06-08 12:53:00', 1, 23, 11, false);
INSERT INTO answer VALUES (55, '2014-06-08 13:10:31', 0, 21, 22, false);
INSERT INTO answer VALUES (56, '2014-06-08 13:11:46', 0, 24, 23, false);
INSERT INTO answer VALUES (57, '2014-06-08 13:12:04', 0, 21, 23, false);
INSERT INTO answer VALUES (58, '2014-06-08 13:15:27', 0, 24, 12, false);
INSERT INTO answer VALUES (59, '2014-06-08 13:15:50', 0, 25, 12, false);
INSERT INTO answer VALUES (60, '2014-06-08 13:17:10', 0, 25, 16, false);
INSERT INTO answer VALUES (61, '2014-06-08 13:17:39', 0, 25, 13, false);
INSERT INTO answer VALUES (62, '2014-06-08 13:18:45', 0, 25, 18, false);
INSERT INTO answer VALUES (63, '2014-06-08 13:19:17', 0, 25, 19, false);
INSERT INTO answer VALUES (64, '2014-06-08 13:19:45', 0, 25, 14, false);
INSERT INTO answer VALUES (66, '2014-06-08 13:23:40', 0, 27, 20, false);
INSERT INTO answer VALUES (67, '2014-06-08 13:24:16', 0, 27, 21, false);
INSERT INTO answer VALUES (68, '2014-06-08 13:24:42', 0, 27, 13, false);
INSERT INTO answer VALUES (69, '2014-06-08 13:25:16', 0, 27, 16, false);
INSERT INTO answer VALUES (71, '2014-06-08 13:29:19', 0, 28, 17, false);
INSERT INTO answer VALUES (70, '2014-06-08 13:28:41', 1, 28, 18, false);
INSERT INTO answer VALUES (72, '2014-06-08 13:29:46', 0, 28, 15, false);
INSERT INTO answer VALUES (73, '2014-06-08 13:30:23', 0, 28, 21, false);
INSERT INTO answer VALUES (65, '2014-06-08 13:21:51', -1, 26, 23, false);
INSERT INTO answer VALUES (75, '2014-06-08 20:01:18', 1, 31, 14, true);
INSERT INTO answer VALUES (76, '2014-06-08 20:27:26', 1, 32, 16, false);
INSERT INTO answer VALUES (80, '2014-06-11 10:25:45', 0, 32, 28, false);
INSERT INTO answer VALUES (74, '2014-06-08 13:31:10', 1, 28, 12, false);
INSERT INTO answer VALUES (4, '2014-06-04 20:48:33', 2, 5, 2, true);


--
-- Name: answer_idanswer_seq; Type: SEQUENCE SET; Schema: public; Owner: lbaw1315
--

SELECT pg_catalog.setval('answer_idanswer_seq', 80, true);


--
-- Data for Name: answercomment; Type: TABLE DATA; Schema: public; Owner: lbaw1315
--

INSERT INTO answercomment VALUES (1, 6, '2014-06-04 20:18:17', 3);
INSERT INTO answercomment VALUES (2, 6, '2014-06-04 20:49:17', 4);
INSERT INTO answercomment VALUES (4, 10, '2014-06-07 11:28:25', 8);
INSERT INTO answercomment VALUES (5, 11, '2014-06-07 19:06:02', 10);
INSERT INTO answercomment VALUES (6, 14, '2014-06-07 19:18:39', 14);
INSERT INTO answercomment VALUES (7, 14, '2014-06-07 19:25:10', 17);
INSERT INTO answercomment VALUES (8, 18, '2014-06-07 19:54:21', 39);
INSERT INTO answercomment VALUES (9, 12, '2014-06-08 12:55:33', 44);
INSERT INTO answercomment VALUES (10, 19, '2014-06-08 13:03:06', 54);
INSERT INTO answercomment VALUES (11, 12, '2014-06-08 13:14:57', 57);
INSERT INTO answercomment VALUES (12, 24, '2014-06-08 20:11:20', 75);
INSERT INTO answercomment VALUES (13, 14, '2014-06-08 21:12:21', 65);
INSERT INTO answercomment VALUES (14, 1, '2014-06-11 10:26:48', 74);


--
-- Name: answercomment_idcomment_seq; Type: SEQUENCE SET; Schema: public; Owner: lbaw1315
--

SELECT pg_catalog.setval('answercomment_idcomment_seq', 14, true);


--
-- Data for Name: answercommentcontent; Type: TABLE DATA; Schema: public; Owner: lbaw1315
--

INSERT INTO answercommentcontent VALUES (1, 6, '2014-06-04 20:18:17', '<p>exactamente. fa&ccedil;o isso e nunca tive problema</p>
');
INSERT INTO answercommentcontent VALUES (2, 6, '2014-06-04 20:49:17', '<p>obrigado pela dica, mas ja tentei isso e n&atilde;o funcionou bem</p>
');
INSERT INTO answercommentcontent VALUES (4, 10, '2014-06-07 11:28:25', '<p>era mesmo isso. obrigado&nbsp;</p>
');
INSERT INTO answercommentcontent VALUES (5, 11, '2014-06-07 19:06:02', '<p>Obrigada. Experimentei e foi um sucesso!!</p>
');
INSERT INTO answercommentcontent VALUES (6, 14, '2014-06-07 19:18:39', '<p>&Eacute; essa mesmo!!&nbsp;e ser&aacute; que n&atilde;o &eacute; pedir muito se me desse os cent&iacute;metros que ela tem de um lado ao outro,<br />
que assim ja me orientava.</p>
');
INSERT INTO answercommentcontent VALUES (7, 14, '2014-06-07 19:25:10', '<p>Obrigada rosacristina!<br />
N&atilde;o tinha sido neste site, mas acho que basicamente era esta receita... s&oacute; n&atilde;o me lembrava da parte da manteiga!<br />
Vou experimentar!&nbsp;</p>
');
INSERT INTO answercommentcontent VALUES (8, 18, '2014-06-07 19:54:21', '<p>pelo que sei das marron glac&eacute;..fazem-se com castanhas cozidas e ent&atilde;o depois &eacute; que s&atilde;o passadas pela calda. Com castanhas assdas nunca ouvi falar</p>
');
INSERT INTO answercommentcontent VALUES (9, 12, '2014-06-08 12:55:33', '<p>receita muito f&aacute;cil! gostei muito da sugest&atilde;o!</p>
');
INSERT INTO answercommentcontent VALUES (10, 19, '2014-06-08 13:03:06', '<p>uuummmmmmm tamb&eacute;m vou exprimentar o teu enigma</p>
');
INSERT INTO answercommentcontent VALUES (11, 12, '2014-06-08 13:14:57', '<p>Sim douradinhos..&nbsp;Quanto &agrave; temperatura&nbsp;n&atilde;o sei at&eacute; q ponto &eacute; v&aacute;lido, porque se forem dos congelados a massa j&aacute; de si &eacute; mais durita..</p>
');
INSERT INTO answercommentcontent VALUES (12, 24, '2014-06-08 20:11:20', '<p>Era mesmo isto!! Obrigado :)</p>
');
INSERT INTO answercommentcontent VALUES (13, 14, '2014-06-08 21:12:21', '<p>O link n&atilde;o funciona...</p>
');
INSERT INTO answercommentcontent VALUES (14, 1, '2014-06-11 10:26:48', '<p>D&aacute; para meter imagens, ou um v&iacute;deo?</p>
');


--
-- Data for Name: answercontent; Type: TABLE DATA; Schema: public; Owner: lbaw1315
--

INSERT INTO answercontent VALUES (3, 5, '2014-06-04 20:01:02', '<p>Sim, tamb&eacute;m me costuma acontecer. H&aacute; quem aconselhe a guardar as claras em castelo no frigor&iacute;fico enquanto se prepara a massa.</p>
');
INSERT INTO answercontent VALUES (4, 2, '2014-06-04 20:48:33', '<p>Tenta provar uma parte do arroz. A forma ideal para estar o risotto &eacute; que o arroz esteja no ponto, ou seja, nem muito rijo nem muito mole. Tem de estar &agrave; &quot;al dente&quot;.</p>
');
INSERT INTO answercontent VALUES (5, 6, '2014-06-04 20:52:16', '<p>os cravinhos da india s&atilde;o faceis de encontrar em&nbsp; qualquer hipermercado, da marca margao por exemplo.<br />
as sementes de cardamomo h&aacute; em todas as lojas gourmet.<br />
vagens de curcuma? n&atilde;o percebi. curcuma &eacute; o vulgar&nbsp;<a href="http://pt.wikipedia.org/wiki/A%C3%A7afr%C3%A3o-da-terra" target="_blank">a&ccedil;afr&atilde;o da terra</a>&nbsp;h&aacute; em todo o supermercado. Mas vagem nunca vi a venda nem nunca vi utiliza&ccedil;&atilde;o n&atilde;o estara a confundir com estigmas de&nbsp;<a href="http://pt.wikipedia.org/wiki/A%C3%A7afr%C3%A3o" target="_blank">a&ccedil;afr&atilde;o</a>&nbsp;(&eacute; muito diferente)?<br />
Se forem os estigmas do acafr&atilde;o costuma haver na zona dos produtos internacionais do jumbo e modelo.<br />
bok choy &eacute; mais tipo uma couve tenra. E &eacute; dificil de encontrar a venda pelo menos nos sitios na zona de coimbra onde tenho procurado o melhor &eacute; plantar &eacute; mt facil encontrar as sementes ou as vezes at&eacute; no lidl.<br />
Em ultimo caso se n&atilde;o se encontrar comprar online &eacute; sempre uma boa op&ccedil;&atilde;o, 2 ou 3 especiarias por mes e fica-se com uma enorme colec&ccedil;&atilde;o num instante, por vezes, mesmo com os portes os pre&ccedil;os compensam.</p>
');
INSERT INTO answercontent VALUES (6, 2, '2014-06-04 20:57:57', '<p>N&atilde;o sei de que zona &eacute;s, mas no Corte ingl&ecirc;s sec&ccedil;&atilde;o goumet, eles tem muita coisa&nbsp; &quot;esquisita&quot; &eacute; uma quest&atilde;o de procurares<br />
&Egrave; l&aacute; que me safo !!!!</p>
');
INSERT INTO answercontent VALUES (7, 8, '2014-06-06 23:56:03', '<p>Tens que usar ovos, queijo e fiambre.</p>

<p>Bates a gema do ovo e depois metes o queijo e o fiambre ou outros ingredientes &agrave; tua escolha.</p>
');
INSERT INTO answercontent VALUES (8, 5, '2014-06-07 11:26:47', '<p>Ol&aacute;.</p>

<p>eu o caril compro sempre nas sec&ccedil;&otilde;es de produtos orientais. S&atilde;o bem melhores que as marcas tipo Marg&atilde;o ou outra coisa qualquer.<br />
O melhor que j&aacute; comprei era uma que vinha num saquinho de pl&aacute;stico transparente, mas n&atilde;o me lembro da marca....</p>

<p>Espero que ajude</p>
');
INSERT INTO answercontent VALUES (9, 12, '2014-06-07 19:01:02', '<p>Normalmente, os cheesecakes costumam ter queijo creme misturado com uma base de bolacha. Leva depois a cobertura de frutos vermelhos. Contudo, eu acho que o cheesecake se torna muito complexo e por isso experimentei fazer pannacotta com frutos vermelhos. Fica &oacute;timo na mesma, &eacute; muito mais f&aacute;cil e a textura &eacute; muito semelhante. Recomendo que utilize muito molho porque a pannacotta vai acabar por ficar enjoativa.</p>
');
INSERT INTO answercontent VALUES (10, 13, '2014-06-07 19:02:30', '<p>Aqui est&aacute; a receita&nbsp;<a href=\"http://www.petiscos.com/receita.php?recid=25362&amp;catid=19\" target=\"_blank\">http://www.petiscos.com/receita.php?recid=25362&amp;catid=19</a>&nbsp;. Espero ter ajudado.</p>
');
INSERT INTO answercontent VALUES (11, 11, '2014-06-07 19:07:46', '<p>A vagem &eacute; melhor porque o aroma natural &eacute; muito melhor que o artificial. Podes rentabiliz&aacute;-la (&eacute; cara) se tiveres bimby pulveriza meio kg de a&ccedil;&uacute;car com a vagem. Ficas com a&ccedil;&uacute;car de baunilha muito bom. Se n&atilde;o tiveres bimby utiliza o liquidificador.</p>
');
INSERT INTO answercontent VALUES (12, 14, '2014-06-07 19:12:31', '<p>Devias encontrar outra receita de brigadeiros, j&aacute; que essa n&atilde;o parece ser a melhor querida.</p>
');
INSERT INTO answercontent VALUES (13, 14, '2014-06-07 19:14:06', '<p>&nbsp;Vagem de baunilha &eacute; mais org&acirc;nico e fidedigno. O sabor &eacute; leve mas intenso. Mais natural, fresco e fi&eacute;l do que isto &eacute; imposs&iacute;vel!</p>
');
INSERT INTO answercontent VALUES (14, 11, '2014-06-07 19:17:29', '<p>N&atilde;o sei a medida da minha, mas leva exactamente 12 ovos e um litro de leite!</p>
');
INSERT INTO answercontent VALUES (15, 13, '2014-06-07 19:19:17', '<p>Ol&aacute;,<br />
<br />
Creme de Leite = Natas<br />
<br />
Doce de Leite = Leite Condensado<br />
<br />
Espero ter ajudado</p>
');
INSERT INTO answercontent VALUES (16, 13, '2014-06-07 19:20:22', '<p>Eu nunca vi mas fico &agrave; espera do resultado eheheh</p>
');
INSERT INTO answercontent VALUES (17, 15, '2014-06-07 19:22:25', '<p>Encontrei esta receita mas n&atilde;o sei se &eacute; o que viste..<br />
<a href=\"http://cerejaneon.blogspot.pt/2012/04/maca-assada-com-um-gole-de-rum.html\" target=\"_blank\">http://cerejaneon.blogspot.pt/2012/04/maca-assada-com-um-gole-de-rum.html</a></p>

<p>D&aacute; uma olhadela querida!</p>
');
INSERT INTO answercontent VALUES (18, 14, '2014-06-07 19:25:41', '<p>Ol&aacute; rosa!<br />
Eu deixo descongelar e costumo lav&aacute;-las, pois sempre se encontra areia....<br />
&Aacute;s vezes lavo em &aacute;gua corrente, outras numa ta&ccedil;a, mas tentando fazer isso r&aacute;pido para n&atilde;o ficarem sem o gosto caracter&iacute;stico delas&nbsp;</p>
');
INSERT INTO answercontent VALUES (19, 12, '2014-06-07 19:26:11', '<p>eu tb passo sempre por agua..mas meto numa ta&ccedil;a com agua e sal ...</p>
');
INSERT INTO answercontent VALUES (20, 13, '2014-06-07 19:26:40', '<p>Eu fa&ccedil;o da seguinte maneira: segundos antes de utilizar retiro do congelador passo por agua corrente para retira o possivel gelo agarrado e coloco directamente no que vou fazer.</p>
');
INSERT INTO answercontent VALUES (21, 11, '2014-06-07 19:27:49', '<p>Eu costumo comprar, prncipalmente as ameijoas vietnamitas, pois n&atilde;o t&ecirc;m areia nenhuma. Retiro-as do congelador, passo-as por &aacute;gua corrente e de seguida passo-as logo para a panela, em lume brando, geralmente estas n&atilde;o ficam fechadas.</p>
');
INSERT INTO answercontent VALUES (22, 13, '2014-06-07 19:32:50', '<p>eu fa&ccedil;o 1 receita parecida com essa ke so leva 1 chavena (200ml) ,sera por isso&nbsp;<img alt=\"Huh\" src=\"http://www.petiscos.com/smf/Smileys/default/huh.gif\" />&nbsp;<img alt=\"Huh\" src=\"http://www.petiscos.com/smf/Smileys/default/huh.gif\" />&nbsp;,mas nao abate fica super fofinho ,,tenta so com 1 chavena de natas ,e tenta nao abrir o forno nos primeiros 10 minutos ,,bjs</p>
');
INSERT INTO answercontent VALUES (22, 13, '2014-06-07 19:33:17', '<p>eu fa&ccedil;o 1 receita parecida com essa ke so leva 1 chavena (200ml) ,sera por isso&nbsp;&nbsp;<img alt=\"indecision\" src=\"http://gnomo.fe.up.pt/~lbaw1315/final/lib/ckeditor/plugins/smiley/images/whatchutalkingabout_smile.png\" style=\"height:23px; width:23px\" title=\"indecision\" /><span style=\"line-height:1.6\">&nbsp;,mas nao abate fica super fofinho ,,tenta so com 1 chavena de natas ,e tenta nao abrir o forno nos primeiros 10 minutos ,,bjs</span></p>
');
INSERT INTO answercontent VALUES (22, 13, '2014-06-07 19:33:36', '<p>eu fa&ccedil;o 1 receita parecida com essa ke so leva 1 chavena (200ml) ,sera por isso ???&nbsp;mas nao abate fica super fofinho ,,tenta so com 1 chavena de natas ,e tenta nao abrir o forno nos primeiros 10 minutos ,,bjs</p>
');
INSERT INTO answercontent VALUES (23, 13, '2014-06-07 19:34:01', '<p>ol&aacute; experimente ir ao corte ingles la deve de ter. as coisas mais esquisitas tem la</p>
');
INSERT INTO answercontent VALUES (24, 15, '2014-06-07 19:35:28', '<p>Eu uso estas quantidades e corre sempre bem:<br />
<br />
4 ovos<br />
250 gr de farinha para bolos<br />
250 gr de a&ccedil;&uacute;car<br />
1 pacote de 200 ml de natas<br />
1 colher de ch&aacute; de fermento<br />
<br />
<a href=\"http://gdeguloseimas.blogspot.com/2008/12/bolo-de-natas.html\" target=\"_blank\">http://gdeguloseimas.blogspot.com/2008/12/bolo-de-natas.html</a></p>
');
INSERT INTO answercontent VALUES (25, 15, '2014-06-07 19:36:19', '<p>Se fores da zona do Porto podes tentar procurar na Casa Janu&aacute;rio na baixa.</p>
');
INSERT INTO answercontent VALUES (26, 14, '2014-06-07 19:36:53', '<p>Pode ser feita com margarina normal, desde que seja sem sal</p>
');
INSERT INTO answercontent VALUES (27, 14, '2014-06-07 19:38:08', '<p>Outra coisa que faz abater os bolos &eacute; a falta de farinha...tamb&eacute;m pode ser esse o problema&nbsp;<img alt=\"frown\" src=\"http://gnomo.fe.up.pt/~lbaw1315/final/lib/ckeditor/plugins/smiley/images/confused_smile.png\" style=\"height:23px; width:23px\" title=\"frown\" /></p>
');
INSERT INTO answercontent VALUES (28, 17, '2014-06-07 19:39:56', '<p>Misturar batendo com demasiada for&ccedil;a as claras j&aacute; em castelo &agrave; restante massa, ou abrir o forno antes de uma meia hora de cozedura a 180&ordm; foram os erros de que a minha M&atilde;e me preveniu em rela&ccedil;&atilde;o aos bolos que abatem.<br />
<br />
Tamb&eacute;m j&aacute; reparei que quando a massa fica muito l&iacute;quida n&atilde;o sobe bem.&nbsp;<br />
<br />
Os bolos que costumo fazer n&atilde;o levam mais de uma colher de ch&aacute; de fermento, mas costumo ao mesmo tempo utilizar a farinha Branca de Neve super-fina self-raising (diz mesmo &#39;para bolos&#39;) que acho que j&aacute; tem algum fermento.</p>
');
INSERT INTO answercontent VALUES (29, 17, '2014-06-07 19:40:17', '<p>qualquer manteiga sem sal d&aacute;. acho que &eacute; melhor manteiga que margarina.</p>
');
INSERT INTO answercontent VALUES (30, 16, '2014-06-07 19:42:10', '<p>Obrigado pelas ajudas queridas!!<br />
<br />
Aproveito para dizer que o creme de ovos,feito com gemas,maizena e a&ccedil;ucar em calda,assenta que nem uma luva neste bolo.</p>
');
INSERT INTO answercontent VALUES (27, 6, '2014-06-07 20:44:09', '<p>Outra coisa que faz abater os bolos &eacute; a falta de farinha...tamb&eacute;m pode ser esse o problema <img alt="frown" src="http://localhost/overCooked/final/lib/ckeditor/plugins/smiley/images/confused_smile.png" style="height:23px; width:23px" title="frown" /></p>
');
INSERT INTO answercontent VALUES (31, 18, '2014-06-07 19:44:35', '<p>O arroz selvagem &eacute; assim, sementes longas e escurinhas!<br />
Nos restaurantes costumam misturar um pouco. Esse arroz &eacute; muito caro!!</p>
');
INSERT INTO answercontent VALUES (32, 18, '2014-06-07 19:44:53', '<p>H&aacute; muito que n&atilde;o vejo margarina para folhados nos supers perto de mim!<br />
Lembro-me de haver e penso que era margarina vaqueiro...</p>
');
INSERT INTO answercontent VALUES (33, 17, '2014-06-07 19:46:25', '<p>Nunca cozinhei, nem nunca vi em portugal &agrave; venda, mas, no quando estive de f&eacute;rias no Brasil comi acho que grelhada (n&atilde;o tenho acertesa), e at&eacute; gostei, mas saber que era jacar&eacute;, n&atilde;o comi muito foi mesmo por curiosidade.</p>
');
INSERT INTO answercontent VALUES (34, 16, '2014-06-07 19:46:55', '<p>Se deres uma googlada por&nbsp;<em>cozinhar carne crocodilo</em>&nbsp;aparecem-te in&uacute;meros links de receitas mas de jacar&eacute;, e ao que vi a parte comest&iacute;vel ser&aacute; a cauda (n&atilde;o sei se aplica igualmente ao crocodilo mas ser&aacute; concerteza).<br />
<br />
J&aacute; agora onde arranjas a comprar isso?</p>
');
INSERT INTO answercontent VALUES (35, 16, '2014-06-07 19:47:19', '<p>N&atilde;o ser&atilde;o cominhos?</p>
');
INSERT INTO answercontent VALUES (36, 19, '2014-06-07 19:49:13', '<p>Eu j&aacute; vi postas de crocodilo &agrave; venda, n&atilde;o me lembro se foi no Continente em Coimbra ou no eLeclerc da Figueira da Foz (onde tamb&eacute;m cheguei a ver pernas de r&atilde;).<br />
<br />
Na altura ainda fiquei curioso mas n&atilde;o cheguei a comprar.</p>
');
INSERT INTO answercontent VALUES (36, 19, '2014-06-07 19:49:22', '<p>Eu j&aacute; vi postas de crocodilo &agrave; venda, n&atilde;o me lembro se foi no Continente em Coimbra ou no eLeclerc da Figueira da Foz (onde tamb&eacute;m cheguei a ver pernas de r&atilde;).<br />
<br />
Na altura ainda fiquei curiosa&nbsp;mas n&atilde;o cheguei a comprar.</p>
');
INSERT INTO answercontent VALUES (37, 19, '2014-06-07 19:49:44', '<p>N&atilde;o ser&aacute; o arroz pilau (com especiarias)? Nos restaurantes indianos, variando de restaurante para restaurante, &eacute; poss&iacute;vel encontrar v&aacute;rios tipos de arroz basmati. O arroz basmati simples &eacute; s&oacute; uma entre v&aacute;rias op&ccedil;&otilde;es.</p>
');
INSERT INTO answercontent VALUES (38, 15, '2014-06-07 19:50:33', '<p>Sabia que tinha c&aacute; em casa receitas indianas. Achei v&aacute;rios pratos de arroz &quot;pulau&quot;. &Eacute; ligeiramente diferente do que se v&ecirc; nos restaurantes indianos. Realmente uma das coisas que leva s&atilde;o sementes de cominho, mas refere tb cardamomo, canela, gengibre... etc.&nbsp;<br />
<br />
J&aacute; agora n&atilde;o sei se sabem isto, mas um indiano explicou-me que os pratos dos restaurantes indianos n&atilde;o s&atilde;o iguais aos da India, como pensamos. As receitas dos nossos restaurantes indianos s&atilde;o maioritariamente origin&aacute;rias da Gr&atilde;-Bretanha. O famoso Chicken Tikka Masala foi criado pelos brit&acirc;nicos. E o curioso &eacute; que os indianos tb come&ccedil;aram a consumi-lo, mas n&atilde;o &eacute; um prato deles.</p>
');
INSERT INTO answercontent VALUES (39, 12, '2014-06-07 19:52:24', '<p>Como comprar e conservar castanhas<br />
<br />
As castanhas encontram-se no mercado desde princ&iacute;pios de outono a finais de inverno. No momento da compra, deve ter-se particular cuidado na observa&ccedil;&atilde;o do estado da sua pele, que deve ser bem brilhante e intacta (sem cortes ou gretas). Para conservar em casa, devem ser guardadas em local fresco e seco. &Eacute; importante que n&atilde;o sejam comprimidas e ama&ccedil;adas, devendo estar separadas entre si, tanto quanto poss&iacute;vel para que n&atilde;o fiquem mo&iacute;das. Tanto cruas como assadas, as castanhas podem perfeitamente conservar-se num congelador durante cerca de 6 meses.</p>
');
INSERT INTO answercontent VALUES (40, 13, '2014-06-07 19:53:36', '<p>C&aacute; vai mais uma dica do limbo cal&oacute;rico..... mas n&atilde;o muito acho eu !&nbsp;castanhas cruas, depois de descascadas, fritinhas como as batatas, em &oacute;leo muito quente durante uns 3 minutinhos at&eacute; estarem douradas (douradas e n&atilde;o acastanhadas caso contr&aacute;rio ficam muito duras) ficam um espect&aacute;culo e demoram muito menos tempo para se comer.... como n&atilde;o absorvem &oacute;leo, ficam mesmo como as assadas praticamente!</p>
');
INSERT INTO answercontent VALUES (41, 21, '2014-06-08 12:51:39', '<p>Aqui em casa faz-se uma coisa muito cla&oacute;rica mas optima:<br />
Coze-se os peitos sem pele em &aacute;gua e sal. &Agrave; parte coze-se batinha nova pequenina.<br />
Com a &aacute;gua do frango faz-se canja. Depois leva-se a carne e as batatas &agrave; fritadeira e aloura-se tudo.<br />
<br />
Toda a gente que j&aacute; comeu isso ADOROU e pede a receita.&nbsp;<br />
Espero que gostes, mas n&atilde;o sei se era isso que querias</p>
');
INSERT INTO answercontent VALUES (41, 21, '2014-06-08 12:51:50', '<p>Aqui em casa faz-se uma coisa muito cal&oacute;rica mas optima:<br />
Coze-se os peitos sem pele em &aacute;gua e sal. &Agrave; parte coze-se batinha nova pequenina.<br />
Com a &aacute;gua do frango faz-se canja. Depois leva-se a carne e as batatas &agrave; fritadeira e aloura-se tudo.<br />
<br />
Toda a gente que j&aacute; comeu isso ADOROU e pede a receita.&nbsp;<br />
Espero que gostes, mas n&atilde;o sei se era isso que querias</p>
');
INSERT INTO answercontent VALUES (42, 21, '2014-06-08 12:52:21', '<p>ol&aacute; a minha m&atilde;e costuma pincelar o frango com um molho de azeite, alho, &oacute;reg&atilde;os e piripiri.....<br />
<br />
deixa repousa e quando vai grahlar pincela novamente......<br />
<br />
fica bom e &eacute; simples</p>
');
INSERT INTO answercontent VALUES (43, 11, '2014-06-08 12:53:00', '<p>O molho q fa&ccedil;o para os grelhados &eacute;:<br />
- Azeite<br />
- alho esmagado<br />
- louro<br />
- tomilho<br />
- oreg&otilde;es<br />
- um raminho de salsa<br />
- 1 ou 2 colheres de tomate QB pimentos<br />
- vinho branco verde<br />
- sal e pimenta<br />
<br />
Misturo tudo muito bem e envolvo a carne toda com este molho. Deixo de um dia para outro ou algumas horas. Depois &eacute; so grelhar. Hummmmmm e com estes dias de sol n&atilde;o ha nada melhor nhami</p>
');
INSERT INTO answercontent VALUES (63, 19, '2014-06-08 13:19:17', '<p>Pois eu tamb&eacute;m demolho num pouco de &aacute;gua fria e depois levo a lume tamb&eacute;m para derreterem com um bocadinho de &aacute;gua et voil&aacute;!<br />
Mas cortadas talvez se dissolvam melhor.</p>
');
INSERT INTO answercontent VALUES (44, 11, '2014-06-08 12:53:40', '<p>Uma sugest&atilde;o simples e gostosa...<br />
Cozinhe o frango em &aacute;gua e sal. Deixe esfriar e desfie o frango, ou corte em min&uacute;sculos pedacinhos.<br />
Reserve.<br />
<br />
Corte uma cebola bem muidinha e coloque em uma panela com uma colher de sopa de margarina. Enquanto frita, dissolva 1 colher de sopa de amido de milho em uma x&iacute;cara de leite. Reserve. Coloque o frango na panela, e deixe refogar um pouquinho. Acrescente o leite, coloque mais 1/2 x&iacute;cara de leite(ou 1 depende da quantidade de frango) e deixe cozinhar mexendo sempre. Prove o sal, acrescente cheiro verde e requeij&atilde;o se tiver.<br />
Coloque em um refrat&aacute;rio e por cima espalhe batata palha<br />
Agora &eacute; s&oacute; comer!!!</p>
');
INSERT INTO answercontent VALUES (45, 12, '2014-06-08 12:54:17', '<p>aqui faz-se 1 g&eacute;nero de molho onde fica a marinar um tempinho antes de se fazer:<br />
<br />
colorau, pimenta da terra ou entao massa de pimentao, sal e alho cortado as rodelas.<br />
<br />
Depois coloca-se 1 pouco de vinho branco mas de tal forma que n&aacute;o chegue a fazer molho.<br />
<br />
Acho que se chama tempero &agrave; reginal e h&aacute; quem use tambem para fritar, mas nos churrasco &eacute; de comer e chorar por mais!!!</p>
');
INSERT INTO answercontent VALUES (46, 12, '2014-06-08 12:55:06', '<p>Cortas os peitos de frango em 3 ou 4 peda&ccedil;os e alouras em margarina.<br />
Temperas de sal e pimenta.<br />
Juntas tomate pelado aos bocadinhos e 1 pacote de sopa de cebola dissolvida em vinho branco verde.<br />
Tapas e deixas em lume brando uns 20 minutos.<br />
Juntas azeitonas descaro&ccedil;adas e pimento verde &agrave;s tirinhas.<br />
Rectificas o tempero e deixas cozer + 10 minutos.<br />
Polvilhas com oreg&atilde;os e serves com esparguete cozido.<br />
<br />
Nota - podes saltear o esparguete cozido em azeite e alho.</p>
');
INSERT INTO answercontent VALUES (47, 13, '2014-06-08 12:56:13', '<p>Eu pessoalmente gosto da carne sem nenhum outro molho. Mas tb n&atilde;o te posso ajudar pois n&atilde;o conhe&ccedil;o nenhum :(</p>
');
INSERT INTO answercontent VALUES (48, 14, '2014-06-08 12:56:52', '<p>Olha eu &agrave;s vezes uso os molhos de fondue!!! Encontras alguns aqui no forum. Eu acho que fica bem em especial o de alho e o da sopa de cebola</p>
');
INSERT INTO answercontent VALUES (49, 14, '2014-06-08 12:57:12', '<p>Peitinhos de frango ou mesmo o frango partido em bocados...<br />
<br />
Azeite no fundo do tacho, cebola as meias luas, alho as rodelas, salsa picada, pimento verde (facultativo), tomate de lata (1 peq.), vinho branco, sal e pimenta, p&otilde;e-se tudo ao mesmo tempo ao lume e quando come&ccedil;ar a ferver baixa-se para o minimo. C&aacute; em&nbsp; casa come-se com batata frita, arroz branco ou esparguete.<br />
<br />
Demora ai uma meia horita e &eacute; muito gostoso se gostarem podes juntar umas rodelinhas de lingiu&ccedil;a alentejan ou bacom que ainda fica melhor..<br />
<br />
<br />
Bom Apetite!!!!!!!!!!!!</p>
');
INSERT INTO answercontent VALUES (50, 15, '2014-06-08 13:00:02', '<p>4 coxas com pernas de frango,&nbsp;2 pitadas de rosmaninho triturado,&nbsp;sal<br />
tomate,&nbsp;colher&nbsp;sumo de lim&atilde;o,&nbsp;5 colhers de azeite,&nbsp;colher&nbsp;de mostarda,&nbsp;colher &nbsp;a&ccedil;&uacute;car,&nbsp;sal<br />
meio copo de vinho branco,&nbsp;2 colheres sumo&nbsp;lim&atilde;o,&nbsp;2 colheres azeite,&nbsp;pimenta preta<br />
<br />
Numa tigela funda p&ocirc;e-se as coxas com todos os ingredientes da marinada misturados e tapa-se.T&nbsp;emper&aacute;-las com sal.Faz-se o molho de tomate misturando todos os ingredientes.<br />
Poem-se as coxas na grelha depois de pincelada com &oacute;leo durante cerca de 40 minutos em lume n&atilde;o muito forte. Durante a assadura pincela-se com a marinada e 10 minutos antes de as tirar pincelam-se com o molho de tomate..</p>
');
INSERT INTO answercontent VALUES (51, 16, '2014-06-08 13:01:02', '<p>Um brinde:<br />
Enquanto o braseiro se faz atirar l&aacute; para o meio duas cebolas grandes.... quando estiverem bem esturricadas por fora, tira-las... deixar arrefecer um bocadinho, tirar as partes queimadas, passarpor &aacute;gua e desfolha-las... depois temperar com azeite, um cheirinho de vinagre e&nbsp; sal: um &oacute;pitmo acompanhamento...</p>
');
INSERT INTO answercontent VALUES (52, 16, '2014-06-08 13:01:20', '<p>podes por os peitos de frango directamente do congelador para o tacho s&oacute; demora &acute;mais um bocadinho a ficar pronto, eu acabei agora de fazer amanha para o almo&ccedil;o.</p>
');
INSERT INTO answercontent VALUES (53, 17, '2014-06-08 13:02:11', '<p>Azeite, Alhos partidos muito miudinhos, oregaos, piri-piri<br />
Leva-se a lume brando sem deixar queimar o alho.<br />
Junta-se Uma colher de sopa de Whisky e deixa se levantar fervura.<br />
<br />
Depois &eacute; s&oacute; pincelar as carnes com este molhinho e lamber os dedinhos na hora do churrasco...</p>
');
INSERT INTO answercontent VALUES (54, 18, '2014-06-08 13:02:38', '<p>Pois, eu costumo fazer um molho para opeixe grelhado (receita do meu pai)... fica muito bom....&nbsp;<br />
<br />
- Nun &quot;taxito&quot; pequeno, coloca-se manteiga vaqueiro, um pouqinho de azeite, 3 ou 4 alhos esmagados com casca, sumo de lim&atilde;o, pimentae colorau, quando come&ccedil;ar a ferver espera-se um pouquinho para a manteiga torrar..... e est&aacute; pronto......<br />
<br />
<br />
- Bom apetite......</p>
');
INSERT INTO answercontent VALUES (55, 22, '2014-06-08 13:10:31', '<p>Ol&aacute;, olha pelo que sei disso de ouvir outras meninas comentarem, o segredo &eacute; mesmo colocar o forno em temperatura baixa (150&ordm;), porque quer os de compra quer os caseiros se colocares no forno a temperaturas altas tipo 180&ordm; os rissois ficam secos e alguns a carne vem para fora. No tabuleiro de ir ao forno coloca uma folha de alum&iacute;nio e poe os rissois por cima e leva ao forno a 150&ordm; e a meio do tempo viras os rissois para ficarem iguais de ambos os lados. Espero ter ajudado :)</p>
');
INSERT INTO answercontent VALUES (56, 23, '2014-06-08 13:11:46', '<p>Fazes um refogado com cebola, alho e azeite. Qdo estiver a cebola transl&uacute;cida acrescentas a cenoura ralada e mexes. Deixas tomar gosto. Depois acrescentas a &aacute;gua e deixas ferver. Adicionas o arroz e deixa cozer.<br />
<br />
N&atilde;o esquecendo o sal... como eu!!!</p>
');
INSERT INTO answercontent VALUES (57, 23, '2014-06-08 13:12:04', '<p>Os peixinhos s&atilde;o douradinhos? Os douradinhos ficam muito bons, talvez porque j&aacute; tenham alguma gordura, mas os riss&oacute;is e afins, n&atilde;o ficam nada bem... Mais vale comer poucas vezes e em condi&ccedil;&otilde;es, digo eu!&nbsp; :)</p>
');
INSERT INTO answercontent VALUES (58, 12, '2014-06-08 13:15:27', '<p>Experimenta por se gostares!<br />
<br />
Eu s&oacute; utilizo caldo knorr no frango &agrave; maricas e nos caracois. Acho que faz um pouquinho mal para que tenha colesterol elevado, por isso evito...</p>
');
INSERT INTO answercontent VALUES (59, 12, '2014-06-08 13:15:50', '<p>O truke k eu conhe&ccedil;o (nem sei se &eacute; truke...) &eacute; demolhar as folhas de gelatina em &aacute;gua fria antes de as juntar &agrave; prepara&ccedil;&atilde;o...</p>
');
INSERT INTO answercontent VALUES (60, 16, '2014-06-08 13:17:10', '<p>O truque que eu conhe&ccedil;o &eacute; cortar as folhas com a tesoura e depois colocar pouca &aacute;gua ir ao lume numa ca&ccedil;arola sempre com o cabo na m&atilde;o e a fazer movimentos circulares (sem p&ocirc;r o tacho na boca) at&eacute; que elas se desfa&ccedil;am todas (a &aacute;gua n&atilde;o deve ferver e no fim fica amarela).<br />
<br />
Espero que resulte</p>
');
INSERT INTO answercontent VALUES (61, 13, '2014-06-08 13:17:39', '<p>&nbsp;Eu come&ccedil;o por cortas as folhas com a tesoura e demolho em &aacute;gua fria depois leve um bocadinho ao microondas e junto aquele liquido ao preparado, tem saido bem.<br />
<br />
<br />
<br />
Espero que resulte<br />
<br />
Sauda&ccedil;&otilde;es culin&aacute;rias!</p>
');
INSERT INTO answercontent VALUES (62, 18, '2014-06-08 13:18:45', '<p>Eu devo ser a mais pregui&ccedil;osa do grupo ..&nbsp;pois eu nem&nbsp; corto as folhas. Demolho-as, depois microondas e est&atilde;o prontas a ser usadas. Nao fizesse eu parte do club &quot;facil &eacute; q esta a dar&quot;&nbsp;</p>
');
INSERT INTO answercontent VALUES (64, 14, '2014-06-08 13:19:45', '<p>Eu corto para uma tacinha com uma tesoura e depois ponho no microondas at&eacute; ferver. Pronto!<br />
Super f&aacute;cil...</p>
');
INSERT INTO answercontent VALUES (65, 23, '2014-06-08 13:21:51', '<p>Nunca fiz...<br />
<br />
mas encontrei esta receita na net:&nbsp;<a href=\"http://www.receitasemenus.net/farturas_top.html\" target=\"_blank\">http://www.receitasemenus.net/farturas_top.html</a></p>
');
INSERT INTO answercontent VALUES (66, 20, '2014-06-08 13:23:40', '<p>Eu tamb&eacute;m uso quase sempre o emmental ralado e fica sempre bem.<br />
<br />
Um queijo que eu acho &oacute;ptimo para misturar nas massas (tem um sabor completamente diferente) &eacute; o Queijo da Ilha ralado.</p>
');
INSERT INTO answercontent VALUES (67, 21, '2014-06-08 13:24:16', '<p>Eu uso queijo terra nostra ralado. Tamb&eacute;m derrete e fica com 1 sabor muito bom</p>
');
INSERT INTO answercontent VALUES (68, 13, '2014-06-08 13:24:42', '<p>Para mim nao ha nada como o mozarela! Mas tb gosto de emmental!</p>
');
INSERT INTO answercontent VALUES (69, 16, '2014-06-08 13:25:16', '<p>pra mim basta ser...........queijo!!!!!!!!!!!!!!!!!!!!!!</p>
');
INSERT INTO answercontent VALUES (70, 18, '2014-06-08 13:28:41', '<p>Ponho na bimby ( uma lidificadora tb serve ), 3 laranjas descascadas com a faca para retirae toda a perte branca, 1 lim&atilde;o (para n&atilde;o deixar que o sumo oxide), abro os damascos retiro o caro&ccedil;o e junto , reduso tudo a pur&eacute;, junto agua bem fresquinha e ...... voil&aacute; um sumo mto agradavel</p>
');
INSERT INTO answercontent VALUES (71, 17, '2014-06-08 13:29:19', '<p>Eu adoro damascos!!!&nbsp;&nbsp;&nbsp;E tb temos um mas ainda pequeno. Este ano foi o 1&ordm; que deu fruta por isso ainda n&atilde;o tnho o vosso problema&nbsp;&nbsp;Mas j&aacute; agora gostei da ideia do sumo e tb gostaria de saber como se secam. Sim pq para o ano posso ter uma enchente de damascos&nbsp;</p>
');
INSERT INTO answercontent VALUES (72, 15, '2014-06-08 13:29:46', '<p>os damaskeiros um ano d&atilde;o mta fruta&nbsp; e no outro na d&atilde;o kase nada, por isso nanda, n&atilde;o te admires se para o ano tiveres poucos.<br />
Este ano o meu deu tanta fruta, ke ate partui pernadas com o peso&nbsp;</p>
');
INSERT INTO answercontent VALUES (73, 21, '2014-06-08 13:30:23', '<p>eu fiz um doce de ameixa...delicioso e inda assim...<br />
ha por aki tanta ameixa...</p>
');
INSERT INTO answercontent VALUES (74, 12, '2014-06-08 13:31:10', '<p>posso perguntar de k eskema falam?<br />
e k num percebo esta conversa...<br />
desculpem...<br />
eu fa&ccedil;o todos os doces da mesma maneira...<br />
1kg de fruta,no caso das ameixas so tirei os caro&ccedil;os pk gosto de encontrar pedacitos de pele...<br />
meio kilo de a&ccedil;ucar<br />
canela q.b.<br />
vai ao lume...<br />
ferve por meia hora...<br />
apago o fogao...<br />
deixo apurar por meia hora<br />
e varinha magica q.b.<br />
e e assim k fa&ccedil;o os doces...</p>
');
INSERT INTO answercontent VALUES (75, 14, '2014-06-08 21:01:18', '<p>Penso que era isto que procuravas!</p>

<blockquote>
<p><strong>Receita de Bacalhau no Forno com Maionese</strong></p>
<br />
<strong>Ingredientes:</strong>

<ul>
	<li>4 postas de bacalhau demolhado</li>
	<li>2 cebolas grandes</li>
	<li>2 dentes de alho</li>
	<li>2 copos de vinho branco</li>
	<li>1 fio de azeite</li>
	<li>1 litro de leite para cozer o bacalhau</li>
	<li>1 k batatas</li>
	<li>1/2 frasco de maionese</li>
	<li>azeitonas qb</li>
	<li>noz-moscada</li>
	<li>pimenta</li>
	<li>5 colheres de sopa de polpa de tomate</li>
	<li>150 gramas de manteiga</li>
	<li>1 copo de leite para o pur&eacute; de batata</li>
	<li>2 ovos</li>
	<li>1 gema batida</li>
	<li>1 assadeira de barro para levar ao forno</li>
	<li>sal qb</li>
</ul>

<p><strong>Prepara&ccedil;&atilde;o:</strong><br />
<br />
1. Cozer o bacalhau com 1 litro de leite e reservar.<br />
<br />
2. Cozer as batatas com &aacute;gua e sal para fazer pur&eacute;.<br />
Depois de cozidas passa-las pelo passe vite e adicionar o leite a manteiga os ovos e temperar com noz-moscada.<br />
Reservar o pur&eacute; de batata.<br />
<br />
3. Fazer o molho para regar o bacalhau.Colocar o fio de azeite num tacho cortar as cebolas em tiras fininhas e os dentes de alho e levar ao lume at&eacute; a cebola ficar lourinha.<br />
Adicionar o vinho branco e a polpa de tomate e deixar cozinhar em lume brando por 15 minutos.<br />
Adicionar pimenta a gosto e sal.<br />
<br />
4. Na assadeira colocar o bacalhau reservado no meio.<br />
Barrar o bacalhau com a maionese e regar com o molho feito anteriomente.<br />
Colocar o pur&eacute; de batata num saco de pasteleiro e fazer rosetas frisadas em volta do bacalhau.<br />
E com a gema batida pincelar o pur&eacute; para que fique lourinho no forno.<br />
Colocar 1 azeitona em cima de cada montinho de pur&eacute;.<br />
<br />
5. Levar ao forno a assadeira at&eacute; que o pur&eacute; fique dourado por cima.<br />
<br />
6. Servir com uma salada de tomate e alface.<br />
<br />
Bom apetite.</p>
</blockquote>
');
INSERT INTO answercontent VALUES (75, 14, '2014-06-08 21:10:14', '<p>Penso que era isto que procuravas!</p>

<p>&nbsp;</p>

<p><strong>Receita de Bacalhau no Forno com Maionese</strong></p>

<p><br />
<strong>Ingredientes:</strong></p>

<ul>
	<li>4 postas de bacalhau demolhado</li>
	<li>2 cebolas grandes</li>
	<li>2 dentes de alho</li>
	<li>2 copos de vinho branco</li>
	<li>1 fio de azeite</li>
	<li>1 litro de leite para cozer o bacalhau</li>
	<li>1 k batatas</li>
	<li>1/2 frasco de maionese</li>
	<li>azeitonas qb</li>
	<li>noz-moscada</li>
	<li>pimenta</li>
	<li>5 colheres de sopa de polpa de tomate</li>
	<li>150 gramas de manteiga</li>
	<li>1 copo de leite para o pur&eacute; de batata</li>
	<li>2 ovos</li>
	<li>1 gema batida</li>
	<li>1 assadeira de barro para levar ao forno</li>
	<li>sal qb</li>
</ul>

<p><strong>Prepara&ccedil;&atilde;o:</strong><br />
<br />
1. Cozer o bacalhau com 1 litro de leite e reservar.<br />
<br />
2. Cozer as batatas com &aacute;gua e sal para fazer pur&eacute;.<br />
Depois de cozidas passa-las pelo passe vite e adicionar o leite a manteiga os ovos e temperar com noz-moscada.<br />
Reservar o pur&eacute; de batata.<br />
<br />
3. Fazer o molho para regar o bacalhau.Colocar o fio de azeite num tacho cortar as cebolas em tiras fininhas e os dentes de alho e levar ao lume at&eacute; a cebola ficar lourinha.<br />
Adicionar o vinho branco e a polpa de tomate e deixar cozinhar em lume brando por 15 minutos.<br />
Adicionar pimenta a gosto e sal.<br />
<br />
4. Na assadeira colocar o bacalhau reservado no meio.<br />
Barrar o bacalhau com a maionese e regar com o molho feito anteriomente.<br />
Colocar o pur&eacute; de batata num saco de pasteleiro e fazer rosetas frisadas em volta do bacalhau.<br />
E com a gema batida pincelar o pur&eacute; para que fique lourinho no forno.<br />
Colocar 1 azeitona em cima de cada montinho de pur&eacute;.<br />
<br />
5. Levar ao forno a assadeira at&eacute; que o pur&eacute; fique dourado por cima.<br />
<br />
6. Servir com uma salada de tomate e alface.<br />
<br />
Bom apetite.</p>
');
INSERT INTO answercontent VALUES (76, 16, '2014-06-08 20:27:26', '<p>Ol&aacute;!</p>

<p>Tens aqui um video do grande <span dir=\"ltr\"><strong>Gordon Ramsey</strong>!</span></p>

<p><iframe allowfullscreen=\"\" frameborder=\"0\" height=\"315\" src=\"//www.youtube.com/embed/5uXIPhxL5XA\" width=\"560\"></iframe></p>

<p>&nbsp;</p>
');
INSERT INTO answercontent VALUES (76, 16, '2014-06-08 20:28:22', '<p>Ol&aacute;!</p>

<p>Tens aqui um video do grande <span dir=\"\\\"><strong>Gordon Ramsey</strong>!</span></p>

<p><iframe allowfullscreen=\"\" frameborder=\"0\" height=\"315\" src=\"http://www.youtube.com/embed/5uXIPhxL5XA\" width=\"560\"></iframe></p>

<p>&nbsp;</p>
');
INSERT INTO answercontent VALUES (76, 16, '2014-06-08 20:29:03', '<p>Ol&aacute;!</p>

<p>Tens aqui um video do grande <span dir=\"\\\"><strong>Gordon Ramsey</strong>!</span></p>

<p><iframe allowfullscreen=\"\" frameborder=\"0\" height=\"360\" src=\"//www.youtube.com/embed/5uXIPhxL5XA\" width=\"640\"></iframe></p>
');
INSERT INTO answercontent VALUES (76, 16, '2014-06-08 21:31:29', '<p>Ol&aacute;!</p>

<p>Tens aqui um video do grande <span dir="\"><strong>Gordon Ramsey</strong>!</span></p>

<p><iframe allowfullscreen="" frameborder="0" height="315" src="//www.youtube.com/embed/5uXIPhxL5XA" width="560"></iframe></p>
');
INSERT INTO answercontent VALUES (76, 16, '2014-06-08 20:35:32', '<p>Ol&aacute;!</p>

<p>Tens aqui um video do grande <span dir=\"\\\"><strong>Gordon Ramsey</strong>!</span><iframe allowfullscreen=\"\" frameborder=\"0\" height=\"315\" src=\"//www.youtube.com/embed/5uXIPhxL5XA\" width=\"560\"></iframe></p>
');
INSERT INTO answercontent VALUES (76, 16, '2014-06-08 23:44:07', '<p>Ol&aacute;!</p>

<p>Tens aqui um video do grande <span dir=\"\\\"><strong>Gordon Ramsey</strong>!</span></p>

<p><iframe allowfullscreen=\"\" frameborder=\"0\" height=\"315\" src=\"//www.youtube.com/embed/5uXIPhxL5XA\" width=\"560\"></iframe></p>
');
INSERT INTO answercontent VALUES (76, 16, '2014-06-08 23:47:14', '<p>Ol&aacute;!</p>

<p>Tens aqui um video do grande <span dir=\"\\\"><strong>Gordon Ramsey</strong>!</span></p>

<p>&nbsp;</p>

<p><iframe allowfullscreen=\"\" frameborder=\"0\" height=\"315\" src=\"//www.youtube.com/embed/5uXIPhxL5XA\" width=\"560\"></iframe></p>
');
INSERT INTO answercontent VALUES (76, 16, '2014-06-08 23:48:09', '<p>Ol&aacute;!</p>

<p>Tens aqui um video do grande <span dir=\"\\\"><strong>Gordon Ramsey</strong>!</span></p>

<p><iframe allowfullscreen=\"\" frameborder=\"0\" height=\"315\" src=\"//www.youtube.com/embed/5uXIPhxL5XA\" width=\"560\"></iframe></p>
');
INSERT INTO answercontent VALUES (76, 16, '2014-06-08 23:56:27', '<p>Ol&aacute;!</p>

<p>Tens aqui um video do grande <span dir=\"\\\"><strong>Gordon Ramsey</strong>!</span></p>

<p><iframe allowfullscreen=\"\" frameborder=\"0\" height=\"360\" src=\"//www.youtube.com/embed/5uXIPhxL5XA\" width=\"640\"></iframe></p>
');
INSERT INTO answercontent VALUES (76, 1, '2014-06-08 23:56:57', '<p>Ol&aacute;!</p>

<p>Tens aqui um video do grande <span dir=\"\\\"><strong>Gordon Ramsey</strong>!</span></p>

<p><iframe allowfullscreen=\"\" frameborder=\"0\" height=\"360\" src=\"//www.youtube.com/embed/5uXIPhxL5XA\" width=\"640\"></iframe></p>
');
INSERT INTO answercontent VALUES (76, 16, '2014-06-09 00:57:46', '<p>Ol&aacute;!</p>

<p>Tens aqui um video do grande <span dir="\"><strong>Gordon Ramsey</strong>!</span></p>

<p><iframe allowfullscreen="" frameborder="0" height="360" src="//www.youtube.com/embed/5uXIPhxL5XA" width="640"></iframe></p>
');
INSERT INTO answercontent VALUES (76, 1, '2014-06-08 23:58:24', '<p>Ol&aacute;!</p>

<p>Tens aqui um video do grande <span dir=\"\\\"><strong>Gordon Ramsey</strong>!</span></p>

<p><iframe allowfullscreen=\"\" frameborder=\"0\" height=\"360\" src=\"//www.youtube.com/embed/5uXIPhxL5XA\" width=\"640\"></iframe></p>
');
INSERT INTO answercontent VALUES (80, 28, '2014-06-11 10:25:45', '<p>Deixo-te aqui uma receita que encontrei.</p>
');
INSERT INTO answercontent VALUES (80, 28, '2014-06-11 10:26:33', '<p>Deixo-te aqui uma receita que encontrei.</p>

<p>Picar os cogumelos (piquei com uma faca, mas pode ser triturado, o resultado &eacute; que triturados ficam em pasta, mas optei por algo mais suave). Sec&aacute;-los numa frigideira anti-aderente bem quente, cerca de 10 minutos, at&eacute; ficar seco. Guardar no frigor&iacute;fico. Temperar a carne com sal e pimenta. Selar a carne em todos os seus lados em azeite bem quente. Depois de arrefecer um pouco, barrar com um pouco de mostarda. Guardar no frio. Colocar fatias de presunto estendidas umas ao lado das outras em cima de um pouco de pel&iacute;cula aderente. Barrar com os cogumelos. Colocar a carne no meio e enrolar bem apertadinho. Guardar de novo no frio cerca de meia hora. Estender a massa folhada e pincelar com gema de ovo. Colocar a carne, desembrulhada da pel&iacute;cula aderente, no meio da massa folhada e enrolar fechando dos lados. Voltar a guardar no frio cerca de 20 a 30 minutos Pincelar com mais ovo &agrave; volta da massa folhada. Colocar num tabuleiro que vai ao forno previamente aquecido a cerca de 180/200 graus. Fica no forno cerca de 40 minutos. Preparar o molho com um refogado de azeite com cebola e alho. Quando estiver tudo lourinho, colocar o vinagre e os 2 vinhos. Reduzir esta mistura a 1/4. Temperar com sal e pimenta. Colocar a margarina fria. Reduzir a 1/2. Est&aacute; ent&atilde;o pronto a acompanhar o bife&hellip; Quando a carne enrolada estiver pronta (basta controlar a massa folhada, os 40 minutos bastam), deix&aacute;-la repousar 10 minutos. Parti-la em fatias grossas. Est&aacute; pronto a servir, acompanhado do molho, que faz toda a diferen&ccedil;a, e acompanhamentos que pretendam... Regra geral serve com pur&eacute;, podem tamb&eacute;m cozer uns legumes adicionalmente ou salte&aacute;-los.</p>
');


--
-- Data for Name: answervote; Type: TABLE DATA; Schema: public; Owner: lbaw1315
--

INSERT INTO answervote VALUES (3, 2, 1);
INSERT INTO answervote VALUES (3, 6, 1);
INSERT INTO answervote VALUES (4, 6, 1);
INSERT INTO answervote VALUES (5, 5, 1);
INSERT INTO answervote VALUES (4, 5, 1);
INSERT INTO answervote VALUES (3, 5, 1);
INSERT INTO answervote VALUES (6, 2, 1);
INSERT INTO answervote VALUES (5, 2, 1);
INSERT INTO answervote VALUES (7, 10, 1);
INSERT INTO answervote VALUES (8, 10, 1);
INSERT INTO answervote VALUES (9, 11, 1);
INSERT INTO answervote VALUES (10, 11, 1);
INSERT INTO answervote VALUES (14, 14, 1);
INSERT INTO answervote VALUES (17, 14, 1);
INSERT INTO answervote VALUES (34, 18, 1);
INSERT INTO answervote VALUES (7, 22, 1);
INSERT INTO answervote VALUES (8, 22, 1);
INSERT INTO answervote VALUES (10, 22, 1);
INSERT INTO answervote VALUES (11, 22, 1);
INSERT INTO answervote VALUES (13, 22, 1);
INSERT INTO answervote VALUES (17, 22, 1);
INSERT INTO answervote VALUES (18, 22, 1);
INSERT INTO answervote VALUES (20, 22, 1);
INSERT INTO answervote VALUES (21, 22, 1);
INSERT INTO answervote VALUES (29, 22, 1);
INSERT INTO answervote VALUES (24, 22, 1);
INSERT INTO answervote VALUES (34, 22, 1);
INSERT INTO answervote VALUES (39, 22, 1);
INSERT INTO answervote VALUES (49, 22, 1);
INSERT INTO answervote VALUES (43, 22, 1);
INSERT INTO answervote VALUES (70, 15, 1);
INSERT INTO answervote VALUES (75, 24, 1);
INSERT INTO answervote VALUES (65, 14, -1);
INSERT INTO answervote VALUES (76, 25, 1);
INSERT INTO answervote VALUES (74, 1, 1);


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: lbaw1315
--

INSERT INTO country VALUES (1, 'Afghanistan');
INSERT INTO country VALUES (2, 'Albania');
INSERT INTO country VALUES (3, 'Algeria');
INSERT INTO country VALUES (4, 'American Samoa');
INSERT INTO country VALUES (5, 'Andorra');
INSERT INTO country VALUES (6, 'Angola');
INSERT INTO country VALUES (7, 'Anguilla');
INSERT INTO country VALUES (8, 'Antarctica');
INSERT INTO country VALUES (9, 'Antiqua and Barbuda');
INSERT INTO country VALUES (10, 'Argentina');
INSERT INTO country VALUES (11, 'Armenia');
INSERT INTO country VALUES (12, 'Aruba');
INSERT INTO country VALUES (13, 'Australia');
INSERT INTO country VALUES (14, 'Austria');
INSERT INTO country VALUES (15, 'Azerbaijan');
INSERT INTO country VALUES (16, 'Bahamas');
INSERT INTO country VALUES (17, 'Bahrain');
INSERT INTO country VALUES (18, 'Bangladesh');
INSERT INTO country VALUES (19, 'Barbados');
INSERT INTO country VALUES (20, 'Belarus');
INSERT INTO country VALUES (21, 'Belgium');
INSERT INTO country VALUES (22, 'Belize');
INSERT INTO country VALUES (23, 'Benin');
INSERT INTO country VALUES (24, 'Bermuda');
INSERT INTO country VALUES (25, 'Bhutan');
INSERT INTO country VALUES (26, 'Bolivia');
INSERT INTO country VALUES (27, 'Bosnia and Herzegovina');
INSERT INTO country VALUES (28, 'Botswana');
INSERT INTO country VALUES (29, 'Brazil');
INSERT INTO country VALUES (30, 'British Indian Ocean Territory');
INSERT INTO country VALUES (31, 'British Virgin Islands');
INSERT INTO country VALUES (32, 'Brunei');
INSERT INTO country VALUES (33, 'Bulgaria');
INSERT INTO country VALUES (34, 'Burkina Faso');
INSERT INTO country VALUES (35, 'Burma (Myanmar)');
INSERT INTO country VALUES (36, 'Burundi');
INSERT INTO country VALUES (37, 'Cambodia');
INSERT INTO country VALUES (38, 'Cameroon');
INSERT INTO country VALUES (39, 'Canada');
INSERT INTO country VALUES (40, 'Cape Verde');
INSERT INTO country VALUES (41, 'Cayman Islands');
INSERT INTO country VALUES (42, 'Central African Republic');
INSERT INTO country VALUES (43, 'Chad');
INSERT INTO country VALUES (44, 'Chile');
INSERT INTO country VALUES (45, 'China');
INSERT INTO country VALUES (46, 'Christmas Island');
INSERT INTO country VALUES (47, 'Cocos (Keeling) Islands');
INSERT INTO country VALUES (48, 'Colombia');
INSERT INTO country VALUES (49, 'Comoros');
INSERT INTO country VALUES (50, 'Cook Islands');
INSERT INTO country VALUES (51, 'Costa Rica');
INSERT INTO country VALUES (52, 'Croatia');
INSERT INTO country VALUES (53, 'Cuba');
INSERT INTO country VALUES (54, 'Cyprus');
INSERT INTO country VALUES (55, 'Czech Republic');
INSERT INTO country VALUES (56, 'Democratic Republic of the Congo');
INSERT INTO country VALUES (57, 'Denmark');
INSERT INTO country VALUES (58, 'Djibouti');
INSERT INTO country VALUES (59, 'Dominica');
INSERT INTO country VALUES (60, 'Dominican Republic');
INSERT INTO country VALUES (61, 'Ecuador');
INSERT INTO country VALUES (62, 'Egypt');
INSERT INTO country VALUES (63, 'El Salvador');
INSERT INTO country VALUES (64, 'Equatorial Guinea');
INSERT INTO country VALUES (65, 'Eritrea');
INSERT INTO country VALUES (66, 'Estonia');
INSERT INTO country VALUES (67, 'Ethiopia');
INSERT INTO country VALUES (68, 'Falkland Islands');
INSERT INTO country VALUES (69, 'Faroe Islands');
INSERT INTO country VALUES (70, 'Fiji');
INSERT INTO country VALUES (71, 'Finland');
INSERT INTO country VALUES (72, 'France');
INSERT INTO country VALUES (73, 'French Polynesia');
INSERT INTO country VALUES (74, 'Gabon');
INSERT INTO country VALUES (75, 'Gambia');
INSERT INTO country VALUES (76, 'Gaza Strip');
INSERT INTO country VALUES (77, 'Georgia');
INSERT INTO country VALUES (78, 'Germany');
INSERT INTO country VALUES (79, 'Ghana');
INSERT INTO country VALUES (80, 'Gibraltar');
INSERT INTO country VALUES (81, 'Greece');
INSERT INTO country VALUES (82, 'Greenland');
INSERT INTO country VALUES (83, 'Grenada');
INSERT INTO country VALUES (84, 'Guam');
INSERT INTO country VALUES (85, 'Guatemala');
INSERT INTO country VALUES (86, 'Guinea');
INSERT INTO country VALUES (87, 'Guinea-Bissau');
INSERT INTO country VALUES (88, 'Guyana');
INSERT INTO country VALUES (89, 'Haiti');
INSERT INTO country VALUES (90, 'Honduras ');
INSERT INTO country VALUES (91, 'Hong Kong');
INSERT INTO country VALUES (92, 'Hungary');
INSERT INTO country VALUES (93, 'Iceland');
INSERT INTO country VALUES (94, 'India');
INSERT INTO country VALUES (95, 'Indonesia');
INSERT INTO country VALUES (96, 'Iran');
INSERT INTO country VALUES (97, 'Iraq');
INSERT INTO country VALUES (98, 'Ireland');
INSERT INTO country VALUES (99, 'Isle of Man');
INSERT INTO country VALUES (100, 'Israel');
INSERT INTO country VALUES (101, 'Italy');
INSERT INTO country VALUES (102, 'Ivory Coast');
INSERT INTO country VALUES (103, 'Jamaica');
INSERT INTO country VALUES (104, 'Japan');
INSERT INTO country VALUES (105, 'Jersey');
INSERT INTO country VALUES (106, 'Jordan');
INSERT INTO country VALUES (107, 'Kazakhstan');
INSERT INTO country VALUES (108, 'Kenya');
INSERT INTO country VALUES (109, 'Kiribati');
INSERT INTO country VALUES (110, 'Kosovo');
INSERT INTO country VALUES (111, 'Kuwait');
INSERT INTO country VALUES (112, 'Kyrgyzstan');
INSERT INTO country VALUES (113, 'Laos');
INSERT INTO country VALUES (114, 'Latvia');
INSERT INTO country VALUES (115, 'Lebanon');
INSERT INTO country VALUES (116, 'Lesotho');
INSERT INTO country VALUES (117, 'Liberia');
INSERT INTO country VALUES (118, 'Libya');
INSERT INTO country VALUES (119, 'Liechtenstein');
INSERT INTO country VALUES (120, 'Lithuania');
INSERT INTO country VALUES (121, 'Luxembourg');
INSERT INTO country VALUES (122, 'Macaus');
INSERT INTO country VALUES (123, 'Macedonia');
INSERT INTO country VALUES (124, 'Madagascar');
INSERT INTO country VALUES (125, 'Malawi');
INSERT INTO country VALUES (126, 'Malaysia');
INSERT INTO country VALUES (127, 'Maldives');
INSERT INTO country VALUES (128, 'Mali');
INSERT INTO country VALUES (129, 'Malta');
INSERT INTO country VALUES (130, 'Marshall Islands');
INSERT INTO country VALUES (131, 'Mauritania');
INSERT INTO country VALUES (132, 'Mauritius');
INSERT INTO country VALUES (133, 'Mayotte');
INSERT INTO country VALUES (134, 'Mexico');
INSERT INTO country VALUES (135, 'Micronesia');
INSERT INTO country VALUES (136, 'Moldova');
INSERT INTO country VALUES (137, 'Monaco');
INSERT INTO country VALUES (138, 'Mongolia');
INSERT INTO country VALUES (139, 'Montenegro');
INSERT INTO country VALUES (140, 'Montserrat');
INSERT INTO country VALUES (141, 'Morocco');
INSERT INTO country VALUES (142, 'Mozambique');
INSERT INTO country VALUES (143, 'Namibia');
INSERT INTO country VALUES (144, 'Nauru');
INSERT INTO country VALUES (145, 'Nepal');
INSERT INTO country VALUES (146, 'Netherlands');
INSERT INTO country VALUES (147, 'Netherlands Antilles');
INSERT INTO country VALUES (148, 'New Caledonia');
INSERT INTO country VALUES (149, 'New Zealand');
INSERT INTO country VALUES (150, 'Nicaragua');
INSERT INTO country VALUES (151, 'Niger');
INSERT INTO country VALUES (152, 'Nigeria');
INSERT INTO country VALUES (153, 'Niue');
INSERT INTO country VALUES (154, 'Norfolk Island');
INSERT INTO country VALUES (155, 'North Korea');
INSERT INTO country VALUES (156, 'Northern Mariana Islands');
INSERT INTO country VALUES (157, 'Norway');
INSERT INTO country VALUES (158, 'Oman');
INSERT INTO country VALUES (159, 'Pakistan');
INSERT INTO country VALUES (160, 'Palau');
INSERT INTO country VALUES (161, 'Panama');
INSERT INTO country VALUES (162, 'Papua New Guinea');
INSERT INTO country VALUES (163, 'Paraguay');
INSERT INTO country VALUES (164, 'Peru');
INSERT INTO country VALUES (165, 'Philippines');
INSERT INTO country VALUES (166, 'Pitcairn Islands');
INSERT INTO country VALUES (167, 'Poland');
INSERT INTO country VALUES (168, 'Portugal');
INSERT INTO country VALUES (169, 'Puerto Rico');
INSERT INTO country VALUES (170, 'Qatar');
INSERT INTO country VALUES (171, 'Republic of the Congo');
INSERT INTO country VALUES (172, 'Romania');
INSERT INTO country VALUES (173, 'Russia');
INSERT INTO country VALUES (174, 'Rwanda');
INSERT INTO country VALUES (175, 'Saint Barthelemy');
INSERT INTO country VALUES (176, 'Saint Helena');
INSERT INTO country VALUES (177, 'Saint Kitts and Nevis');
INSERT INTO country VALUES (178, 'Saint Lucia');
INSERT INTO country VALUES (179, 'Saint Martin');
INSERT INTO country VALUES (180, 'Saint Pierre and Miquelon');
INSERT INTO country VALUES (181, 'Saint Vincent and the Grenadines');
INSERT INTO country VALUES (182, 'Samoa');
INSERT INTO country VALUES (183, 'San Marino');
INSERT INTO country VALUES (184, 'Sao Tome and Principe');
INSERT INTO country VALUES (185, 'Saudi Arabia');
INSERT INTO country VALUES (186, 'Senegal');
INSERT INTO country VALUES (187, 'Serbia');
INSERT INTO country VALUES (188, 'Seychelles');
INSERT INTO country VALUES (189, 'Sierra Leone');
INSERT INTO country VALUES (190, 'Singapore');
INSERT INTO country VALUES (191, 'Slovakia');
INSERT INTO country VALUES (192, 'Slovenia');
INSERT INTO country VALUES (193, 'Solomon Islands');
INSERT INTO country VALUES (194, 'Somalia');
INSERT INTO country VALUES (195, 'South Africa');
INSERT INTO country VALUES (196, 'South Korea');
INSERT INTO country VALUES (197, 'Spain');
INSERT INTO country VALUES (198, 'Sri Lanka');
INSERT INTO country VALUES (199, 'Sudan');
INSERT INTO country VALUES (200, 'Suriname');
INSERT INTO country VALUES (201, 'Svalbard');
INSERT INTO country VALUES (202, 'Swaziland');
INSERT INTO country VALUES (203, 'Sweden');
INSERT INTO country VALUES (204, 'Switzerland');
INSERT INTO country VALUES (205, 'Syria');
INSERT INTO country VALUES (206, 'Taiwan');
INSERT INTO country VALUES (207, 'Tajikistan');
INSERT INTO country VALUES (208, 'Tanzania');
INSERT INTO country VALUES (209, 'Thailand');
INSERT INTO country VALUES (210, 'Timor-Leste');
INSERT INTO country VALUES (211, 'Togo');
INSERT INTO country VALUES (212, 'Tokelau');
INSERT INTO country VALUES (213, 'Tonga');
INSERT INTO country VALUES (214, 'Trinidad and Tobago');
INSERT INTO country VALUES (215, 'Tunisia');
INSERT INTO country VALUES (216, 'Turkey');
INSERT INTO country VALUES (217, 'Turkmenistan');
INSERT INTO country VALUES (218, 'Turks and Caicos Islands');
INSERT INTO country VALUES (219, 'Tuvalu');
INSERT INTO country VALUES (220, 'Uganda');
INSERT INTO country VALUES (221, 'Ukraine');
INSERT INTO country VALUES (222, 'United Arab Emirates');
INSERT INTO country VALUES (223, 'United Kingdom');
INSERT INTO country VALUES (224, 'United States');
INSERT INTO country VALUES (225, 'Uruguay');
INSERT INTO country VALUES (226, 'US Virgin Islands');
INSERT INTO country VALUES (227, 'Uzbekistan');
INSERT INTO country VALUES (228, 'Vanuatu');
INSERT INTO country VALUES (229, 'Vatican City');
INSERT INTO country VALUES (230, 'Venezuela');
INSERT INTO country VALUES (231, 'Vietnam');
INSERT INTO country VALUES (232, 'Wallis and Futuna');
INSERT INTO country VALUES (233, 'West Bank');
INSERT INTO country VALUES (234, 'Western Sahara');
INSERT INTO country VALUES (235, 'Yemen');
INSERT INTO country VALUES (236, 'Zambia');
INSERT INTO country VALUES (237, 'Zimbabwe');


--
-- Name: country_idcountry_seq; Type: SEQUENCE SET; Schema: public; Owner: lbaw1315
--

SELECT pg_catalog.setval('country_idcountry_seq', 237, true);


--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: lbaw1315
--

INSERT INTO question VALUES (14, 'Formas pudim', '2014-06-07 19:16:45', 1, 0, 14);
INSERT INTO question VALUES (6, 'Onde Comprar Receitas?', '2014-06-04 20:51:31', 1, 0, 5);
INSERT INTO question VALUES (11, 'Baunilha', '2014-06-07 19:03:56', 1, 0, 13);
INSERT INTO question VALUES (16, 'Margarina para folhados', '2014-06-07 19:29:48', 1, 0, 16);
INSERT INTO question VALUES (19, 'carne de crocodilo????', '2014-06-07 19:45:50', 1, 0, 18);
INSERT INTO question VALUES (13, 'Doce de leite?', '2014-06-07 19:15:55', 0, 0, 14);
INSERT INTO question VALUES (21, 'Salgadinhos para fazer ', '2014-06-07 20:00:38', 0, 0, 12);
INSERT INTO question VALUES (26, 'Farturas', '2014-06-08 13:21:18', 3, 0, 19);
INSERT INTO question VALUES (27, 'Queijos', '2014-06-08 13:23:08', 0, 0, 18);
INSERT INTO question VALUES (28, 'secar damascos', '2014-06-08 13:27:53', 1, 0, 24);
INSERT INTO question VALUES (7, 'Como fazer Omoletes?', '2014-06-06 23:50:25', 1, 0, 7);
INSERT INTO question VALUES (4, 'Claras em castelo', '2014-06-04 19:58:55', 2, 0, 2);
INSERT INTO question VALUES (8, 'Melhor marca de caril', '2014-06-07 11:25:36', 1, 0, 10);
INSERT INTO question VALUES (10, 'Cheesecake', '2014-06-07 18:59:03', 0, 0, 11);
INSERT INTO question VALUES (12, 'Maçã assada', '2014-06-07 19:14:58', 0, 0, 14);
INSERT INTO question VALUES (17, 'Bolo de nata parece tarte', '2014-06-07 19:31:00', 0, 0, 16);
INSERT INTO question VALUES (18, 'Sementes finas e longas', '2014-06-07 19:41:06', 1, 0, 17);
INSERT INTO question VALUES (20, 'Castanhas', '2014-06-07 19:51:45', 0, 0, 19);
INSERT INTO question VALUES (22, 'Receita rápida e fácil', '2014-06-08 12:49:38', 1, 0, 20);
INSERT INTO question VALUES (30, 'Diferentes tipos de massa', '2014-06-08 19:01:20', 0, 0, 5);
INSERT INTO question VALUES (29, 'Camarão', '2014-06-08 19:00:00', 0, 0, 5);
INSERT INTO question VALUES (23, 'churrasco', '2014-06-08 12:50:33', 1, 0, 20);
INSERT INTO question VALUES (33, 'Como escalfar um ovo', '2014-06-11 10:32:37', 0, 0, 28);
INSERT INTO question VALUES (9, 'Brigadeiros', '2014-06-07 18:56:39', 0, 0, 11);
INSERT INTO question VALUES (25, 'folhas de gelatina', '2014-06-08 13:13:08', 0, 0, 23);
INSERT INTO question VALUES (31, 'Receita de Bacalhau', '2014-06-08 19:32:24', 1, 0, 24);
INSERT INTO question VALUES (5, 'Risotto de camarão', '2014-06-04 20:19:32', 3, 0, 6);
INSERT INTO question VALUES (15, 'Amêijoas congeladas', '2014-06-07 19:24:08', 2, 0, 15);
INSERT INTO question VALUES (24, 'Arroz de cenoura', '2014-06-08 13:05:51', 0, 0, 22);
INSERT INTO question VALUES (32, 'Beef Wellington', '2014-06-08 20:25:33', 2, 0, 25);


--
-- Name: question_idquestion_seq; Type: SEQUENCE SET; Schema: public; Owner: lbaw1315
--

SELECT pg_catalog.setval('question_idquestion_seq', 33, true);


--
-- Data for Name: questioncomment; Type: TABLE DATA; Schema: public; Owner: lbaw1315
--

INSERT INTO questioncomment VALUES (1, 10, '2014-06-07 11:19:42', 7);
INSERT INTO questioncomment VALUES (2, 22, '2014-06-08 19:36:25', 31);
INSERT INTO questioncomment VALUES (4, 28, '2014-06-11 10:27:01', 32);


--
-- Name: questioncomment_idcomment_seq; Type: SEQUENCE SET; Schema: public; Owner: lbaw1315
--

SELECT pg_catalog.setval('questioncomment_idcomment_seq', 4, true);


--
-- Data for Name: questioncommentcontent; Type: TABLE DATA; Schema: public; Owner: lbaw1315
--

INSERT INTO questioncommentcontent VALUES (1, 10, '2014-06-07 11:19:42', '<p>parece-me uma boa quest&atilde;o</p>
');
INSERT INTO questioncommentcontent VALUES (2, 22, '2014-06-08 19:36:25', '<p>Eu tenho uma receita desse tipo que leva por cima da maionese cebola, ser&aacute; essa a receita que procuras?<br />
Eu vou procurar a receita nos meus cadernos e depois posso-te enviar.</p>
');
INSERT INTO questioncommentcontent VALUES (4, 28, '2014-06-11 10:27:01', '<p>Nunca experimentei mas abriste-me o apetite</p>
');


--
-- Data for Name: questioncontent; Type: TABLE DATA; Schema: public; Owner: lbaw1315
--

INSERT INTO questioncontent VALUES (2, 4, '<p>Ol&aacute; amigos e amigas.</p>

<p>Fiz um bolo que levava as claras em castelo.<br />
Bati as claras em castelo,e verifiquei que n&atilde;o caiam.<br />
Continuei a fazer o resto do bolo, quando fui para colocar as claras no resto da massa, no fundo das claras tinham um liquido.<br />
Isso &eacute; normal?</p>
', '2014-06-04 19:58:55');
INSERT INTO questioncontent VALUES (6, 5, '<p>Como saber se o nosso risotto de camar&atilde;o est&aacute; cozido no ponto?</p>
', '2014-06-04 20:19:32');
INSERT INTO questioncontent VALUES (6, 5, '<p>Como saber se o nosso risotto de camar&atilde;o est&aacute; cozido no ponto certo?</p>
', '2014-06-04 20:43:51');
INSERT INTO questioncontent VALUES (5, 6, '<p>Ol&aacute;!<br />
<br />
Tenho um livro de receitas com coisas muito giras, mas o meu problema &eacute; que n&atilde;o consigo encontrar a maioria dos ingredientes. Algu&eacute;m me sabe dizer lojas onde posso comprar essas coisas?<br />
<br />
Alguns exemplos:<br />
cravo da &iacute;ndia<br />
vagens de cardamono<br />
sementes de coentro<br />
vagens de curcuma<br />
bok choy (&eacute; uma esp&eacute;cie de alface usada muito na &Aacute;sia)<br />
entre muitos outros...</p>
', '2014-06-04 20:51:31');
INSERT INTO questioncontent VALUES (7, 7, '<p>Ol&aacute; amigos!</p>

<p>Podem-me indicar a melhor maneira de fazer omoletes por favor?</p>
', '2014-06-06 23:50:25');
INSERT INTO questioncontent VALUES (10, 8, '<p>Ol&aacute;.</p>

<p>Qual a marca de caril em p&oacute; que recomendam?</p>

<p>Gosto muito de caril. Mas a composi&ccedil;&atilde;o varia de marca para marca.<br />
Alguns cheiram a massa de dentista, daquela horr&iacute;vel para chumbar os dentes.</p>
', '2014-06-07 11:25:36');
INSERT INTO questioncontent VALUES (11, 9, '<p>Boa Tarde&nbsp; &nbsp;<img alt=\"Wink\" src=\"http://www.petiscos.com/smf/Smileys/default/wink.gif\" /><br />
<br />
Eu tive um acidente com uns brigadeiros que tentei fazer. J&aacute; fiz uma vez e ficou muito bem mas desta vez n&atilde;o ficaram nada bem. Ent&atilde;o foi assim eu fiz tudo como a receita manda. Quando fui para fazer as bolas n&atilde;o consegui, molhei as m&atilde;os com oleo como dizia nada feito experimentei com azeite tambem sem sucesso e tentei com manteiga que outra receita falava e tamb&eacute;m n&atilde;o deu porque a massa colava-se as m&atilde;o n&atilde;o dava nem por nada formar uma bola.<br />
<br />
Ser&aacute; que algu&eacute;m me dar uma ajudinha para tentar perceber o que fiz de mal?&nbsp;</p>
', '2014-06-07 18:56:39');
INSERT INTO questioncontent VALUES (11, 9, '<p>Boa Tarde&nbsp;<img alt=\"smiley\" src=\"http://gnomo.fe.up.pt/~lbaw1315/final/lib/ckeditor/plugins/smiley/images/regular_smile.png\" style=\"height:23px; width:23px\" title=\"smiley\" /><br />
<br />
Eu tive um acidente com uns brigadeiros que tentei fazer. J&aacute; fiz uma vez e ficou muito bem mas desta vez n&atilde;o ficaram nada bem. Ent&atilde;o foi assim eu fiz tudo como a receita manda. Quando fui para fazer as bolas n&atilde;o consegui, molhei as m&atilde;os com oleo como dizia nada feito experimentei com azeite tambem sem sucesso e tentei com manteiga que outra receita falava e tamb&eacute;m n&atilde;o deu porque a massa colava-se as m&atilde;o n&atilde;o dava nem por nada formar uma bola.<br />
<br />
Ser&aacute; que algu&eacute;m me dar uma ajudinha para tentar perceber o que fiz de mal?&nbsp;</p>
', '2014-06-07 18:56:59');
INSERT INTO questioncontent VALUES (11, 10, '<p>Como fazer um cheesecake de frutos vermelhos para uma festa?</p>
', '2014-06-07 18:59:03');
INSERT INTO questioncontent VALUES (13, 11, '<p>Nunca usei baunilha...<br />
Do que pesquisei, o melhor &eacute; usar vagem de baunilha, mas &eacute; o mais dispendioso.<br />
Algu&eacute;m me explica a diferen&ccedil;a entre aroma, ess&ecirc;ncia, extracto e baunilha em p&oacute;?<br />
O que costumam utilizar e em que quantidades? Tamb&eacute;m li que quantidade em excesso estraga o sabor...</p>
', '2014-06-07 19:03:56');
INSERT INTO questioncontent VALUES (11, 9, '<p>Boa Tarde<br />
<br />
Eu tive um acidente com uns brigadeiros que tentei fazer. J&aacute; fiz uma vez e ficou muito bem mas desta vez n&atilde;o ficaram nada bem. Ent&atilde;o foi assim eu fiz tudo como a receita manda. Quando fui para fazer as bolas n&atilde;o consegui, molhei as m&atilde;os com oleo como dizia nada feito experimentei com azeite tambem sem sucesso e tentei com manteiga que outra receita falava e tamb&eacute;m n&atilde;o deu porque a massa colava-se as m&atilde;o n&atilde;o dava nem por nada formar uma bola.<br />
<br />
Ser&aacute; que algu&eacute;m me dar uma ajudinha para tentar perceber o que fiz de mal?&nbsp;</p>
', '2014-06-07 19:08:50');
INSERT INTO questioncontent VALUES (14, 12, '<p>Boas!<br />
<br />
H&aacute; pouco tempo cruzei-me pela net com uma receita de ma&ccedil;&atilde; assada, que tenho ideia q consistia em cortar a ma&ccedil;&atilde; &aacute;s rodelas, polvilhar com a&ccedil;&uacute;car e depois voltar a &quot;montar&quot; a ma&ccedil;&atilde; e levar ao forno a assar, mas agora n&atilde;o consigo encontrar essa receita...<br />
<br />
por acaso algu&eacute;m tem ideia do que se trata, ou tamb&eacute;m se cruzou com a mesma receita que eu?!&nbsp;<img alt=\"Cheesy\" src=\"http://www.petiscos.com/smf/Smileys/default/cheesy.gif\" /><br />
<br />
Em &uacute;ltimo caso vou experimentar conforme me lembro... mas gostava de ver melhor se n&atilde;o me escapa nenhum pormenor...<br />
<br />
se algu&eacute;m puder ajudar... obrigada!</p>
', '2014-06-07 19:14:58');
INSERT INTO questioncontent VALUES (14, 12, '<p>Boas!<br />
<br />
H&aacute; pouco tempo cruzei-me pela net com uma receita de ma&ccedil;&atilde; assada, que tenho ideia q consistia em cortar a ma&ccedil;&atilde; &aacute;s rodelas, polvilhar com a&ccedil;&uacute;car e depois voltar a &quot;montar&quot; a ma&ccedil;&atilde; e levar ao forno a assar, mas agora n&atilde;o consigo encontrar essa receita...<br />
<br />
por acaso algu&eacute;m tem ideia do que se trata, ou tamb&eacute;m se cruzou com a mesma receita que eu?!&nbsp;<br />
<br />
Em &uacute;ltimo caso vou experimentar conforme me lembro... mas gostava de ver melhor se n&atilde;o me escapa nenhum pormenor...<br />
<br />
se algu&eacute;m puder ajudar... obrigada!</p>
', '2014-06-07 19:15:09');
INSERT INTO questioncontent VALUES (14, 13, '<p>Por acaso alguma menina brasileira aqui do forum me diz o que &eacute; que chamam&nbsp;doce de leite. E&nbsp;creme de&nbsp;leite?&nbsp;&acute;.&Eacute; que aparecem em muitas receitas postas&nbsp; e n&atilde;o sei oq ue ser&aacute;. Obrigada</p>
', '2014-06-07 19:15:55');
INSERT INTO questioncontent VALUES (14, 14, '<p>Ando agora na onda dos pudins de ovos, a experimentar varias receitas que vou tirando daqui.<br />
Mas h&aacute; uma duvida que tenho, &eacute; sobre o tamanho destas, que nas receitas nunca dizem qual &eacute;.<br />
Gostava de saber qual &eacute; o tamanho que devo comprar para um pudim que leve 12 ovos e que fique tipo os dos restaurantes. Tenho uma de medida 16 mas &eacute; pequena, come-se logo o pudim todo&nbsp;&nbsp;lol<br />
Aguardo as vossas dicas!</p>
', '2014-06-07 19:16:45');
INSERT INTO questioncontent VALUES (15, 15, '<p>Como &eacute; que se utilizam as ameijoas congeladas?<br />
J&aacute; v&ecirc;m sem areia, ou &eacute; preciso lavar?<br />
Cozinha-se congelado ou &eacute; necess&aacute;rio deixar descongelar?</p>
', '2014-06-07 19:24:08');
INSERT INTO questioncontent VALUES (16, 16, '<p>Ol&aacute;.J&aacute; ando algum tempo &aacute; procura deste tipo de margarina,j&aacute; procurei em tudo o que &eacute; super e hipermercado e nada...<br />
Procurei tambem na Net e a unica coisa que encontrei foi um post de uma pessoa que dizia,que &eacute; dificil de arranjar,e que ela pr&oacute;pia s&oacute; a conseguia encontrar num determinado local,n&atilde;o referindo no entanto qual.<br />
Alguem conhe&ccedil;e algum sitio onde se venda ?De preferencia que d&ecirc; para encomendar online.<br />
E j&aacute; agora.Sabem-me dizer se a massa folhada pode ser feita com margarina normal?Eu penso que n&atilde;o,mas...<br />
<br />
Desde j&aacute;, muito obrigado.</p>
', '2014-06-07 19:29:48');
INSERT INTO questioncontent VALUES (16, 17, '<p>Costumo fazer a seguinte receita de bolo de natas:<br />
2 Pacotes de natas<br />
3 Ch&aacute;venas de Ch&atilde; de a&ccedil;&uacute;car<br />
2 Ch&aacute;venas de farinha<br />
6 Ovos<br />
4 Colheres de Ch&atilde; de Fermento<br />
<br />
Acontece que o mesmo,ao cozer,leveda normalmente at&eacute; ao cimo da forma,mas no fiz da cozedura est&aacute; novamente no fundo da mesma,parecendo mais uma tarte do que um bolo!<br />
Ser&aacute; que isto acontece por abrir a tampa do forno enquanto o bolo se coze,tal como acontece com os molotofs?Pois o bolo tambem leva as claras batidas em castelo...<br />
Grato desde j&aacute; pela ajuda.</p>
', '2014-06-07 19:31:00');
INSERT INTO questioncontent VALUES (13, 11, '<p>Nunca usei baunilha...<br />
Do que pesquisei, o melhor &eacute; usar vagem de baunilha, mas &eacute; o mais dispendioso.<br />
Algu&eacute;m me explica a diferen&ccedil;a entre aroma, ess&ecirc;ncia, extracto e baunilha em p&oacute;?<br />
O que costumam utilizar e em que quantidades? Tamb&eacute;m li que quantidade em excesso estraga o sabor...</p>
', '2014-06-07 19:31:44');
INSERT INTO questioncontent VALUES (13, 11, '<p>Nunca usei baunilha...<br />
Do que pesquisei, o melhor &eacute; usar vagem de baunilha, mas &eacute; o mais dispendioso.<br />
Algu&eacute;m me explica a diferen&ccedil;a entre aroma, ess&ecirc;ncia, extracto e baunilha em p&oacute;?<br />
O que costumam utilizar e em que quantidades? Tamb&eacute;m li que quantidade em excesso estraga o sabor...</p>
', '2014-06-07 19:31:59');
INSERT INTO questioncontent VALUES (6, 11, '<p>Nunca usei baunilha...<br />
Do que pesquisei, o melhor &eacute; usar vagem de baunilha, mas &eacute; o mais dispendioso.<br />
Algu&eacute;m me explica a diferen&ccedil;a entre aroma, ess&ecirc;ncia, extracto e baunilha em p&oacute;?<br />
O que costumam utilizar e em que quantidades? Tamb&eacute;m li que quantidade em excesso estraga o sabor...</p>
', '2014-06-07 20:34:07');
INSERT INTO questioncontent VALUES (17, 18, '<p>Em certos restaurantes indianos como um arroz excelente! &eacute; arroz basmati branco, normalissimo, mas tem umas sementes finas e longas, s&atilde;o semetes de que?&nbsp;<br />
<br />
Nunca perguntei, at&eacute; porque a maior parte das vezes nesses restaurantes h&aacute; grandes dificuldades de comunica&ccedil;&atilde;o. Mesmo assim admiro o esfor&ccedil;o deles,porque &eacute; uma cultura e lingua muito diferente da nossa.</p>
', '2014-06-07 19:41:06');
INSERT INTO questioncontent VALUES (18, 19, '<p>Alguem ja cozinhou crocodilo? se sim de que forma?</p>
', '2014-06-07 19:45:50');
INSERT INTO questioncontent VALUES (19, 20, '<p>Sobraram-me imensas castanhas assadas. Algu&eacute;m me pode dizer se as posso congelar j&aacute; assadas ou como conserv&aacute;-las sem que fiquem com bolor.<br />
Obrigada pela ajuda.</p>
', '2014-06-07 19:51:45');
INSERT INTO questioncontent VALUES (18, 19, '<p>Alguem ja cozinhou crocodilo? se sim de que forma?</p>
', '2014-06-07 19:57:28');
INSERT INTO questioncontent VALUES (12, 21, '<p>Pessoal.. eu gosto muito de petisquinhos, mas &agrave; custa da &quot;engorda&quot; tive mesmo de abdicar de riss&oacute;is, past&eacute;is de bacalhau e seus derivados..<br />
<br />
No entanto, eu j fiz aqueles &quot;peixinhos&quot; da iglo no forno e at&eacute; gosto mais do q fritos, mas tentei fazer uns riss&oacute;is e ficaram um nojo total.. o meu fofy e eu ficamos mesmo desiludidos, porque ficaram super secos e alguns at&eacute; rebentaram<br />
<br />
Algu&eacute;m conhece alguma marca de riss&oacute;is e essas coisas, m que se possa fazer no forno?&nbsp;</p>
', '2014-06-07 20:00:38');
INSERT INTO questioncontent VALUES (5, 6, '<p>Ol&aacute;!<br />
<br />
Tenho um livro de receitas com coisas muito giras, mas o meu problema &eacute; que n&atilde;o consigo encontrar a maioria dos ingredientes. Algu&eacute;m me sabe dizer lojas onde posso comprar essas coisas?<br />
<br />
Alguns exemplos:<br />
cravo da &iacute;ndia<br />
vagens de cardamono<br />
sementes de coentro<br />
vagens de curcuma<br />
bok choy (&eacute; uma esp&eacute;cie de alface usada muito na &Aacute;sia)<br />
entre muitos outros...</p>
', '2014-06-07 21:23:15');
INSERT INTO questioncontent VALUES (5, 6, '<p>Ol&aacute;!<br />
<br />
Tenho um livro de receitas com coisas muito giras, mas o meu problema &eacute; que n&atilde;o consigo encontrar a maioria dos ingredientes. Algu&eacute;m me sabe dizer lojas onde posso comprar essas coisas?<br />
<br />
Alguns exemplos:<br />
cravo da &iacute;ndia<br />
vagens de cardamono<br />
sementes de coentro<br />
vagens de curcuma<br />
bok choy (&eacute; uma esp&eacute;cie de alface usada muito na &Aacute;sia)<br />
entre muitos outros...</p>
', '2014-06-07 21:24:21');
INSERT INTO questioncontent VALUES (5, 6, '<p>Ol&aacute;!<br />
<br />
Tenho um livro de receitas com coisas muito giras, mas o meu problema &eacute; que n&atilde;o consigo encontrar a maioria dos ingredientes. Algu&eacute;m me sabe dizer lojas onde posso comprar essas coisas?<br />
<br />
Alguns exemplos:<br />
cravo da &iacute;ndia<br />
vagens de cardamono<br />
sementes de coentro<br />
vagens de curcuma<br />
bok choy (&eacute; uma esp&eacute;cie de alface usada muito na &Aacute;sia)<br />
entre muitos outros...</p>
', '2014-06-07 21:24:35');
INSERT INTO questioncontent VALUES (5, 6, 'temporario', '2014-06-07 21:27:00');
INSERT INTO questioncontent VALUES (5, 6, 'temporario', '2014-06-07 21:27:43');
INSERT INTO questioncontent VALUES (5, 6, 'temporario', '2014-06-07 21:28:06');
INSERT INTO questioncontent VALUES (5, 6, 'temporario', '2014-06-07 21:30:05');
INSERT INTO questioncontent VALUES (5, 6, '<p>Ol&aacute;!</p>

<p>Tenho um livro de receitas com coisas muito giras, mas o meu problema &eacute; que n&atilde;o consigo encontrar a maioria dos ingredientes. Algu&eacute;m me sabe dizer lojas onde posso comprar essas coisas?</p>

<p>Alguns exemplos:<br />
cravo da &iacute;ndia<br />
vagens de cardamono<br />
sementes de coentro<br />
vagens de curcuma<br />
bok choy (&eacute; uma esp&eacute;cie de alface usada muito na &Aacute;sia)<br />
entre muitos outros..</p>
', '2014-06-07 21:32:14');
INSERT INTO questioncontent VALUES (5, 6, '<p>Ol&aacute;!</p>

<p>Tenho um livro de receitas com coisas muito giras, mas o meu problema &eacute; que n&atilde;o consigo encontrar a maioria dos ingredientes. Algu&eacute;m me sabe dizer lojas onde posso comprar essas coisas?</p>

<p>Alguns exemplos:<br />
cravo da &iacute;ndia<br />
vagens de cardamono<br />
sementes de coentro<br />
vagens de curcuma<br />
bok choy (&eacute; uma esp&eacute;cie de alface usada muito na &Aacute;sia)<br />
entre muitos outros.. teste</p>
', '2014-06-07 22:20:57');
INSERT INTO questioncontent VALUES (5, 6, '<p>Ol&aacute;!</p>

<p>Tenho um livro de receitas com coisas muito giras, mas o meu problema &eacute; que n&atilde;o consigo encontrar a maioria dos ingredientes. Algu&eacute;m me sabe dizer lojas onde posso comprar essas coisas?</p>

<p>Alguns exemplos:<br />
cravo da &iacute;ndia<br />
vagens de cardamono<br />
sementes de coentro<br />
vagens de curcuma<br />
bok choy (&eacute; uma esp&eacute;cie de alface usada muito na &Aacute;sia)<br />
entre muitos outros.. teste</p>
', '2014-06-07 22:21:07');
INSERT INTO questioncontent VALUES (5, 6, '<p>Ol&aacute;!</p>

<p>Tenho um livro de receitas com coisas muito giras, mas o meu problema &eacute; que n&atilde;o consigo encontrar a maioria dos ingredientes. Algu&eacute;m me sabe dizer lojas onde posso comprar essas coisas?</p>

<p>Alguns exemplos:<br />
cravo da &iacute;ndia<br />
vagens de cardamono<br />
sementes de coentro<br />
vagens de curcuma<br />
bok choy (&eacute; uma esp&eacute;cie de alface usada muito na &Aacute;sia)<br />
entre muitos outros..</p>
', '2014-06-07 22:21:16');
INSERT INTO questioncontent VALUES (17, 18, '<p>Em certos restaurantes indianos como um arroz excelente! &eacute; arroz basmati branco, normalissimo, mas tem umas sementes finas e longas, s&atilde;o semetes de que?&nbsp;<br />
<br />
Nunca perguntei, at&eacute; porque a maior parte das vezes nesses restaurantes h&aacute; grandes dificuldades de comunica&ccedil;&atilde;o. Mesmo assim admiro o esfor&ccedil;o deles,porque &eacute; uma cultura e lingua muito diferente da nossa.</p>
', '2014-06-08 12:45:56');
INSERT INTO questioncontent VALUES (20, 22, '<p>Amiga(o)s&nbsp;<br />
<br />
Preciso de uma receita r&aacute;pida e f&aacute;cil :/&nbsp;para peitos de frango e que n&atilde;o leve natas, de prefer&ecirc;ncia&nbsp;!!!<br />
<br />
Aguardo as vossas sugest&otilde;es, que s&atilde;o sempre boas e bem vindas!!!!<br />
&nbsp;</p>
', '2014-06-08 12:49:38');
INSERT INTO questioncontent VALUES (20, 23, '<p>algu&eacute;m sabe receitas de molhos para churasco carne, peixe, marisco...?</p>
', '2014-06-08 12:50:33');
INSERT INTO questioncontent VALUES (22, 24, '<p>Ol&aacute;aaa!!<br />
<br />
Lembrei-me agora de um arroz que eu costumava comer em casa de pessoas amigas...j&aacute; faz uns aninhos...mas que a minha m&atilde;e nunca fez.<br />
&Eacute; um arroz com cenoura...parecia-me cenoura ralada...mas ficava com um gostinho t&atilde;oooo bommmm! Devia levar ali mais qq coisa n&atilde;o sei...n&atilde;o me parece que fosse s&oacute; arroz com cenoura!&nbsp;E o arroz adquiria um pouco a cor laranja<br />
<br />
Algu&eacute;m sabe fazer este arroz??</p>
', '2014-06-08 13:05:51');
INSERT INTO questioncontent VALUES (23, 25, '<p>Algu&eacute;m sabe algum truque sobre as folhas de gelatina?<br />
J&aacute; tentei duas vezes e nunca se desfazem totalmente!!!&nbsp;&nbsp;<br />
&nbsp;Para a mousse de manga fazem falta!!!!&nbsp;&nbsp;<br />
Obrigada!!!</p>
', '2014-06-08 13:13:08');
INSERT INTO questioncontent VALUES (19, 26, '<p>Gostaria muito de aprender a fazer farturas&nbsp;&nbsp;...algu&eacute;m me poderia ajudar?&nbsp;&nbsp;</p>
', '2014-06-08 13:21:18');
INSERT INTO questioncontent VALUES (18, 27, '<p>Buenas,<br />
<br />
Que tipo de queijos costumam usar, em particular para derreter f&aacute;cil e rapidamente? Quando fa&ccedil;o comida italiana normalmente uso o emmental para cobrir o prato e derreter no forno. Tamb&eacute;m uso o parmes&atilde;o no fetuccine alfredo e j&aacute; notei que este derrete com alguma facilidade, embora o seu sabor se torne algo enjoativo.&nbsp;<br />
Em suma, que queijo devo usar para misturar (derretido) facilmente em massa?</p>
', '2014-06-08 13:23:08');
INSERT INTO questioncontent VALUES (24, 28, '<p>Ol&aacute; a todos,<br />
Tenho um damasqueiro cheio de fruta,vou tentar transformar alguns deles em doce, mas ainda v&atilde;o sobrar imensos,e pensei sec&aacute;-los....s&oacute; que n&atilde;o sei bem por onde come&ccedil;ar.....&nbsp;<br />
Ser&aacute; que algu&eacute;m sabe como fazer?</p>
', '2014-06-08 13:27:53');
INSERT INTO questioncontent VALUES (1, 11, '<p>Nunca usei baunilha...<br />
Do que pesquisei, o melhor &eacute; usar vagem de baunilha, mas &eacute; o mais dispendioso.<br />
Algu&eacute;m me explica a diferen&ccedil;a entre aroma, ess&ecirc;ncia, extracto e baunilha em p&oacute;?<br />
O que costumam utilizar e em que quantidades? Tamb&eacute;m li que quantidade em excesso estraga o sabor...</p>
', '2014-06-08 18:48:54');
INSERT INTO questioncontent VALUES (5, 29, '<p>Podem-me indicar a melhor maneira de fazer camar&atilde;o?</p>
', '2014-06-08 20:00:00');
INSERT INTO questioncontent VALUES (5, 30, '<p>Quais s&atilde;o os diferentes tipos de massa?</p>
', '2014-06-08 20:01:50');
INSERT INTO questioncontent VALUES (24, 31, '<p>H&aacute; muitos anos comi um bacalhau que penso que a receita era do Pantagruel.&nbsp; Um bacalhau divinal <img alt=\"wink\" src=\"http://localhost/overCooked/final/lib/ckeditor/plugins/smiley/images/wink_smile.png\" style=\"height:23px; width:23px\" title=\"wink\" /><br />
Eram postas que me parece que primeiro foram passadas por um polme e fritas, talvez, depois tinha pur&eacute;<br />
de batata e tamb&eacute;m acho que tinha maionese.&nbsp; Se algu&eacute;m me puder ajudar ficarei eternamente grata</p>
', '2014-06-08 19:32:24');
INSERT INTO questioncontent VALUES (24, 31, '<p>H&aacute; muitos anos comi um bacalhau que penso que a receita era do Pantagruel.&nbsp; Um bacalhau divinal <img alt=\"wink\" src=\"http://gnomo.fe.up.pt/~lbaw1315/final/lib/ckeditor/plugins/smiley/images/wink_smile.png\" style=\"height:23px; width:23px\" title=\"wink\" /><br />
Eram postas que me parece que primeiro foram passadas por um polme e fritas, talvez, depois tinha pur&eacute;<br />
de batata e tamb&eacute;m acho que tinha maionese.&nbsp; Se algu&eacute;m me puder ajudar ficarei eternamente grata</p>
', '2014-06-08 19:45:27');
INSERT INTO questioncontent VALUES (24, 31, '<p>H&aacute; muitos anos comi um bacalhau que penso que a receita era do Pantagruel.&nbsp; Um bacalhau divinal ;)<br />
Eram postas que me parece que primeiro foram passadas por um polme e fritas, talvez, depois tinha pur&eacute;<br />
de batata e tamb&eacute;m acho que tinha maionese.&nbsp; Se algu&eacute;m me puder ajudar ficarei eternamente grata</p>
', '2014-06-08 19:51:11');
INSERT INTO questioncontent VALUES (25, 32, '<p>Estou a ver neste momento o Hell&#39;s Kitchen USA e um dos pratos que eles servem no restaurante &eacute; Beef Wellington. Parece muito saboroso, pelo que gostava de saber qual &eacute; o equivalente portugu&ecirc;s ou se h&aacute; algum restaurante que o sirva.</p>
', '2014-06-08 20:25:33');
INSERT INTO questioncontent VALUES (1, 18, '<p>Em certos restaurantes indianos como um arroz excelente! &eacute; arroz basmati branco, normalissimo, mas tem umas sementes finas e longas, s&atilde;o semetes de que?&nbsp;<br />
<br />
Nunca perguntei, at&eacute; porque a maior parte das vezes nesses restaurantes h&aacute; grandes dificuldades de comunica&ccedil;&atilde;o. Mesmo assim admiro o esfor&ccedil;o deles,porque &eacute; uma cultura e lingua muito diferente da nossa.</p>
', '2014-06-08 23:37:47');
INSERT INTO questioncontent VALUES (1, 17, '<p>Costumo fazer a seguinte receita de bolo de natas:<br />
2 Pacotes de natas<br />
3 Ch&aacute;venas de Ch&atilde; de a&ccedil;&uacute;car<br />
2 Ch&aacute;venas de farinha<br />
6 Ovos<br />
4 Colheres de Ch&atilde; de Fermento<br />
<br />
Acontece que o mesmo,ao cozer,leveda normalmente at&eacute; ao cimo da forma,mas no fiz da cozedura est&aacute; novamente no fundo da mesma,parecendo mais uma tarte do que um bolo!<br />
Ser&aacute; que isto acontece por abrir a tampa do forno enquanto o bolo se coze,tal como acontece com os molotofs?Pois o bolo tambem leva as claras batidas em castelo...<br />
Grato desde j&aacute; pela ajuda.</p>
', '2014-06-08 23:38:45');
INSERT INTO questioncontent VALUES (1, 13, '<p>Por acaso alguma menina brasileira aqui do forum me diz o que &eacute; que chamam&nbsp;doce de leite. E&nbsp;creme de&nbsp;leite?&nbsp;&acute;.&Eacute; que aparecem em muitas receitas postas&nbsp; e n&atilde;o sei oq ue ser&aacute;. Obrigada</p>
', '2014-06-08 23:39:46');
INSERT INTO questioncontent VALUES (1, 5, '<p>Como saber se o nosso risotto de camar&atilde;o est&aacute; cozido no ponto certo?</p>
', '2014-06-08 23:40:43');
INSERT INTO questioncontent VALUES (1, 5, '<p>Como saber se o nosso risotto de camar&atilde;o est&aacute; cozido no ponto certo?</p>
', '2014-06-08 23:41:01');
INSERT INTO questioncontent VALUES (28, 33, '<p>Amigos como se escalfam ovos?</p>
', '2014-06-11 10:32:37');


--
-- Data for Name: questionsubscription; Type: TABLE DATA; Schema: public; Owner: lbaw1315
--

INSERT INTO questionsubscription VALUES (5, 4);
INSERT INTO questionsubscription VALUES (6, 4);
INSERT INTO questionsubscription VALUES (5, 5);
INSERT INTO questionsubscription VALUES (2, 4);
INSERT INTO questionsubscription VALUES (5, 8);
INSERT INTO questionsubscription VALUES (11, 10);
INSERT INTO questionsubscription VALUES (18, 19);
INSERT INTO questionsubscription VALUES (11, 9);
INSERT INTO questionsubscription VALUES (22, 19);
INSERT INTO questionsubscription VALUES (23, 26);
INSERT INTO questionsubscription VALUES (24, 27);
INSERT INTO questionsubscription VALUES (28, 32);
INSERT INTO questionsubscription VALUES (1, 32);


--
-- Data for Name: questiontag; Type: TABLE DATA; Schema: public; Owner: lbaw1315
--

INSERT INTO questiontag VALUES (4, 3);
INSERT INTO questiontag VALUES (4, 4);
INSERT INTO questiontag VALUES (5, 5);
INSERT INTO questiontag VALUES (5, 6);
INSERT INTO questiontag VALUES (6, 7);
INSERT INTO questiontag VALUES (7, 8);
INSERT INTO questiontag VALUES (7, 9);
INSERT INTO questiontag VALUES (8, 10);
INSERT INTO questiontag VALUES (9, 11);
INSERT INTO questiontag VALUES (9, 12);
INSERT INTO questiontag VALUES (10, 13);
INSERT INTO questiontag VALUES (10, 14);
INSERT INTO questiontag VALUES (10, 15);
INSERT INTO questiontag VALUES (11, 17);
INSERT INTO questiontag VALUES (12, 18);
INSERT INTO questiontag VALUES (12, 19);
INSERT INTO questiontag VALUES (13, 20);
INSERT INTO questiontag VALUES (13, 21);
INSERT INTO questiontag VALUES (13, 22);
INSERT INTO questiontag VALUES (14, 23);
INSERT INTO questiontag VALUES (14, 24);
INSERT INTO questiontag VALUES (14, 25);
INSERT INTO questiontag VALUES (15, 26);
INSERT INTO questiontag VALUES (16, 27);
INSERT INTO questiontag VALUES (18, 28);
INSERT INTO questiontag VALUES (18, 29);
INSERT INTO questiontag VALUES (18, 30);
INSERT INTO questiontag VALUES (19, 31);
INSERT INTO questiontag VALUES (20, 32);
INSERT INTO questiontag VALUES (21, 33);
INSERT INTO questiontag VALUES (21, 19);
INSERT INTO questiontag VALUES (22, 34);
INSERT INTO questiontag VALUES (22, 35);
INSERT INTO questiontag VALUES (23, 36);
INSERT INTO questiontag VALUES (23, 37);
INSERT INTO questiontag VALUES (24, 28);
INSERT INTO questiontag VALUES (24, 38);
INSERT INTO questiontag VALUES (25, 39);
INSERT INTO questiontag VALUES (26, 40);
INSERT INTO questiontag VALUES (27, 41);
INSERT INTO questiontag VALUES (28, 42);
INSERT INTO questiontag VALUES (30, 43);
INSERT INTO questiontag VALUES (31, 44);
INSERT INTO questiontag VALUES (31, 34);
INSERT INTO questiontag VALUES (32, 45);
INSERT INTO questiontag VALUES (32, 46);
INSERT INTO questiontag VALUES (33, 47);
INSERT INTO questiontag VALUES (33, 48);


--
-- Data for Name: questionvote; Type: TABLE DATA; Schema: public; Owner: lbaw1315
--

INSERT INTO questionvote VALUES (6, 4, 1);
INSERT INTO questionvote VALUES (2, 5, 1);
INSERT INTO questionvote VALUES (5, 5, 1);
INSERT INTO questionvote VALUES (5, 4, 1);
INSERT INTO questionvote VALUES (10, 7, 1);
INSERT INTO questionvote VALUES (5, 8, 1);
INSERT INTO questionvote VALUES (11, 11, 1);
INSERT INTO questionvote VALUES (11, 14, 1);
INSERT INTO questionvote VALUES (16, 15, 1);
INSERT INTO questionvote VALUES (21, 22, 1);
INSERT INTO questionvote VALUES (14, 23, 1);
INSERT INTO questionvote VALUES (22, 5, 1);
INSERT INTO questionvote VALUES (22, 6, 1);
INSERT INTO questionvote VALUES (22, 15, 1);
INSERT INTO questionvote VALUES (22, 16, 1);
INSERT INTO questionvote VALUES (22, 18, 1);
INSERT INTO questionvote VALUES (22, 19, 1);
INSERT INTO questionvote VALUES (23, 26, 1);
INSERT INTO questionvote VALUES (18, 26, 1);
INSERT INTO questionvote VALUES (20, 26, 1);
INSERT INTO questionvote VALUES (18, 28, 1);
INSERT INTO questionvote VALUES (14, 31, 1);
INSERT INTO questionvote VALUES (16, 32, 1);
INSERT INTO questionvote VALUES (28, 32, 1);


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: lbaw1315
--

INSERT INTO tag VALUES (3, 'claras');
INSERT INTO tag VALUES (4, 'bolo');
INSERT INTO tag VALUES (5, 'risotto');
INSERT INTO tag VALUES (6, 'camarão');
INSERT INTO tag VALUES (7, 'ingredientes');
INSERT INTO tag VALUES (8, 'omoletes');
INSERT INTO tag VALUES (9, 'amigos');
INSERT INTO tag VALUES (10, 'caril');
INSERT INTO tag VALUES (11, 'brigadeiro');
INSERT INTO tag VALUES (12, 'chocolate');
INSERT INTO tag VALUES (13, 'cheesecake');
INSERT INTO tag VALUES (14, 'frutos');
INSERT INTO tag VALUES (15, 'vermelhos');
INSERT INTO tag VALUES (17, 'baunilha');
INSERT INTO tag VALUES (18, 'maçã');
INSERT INTO tag VALUES (19, 'forno');
INSERT INTO tag VALUES (20, 'doce');
INSERT INTO tag VALUES (21, 'creme');
INSERT INTO tag VALUES (22, 'leite');
INSERT INTO tag VALUES (23, 'forma');
INSERT INTO tag VALUES (24, 'pudim');
INSERT INTO tag VALUES (25, 'ovos');
INSERT INTO tag VALUES (26, 'amêijoas');
INSERT INTO tag VALUES (27, 'margarina');
INSERT INTO tag VALUES (28, 'arroz');
INSERT INTO tag VALUES (29, 'basmati');
INSERT INTO tag VALUES (30, 'sementes');
INSERT INTO tag VALUES (31, 'crocodilo');
INSERT INTO tag VALUES (32, 'castanhas');
INSERT INTO tag VALUES (33, 'salgados');
INSERT INTO tag VALUES (34, 'receita');
INSERT INTO tag VALUES (35, 'fácil');
INSERT INTO tag VALUES (36, 'churrasco');
INSERT INTO tag VALUES (37, 'molhos');
INSERT INTO tag VALUES (38, 'cenoura');
INSERT INTO tag VALUES (39, 'gelatina');
INSERT INTO tag VALUES (40, 'fartura');
INSERT INTO tag VALUES (41, 'queijo');
INSERT INTO tag VALUES (42, 'damasco');
INSERT INTO tag VALUES (43, 'massa');
INSERT INTO tag VALUES (44, 'bacalhau');
INSERT INTO tag VALUES (45, 'beef');
INSERT INTO tag VALUES (46, 'wellington');
INSERT INTO tag VALUES (47, 'ovo');
INSERT INTO tag VALUES (48, 'escalfar');


--
-- Name: tag_idtag_seq; Type: SEQUENCE SET; Schema: public; Owner: lbaw1315
--

SELECT pg_catalog.setval('tag_idtag_seq', 48, true);


--
-- Data for Name: webuser; Type: TABLE DATA; Schema: public; Owner: lbaw1315
--

INSERT INTO webuser VALUES (7, 'fernando', '27978437b5586de4052f97d4ed86509eed030c7e1facdac3bf889271d0aeb3b2', 'PfxWlH15lrD893HSpv3AZ5AIWp68iQ==', NULL, '2014-06-06 23:49:29', NULL, '1992-10-10 00:00:00', NULL, 'ei11066@fe.up.pt', NULL, 'Fernando Vasconcelos', 0, 0, 1, 1, 168, 'user', false);
INSERT INTO webuser VALUES (25, 'joseManel', '49b119325469de3c640508bb4ff631719dcbd190c6bce56e46a8b9efbef67f33', 'x4HnjpznNwFX/QkaZOfzhV4FR+fm/g==', NULL, '2014-06-08 20:24:36', NULL, '1980-05-22 00:00:00', NULL, 'joseM@globo.org', NULL, 'José Manuel da Costa', 0, 0, 1, 2, 168, 'user', false);
INSERT INTO webuser VALUES (6, 'carlos', '749f4d0205170bed257155b72ecdd3a649ef4c53dbb8f74302188311de082eda', 'B0EMjkSt5XosupCKt2E472ESiD3OQQ==', NULL, '2014-06-04 20:15:56', '', '1970-01-01 00:00:00', '', 'carlos@yahoo.com', NULL, 'Carlos Morais', 1, 2, 1, 10, 168, 'moderator', false);
INSERT INTO webuser VALUES (23, 'nanda', '5ce9d1ffc842ee2a3bf7f6397ae03733508cb289b0996a5e70fdfdfc17a8177c', 'qgmS81kqlerl4NK6c9pNBPGVj/siuw==', NULL, '2014-06-08 13:11:10', NULL, '1949-04-30 00:00:00', NULL, 'nanda@gmail.com', NULL, 'Fernanda Maria da Silva', 3, 0, 1, 0, 168, 'user', false);
INSERT INTO webuser VALUES (10, 'joao', 'fde2eb258f6d8808a028725778cd816f5a03be7fec4ce4618ca4e4b7e066f220', 'KNeSniYvgxejK2+HyqwIMTHaf6mNuw==', NULL, '2014-06-07 11:18:20', NULL, '1993-12-12 00:00:00', NULL, 'joao@gmail.com', NULL, 'João Luís ', 0, 2, 1, 1, 168, 'user', false);
INSERT INTO webuser VALUES (9, 'colt', '6afd82b1299a32d49d9e30115451dfb95b74742617fc0b7f36d1e99ab5660877', 'wTJujvzxtlEx0699+hjn8/HjC40DIg==', NULL, '2014-06-06 23:56:56', NULL, '2000-05-04 00:00:00', NULL, 'naotenhosouguna@gmail.com', NULL, 'colt o guna da areosa', 0, 0, 0, 0, 168, 'user', true);
INSERT INTO webuser VALUES (24, 'belinha', 'b3b0508f0d64fd23a98e1d41ab2e93b44a4f4750910fddcdc4e0c44cebf6493c', 'I4VbULKBgANBONoXT7nDszflOKI2UA==', NULL, '2014-06-08 13:26:52', NULL, '1955-05-05 00:00:00', NULL, 'isabel@gmail.com', NULL, 'Isabel José Rodrigues', 0, 1, 2, 2, 168, 'user', false);
INSERT INTO webuser VALUES (8, 'JoanaADias', '7ddb6f49494787580925ab139a3d518ca98b73458c31585325c6eec290541292', 'JWIgKV0j9kAvv3RzTmY8GKPQk+ZySg==', NULL, '2014-06-06 23:52:25', NULL, '1986-08-08 00:00:00', NULL, 'jad@be.pt', NULL, 'Joana Amaral Dias', 1, 0, 0, 4, 168, 'user', false);
INSERT INTO webuser VALUES (14, 'ritaChef', '8fb8d3dcb23b0f840a1952cb4014dedf111874b13c37376ddfa3ea6a52418829', '9DJbz5eV56xUSlX/8kdn0qKrtWnx1g==', NULL, '2014-06-07 19:11:48', NULL, '1975-07-24 00:00:00', NULL, 'rita_andreia@gmail.com', NULL, 'Rita Andreia Silva', 9, 3, 3, 12, 168, 'user', false);
INSERT INTO webuser VALUES (22, 'paulita', '1cb3e1237955d9846a31ef13204004d383324adea9d4c492ad12876ad913b055', 'cjarBC95iSbrb30E4aKnxCu2pkVLeQ==', NULL, '2014-06-08 13:05:02', NULL, '1970-10-17 00:00:00', NULL, 'paula_manuela@gmail.com', NULL, 'Paula Manuela Vieira', 1, 1, 1, 0, 168, 'user', false);
INSERT INTO webuser VALUES (2, 'susana', '523df842dd58fce9c915210fbc07f862c84a8cb7d2cbcf0502ac92deaccea7f8', '4kpKvqa4dJn0Cd1miYi38zJxqOmaDA==', '', '2014-06-04 16:59:46', '', '1970-01-01 00:00:00', '', 'susy@gmail.com', NULL, 'Susana Mendes', 2, 0, 1, 11, 168, 'user', false);
INSERT INTO webuser VALUES (19, 'carmelina', '870e32899f9a13f7e438d430d2dd0075ee6b96f1a0e9555a2aaf59dd8d40b5cf', 'EnH+ORVYAJCx5aNYmAhjzeoKfVI3nA==', NULL, '2014-06-07 19:48:41', NULL, '1964-12-07 00:00:00', NULL, 'carmelina@gmail.com', NULL, 'Carmelina Amélia', 3, 1, 2, 3, 168, 'user', false);
INSERT INTO webuser VALUES (20, 'rui', '65832ce884e50b18403adce6dca73afe0b528db34fa84898d0af02db55a14b22', 'Sc5x7iz6yXH9uByGt1dWNRvVc0sTaQ==', NULL, '2014-06-08 12:48:27', NULL, '1954-03-29 00:00:00', NULL, 'rui@gmail.com', NULL, 'Rui Manuel Coelho', 1, 0, 2, 2, 168, 'user', false);
INSERT INTO webuser VALUES (13, 'manuela', '7ca6e9a88f1afd312cfc031e1c22ae5b9de856f011848b40529b834ee785bd40', '225M45fyY7Rp9GsxEAg9lTcI905ydw==', NULL, '2014-06-07 19:01:56', NULL, '1965-11-15 00:00:00', NULL, 'manuela@gmail.com', NULL, 'Manuela Almeida', 10, 0, 1, 10, 168, 'user', false);
INSERT INTO webuser VALUES (16, 'rosinha', '6ce24d880210177e4a7cff1cdd438b4d29b5851b84262c2344cf131544b22d55', 'NaiseuyvugsgjTFgUuC4CaWcsq42uA==', NULL, '2014-06-07 19:28:41', NULL, '1980-12-14 00:00:00', NULL, 'rosamanela@gmail.com', NULL, 'Rosa Manuela Alves', 8, 0, 2, 7, 168, 'user', false);
INSERT INTO webuser VALUES (12, 'manel', '83419fb7709f6730b797d57409ed53d04ac91555d59c36cba1e0aa28466185b1', 'Lj5Suk4KGh4DRIgnEf1YhJ24l2166g==', NULL, '2014-06-07 19:00:20', NULL, '1954-03-01 00:00:00', NULL, 'manuel@gmail.com', NULL, 'Manuel Silva', 8, 2, 1, 6, 168, 'user', false);
INSERT INTO webuser VALUES (17, 'tatianaMegaChef', '34bb1a4ca7d5edc28a7a9aa88a4d411aa7086e9287ea47919303a6a6efb8c944', 'oqSVfQN5BcqbexkkOnXNkG+GUWsHZg==', NULL, '2014-06-07 19:39:28', NULL, '1967-01-20 00:00:00', NULL, 'taty@gmail.com', NULL, 'Tatiana Andreia Almeida', 5, 0, 1, 3, 168, 'user', false);
INSERT INTO webuser VALUES (18, 'papoila', 'f622829d166158816cc5931f2e2f572eed56d1df3de91a97bb4e426985b13639', 'jE62J76tXTTL8DaqPJQFwQeIVguX1A==', NULL, '2014-06-07 19:43:52', NULL, '1990-04-21 00:00:00', NULL, 'margarida@gmail.com', NULL, 'Margarida Raquel Costa', 5, 1, 2, 3, 168, 'user', false);
INSERT INTO webuser VALUES (15, 'rosacristina', 'aa05198432211ad2b483c33d15bf52dc8a2ea6aac0df27059693b3c4dc91d0b1', 'T54CqS6wSlBPdrsZpCGS/jURsiu2oA==', NULL, '2014-06-07 19:21:38', NULL, '1960-12-09 00:00:00', NULL, 'rosa@hotmail.com', NULL, 'Rosa Cristina da Silva Albuquerque', 6, 0, 1, 11, 168, 'user', false);
INSERT INTO webuser VALUES (11, 'anasousa', 'a43202ae8466276634ba8fb66a7147638e79c704a95adc195fcf679ec966fbc7', 'EJPzIjdnWFxjn7mp6sAZabyJNfPj8Q==', NULL, '2014-06-07 18:54:35', NULL, '1993-05-17 00:00:00', NULL, 'ana@gmail.com', NULL, 'Ana Isabel Sousa', 5, 1, 2, 11, 168, 'user', false);
INSERT INTO webuser VALUES (21, 'senhorJose', '7c5f07c0055c3011a12c992a3d4a6801626dd087c38333abc242f68ce0e5063e', 'HcP3Y9b8LpiZnOR7L52UO0+lEJuOHw==', NULL, '2014-06-08 12:51:12', NULL, '1963-08-14 00:00:00', NULL, 'jose@hotmail.com', NULL, 'José Manuel da Costa Andrade', 4, 0, 0, 0, 168, 'user', false);
INSERT INTO webuser VALUES (1, 'lbaw1315', 'c70fffe2843f3915f97ca225d80e36f85f0bff5703183357d24b92015ced8510', 'jyEpGghEpilegpXpFnCWi5hN7FPgyw==', NULL, '2014-06-04 16:58:56', NULL, NULL, NULL, 'lbaw1315@gnomo.fe.up.pt', NULL, 'OverCooked', 0, 1, 0, 0, 168, 'admin', false);
INSERT INTO webuser VALUES (26, 'teste', 'a2b24ba2db0db33ba88ab46adfec2670c77e687841787624e560e55e7d27fc34', 'JyWvWy08uUhfDOg7dGul5+a5Xk3buQ==', NULL, '2014-06-10 18:16:47', NULL, '1111-11-11 00:00:00', NULL, 'teste@teste.com', NULL, 'teste', 0, 0, 0, 0, 168, 'user', false);
INSERT INTO webuser VALUES (27, 'ritolas', '90547d14b9eccb54713693fe87ac1b05ec49db273202d2be39072327cd641c92', 'zmItbT8hEPQU1I95/bxJucv+wdNfVA==', NULL, '2014-06-10 20:06:49', NULL, '1980-04-01 00:00:00', NULL, 'rita@gmail.com', NULL, 'Rita Cristina', 0, 0, 0, 0, 168, 'user', true);
INSERT INTO webuser VALUES (5, 'maria', 'e10fdc3426b1fd81660965797d9248cb50cd693396569c6d3debeac3f0ec9824', 'dnWFyENsSJIs2lLNmcko3Iu4vrWQ0Q==', 'maria.jpg', '2014-06-04 20:00:09', '', '1978-10-10 00:00:00', 'Lisboa', 'mpires@hotmail.com', 'F', 'Maria Pires', 2, 0, 3, 17, 168, 'moderator', false);
INSERT INTO webuser VALUES (28, 'mariamanuela', 'a43cac5096e53721ed3f7ce3315f9a8384376b8d3915563bf0f8f227a83edb3d', '2Tw2QJNonrYfvN5LFJhLnUXk2WUtOQ==', 'mariamanuela.jpg', '2014-06-11 10:24:24', 'Sou uma chefe experiente com muita vontade', '1960-06-11 00:00:00', 'Porto', 'mariamanuela@gmail.com', 'F', 'Maria Manuela da Silva Coelho', 1, 1, 1, 0, 168, 'user', false);


--
-- Name: webuser_iduser_seq; Type: SEQUENCE SET; Schema: public; Owner: lbaw1315
--

SELECT pg_catalog.setval('webuser_iduser_seq', 28, true);


SET search_path = frmk, pg_catalog;

--
-- Name: follows_pkey; Type: CONSTRAINT; Schema: frmk; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY follows
    ADD CONSTRAINT follows_pkey PRIMARY KEY (follower, followed);


--
-- Name: tweets_pkey; Type: CONSTRAINT; Schema: frmk; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY tweets
    ADD CONSTRAINT tweets_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: frmk; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (username);


SET search_path = public, pg_catalog;

--
-- Name: answer_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY answer
    ADD CONSTRAINT answer_pkey PRIMARY KEY (idanswer);


--
-- Name: answercomment_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY answercomment
    ADD CONSTRAINT answercomment_pkey PRIMARY KEY (idcomment);


--
-- Name: answercommentcontent_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY answercommentcontent
    ADD CONSTRAINT answercommentcontent_pkey PRIMARY KEY (idcomment, iduser, date);


--
-- Name: answercontent_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY answercontent
    ADD CONSTRAINT answercontent_pkey PRIMARY KEY (idanswer, iduser, date);


--
-- Name: answervote_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY answervote
    ADD CONSTRAINT answervote_pkey PRIMARY KEY (idanswer, iduser);


--
-- Name: country_name_key; Type: CONSTRAINT; Schema: public; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY country
    ADD CONSTRAINT country_name_key UNIQUE (name);


--
-- Name: country_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY country
    ADD CONSTRAINT country_pkey PRIMARY KEY (idcountry);


--
-- Name: question_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY question
    ADD CONSTRAINT question_pkey PRIMARY KEY (idquestion);


--
-- Name: questioncomment_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY questioncomment
    ADD CONSTRAINT questioncomment_pkey PRIMARY KEY (idcomment);


--
-- Name: questioncommentcontent_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY questioncommentcontent
    ADD CONSTRAINT questioncommentcontent_pkey PRIMARY KEY (idcomment, iduser, date);


--
-- Name: questioncontent_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY questioncontent
    ADD CONSTRAINT questioncontent_pkey PRIMARY KEY (iduser, idquestion, date);


--
-- Name: questionsubscription_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY questionsubscription
    ADD CONSTRAINT questionsubscription_pkey PRIMARY KEY (iduser, idquestion);


--
-- Name: questiontag_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY questiontag
    ADD CONSTRAINT questiontag_pkey PRIMARY KEY (idquestion, idtag);


--
-- Name: questionvote_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY questionvote
    ADD CONSTRAINT questionvote_pkey PRIMARY KEY (iduser, idquestion);


--
-- Name: tag_name_key; Type: CONSTRAINT; Schema: public; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY tag
    ADD CONSTRAINT tag_name_key UNIQUE (name);


--
-- Name: tag_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (idtag);


--
-- Name: webuser_email_key; Type: CONSTRAINT; Schema: public; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY webuser
    ADD CONSTRAINT webuser_email_key UNIQUE (email);


--
-- Name: webuser_pkey; Type: CONSTRAINT; Schema: public; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY webuser
    ADD CONSTRAINT webuser_pkey PRIMARY KEY (iduser);


--
-- Name: webuser_username_key; Type: CONSTRAINT; Schema: public; Owner: lbaw1315; Tablespace: 
--

ALTER TABLE ONLY webuser
    ADD CONSTRAINT webuser_username_key UNIQUE (username);


--
-- Name: answer_comment_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE INDEX answer_comment_index ON answercomment USING btree (idanswer);


--
-- Name: answer_vote_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE INDEX answer_vote_index ON answervote USING btree (idanswer);


--
-- Name: answers_for_question_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE INDEX answers_for_question_index ON answer USING btree (idquestion);


--
-- Name: best_answer_of_question_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE UNIQUE INDEX best_answer_of_question_index ON answer USING btree (idquestion) WHERE bestanswer;


--
-- Name: content_of_answer_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE INDEX content_of_answer_index ON answercontent USING btree (idanswer, date);


--
-- Name: content_of_comment1_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE INDEX content_of_comment1_index ON questioncommentcontent USING btree (idcomment, date);


--
-- Name: content_of_comment2_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE INDEX content_of_comment2_index ON answercommentcontent USING btree (idcomment, date);


--
-- Name: content_of_question_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE INDEX content_of_question_index ON questioncontent USING btree (idquestion, date);


--
-- Name: hot_questions_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE INDEX hot_questions_index ON question USING btree (idquestion) WHERE (hot > 0);


--
-- Name: moderators_or_admins_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE INDEX moderators_or_admins_index ON webuser USING btree (usergroup) WHERE ((usergroup = 'moderator'::usergroupenum) OR (usergroup = 'admin'::usergroupenum));


--
-- Name: question_comment_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE INDEX question_comment_index ON questioncomment USING btree (idquestion);


--
-- Name: question_vote_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE INDEX question_vote_index ON questionvote USING btree (idquestion);


--
-- Name: questions_about_tag_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE INDEX questions_about_tag_index ON questiontag USING btree (idtag);


--
-- Name: questions_subscription_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE INDEX questions_subscription_index ON questionsubscription USING btree (iduser);


--
-- Name: questions_user_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE INDEX questions_user_index ON question USING btree (iduser);


--
-- Name: search_answer_content_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE INDEX search_answer_content_index ON question USING gin (to_tsvector('portuguese'::regconfig, title));


--
-- Name: search_question_content_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE INDEX search_question_content_index ON questioncontent USING gin (to_tsvector('portuguese'::regconfig, html));


--
-- Name: search_question_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE INDEX search_question_index ON question USING gin (to_tsvector('portuguese'::regconfig, title));


--
-- Name: tags_of_question_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE INDEX tags_of_question_index ON questiontag USING btree (idquestion);


--
-- Name: webuser_username_index; Type: INDEX; Schema: public; Owner: lbaw1315; Tablespace: 
--

CREATE INDEX webuser_username_index ON webuser USING btree (username);


--
-- Name: answer_vw_insert; Type: RULE; Schema: public; Owner: lbaw1315
--

CREATE RULE answer_vw_insert AS ON INSERT TO answer_vw DO INSTEAD (INSERT INTO answer (date, idquestion, iduser) VALUES (new.date, new.idquestion, new.iduser); INSERT INTO answercontent (iduser, idanswer, html, date) VALUES (new.iduser, (SELECT answer.idanswer FROM answer WHERE (((answer.date = new.date) AND (answer.idquestion = new.idquestion)) AND (answer.iduser = new.iduser))), new.html, new.date); );


--
-- Name: answercomment_vw_insert; Type: RULE; Schema: public; Owner: lbaw1315
--

CREATE RULE answercomment_vw_insert AS ON INSERT TO answercomment_vw DO INSTEAD (INSERT INTO answercomment (date, idanswer, iduser) VALUES (new.date, new.idanswer, new.iduser); INSERT INTO answercommentcontent (iduser, idcomment, content, date) VALUES (new.iduser, (SELECT answercomment.idcomment FROM answercomment WHERE ((answercomment.date = new.date) AND (answercomment.idanswer = new.idanswer))), new.content, new.date); );


--
-- Name: question_vw_insert; Type: RULE; Schema: public; Owner: lbaw1315
--

CREATE RULE question_vw_insert AS ON INSERT TO question_vw DO INSTEAD (INSERT INTO question (title, date, iduser) VALUES (new.title, new.date, new.iduser); INSERT INTO questioncontent (iduser, idquestion, html, date) VALUES (new.iduser, (SELECT question.idquestion FROM question WHERE (((question.title = new.title) AND (question.date = new.date)) AND (question.iduser = new.iduser))), new.html, new.date); );


--
-- Name: questioncomment_vw_insert; Type: RULE; Schema: public; Owner: lbaw1315
--

CREATE RULE questioncomment_vw_insert AS ON INSERT TO questioncomment_vw DO INSTEAD (INSERT INTO questioncomment (date, idquestion, iduser) VALUES (new.date, new.idquestion, new.iduser); INSERT INTO questioncommentcontent (iduser, idcomment, content, date) VALUES (new.iduser, (SELECT questioncomment.idcomment FROM questioncomment WHERE ((questioncomment.date = new.date) AND (questioncomment.idquestion = new.idquestion))), new.content, new.date); );


--
-- Name: update_answer_score; Type: TRIGGER; Schema: public; Owner: lbaw1315
--

CREATE TRIGGER update_answer_score AFTER UPDATE ON answervote FOR EACH ROW EXECUTE PROCEDURE update_answer_score();


--
-- Name: update_answer_score2; Type: TRIGGER; Schema: public; Owner: lbaw1315
--

CREATE TRIGGER update_answer_score2 AFTER INSERT ON answervote FOR EACH ROW EXECUTE PROCEDURE update_answer_score2();


--
-- Name: update_answer_score3; Type: TRIGGER; Schema: public; Owner: lbaw1315
--

CREATE TRIGGER update_answer_score3 AFTER DELETE ON answervote FOR EACH ROW EXECUTE PROCEDURE update_answer_score3();


--
-- Name: update_best_answer_score; Type: TRIGGER; Schema: public; Owner: lbaw1315
--

CREATE TRIGGER update_best_answer_score AFTER UPDATE ON answer FOR EACH ROW EXECUTE PROCEDURE update_best_answer_score();


--
-- Name: update_best_answer_score_delete; Type: TRIGGER; Schema: public; Owner: lbaw1315
--

CREATE TRIGGER update_best_answer_score_delete AFTER DELETE ON answer FOR EACH ROW EXECUTE PROCEDURE update_best_answer_score_delete();


--
-- Name: update_n_answer_comments; Type: TRIGGER; Schema: public; Owner: lbaw1315
--

CREATE TRIGGER update_n_answer_comments AFTER INSERT ON answercomment FOR EACH ROW EXECUTE PROCEDURE update_n_answer_comments();


--
-- Name: update_n_answer_comments_delete; Type: TRIGGER; Schema: public; Owner: lbaw1315
--

CREATE TRIGGER update_n_answer_comments_delete AFTER DELETE ON answercomment FOR EACH ROW EXECUTE PROCEDURE update_n_answer_comments_delete();


--
-- Name: update_n_answers; Type: TRIGGER; Schema: public; Owner: lbaw1315
--

CREATE TRIGGER update_n_answers AFTER INSERT ON answer FOR EACH ROW EXECUTE PROCEDURE update_n_answers();


--
-- Name: update_n_question_comments; Type: TRIGGER; Schema: public; Owner: lbaw1315
--

CREATE TRIGGER update_n_question_comments AFTER INSERT ON questioncomment FOR EACH ROW EXECUTE PROCEDURE update_n_question_comments();


--
-- Name: update_n_question_comments_delete; Type: TRIGGER; Schema: public; Owner: lbaw1315
--

CREATE TRIGGER update_n_question_comments_delete AFTER DELETE ON questioncomment FOR EACH ROW EXECUTE PROCEDURE update_n_question_comments_delete();


--
-- Name: update_n_questions; Type: TRIGGER; Schema: public; Owner: lbaw1315
--

CREATE TRIGGER update_n_questions AFTER INSERT ON question FOR EACH ROW EXECUTE PROCEDURE update_n_questions();


--
-- Name: update_n_questions_delete; Type: TRIGGER; Schema: public; Owner: lbaw1315
--

CREATE TRIGGER update_n_questions_delete AFTER DELETE ON question FOR EACH ROW EXECUTE PROCEDURE update_n_questions_delete();


--
-- Name: update_question_score; Type: TRIGGER; Schema: public; Owner: lbaw1315
--

CREATE TRIGGER update_question_score AFTER UPDATE ON questionvote FOR EACH ROW EXECUTE PROCEDURE update_question_score();


--
-- Name: update_question_score2; Type: TRIGGER; Schema: public; Owner: lbaw1315
--

CREATE TRIGGER update_question_score2 AFTER INSERT ON questionvote FOR EACH ROW EXECUTE PROCEDURE update_question_score2();


--
-- Name: update_question_score3; Type: TRIGGER; Schema: public; Owner: lbaw1315
--

CREATE TRIGGER update_question_score3 AFTER DELETE ON questionvote FOR EACH ROW EXECUTE PROCEDURE update_question_score3();


SET search_path = frmk, pg_catalog;

--
-- Name: follows_followed_fkey; Type: FK CONSTRAINT; Schema: frmk; Owner: lbaw1315
--

ALTER TABLE ONLY follows
    ADD CONSTRAINT follows_followed_fkey FOREIGN KEY (followed) REFERENCES users(username);


--
-- Name: follows_follower_fkey; Type: FK CONSTRAINT; Schema: frmk; Owner: lbaw1315
--

ALTER TABLE ONLY follows
    ADD CONSTRAINT follows_follower_fkey FOREIGN KEY (follower) REFERENCES users(username);


--
-- Name: tweets_username_fkey; Type: FK CONSTRAINT; Schema: frmk; Owner: lbaw1315
--

ALTER TABLE ONLY tweets
    ADD CONSTRAINT tweets_username_fkey FOREIGN KEY (username) REFERENCES users(username);


SET search_path = public, pg_catalog;

--
-- Name: answer_idquestion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY answer
    ADD CONSTRAINT answer_idquestion_fkey FOREIGN KEY (idquestion) REFERENCES question(idquestion);


--
-- Name: answer_iduser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY answer
    ADD CONSTRAINT answer_iduser_fkey FOREIGN KEY (iduser) REFERENCES webuser(iduser);


--
-- Name: answercomment_idanswer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY answercomment
    ADD CONSTRAINT answercomment_idanswer_fkey FOREIGN KEY (idanswer) REFERENCES answer(idanswer);


--
-- Name: answercomment_iduser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY answercomment
    ADD CONSTRAINT answercomment_iduser_fkey FOREIGN KEY (iduser) REFERENCES webuser(iduser);


--
-- Name: answercommentcontent_idcomment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY answercommentcontent
    ADD CONSTRAINT answercommentcontent_idcomment_fkey FOREIGN KEY (idcomment) REFERENCES answercomment(idcomment);


--
-- Name: answercommentcontent_iduser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY answercommentcontent
    ADD CONSTRAINT answercommentcontent_iduser_fkey FOREIGN KEY (iduser) REFERENCES webuser(iduser);


--
-- Name: answercontent_idanswer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY answercontent
    ADD CONSTRAINT answercontent_idanswer_fkey FOREIGN KEY (idanswer) REFERENCES answer(idanswer);


--
-- Name: answercontent_iduser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY answercontent
    ADD CONSTRAINT answercontent_iduser_fkey FOREIGN KEY (iduser) REFERENCES webuser(iduser);


--
-- Name: answervote_idanswer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY answervote
    ADD CONSTRAINT answervote_idanswer_fkey FOREIGN KEY (idanswer) REFERENCES answer(idanswer);


--
-- Name: answervote_iduser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY answervote
    ADD CONSTRAINT answervote_iduser_fkey FOREIGN KEY (iduser) REFERENCES webuser(iduser);


--
-- Name: question_iduser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY question
    ADD CONSTRAINT question_iduser_fkey FOREIGN KEY (iduser) REFERENCES webuser(iduser);


--
-- Name: questioncomment_idquestion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY questioncomment
    ADD CONSTRAINT questioncomment_idquestion_fkey FOREIGN KEY (idquestion) REFERENCES question(idquestion);


--
-- Name: questioncomment_iduser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY questioncomment
    ADD CONSTRAINT questioncomment_iduser_fkey FOREIGN KEY (iduser) REFERENCES webuser(iduser);


--
-- Name: questioncommentcontent_idcomment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY questioncommentcontent
    ADD CONSTRAINT questioncommentcontent_idcomment_fkey FOREIGN KEY (idcomment) REFERENCES questioncomment(idcomment);


--
-- Name: questioncommentcontent_iduser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY questioncommentcontent
    ADD CONSTRAINT questioncommentcontent_iduser_fkey FOREIGN KEY (iduser) REFERENCES webuser(iduser);


--
-- Name: questioncontent_idquestion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY questioncontent
    ADD CONSTRAINT questioncontent_idquestion_fkey FOREIGN KEY (idquestion) REFERENCES question(idquestion);


--
-- Name: questioncontent_iduser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY questioncontent
    ADD CONSTRAINT questioncontent_iduser_fkey FOREIGN KEY (iduser) REFERENCES webuser(iduser);


--
-- Name: questionsubscription_idquestion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY questionsubscription
    ADD CONSTRAINT questionsubscription_idquestion_fkey FOREIGN KEY (idquestion) REFERENCES question(idquestion);


--
-- Name: questionsubscription_iduser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY questionsubscription
    ADD CONSTRAINT questionsubscription_iduser_fkey FOREIGN KEY (iduser) REFERENCES webuser(iduser);


--
-- Name: questiontag_idquestion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY questiontag
    ADD CONSTRAINT questiontag_idquestion_fkey FOREIGN KEY (idquestion) REFERENCES question(idquestion);


--
-- Name: questiontag_idtag_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY questiontag
    ADD CONSTRAINT questiontag_idtag_fkey FOREIGN KEY (idtag) REFERENCES tag(idtag);


--
-- Name: questionvote_idquestion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY questionvote
    ADD CONSTRAINT questionvote_idquestion_fkey FOREIGN KEY (idquestion) REFERENCES question(idquestion);


--
-- Name: questionvote_iduser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY questionvote
    ADD CONSTRAINT questionvote_iduser_fkey FOREIGN KEY (iduser) REFERENCES webuser(iduser);


--
-- Name: webuser_idcountry_fkey; Type: FK CONSTRAINT; Schema: public; Owner: lbaw1315
--

ALTER TABLE ONLY webuser
    ADD CONSTRAINT webuser_idcountry_fkey FOREIGN KEY (idcountry) REFERENCES country(idcountry);


--
-- PostgreSQL database dump complete
--

