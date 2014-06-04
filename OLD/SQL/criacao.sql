/*ALTERAR TRIGGERS COM BASE NA WIKI*/
DROP TABLE IF EXISTS webUser CASCADE;
DROP TABLE IF EXISTS question CASCADE;
DROP TABLE IF EXISTS answer CASCADE;
DROP TABLE IF EXISTS answerComment CASCADE;
DROP TABLE IF EXISTS questionComment CASCADE;
DROP TABLE IF EXISTS questionContent;
DROP TABLE IF EXISTS questionVote;
DROP TABLE IF EXISTS answerVote;
DROP TABLE IF EXISTS answerContent;
DROP TABLE IF EXISTS questionSubscription;
DROP TABLE IF EXISTS questionCommentContent;
DROP TABLE IF EXISTS answerCommentContent;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS tag CASCADE;
DROP TABLE IF EXISTS questionTag;

DROP TYPE IF EXISTS userGroupEnum;

CREATE TABLE country (
	idCountry SERIAL PRIMARY KEY,
	name TEXT NOT NULL UNIQUE
);

CREATE TYPE userGroupEnum AS ENUM ('user', 'moderator', 'admin');

CREATE TABLE webUser (
  idUser SERIAL PRIMARY KEY,
  username TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  salt TEXT NOT NULL,
  imageLink TEXT default NULL,
  registrationDate TIMESTAMP NOT NULL,
  about TEXT default NULL,
  birthDate TIMESTAMP,
  city TEXT,
  email TEXT NOT NULL UNIQUE,
  gender CHAR(1) CONSTRAINT gender_ck CHECK (gender IN ('F', 'M')),
  name TEXT NOT NULL,
  numAnswers INTEGER NOT NULL DEFAULT 0,
  numComments INTEGER NOT NULL DEFAULT 0,
  numQuestions INTEGER NOT NULL DEFAULT 0,
  score INTEGER NOT NULL DEFAULT 0,
  idCountry INTEGER REFERENCES country (idCountry),
  userGroup userGroupEnum NOT NULL,
  banned BOOLEAN NOT NULL DEFAULT FALSE,
  CHECK (numAnswers>=0 AND numComments>=0 AND numQuestions>=0)
);

CREATE TABLE question (
  idQuestion SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  date TIMESTAMP NOT NULL,
  score INTEGER NOT NULL DEFAULT 0,
  hot INTEGER NOT NULL DEFAULT 0,
  idUser INTEGER REFERENCES webUser (idUser)
);

CREATE TABLE tag (
  idTag SERIAL PRIMARY KEY,
  name TEXT NOT NULL UNIQUE
);

CREATE TABLE questionTag (
  idQuestion INTEGER REFERENCES question (idQuestion),
  idTag INTEGER REFERENCES tag (idTag),
  PRIMARY KEY (idQuestion, idTag)
);

CREATE TABLE questionSubscription (
  idUser INTEGER REFERENCES webUser (idUser),
  idQuestion INTEGER REFERENCES question (idQuestion),
  PRIMARY KEY (idUser, idQuestion)
);

CREATE TABLE questionContent (
  idUser INTEGER REFERENCES webUser (idUser),
  idQuestion INTEGER REFERENCES question (idQuestion),
  html TEXT NOT NULL,
  date TIMESTAMP NOT NULL,
  PRIMARY KEY (idUser, idQuestion, date)
);

CREATE TABLE questionVote (
  idUser INTEGER REFERENCES webUser (idUser),
  idQuestion INTEGER REFERENCES question (idQuestion),
  upDown INTEGER NOT NULL,
  CHECK (upDown=-1 OR upDown=1),
  PRIMARY KEY (idUser, idQuestion)
);

CREATE TABLE answer (
  idAnswer SERIAL PRIMARY KEY,
  date TIMESTAMP NOT NULL,
  score INTEGER NOT NULL DEFAULT 0,
  idQuestion INTEGER REFERENCES question (idQuestion),
  idUser INTEGER REFERENCES webUser (idUser),
  bestAnswer BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE answerVote(
  idAnswer INTEGER REFERENCES answer (idAnswer),
  idUser INTEGER REFERENCES webUser (idUser),
  upDown INTEGER NOT NULL,
  CHECK (upDown=-1 OR upDown=1),
  PRIMARY KEY (idAnswer, idUser)
);

CREATE TABLE answerContent (
  idAnswer INTEGER REFERENCES answer (idAnswer),
  idUser INTEGER REFERENCES webUser (idUser),
  date TIMESTAMP NOT NULL,
  html TEXT NOT NULL,
  PRIMARY KEY (idAnswer, idUser, date)
);

CREATE TABLE questionComment (
  idComment SERIAL PRIMARY KEY,
  idUser INTEGER REFERENCES webUser (idUser),
  date TIMESTAMP NOT NULL,
  idQuestion INTEGER REFERENCES question (idQuestion)
);

CREATE TABLE answerComment (
  idComment SERIAL PRIMARY KEY,
  idUser INTEGER REFERENCES webUser (idUser),
  date TIMESTAMP,
  idAnswer INTEGER REFERENCES answer (idAnswer)
);

CREATE TABLE questionCommentContent (
  idComment INTEGER REFERENCES questionComment (idComment),
  idUser INTEGER REFERENCES webUser (idUser),
  date TIMESTAMP NOT NULL,
  content TEXT default NULL,
  CHECK (char_length(content) <= 200),
  PRIMARY KEY (idComment, idUser, date)
);

CREATE TABLE answerCommentContent (
  idComment INTEGER REFERENCES answerComment (idComment),
  idUser INTEGER REFERENCES webUser (idUser),
  date TIMESTAMP NOT NULL,
  content TEXT default NULL,
  CHECK (char_length(content) <= 200),
  PRIMARY KEY (idComment, idUser, date)
);


--view to get question with latest content
CREATE VIEW question_vw AS
SELECT question.idQuestion AS idQuestion, question.title AS title, question.date AS date, 
  question.score AS score, question.hot AS hot, question.idUser AS idUser, questionContent.idUser AS lastUser, 
  questionContent.date AS lastDate, questionContent.html AS html
FROM question, questionContent 
WHERE question.idQuestion = questionContent.idQuestion
  AND questionContent.date = (SELECT MAX(questionContent.date) FROM questionContent WHERE questionContent.idQuestion = question.idQuestion);

CREATE RULE question_vw_INSERT AS ON INSERT TO question_vw DO INSTEAD (
  INSERT INTO question (title, date, idUser) 
  VALUES (NEW.title, NEW.date, NEW.idUser);
  INSERT INTO questionContent (idUser, idQuestion, html, date)
  VALUES (NEW.idUser, 
    (SELECT idQuestion 
      FROM question 
      WHERE title = NEW.title 
        AND date = NEW.date 
        AND idUser = NEW.idUser), NEW.html, NEW.date);
);

--answer with last content
CREATE VIEW answer_vw AS
SELECT answer.idAnswer, answer.date AS date, answer.score, 
  answer.idQuestion, answer.idUser, answer.bestAnswer,
  answerContent.idUser AS lastUser, answerContent.date AS lastDate,
  answerContent.html
FROM answer, answerContent
WHERE answer.idAnswer = answerContent.idAnswer
  AND answerContent.date = (SELECT MAX(answerContent.date) FROM answerContent WHERE answerContent.idAnswer = answer.idAnswer);

CREATE RULE answer_vw_INSERT AS ON INSERT TO answer_vw DO INSTEAD (
  INSERT INTO answer (date, idQuestion, idUser) 
  VALUES (NEW.date, NEW.idQuestion, NEW.idUser);
  INSERT INTO answerContent (idUser, idAnswer, html, date)
  VALUES (NEW.idUser, 
    (SELECT idAnswer 
      FROM answer 
      WHERE date = NEW.date 
        AND idQuestion = NEW.idQuestion 
        AND idUser = NEW.idUser), NEW.html, NEW.date);
);
  

-- to list question headers
CREATE VIEW question_list_vw AS
  SELECT question.idQuestion, question.title, question.date, question.score, question.idUser, webuser.username, question.hot,
  (SELECT COUNT(*) FROM answer WHERE question.idquestion = answer.idquestion) AS numAnswers
  FROM question , webuser
  WHERE question.idUser = webuser.idUser
  ORDER BY question.idQuestion;

--commentquestion with last content not tested
CREATE VIEW questionComment_vw AS
SELECT questionComment.idComment, questionComment.date, questionComment.idQuestion,
  questionComment.idUser, questionCommentContent.date AS lastDate,
  questionCommentContent.content
FROM questionComment, questionCommentContent
WHERE questionComment.idComment = questionCommentContent.idComment
  AND questionCommentContent.date = (SELECT MAX(questionCommentContent.date) FROM questionCommentContent WHERE questionCommentContent.idComment = questionComment.idComment);

CREATE RULE questionComment_vw_INSERT AS ON INSERT TO questionComment_vw DO INSTEAD (
  INSERT INTO questionComment (date, idQuestion, idUser) 
  VALUES (NEW.date, NEW.idQuestion, NEW.idUser);
  INSERT INTO questionCommentContent (idUser, idComment, content, date)
  VALUES (NEW.idUser, 
    (SELECT idComment 
      FROM questionComment 
      WHERE date = NEW.date 
        AND questionComment.idQuestion = NEW.idQuestion), NEW.content, NEW.date);
);

--commentanswer with last content not tested
CREATE VIEW answerComment_vw AS
SELECT answerComment.idComment, answerComment.date, answerComment.idAnswer,
  answerComment.idUser, answerCommentContent.date AS lastDate,
  answerCommentContent.content
FROM answerComment, answerCommentContent
WHERE answerComment.idComment = answerCommentContent.idComment
  AND answerCommentContent.date = (SELECT MAX(answerCommentContent.date) FROM answerCommentContent WHERE answerCommentContent.idComment = answerComment.idComment);

CREATE RULE answerComment_vw_INSERT AS ON INSERT TO answerComment_vw DO INSTEAD (
  INSERT INTO answerComment (date, idAnswer, idUser) 
  VALUES (NEW.date, NEW.idAnswer, NEW.idUser);
  INSERT INTO answerCommentContent (idUser, idComment, content, date)
  VALUES (NEW.idUser, 
    (SELECT idComment 
      FROM answerComment 
      WHERE date = NEW.date 
        AND answerComment.idAnswer = NEW.idAnswer), NEW.content, NEW.date);
);


--Triggers

DROP TRIGGER IF EXISTS update_n_questions ON question;
DROP TRIGGER IF EXISTS update_n_questions_delete ON question;
DROP TRIGGER IF EXISTS update_n_answers ON answer;
DROP TRIGGER IF EXISTS update_n_answers_delete ON answer;
DROP TRIGGER IF EXISTS update_best_answer_score ON answer;
DROP TRIGGER IF EXISTS update_best_answer_score_delete ON answer;
DROP TRIGGER IF EXISTS update_n_question_comments ON questioncomment;
DROP TRIGGER IF EXISTS update_n_answer_comments ON answercomment;
DROP TRIGGER IF EXISTS update_n_question_comments_delete ON questioncomment;
DROP TRIGGER IF EXISTS update_n_answer_comments_delete ON answercomment;
DROP TRIGGER IF EXISTS update_question_score ON questionvote;
DROP TRIGGER IF EXISTS update_answer_score ON answervote;
DROP TRIGGER IF EXISTS update_question_score2 ON questionvote;
DROP TRIGGER IF EXISTS update_answer_score2 ON answervote;
DROP TRIGGER IF EXISTS update_question_score3 ON questionvote;
DROP TRIGGER IF EXISTS update_answer_score3 ON answervote;

/*CREATE OR REPLACE FUNCTION update_n_questions() RETURNS trigger AS $update_n_questions$
  BEGIN
      UPDATE webUser SET numQuestions = numQuestions+1 WHERE idUser = NEW.idUser;
      RETURN NEW;
  END;
$update_n_questions$ LANGUAGE plpgsql;

CREATE TRIGGER update_n_questions BEFORE INSERT ON question FOR EACH ROW EXECUTE PROCEDURE update_n_questions();

CREATE OR REPLACE FUNCTION update_n_questions_delete() RETURNS trigger AS $update_n_questions$
  BEGIN
      UPDATE webUser SET numQuestions = numQuestions-1 WHERE idUser = NEW.idUser;
      RETURN NEW;
  END;
$update_n_questions$ LANGUAGE plpgsql;

CREATE TRIGGER update_n_questions_delete BEFORE DELETE ON question FOR EACH ROW EXECUTE PROCEDURE update_n_questions_delete();

CREATE OR REPLACE FUNCTION update_n_answers() RETURNS trigger AS $update_n_answers$
  BEGIN
      UPDATE webUser SET numAnswers = numAnswers+1 WHERE idUser = NEW.idUser;
      RETURN NEW;
  END;
$update_n_answers$ LANGUAGE plpgsql;

CREATE TRIGGER update_n_answers BEFORE INSERT ON answer FOR EACH ROW EXECUTE PROCEDURE update_n_answers();

CREATE OR REPLACE FUNCTION update_best_answer_score() RETURNS trigger AS $update_n_answers$
  BEGIN
     IF NOT NEW.bestAnswer AND OLD.bestAnswer THEN
       UPDATE webUSer SET score = score-3 WHERE idUser = NEW.idUser;
       END IF;
       IF NEW.bestAnswer AND NOT OLD.bestAnswer THEN
         UPDATE webUSer SET score = score+3 WHERE idUser = NEW.idUser;
       END IF;
      RETURN NEW;
  END;
$update_n_answers$ LANGUAGE plpgsql;

CREATE TRIGGER update_best_answer_score BEFORE UPDATE ON answer FOR EACH ROW EXECUTE PROCEDURE update_best_answer_score();

CREATE OR REPLACE FUNCTION update_best_answer_score_delete() RETURNS trigger AS $update_n_answers$
  BEGIN
     UPDATE webUser SET numAnswers = numAnswers-1 WHERE idUser = NEW.idUser;
     IF OLD.bestAnswer THEN
       UPDATE webUSer SET score = score-3 WHERE idUser = NEW.idUser;
       END IF;
      RETURN NEW;
  END;
$update_n_answers$ LANGUAGE plpgsql;

CREATE TRIGGER update_best_answer_score_delete BEFORE DELETE ON answer FOR EACH ROW EXECUTE PROCEDURE update_best_answer_score_delete();

CREATE OR REPLACE FUNCTION update_n_question_comments() RETURNS trigger AS $update_n_question_comments$
  BEGIN
      UPDATE webUser SET numComments = numComments+1 WHERE idUser = (SELECT idUser FROM questionComment, questionCommentContent WHERE questionComment.idComment = questionCommentContent.idComment);
      RETURN NEW;
  END;
$update_n_question_comments$ LANGUAGE plpgsql;

CREATE TRIGGER update_n_question_comments BEFORE INSERT ON questioncomment FOR EACH ROW  EXECUTE PROCEDURE update_n_question_comments();

CREATE OR REPLACE FUNCTION update_n_answer_comments() RETURNS trigger AS $update_n_answer_comments$
  BEGIN
      UPDATE webUser SET numComments = numComments+1 WHERE idUser = (SELECT idUser FROM answerComment, answerCommentContent WHERE answerComment.idComment = answerCommentContent.idComment);
      RETURN NEW;
  END;
$update_n_answer_comments$ LANGUAGE plpgsql;

CREATE TRIGGER update_n_answer_comments BEFORE INSERT ON answercomment FOR EACH ROW  EXECUTE PROCEDURE update_n_answer_comments();

CREATE OR REPLACE FUNCTION update_n_question_comments_delete() RETURNS trigger AS $update_n_question_comments_delete$
  BEGIN
      UPDATE webUser SET numComments = numComments-1 WHERE idUser = (SELECT idUser FROM questionComment, questionCommentContent WHERE questionComment.idComment = questionCommentContent.idComment);
      RETURN NEW;
  END;
$update_n_question_comments_delete$ LANGUAGE plpgsql;

CREATE TRIGGER update_n_question_comments_delete BEFORE DELETE ON questioncomment FOR EACH ROW  EXECUTE PROCEDURE update_n_question_comments_delete();

CREATE OR REPLACE FUNCTION update_n_answer_comments_delete() RETURNS trigger AS $update_n_answer_comments_delete$
  BEGIN
      UPDATE webUser SET numComments = numComments-1 WHERE idUser = (SELECT idUser FROM answerComment, answerCommentContent WHERE answerComment.idComment = answerCommentContent.idComment);
      RETURN NEW;
  END;
$update_n_answer_comments_delete$ LANGUAGE plpgsql;

CREATE TRIGGER update_n_answer_comments_delete BEFORE DELETE ON answercomment FOR EACH ROW  EXECUTE PROCEDURE update_n_answer_comments_delete();


CREATE OR REPLACE FUNCTION update_question_score() RETURNS trigger AS $update_question_score$
  BEGIN
      IF NEW.updown = 1 AND OLD.updown = -1 THEN
          UPDATE webUser SET score = score-1 WHERE idUser = (SELECT idUser FROM question WHERE idQuestion = NEW.idQuestion);
          UPDATE question SET score = score-2 WHERE idQuestion= NEW.idQuestion;
      END IF;
      IF NEW.updown = -1 AND OLD.updown = 1 THEN
          UPDATE webUser SET score = score+1 WHERE idUser = (SELECT idUser FROM question WHERE idQuestion = NEW.idQuestion);
          UPDATE question SET score = score+2 WHERE idQuestion= NEW.idQuestion;
      END IF;
      RETURN NEW;
  END;
$update_question_score$ LANGUAGE plpgsql;

CREATE TRIGGER update_question_score BEFORE UPDATE ON questionvote FOR EACH ROW EXECUTE PROCEDURE update_question_score();

CREATE OR REPLACE FUNCTION update_question_score2() RETURNS trigger AS $update_question_score$
  BEGIN
      IF NEW.updown = 1 THEN
          UPDATE webUser SET score = score+1 WHERE idUser = (SELECT idUser FROM question WHERE idQuestion = NEW.idQuestion);
      END IF;
      UPDATE question SET score = score+NEW.updown WHERE idQuestion= NEW.idQuestion;
      RETURN NEW;
  END;
$update_question_score$ LANGUAGE plpgsql;

CREATE TRIGGER update_question_score2 BEFORE INSERT ON questionvote FOR EACH ROW EXECUTE PROCEDURE update_question_score2();

CREATE OR REPLACE FUNCTION update_question_score3() RETURNS trigger AS $update_question_score$
  BEGIN
     IF OLD.updown = 1 THEN
       UPDATE webUser SET score = score-OLD.updown WHERE idUser = (SELECT idUser FROM question WHERE idQuestion = OLD.idQuestion);
      END IF;
      UPDATE question SET score = score-OLD.updown WHERE idQuestion= OLD.idQuestion;
      RETURN NEW;
  END;
$update_question_score$ LANGUAGE plpgsql;

CREATE TRIGGER update_question_score3 BEFORE DELETE ON questionvote FOR EACH ROW EXECUTE PROCEDURE update_question_score3();

CREATE OR REPLACE FUNCTION update_answer_score() RETURNS trigger AS $update_answer_score$
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
$update_answer_score$ LANGUAGE plpgsql;

CREATE TRIGGER update_answer_score BEFORE UPDATE ON answervote FOR EACH ROW EXECUTE PROCEDURE update_answer_score();

CREATE OR REPLACE FUNCTION update_answer_score2() RETURNS trigger AS $update_answer_score$
  BEGIN
     IF NEW.updown = 1  THEN
       UPDATE webUser SET score = score+2 WHERE idUser = (SELECT idUser FROM answer WHERE idAnswer = NEW.idAnswer);
      END IF;
      UPDATE answer SET score = score+NEW.updown WHERE idAnswer = NEW.idAnswer;
      RETURN NEW;
  END;
$update_answer_score$ LANGUAGE plpgsql;

CREATE TRIGGER update_answer_score2 BEFORE INSERT ON answervote FOR EACH ROW EXECUTE PROCEDURE update_answer_score2();

CREATE OR REPLACE FUNCTION update_answer_score3() RETURNS trigger AS $update_answer_score$
  BEGIN
     IF OLD.updown = 1 THEN
       UPDATE webUser SET score = score-2 WHERE idUser = (SELECT idUser FROM answer WHERE idAnswer = OLD.idAnswer);
      END IF;
      UPDATE answer SET score = score-OLD.updown WHERE idAnswer = OLD.idAnswer;
      RETURN NEW;
  END;
$update_answer_score$ LANGUAGE plpgsql;

CREATE TRIGGER update_answer_score3 BEFORE DELETE ON answervote FOR EACH ROW EXECUTE PROCEDURE update_answer_score3();*/


CREATE OR REPLACE FUNCTION update_n_questions() RETURNS trigger AS $update_n_questions$
    BEGIN
        UPDATE webUser SET numQuestions = numQuestions+1 WHERE idUser = NEW.idUser;
        RETURN NEW;
    END;
$update_n_questions$ LANGUAGE plpgsql;

CREATE TRIGGER update_n_questions AFTER INSERT ON question FOR EACH ROW EXECUTE PROCEDURE update_n_questions();

CREATE OR REPLACE FUNCTION update_n_questions_delete() RETURNS trigger AS $update_n_questions_delete$
    BEGIN
        UPDATE webUser SET numQuestions = numQuestions-1 WHERE idUser = OLD.idUser;
        RETURN NULL;
    END;
$update_n_questions_delete$ LANGUAGE plpgsql;

CREATE TRIGGER update_n_questions_delete AFTER DELETE ON question FOR EACH ROW EXECUTE PROCEDURE update_n_questions_delete();

CREATE OR REPLACE FUNCTION update_n_answers() RETURNS trigger AS $update_n_answers$
    BEGIN
        UPDATE webUser SET numAnswers = numAnswers+1 WHERE idUser = NEW.idUser;
        RETURN NEW;
    END;
$update_n_answers$ LANGUAGE plpgsql;

CREATE TRIGGER update_n_answers AFTER INSERT ON answer FOR EACH ROW EXECUTE PROCEDURE update_n_answers();


CREATE OR REPLACE FUNCTION update_n_question_comments() RETURNS trigger AS $update_n_question_comments$
    BEGIN
        UPDATE webUser SET numComments = numComments+1 WHERE idUser = NEW.idUser;
        RETURN NEW;
    END;
$update_n_question_comments$ LANGUAGE plpgsql;

CREATE TRIGGER update_n_question_comments AFTER INSERT ON questioncomment FOR EACH ROW  EXECUTE PROCEDURE update_n_question_comments();

CREATE OR REPLACE FUNCTION update_n_answer_comments() RETURNS trigger AS $update_n_answer_comments$
    BEGIN
        UPDATE webUser SET numComments = numComments+1 WHERE idUser = NEW.idUser;
        RETURN NEW;
    END;
$update_n_answer_comments$ LANGUAGE plpgsql;

CREATE TRIGGER update_n_answer_comments AFTER INSERT ON answercomment FOR EACH ROW  EXECUTE PROCEDURE update_n_answer_comments();

CREATE OR REPLACE FUNCTION update_n_question_comments_delete() RETURNS trigger AS $update_n_question_comments_delete$
    BEGIN
        UPDATE webUser SET numComments = numComments-1 WHERE idUser = OLD.idUser;
        RETURN NULL;
    END;
$update_n_question_comments_delete$ LANGUAGE plpgsql;

CREATE TRIGGER update_n_question_comments_delete AFTER DELETE ON questioncomment FOR EACH ROW  EXECUTE PROCEDURE update_n_question_comments_delete();

CREATE OR REPLACE FUNCTION update_n_answer_comments_delete() RETURNS trigger AS $update_n_answer_comments_delete$
    BEGIN
        UPDATE webUser SET numComments = numComments-1 WHERE idUser = OLD.idUser;
        RETURN NULL;
    END;
$update_n_answer_comments_delete$ LANGUAGE plpgsql;

CREATE TRIGGER update_n_answer_comments_delete AFTER DELETE ON answercomment FOR EACH ROW  EXECUTE PROCEDURE update_n_answer_comments_delete();

CREATE OR REPLACE FUNCTION update_question_score() RETURNS trigger AS $update_question_score$
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
$update_question_score$ LANGUAGE plpgsql;

CREATE TRIGGER update_question_score AFTER UPDATE ON questionvote FOR EACH ROW EXECUTE PROCEDURE update_question_score();

CREATE OR REPLACE FUNCTION update_question_score2() RETURNS trigger AS $update_question_score2$
    BEGIN
        IF NEW.updown = 1 THEN
            UPDATE webUser SET score = score+1 WHERE idUser = (SELECT idUser FROM question WHERE idQuestion = NEW.idQuestion);
        END IF;
        UPDATE question SET score = score+NEW.updown WHERE idQuestion= NEW.idQuestion;
        RETURN NEW;
    END;
$update_question_score2$ LANGUAGE plpgsql;

CREATE TRIGGER update_question_score2 AFTER INSERT ON questionvote FOR EACH ROW EXECUTE PROCEDURE update_question_score2();

CREATE OR REPLACE FUNCTION update_question_score3() RETURNS trigger AS $update_question_score3$
    BEGIN
        IF OLD.updown = 1 THEN
            UPDATE webUser SET score = score-OLD.updown WHERE idUser = (SELECT idUser FROM question WHERE idQuestion = OLD.idQuestion);
        END IF;
        UPDATE question SET score = score-OLD.updown WHERE idQuestion= OLD.idQuestion;
        RETURN NULL;
    END;
$update_question_score3$ LANGUAGE plpgsql;

CREATE TRIGGER update_question_score3 AFTER DELETE ON questionvote FOR EACH ROW EXECUTE PROCEDURE update_question_score3();

CREATE OR REPLACE FUNCTION update_answer_score() RETURNS trigger AS $update_answer_score$
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
$update_answer_score$ LANGUAGE plpgsql;

CREATE TRIGGER update_answer_score AFTER UPDATE ON answervote FOR EACH ROW EXECUTE PROCEDURE update_answer_score();

CREATE OR REPLACE FUNCTION update_answer_score2() RETURNS trigger AS $update_answer_score2$
    BEGIN
        IF NEW.updown = 1  THEN
            UPDATE webUser SET score = score+2 WHERE idUser = (SELECT idUser FROM answer WHERE idAnswer = NEW.idAnswer);
        END IF;
        UPDATE answer SET score = score+NEW.updown WHERE idAnswer = NEW.idAnswer;
        RETURN NEW;
    END;
$update_answer_score2$ LANGUAGE plpgsql;

CREATE TRIGGER update_answer_score2 AFTER INSERT ON answervote FOR EACH ROW EXECUTE PROCEDURE update_answer_score2();

CREATE OR REPLACE FUNCTION update_answer_score3() RETURNS trigger AS $update_answer_score3$
    BEGIN
        IF OLD.updown = 1 THEN
            UPDATE webUser SET score = score-2 WHERE idUser = (SELECT idUser FROM answer WHERE idAnswer = OLD.idAnswer);
        END IF;
        UPDATE answer SET score = score-OLD.updown WHERE idAnswer = OLD.idAnswer;
        RETURN NULL;
    END;
$update_answer_score3$ LANGUAGE plpgsql;

CREATE TRIGGER update_answer_score3 AFTER DELETE ON answervote FOR EACH ROW EXECUTE PROCEDURE update_answer_score3();

CREATE OR REPLACE FUNCTION update_best_answer_score() RETURNS trigger AS $update_best_answer_score$
    BEGIN
        IF NOT NEW.bestAnswer AND OLD.bestAnswer THEN
            UPDATE webUSer SET score = score-3 WHERE idUser = NEW.idUser;
           END IF;
           IF NEW.bestAnswer AND NOT OLD.bestAnswer THEN
               UPDATE webUSer SET score = score+3 WHERE idUser = NEW.idUser;
           END IF;
        RETURN NEW;
    END;
$update_best_answer_score$ LANGUAGE plpgsql;

CREATE TRIGGER update_best_answer_score AFTER UPDATE ON answer FOR EACH ROW EXECUTE PROCEDURE update_best_answer_score();

CREATE OR REPLACE FUNCTION update_best_answer_score_delete() RETURNS trigger AS $update_best_answer_score_delete$
    BEGIN
        UPDATE webUser SET numAnswers = numAnswers-1 WHERE idUser = OLD.idUser;
        IF OLD.bestAnswer THEN
            UPDATE webUSer SET score = score-3 WHERE idUser = OLD.idUser;
        END IF;
        RETURN NULL;
    END;
$update_best_answer_score_delete$ LANGUAGE plpgsql;

CREATE TRIGGER update_best_answer_score_delete AFTER DELETE ON answer FOR EACH ROW EXECUTE PROCEDURE update_best_answer_score_delete();
/*answer
CREATE RULE question_vw_INSERT AS ON INSERT TO question_vw DO INSTEAD (
	INSERT INTO question (title, date, idUser) 
	VALUES (NEW.title, NEW.date, NEW.idUser);
	INSERT INTO questionContent (idUser, idQuestion, html, date)
	VALUES (NEW.idUser, 
		(SELECT idQuestion 
			FROM question 
			WHERE title = NEW.title 
				AND date = NEW.date 
				AND idUser = NEW.idUser), NEW.html, NEW.date);
);

CREATE RULE answer_vw_INSERT AS ON INSERT TO answer_vw DO INSTEAD (
	INSERT INTO answer (date, idQuestion, idUser) 
	VALUES (NEW.date, NEW.idQuestion, NEW.idUser);
	INSERT INTO answerContent (idUser, idAnswer, html, date)
	VALUES (NEW.idUser, 
		(SELECT idAnswer 
			FROM answer 
			WHERE date = NEW.date 
				AND idQuestion = NEW.idQuestion 
				AND idUser = NEW.idUser), NEW.html, NEW.date);
);


CREATE RULE questionComment_vw_INSERT AS ON INSERT TO questionComment_vw DO INSTEAD (
	INSERT INTO questionComment (date, idQuestion) 
	VALUES (NEW.date, NEW.idQuestion);
	INSERT INTO questionCommentContent (idUser, idComment, content, date)
	VALUES (NEW.idUser, 
		(SELECT idComment 
			FROM questionComment 
			WHERE date = NEW.date 
				AND questionComment.idQuestion = NEW.idQuestion), NEW.content, NEW.date);
);


CREATE RULE answerComment_vw_INSERT AS ON INSERT TO answerComment_vw DO INSTEAD (
	INSERT INTO answerComment (date, idAnswer) 
	VALUES (NEW.date, NEW.idAnswer);
	INSERT INTO answerCommentContent (idUser, idComment, content, date)
	VALUES (NEW.idUser, 
		(SELECT idComment 
			FROM answerComment 
			WHERE date = NEW.date 
				AND answerComment.idAnswer = NEW.idAnswer), NEW.content, NEW.date);
);*/

CREATE INDEX webUser_username_index ON webUser(username);

CREATE INDEX moderators_or_admins_index ON webUser(userGroup) Where userGroup='moderator' OR userGroup='admin';

CREATE INDEX questions_about_tag_index ON questionTag(idTag);
CREATE INDEX tags_of_question_index ON questionTag(idQuestion);

CREATE INDEX questions_user_index ON question(idUser);
CREATE INDEX questions_subscription_index ON questionSubscription(idUser);


CREATE INDEX answers_for_question_index ON answer(idQuestion);

CREATE INDEX question_vote_index ON questionVote(idQuestion);
CREATE INDEX answer_vote_index ON answerVote(idAnswer);

CREATE INDEX content_of_question_index ON questionContent(idQuestion,date);
CREATE INDEX content_of_answer_index ON answercontent(idAnswer,date);
CREATE INDEX content_of_comment1_index ON questionCommentContent(idComment, date);
CREATE INDEX content_of_comment2_index ON answerCommentContent(idComment, date);

CREATE INDEX question_comment_index ON questioncomment(idQuestion);
CREATE INDEX answer_comment_index ON answercomment(idAnswer);

CREATE UNIQUE INDEX best_answer_of_question_index ON answer(idQuestion)
    WHERE bestAnswer;

CREATE INDEX hot_questions_index ON question(idQuestion) where hot>0;

CREATE INDEX search_question_index ON question USING gin(to_tsvector('portuguese', title));

CREATE INDEX search_question_content_index ON questionContent USING gin(to_tsvector('portuguese', html));

CREATE INDEX search_answer_content_index ON question USING gin(to_tsvector('portuguese', title));
