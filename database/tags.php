<?php

function getTags() {

    global $conn;
    $stmt = $conn->prepare("SELECT name FROM tag ORDER BY name ASC;");

    $stmt->execute();
    return $stmt->fetchAll();
}

function getTagsByParam($type,$order) {

    global $conn;
    if($type=='name')
    {
        $stmt = $conn->prepare("SELECT name FROM tag ORDER BY name $order;");
        $stmt->execute();
        return $stmt->fetchAll();
    }else if($type=='freq')
    {
        $stmt = $conn->prepare("SELECT COUNT(questiontag.idQuestion) as freq, tag.name as name FROM tag left join questiontag using(idTag) GROUP BY tag.idTag ORDER BY freq $order;");
        $stmt->execute();
        return $stmt->fetchAll();
    }

}

function getQuestionByTag($tag) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM question_vw, tag, questionTag
        WHERE tag.name=:name AND questionTag.idTag=tag.idTag AND question_vw.idQuestion=questionTag.idQuestion;");

    $stmt->bindParam(":name", $tag);
    $stmt->execute();
    return $stmt->fetchAll();
}

function getQuestionsByTag($tag,$numQuestions, $page, $type = 'idQuestion', $order = 'desc') {
    $type = "question_list_vw." . $type;
    $offset = $numQuestions * ($page - 1);

    $query = "SELECT * FROM question_list_vw, tag, questionTag
     WHERE tag.name=:name AND questionTag.idTag=tag.idTag AND question_list_vw.idQuestion=questionTag.idQuestion
     ORDER BY " . $type . ' ' . $order . " LIMIT :num OFFSET :offset;";

    global $conn;
    $stmt = $conn->prepare($query);

    $stmt->bindParam(":name", $tag);
    $stmt->bindParam(":offset", $offset);
    $stmt->bindParam(":num", $numQuestions);
    $stmt->execute();
    return $stmt->fetchAll();
}

function getNumQuestionsByTag($tag) {
    global $conn;

    $stmt = $conn->prepare("SELECT count(*) FROM question_list_vw, tag, questionTag
     WHERE tag.name=:name AND questionTag.idTag=tag.idTag AND question_list_vw.idQuestion=questionTag.idQuestion");

    $stmt->bindParam(":name", $tag);
    $stmt->execute();
    $x = $stmt->fetch();
    return $x['count'];
}

function getTag($tag) {
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM tag WHERE tag.name = :name;");

    $stmt->bindParam(":name", $tag);
    $stmt->execute();
    return $stmt->fetchAll();
}

function createTag($tag) {
    global $conn;
    $stmt = $conn->prepare("INSERT INTO tag (name)
                            SELECT (:name)
                            WHERE NOT EXISTS (SELECT * FROM Tag
                            WHERE name = :name);");
    $stmt->bindParam(":name", $tag);
    return $stmt->execute();
}

function createQuestionTag($tag, $questionid) {
    global $conn;
    createTag($tag);

    $tag2 = getTag($tag);
    $tagid = $tag2[0]['idtag'];
    $stmt = $conn->prepare("INSERT INTO questiontag (idQuestion, idTag) VALUES (:questionid, :tagid);");

    $stmt->bindParam(":tagid", $tagid);
    $stmt->bindParam(":questionid", $questionid);
    $stmt->execute();
    return $stmt->fetchAll();
}

?>
