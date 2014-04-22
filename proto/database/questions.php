<?php

function getQuestionsByDate($numQuestions) {

    global $conn;
    $stmt = $conn->prepare("SELECT *
        FROM question_list_vw
        LIMIT :num
        ORDER BY idQuestion
        DESC;");
    
    $stmt->bindParam(":num", $numQuestions);
    $stmt->execute();
    $stmt->fetchAll();

    $data = array();
    if ($stmt->num_rows() > 0) {
        foreach ($stmt->result() as $row) {
            $data[$row->id] = $row->name;
        }
    }

    return json_encode($data);
}

function getQuestionsHot() {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM Question WHERE hot;");
    
    $stmt->execute();
    $stmt->fetchAll();

    $data = array();
    if ($stmt->num_rows() > 0) {
        foreach ($stmt->result() as $row) {
            $data[$row->id] = $row->name;
        }
    }
    return json_encode($data);
}

function getQuestionsSubscribed($idUser) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM Question, QuestionSubscription 
        WHERE QuestionSubscription.idUser = :id
        AND QuestionSubscription.idQuestion = Question.idQuestion;");
    
    $stmt->bindParam(":id", $idUser);
    $stmt->execute();
    $stmt->fetchAll();

    $data = array();
    if ($stmt->num_rows() > 0) {
        foreach ($stmt->result() as $row) {
            $data[$row->id] = $row->name;
        }
    }
    return json_encode($data);
}

function getQuestionsAsked($idUser) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM Question
        WHERE Question.idUser = :id;");
    
    $stmt->bindParam(":id", $idUser);
    $stmt->execute();
    $stmt->fetchAll();

    $data = array();
    if ($stmt->num_rows() > 0) {
        foreach ($stmt->result() as $row) {
            $data[$row->id] = $row->name;
        }
    }
    return json_encode($data);
}

function getQuestionsAnswered($idUser) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM answer_vw
        WHERE answer.idUser = :id;");
    
    $stmt->bindParam(":id", $idUser);
    $stmt->execute();
    $stmt->fetchAll();

    $data = array();
    if ($stmt->num_rows() > 0) {
        foreach ($stmt->result() as $row) {
            $data[$row->id] = $row->name;
        }
    }
    return json_encode($data);
}

function getQuestion($idQuestion) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM answer_vw
        WHERE answer.idUser = :id;");
    
    $stmt->bindParam(":id", $idQuestion);
    $stmt->execute();
    $stmt->fetch();

    $data = array();
    if ($stmt->num_rows() > 0) {
        foreach ($stmt->result() as $row) {
            $data[$row->id] = $row->name;
        }
    }
    return json_encode($data);
}

function getQuestionTags($idQuestion) {

    global $conn;
    $stmt = $conn->prepare("SELECT Tag.name FROM Tag,QuestionTag
        WHERE QuestionTag.idQuestion = :id AND Tag.idTag = QuestionTag.idTag;");
    
    $stmt->bindParam(":id", $idQuestion);
    $stmt->execute();
    $stmt->fetchAll();

    $data = array();
    if ($stmt->num_rows() > 0) {
        foreach ($stmt->result() as $row) {
            $data[$row->id] = $row->name;
        }
    }
    return json_encode($data);
}

function getQuestionAnswers($idQuestion) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM answer_vw
        WHERE idQuestion = :id;");
    
    $stmt->bindParam(":id", $idQuestion);
    $stmt->execute();
    $stmt->fetchAll();

    $data = array();
    if ($stmt->num_rows() > 0) {
        foreach ($stmt->result() as $row) {
            $data[$row->id] = $row->name;
        }
    }
    return json_encode($data);
}

function getQuestionComments($idQuestion) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM questionComment_vw WHERE idQuestion = :id;");
    
    $stmt->bindParam(":id", $idQuestion);
    $stmt->execute();
    $stmt->fetchAll();

    $data = array();
    if ($stmt->num_rows() > 0) {
        foreach ($stmt->result() as $row) {
            $data[$row->id] = $row->name;
        }
    }
    return json_encode($data);
}

function getAnswerComments($idAnswer) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM answerComment_vw
        WHERE idAnswer = :id;");
    
    $stmt->bindParam(":id", $idAnswer);
    $stmt->execute();
    $stmt->fetchAll();

    $data = array();
    if ($stmt->num_rows() > 0) {
        foreach ($stmt->result() as $row) {
            $data[$row->id] = $row->name;
        }
    }
    return json_encode($data);
}

function searchQuestions($text) {

    global $conn;
    $stmt = $conn->prepare("SELECT question.idQuestion, question.title, question.DATE, question.score,
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
        OR to_tsvector('portuguese', answerContent.html) @@ to_tsquery('poruguese', :text))
        AND question.idUser = webUser.idUser
        GROUP BY question.idQuestion;");
    
    $stmt->bindParam(":text", $text);
    $stmt->execute();
    $stmt->fetchAll();

    $data = array();
    if ($stmt->num_rows() > 0) {
        foreach ($stmt->result() as $row) {
            $data[$row->id] = $row->name;
        }
    }
    return json_encode($data);
}

function addQuestion($title, $idUser, $content)
{
    global $conn;
    $stmt = $conn->prepare("SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
        INSERT INTO question_vw (title, idUser, html) VALUES(:title, :user, :content);");

    $stmt->bindParam(":title", $title);
    $stmt->bindParam(":user", $idUser);
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

function addCommentToAnswer($idAnswer, $idUser, $content)
{
    global $conn;
    $stmt = $conn->prepare("INSERT INTO answerComment_vw (answerComment.idQuestion, answerCommentContent.idUser, answerCommentContent.content)
        VALUES(:answer, :user, :content);");

    $stmt->bindParam(":answer", $idAnswer);
    $stmt->bindParam(":user", $idUser);
    $stmt->bindParam(":content", $content);

    $stmt->execute();
}

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
