<?php

function isQuestionSubscribed($idUser,$idQuestion) {
    global $conn;
    $stmt = $conn->prepare("SELECT COUNT(*) AS subscribed FROM QuestionSubscription
        WHERE QuestionSubscription.idUser = :idUser
        AND QuestionSubscription.idQuestion = :idQuestion");

    $stmt->bindParam("idUser", $idUser);
    $stmt->bindParam("idQuestion", $idQuestion);
    $stmt->execute();
    $tmp = $stmt->fetch();
    $tmp2 = $tmp['subscribed'];
    return $tmp2;
}

function setBestAnswer($idAnswer,$value){
    global $conn;
    $stmt = $conn->prepare("UPDATE answer SET bestanswer = false 
        WHERE idanswer = (SELECT idAnswer FROM Answer Where bestanswer=true
            AND idQuestion=(SELECT idQuestion FROM Answer Where idAnswer=:idAnswer))");
    $stmt->bindParam("idAnswer", $idAnswer);
    $res1 = $stmt->execute();

    if(!($value == '0' || $value == 0))
    {
        $stmt2 = $conn->prepare("UPDATE answer SET bestanswer=true WHERE idanswer=:idAnswer");
        $stmt2->bindParam("idAnswer", $idAnswer);
        $res2 = $stmt2->execute();
    } else return $res1;

    return ($res1 && $res2);
}

function setQuestionSubscribed($idUser,$idQuestion,$value) {
    global $conn;
    if($value == '0' || $value == 0)
    {
    $stmt = $conn->prepare("DELETE FROM questionsubscription
    WHERE iduser = :idUser
    AND idquestion = :idQuestion");
    $stmt->bindParam("idUser", $idUser);
    $stmt->bindParam("idQuestion", $idQuestion);
    return $stmt->execute();
    }
    $stmt = $conn->prepare("INSERT INTO questionsubscription (iduser,idquestion) VALUES (:idUser,:idQuestion)");
    $stmt->bindParam("idUser", $idUser);
    $stmt->bindParam("idQuestion", $idQuestion);
    return $stmt->execute();
}

function getQuestionVote($idQuestion, $idUser)
{
    global $conn;
    $stmt = $conn->prepare("SELECT updown FROM QuestionVote Where idQuestion = :idQuestion AND idUser = :idUser");

    $stmt->bindParam("idQuestion", $idQuestion);
    $stmt->bindParam("idUser", $idUser);
    $stmt->execute();
    $tmp = $stmt->fetch();
    if($tmp)
        return $tmp['updown'];
    else return 0;
}

function getAnswerVote($idAnswer, $idUser)
{
    global $conn;
    $stmt = $conn->prepare("SELECT updown FROM AnswerVote Where idAnswer = :idAnswer AND idUser = :idUser");

    $stmt->bindParam("idAnswer", $idAnswer);
    $stmt->bindParam("idUser", $idUser);
    $stmt->execute();
    $tmp = $stmt->fetch();
    if($tmp)
        return $tmp['updown'];
    else return 0;
}

function getNumQuestionsByDate() {
    global $conn;
    $stmt = $conn->prepare("SELECT count(*) FROM question;");
    $stmt->execute();
    $x = $stmt->fetch();
    return $x['count'];
}

function getQuestionsByDate($numQuestions, $page, $type = 'idQuestion', $order = 'desc') {

    global $conn;
    $offset = $numQuestions * ($page - 1);
    $query = "SELECT * FROM question_list_vw ORDER BY " . $type . ' ' . $order . " LIMIT :num OFFSET :offset;";

    $stmt = $conn->prepare($query);

    $stmt->bindParam(":offset", $offset);
    $stmt->bindParam(":num", $numQuestions);
    $stmt->execute();
    return $stmt->fetchAll();
}

function getNumQuestionsHot() {
    global $conn;
    $stmt = $conn->prepare("SELECT count(*) FROM question WHERE hot>0;");
    $stmt->execute();
    $x = $stmt->fetch();
    return $x['count'];
}

function getQuestionsHot($numQuestions, $page) {

    global $conn;
    $offset = $numQuestions * ($page - 1);
    $stmt = $conn->prepare("SELECT * FROM question_list_vw WHERE hot>0 ORDER BY hot ASC LIMIT :num OFFSET :offset;");

    $stmt->bindParam("offset", $offset);
    $stmt->bindParam("num", $numQuestions);
    $stmt->execute();
    return $stmt->fetchAll();
}

function getNumQuestionsSubscribed($idUser) {
    global $conn;
    $stmt = $conn->prepare("SELECT count(*) FROM QuestionSubscription
        WHERE QuestionSubscription.idUser = :id;");

    $stmt->bindParam(":id", $idUser);
    $stmt->execute();
    $x = $stmt->fetch();
    return $x['count'];
}

function getQuestionsSubscribed($idUser, $numQuestions = 15, $page = 1, $type = 'idQuestion', $order = 'desc') {

    $type = "question_list_vw." . $type;
    global $conn;
    $offset = $numQuestions * ($page - 1);

    $query = "SELECT * FROM question_list_vw, QuestionSubscription
        WHERE QuestionSubscription.idUser = :id
        AND QuestionSubscription.idQuestion = question_list_vw.idQuestion ORDER BY " . $type . ' ' . $order . " LIMIT :num OFFSET :offset;";

    $stmt = $conn->prepare($query);

    $stmt->bindParam(":id", $idUser);
    $stmt->bindParam("offset", $offset);
    $stmt->bindParam("num", $numQuestions);
    $stmt->execute();
    return $stmt->fetchAll();
}

function getQuestionsAsked($idUser) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM question_list_vw
        WHERE question_list_vw.idUser = :id ORDER BY idQuestion DESC;");

    $stmt->bindParam(":id", $idUser);
    $stmt->execute();
    return $stmt->fetchAll();
}

function getQuestionsAnswered($idUser) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM question_list_vw WHERE idQuestion in
    (SELECT idQuestion FROM answer_vw WHERE idUser=:id) ORDER BY idQuestion DESC;");

    $stmt->bindParam(":id", $idUser);
    $stmt->execute();
    return $stmt->fetchAll();
}

function getQuestion($idQuestion) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM question_vw WHERE idQuestion = :id;");

    $stmt->bindParam("id", $idQuestion);
    $stmt->execute();
    return $stmt->fetch();
}

function getQuestionTags($idQuestion) {

    global $conn;
    $stmt = $conn->prepare("SELECT Tag.name FROM Tag,QuestionTag
        WHERE QuestionTag.idQuestion = :id AND Tag.idTag = QuestionTag.idTag;");

    $stmt->bindParam("id", $idQuestion);
    $stmt->execute();
    return $stmt->fetchAll();
}

function getQuestionAnswers($idQuestion) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM answer_vw
        WHERE idQuestion = :id;");

    $stmt->bindParam("id", $idQuestion);
    $stmt->execute();
    return $stmt->fetchAll();
}

function getAnswer($idAnswer) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM answer_vw
        WHERE idAnswer = :id;");

    $stmt->bindParam("id", $idAnswer);
    $stmt->execute();
    return $stmt->fetch();
}

function getQuestionComments($idQuestion) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM questionComment_vw WHERE idQuestion = :id;");

    $stmt->bindParam("id", $idQuestion);
    $stmt->execute();
    return $stmt->fetchAll();
}

function getAnswerComments($idAnswer) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM answerComment_vw
        WHERE idAnswer = :id;");

    $stmt->bindParam("id", $idAnswer);
    $stmt->execute();
    return $stmt->fetchAll();
}

function getAnswerComment($idComment) {
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM answerComment
        WHERE idComment = :id;");

    $stmt->bindParam(":id", $idComment);
    $stmt->execute();
    return $stmt->fetch();
}


function getQuestionComment($idComment) {
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM questionComment
        WHERE idComment = :id;");

    $stmt->bindParam(":id", $idComment);
    $stmt->execute();
    return $stmt->fetch();
}

function searchQuestions($text, $type, $order) {

    global $conn;

    $query1 = "SELECT question.idQuestion, question.title, question.DATE, question.score,
(SELECT COUNT(*) FROM answer WHERE question.idquestion = answer.idquestion) AS numAnswers1
FROM question left join questionContent using(idQuestion) left join webUser on question.idUser = webUser.idUser left join answer using(idquestion) left join answerContent using(idAnswer)
WHERE (questionContent.DATE = (SELECT MAX(questionContent.DATE)
FROM questionContent WHERE questionContent.idQuestion = question.idQuestion) OR questionContent is null)
	AND (answerContent.DATE = (SELECT MAX(answerContent.DATE) FROM answerContent
WHERE answerContent.idAnswer = answer.idAnswer) OR answerContent is null)
	AND (to_tsvector('portuguese', question.title) @@
    to_tsquery('portuguese', :text)
		OR to_tsvector('portuguese', questionContent.html) @@
    to_tsquery('portuguese', :text)
		OR to_tsvector('portuguese', answerContent.html) @@
    to_tsquery('portuguese', :text))
     GROUP BY question.idQuestion" . " ORDER BY " . $type . " " . $order;

    $stmt = $conn->prepare($query1);
    $stmt->bindParam(":text", $text);

    $stmt->execute();
    return $stmt->fetchAll();
}

function getQuestionByTitle($title) {
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM question_vw WHERE title = :title;");

    $stmt->bindParam(":title", $title);
    $stmt->execute();
    return $stmt->fetch();
}


function addQuestion($title, $idUser, $content) {
    global $conn;
    $conn->exec("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;");
    $stmt = $conn->prepare("INSERT INTO question_vw (title, date, idUser, html) VALUES(:title, :date, :user, :content);");

    $stmt->bindParam(":title", $title);

    $stmt->bindParam(":user", $idUser);
    $stmt->bindParam(":date", getCurrentDate());
    $stmt->bindParam(":content", $content);

    return $stmt->execute();
}

function addAnswerToQuestion($idQuestion, $idUser, $content) {
    global $conn;
    $conn->exec("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;");
    $stmt = $conn->prepare("INSERT INTO answer_vw (idQuestion, date, idUser, html)
        VALUES (:question, :date, :idUser, :content);");

    $stmt->bindParam(":question", $idQuestion);
    $stmt->bindParam(":idUser", $idUser);
    $stmt->bindParam(":content", $content);
    $stmt->bindParam(":date", getCurrentDate());


    return $stmt->execute();
}

function addCommentToQuestion($idQuestion, $idUser, $content) {
    global $conn;
    $conn->exec("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;");
    $stmt = $conn->prepare("INSERT INTO questionComment_vw (idQuestion, date, idUser, content)
        VALUES(:question, :date, :user, :content);");

    $stmt->bindParam(":question", $idQuestion);
    $stmt->bindParam(":user", $idUser);
    $stmt->bindParam(":content", $content);
    $stmt->bindParam(":date", getCurrentDate());

    return $stmt->execute();
}

function addCommentToAnswer($idAnswer, $idUser, $content) {
    global $conn;
    $conn->exec("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;");
    $stmt = $conn->prepare("INSERT INTO answerComment_vw (idAnswer, date, idUser, content)
        VALUES(:answer, :date, :user, :content);");
    $stmt->bindParam(":answer", $idAnswer);
    $stmt->bindParam(":user", $idUser);
    $stmt->bindParam(":content", $content);
    $stmt->bindParam(":date", getCurrentDate());
    return $stmt->execute();
}

function addVoteToQuestion($idUser,$idQuestion,$value)
{
    global $conn;
    if($value == '0' || $value == 0)
    {
        $conn->exec("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;");
        $stmt = $conn->prepare("DELETE FROM QuestionVote WHERE idUser = :user AND idQuestion = :question");
        $stmt->bindParam("question", $idQuestion);
        $stmt->bindParam("user", $idUser);
        $res = $stmt->execute();
        return $res;
    }

    $conn->exec("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;");
    $stmt = $conn->prepare("UPDATE QuestionVote SET updown = :value WHERE idUser = :user AND idQuestion = :question");
    $stmt->bindParam("question", $idQuestion);
    $stmt->bindParam("user", $idUser);
    $stmt->bindParam("value", $value);
    $res1 = $stmt->execute();

    $conn->exec("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;");
    $stmt2 = $conn->prepare("INSERT INTO QuestionVote (idUser,idQuestion,upDown) SELECT :user,:question,:value WHERE NOT EXISTS (SELECT * FROM QuestionVote WHERE idUser = :user AND idQuestion = :question);");
    $stmt2->bindParam("question", $idQuestion);
    $stmt2->bindParam("user", $idUser);
    $stmt2->bindParam("value", $value);
    $res2 = $stmt2->execute();

    return ($res1 && $res2);
}

function addVoteToAnswer($idUser,$idAnswer,$value)
{
    global $conn;
    $conn->exec("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;");
    $stmt = $conn->prepare("UPDATE AnswerVote SET updown = :value WHERE idUser = :user AND idAnswer = :answer");
    $stmt->bindParam("answer", $idAnswer);
    $stmt->bindParam("user", $idUser);
    $stmt->bindParam("value", $value);
    $res1 = $stmt->execute();

    $conn->exec("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;");
    $stmt2 = $conn->prepare("INSERT INTO AnswerVote (idUser,idAnswer,upDown) SELECT :user,:answer,:value WHERE NOT EXISTS (SELECT * FROM AnswerVote WHERE idUser = :user AND idAnswer = :answer);");
    $stmt2->bindParam("answer", $idAnswer);
    $stmt2->bindParam("user", $idUser);
    $stmt2->bindParam("value", $value);
    $res2 = $stmt2->execute();

    return ($res1 && $res2);
}

function changeQuestionContent($idUser, $idQuestion, $html)
{
    global $conn;
    $stmt = $conn->prepare("INSERT INTO questionContent (idUser, idQuestion, html, date)
        VALUES (:idUser, :idQuestion, :html, :date);");

    $stmt->bindParam(":idUser", $idUser);
    $stmt->bindParam(":idQuestion", $idQuestion);
    $stmt->bindParam(":html", $html);
    $stmt->bindParam(":date", getCurrentDate());

    return $stmt->execute();
}

function changeQuestionTitle($idQuestion, $title)
{
    global $conn;
    $stmt = $conn->prepare("UPDATE Question SET title = :title WHERE idQuestion = :idQuestion");

    $stmt->bindParam(":idQuestion", $idQuestion);
    $stmt->bindParam(":title", $title);
    return $stmt->execute();
}

function changeAnswerContent($idUser, $idAnswer, $html)
{
    global $conn;
    $stmt = $conn->prepare("INSERT INTO answerContent (idAnswer, idUser, date, html)
        VALUES (:idAnswer, :idUser, :date, :html);");

    $stmt->bindParam(":idAnswer", $idAnswer);
    $stmt->bindParam(":idUser", $idUser);
    $stmt->bindParam(":date", getCurrentDate());
    $stmt->bindParam(":html", $html);

    return $stmt->execute();
}

function changeCommentToQuestionContent($idUser, $idComment, $html)
{
    global $conn;
    $stmt = $conn->prepare("INSERT INTO questionCommentContent (idComment, idUser, date, content)
        VALUES (:idComment, :idUser, :date, :content);");

    $stmt->bindParam(":idComment", $idComment);
    $stmt->bindParam(":idUser", $idUser);
    $stmt->bindParam(":date", getCurrentDate());
    $stmt->bindParam(":content", $html);

    return $stmt->execute();
}

function changeCommentToAnswerContent($idUser, $idComment, $html)
{
    global $conn;
    $stmt = $conn->prepare("INSERT INTO answerCommentContent (idComment, idUser, date, content)
        VALUES (:idComment, :idUser, :date, :content);");

    $stmt->bindParam(":idComment", $idComment);
    $stmt->bindParam(":idUser", $idUser);
    $stmt->bindParam(":date", getCurrentDate());
    $stmt->bindParam(":content", $html);

    return $stmt->execute();
}

function deleteQuestion($idQuestion) {
    global $conn;
    deleteQuestionComments($idQuestion);
    deleteQuestionAnswers($idQuestion);

    $stmt5 = $conn->prepare("DELETE FROM questionSubscription WHERE idQuestion = :idQuestion;");
    $stmt5->bindParam(":idQuestion", $idQuestion);
    $stmt5->execute();

    $stmt4 = $conn->prepare("DELETE FROM questionVote WHERE idQuestion = :idQuestion;");
    $stmt4->bindParam(":idQuestion", $idQuestion);
    $stmt4->execute();

    $stmt3 = $conn->prepare("DELETE FROM questionContent WHERE idQuestion = :idQuestion;");
    $stmt3->bindParam(":idQuestion", $idQuestion);
    $stmt3->execute();

    $stmt2 = $conn->prepare("DELETE FROM questionTag WHERE idQuestion = :idQuestion;");
    $stmt2->bindParam(":idQuestion", $idQuestion);
    $stmt2->execute();

    $stmt = $conn->prepare("DELETE FROM question WHERE idQuestion = :idQuestion;");
    $stmt->bindParam(":idQuestion", $idQuestion);
    return $stmt->execute();
}

function deleteQuestionComments($idQuestion) {
    global $conn;
    $stmt2 = $conn->prepare("DELETE FROM questionCommentContent USING questionComment WHERE idQuestion = :idQuestion AND questionComment.idComment = questionCommentContent.idComment;");
    $stmt2->bindParam(":idQuestion", $idQuestion);
    $stmt2->execute();

    $stmt = $conn->prepare("DELETE FROM questionComment WHERE idQuestion = :idQuestion;");
    $stmt->bindParam(":idQuestion", $idQuestion);
    return $stmt->execute();
}

function deleteQuestionAnswers($idQuestion) {
    global $conn;
    $stmt4 = $conn->prepare("DELETE FROM answerCommentContent USING answer, answerComment WHERE answer.idQuestion = :idQuestion AND answerComment.idAnswer = answer.idAnswer AND answerComment.idComment = answerCommentContent.idComment");
    $stmt4->bindParam(":idQuestion", $idQuestion);
    $stmt4->execute();

    $stmt3 = $conn->prepare("DELETE FROM answerComment USING answer WHERE answer.idQuestion = :idQuestion AND answerComment.idAnswer = answer.idAnswer;");
    $stmt3->bindParam(":idQuestion", $idQuestion);
    $stmt3->execute();

    $stmt5 = $conn->prepare("DELETE FROM answerVote USING answer WHERE answer.idQuestion = :idQuestion AND answer.idAnswer = answerVote.idAnswer;");
    $stmt5->bindParam(":idQuestion", $idQuestion);
    $stmt5->execute();

    $stmt2 = $conn->prepare("DELETE FROM answerContent USING answer WHERE answer.idQuestion = :idQuestion AND answer.idAnswer = answerContent.idAnswer;");
    $stmt2->bindParam(":idQuestion", $idQuestion);
    $stmt2->execute();

    $stmt = $conn->prepare("DELETE FROM answer WHERE idQuestion = :idQuestion;");
    $stmt->bindParam(":idQuestion", $idQuestion);
    return $stmt->execute();
}


function deleteAnswer($idAnswer) {
    global $conn;
    deleteAnswerComments($idAnswer);
    $stmt5 = $conn->prepare("DELETE FROM answerVote WHERE idAnswer = :idAnswer;");
    $stmt5->bindParam(":idAnswer", $idAnswer);
    $stmt5->execute();

    $stmt2 = $conn->prepare("DELETE FROM answerContent WHERE idAnswer = :idAnswer;");
    $stmt2->bindParam(":idAnswer", $idAnswer);
    $stmt2->execute();

    $stmt = $conn->prepare("DELETE FROM answer WHERE idAnswer = :idAnswer;");
    $stmt->bindParam(":idAnswer", $idAnswer);
    return $stmt->execute();
}

function deleteAnswerComments($idAnswer) {
    global $conn;
    $stmt2 = $conn->prepare("DELETE FROM answerCommentContent USING answerComment WHERE answerComment.idAnswer = :idAnswer AND answerCommentContent.idComment = answerComment.idComment;");
    $stmt2->bindParam(":idAnswer", $idAnswer);
    $stmt2->execute();

    $stmt = $conn->prepare("DELETE FROM answerComment WHERE idAnswer = :idAnswer;");
    $stmt->bindParam(":idAnswer", $idAnswer);
    return $stmt->execute();
}

function deleteAnswerComment($idComment) {
    global $conn;
    $stmt2 = $conn->prepare("DELETE FROM answerCommentContent WHERE idComment = :idComment;");
    $stmt2->bindParam(":idComment", $idComment);
    $stmt2->execute();

    $stmt = $conn->prepare("DELETE FROM answerComment WHERE idComment = :idComment;");
    $stmt->bindParam(":idComment", $idComment);
    return $stmt->execute();
}

function deleteQuestionComment($idComment) {
    global $conn;
    $stmt2 = $conn->prepare("DELETE FROM questionCommentContent WHERE idComment = :idComment;");
    $stmt2->bindParam(":idComment", $idComment);
    $stmt2->execute();

    $stmt = $conn->prepare("DELETE FROM questionComment WHERE idComment = :idComment;");
    $stmt->bindParam(":idComment", $idComment);
    return $stmt->execute();
}


/*
Hot is:
    - without best answer
    - ordered by date of last answer
    - question in last 10 days
    - top 20
*/
function setHot()
{
        global $conn;
        $stmt = $conn->prepare("UPDATE Question SET hot = 0");
        $stmt->execute();

        $query = "(select row_number() over(order by
                            case when mdate is NULL then 1 else 0 end, mdate desc)
						as hotRow, nobest.idquestion as idqqq,newanswers.mdate from
                        (select idquestion from question where not exists
                            (select null from answer where bestanswer=true and idquestion = question.idquestion)
                            and date_part('days', now()-date)<=10.0) as nobest
                            left join (select max(date) as mdate, idquestion from answer group by idquestion)
                            as newanswers using(idquestion) limit 20) as selectedquestions";
        $qcomplete = "Update question set hot = selectedquestions.hotrow from ".$query." 
        				where question.idquestion = selectedquestions.idqqq";
        $stmt2 = $conn->prepare($qcomplete);
        $stmt2->execute();
}

?>
