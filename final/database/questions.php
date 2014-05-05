<?php

function getQuestionsByDate($numQuestions, $page) {

    global $conn;
    $offset = $numQuestions * ($page - 1);
    $stmt = $conn->prepare("SELECT * FROM question_list_vw ORDER BY idQuestion ASC LIMIT :num OFFSET :offset;"); //TODO: alterar ASC para DESC
    
    $stmt->bindParam("offset", $offset);
    $stmt->bindParam("num", $numQuestions);
    $stmt->execute();
    return $stmt->fetchAll();

  /*  $data = array();
    if ($stmt->num_rows() > 0) {
        foreach ($stmt->result() as $row) {
            $data[$row->id] = $row->name;
        }
    }
    return json_encode($data);*/
}

function getQuestionsHot($numQuestions, $page) {

    global $conn;
    $offset = $numQuestions * ($page - 1);
    $stmt = $conn->prepare("SELECT * FROM question_list_vw WHERE hot ORDER BY idQuestion ASC LIMIT :num OFFSET :offset;"); //TODO: alterar ASC para DESC


    $stmt->bindParam("offset", $offset);
    $stmt->bindParam("num", $numQuestions);
    $stmt->execute();
    return $stmt->fetchAll();
}

function getQuestionsSubscribed($idUser) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM question_list_vw, QuestionSubscription
        WHERE QuestionSubscription.idUser = :id
        AND QuestionSubscription.idQuestion = question_list_vw.idQuestion;");
    
    $stmt->bindParam(":id", $idUser);
    $stmt->execute();
    return $stmt->fetchAll();
}

function getQuestionsAsked($idUser) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM question_list_vw
        WHERE question_list_vw.idUser = :id;");
    
    $stmt->bindParam(":id", $idUser);
    $stmt->execute();
    return $stmt->fetchAll();
}

function getQuestionsAnswered($idUser) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM question_list_vw WHERE idQuestion=
    (SELECT idQuestion FROM answer_vw WHERE idUser=:id);");

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

function searchQuestions($text) {

    global $conn;
    $stmt = $conn->prepare("
       SELECT question.idQuestion, question.title, question.DATE, question.score, webUser.username, webUser.imagelink,
        (SELECT COUNT(*) FROM answer WHERE question.idquestion = answer.idquestion) AS numAnswers1
        FROM questionContent, question, answer, answerContent, webUser
        WHERE questionContent.idQuestion = question.idQuestion
        AND questionContent.DATE =
            (SELECT MAX(questionContent.DATE) FROM questionContent WHERE questionContent.idQuestion = question.idQuestion)
        AND answerContent.DATE = (SELECT MAX(answerContent.DATE) FROM answerContent WHERE answerContent.idAnswer = answer.idAnswer)
        AND question.idQuestion = answer.idQuestion
        AND answer.idAnswer = answerContent.idAnswer
        AND (to_tsvector('portuguese', question.title) @@ to_tsquery('portuguese', :text)
        OR to_tsvector('portuguese', questionContent.html) @@ to_tsquery('portuguese', :text)
        OR to_tsvector('portuguese', answerContent.html) @@ to_tsquery('portuguese', :text))
        AND question.idUser = webUser.idUser
        GROUP BY question.idQuestion, webuser.username,webuser.imagelink
        ORDER BY question.idquestion DESC;");

    $stmt->bindParam(":text", $text);
    $stmt->execute();
    return $stmt->fetchAll();
}

function addQuestion($title, $idUser, $content)
{
    global $conn;
    $stmt = $conn->prepare("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
        INSERT INTO question_vw (title, date, idUser, html) VALUES(:title, :date, :user, :content);");

    $stmt->bindParam(":title", $title);
    $stmt->bindParam(":user", $idUser);
    $stmt->bindParam(":date",date('Y-m-d H:i:s', time()));
    $stmt->bindParam(":content", $content);

    $stmt->execute();
}

function addAnswerToQuestion($idQuestion, $idUser, $content)
{
    global $conn;
    $stmt = $conn->prepare("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
        INSERT INTO answer_vw (answer.idQuestion, answer.idUser, answerContent.html)
        VALUES (:question, :idUser, :content);");

    $stmt->bindParam(":question", $idQuestion);
    $stmt->bindParam(":user", $idUser);
    $stmt->bindParam(":content", $content);

    $stmt->execute();
}

function addCommentToQuestion($idQuestion, $idUser, $content)
{
    global $conn;
    $stmt = $conn->prepare("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
        INSERT INTO questionComment_vw (questionComment.idQuestion, questionCommentContent.idUser, questionCommentContent.content)
        VALUES(:question, :user, :content);");

    $stmt->bindParam(":question", $idQuestion);
    $stmt->bindParam(":user", $idUser);
    $stmt->bindParam(":content", $content);

    $stmt->execute();
}

function addCommentToAnswer($idAnswer, $idUser, $content)
{
    global $conn;
    $stmt = $conn->prepare("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
        INSERT INTO answerComment_vw (answerComment.idQuestion, answerCommentContent.idUser, answerCommentContent.content)
        VALUES(:answer, :user, :content);");

    $stmt->bindParam(":answer", $idAnswer);
    $stmt->bindParam(":user", $idUser);
    $stmt->bindParam(":content", $content);

    $stmt->execute();
}

//TODO: SQL026 - Adicionar voto a pergunta
//TODO: SQL027 - Adicionar voto a resposta


/* repeated??
function addCommentToAnswer($idAnswer, $idUser, $content)
{
    global $conn;
    $stmt = $conn->prepare("INSERT INTO answerComment_vw (answerComment.idQuestion, answerCommentContent.idUser, answerCommentContent.content)
        VALUES(:answer, :user, :content);");

    $stmt->bindParam(":answer", $idAnswer);
    $stmt->bindParam(":user", $idUser);
    $stmt->bindParam(":content", $content);

    $stmt->execute();
}*/

function changeQuestionContent($idUser, $idQuestion, $html, $date)
{
    global $conn;
    $stmt = $conn->prepare("INSERT INTO questionContent (idUser, idQuestion, html, date)
        VALUES (:idUser, :idQuestion, :html, :date);");

    $stmt->bindParam(":idUser", $idUser);
    $stmt->bindParam(":idQuestion", $idQuestion);
    $stmt->bindParam(":html", $html);
    $stmt->bindParam(":date", $date);

    $stmt->execute();
}

function changeAnswerContent($idUser, $idAnswer, $html, $date)
{
    global $conn;
    $stmt = $conn->prepare("INSERT INTO answerContent (idAnswer, idUser, date, html)
        VALUES (:idAnswer, :idUser, :date, :html);");
    
    $stmt->bindParam(":idAnswer", $idAnswer);
    $stmt->bindParam(":idUser", $idUser);
    $stmt->bindParam(":date", $date);
    $stmt->bindParam(":html", $html);

    $stmt->execute();
}

function changeCommentToQuestionContent($idUser, $idComment, $html, $date)
{
    global $conn;
    $stmt = $conn->prepare("INSERT INTO questionCommentContent (idComment, idUser, date, content)
        VALUES (:idComment, :idUser, :date, :content);");

    $stmt->bindParam(":idComment", $idComment);
    $stmt->bindParam(":idUser", $idUser);
    $stmt->bindParam(":date", $date);
    $stmt->bindParam(":content", $html);

    $stmt->execute();
}

function changeCommentToAnswerContent($idUser, $idComment, $html, $date)
{
    global $conn;
    $stmt = $conn->prepare("INSERT INTO answerCommentContent (idComment, idUser, date, content)
        VALUES (:idComment, :idUser, :date, :content);");

    $stmt->bindParam(":idComment", $idComment);
    $stmt->bindParam(":idUser", $idUser);
    $stmt->bindParam(":date", $date);
    $stmt->bindParam(":content", $html);

    $stmt->execute();
}

?>
