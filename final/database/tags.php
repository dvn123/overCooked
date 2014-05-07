<?php

function getTags() {

    global $conn;
    $stmt = $conn->prepare("SELECT name FROM tag ORDER BY name ASC;");

    $stmt->execute();
    return $stmt->fetchAll();

    /*$data = array();
    if ($stmt->num_rows() > 0) {
        foreach ($stmt->result() as $row) {
            $data[$row->id] = $row->name;
        }
    }
    return json_encode($data);*/
}

function getQuestionByTag($tag) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM question_vw, tag, questionTag
        WHERE tag.name=:name AND questionTag.idTag=tag.idTag AND question_vw.idQuestion=questionTag.idQuestion;");

    $stmt->bindParam(":name", $tag);
    $stmt->execute();
    return $stmt->fetchAll();
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
    /*$stmt = $conn->prepare("INSERT INTO tag (name)
                            VALUES (:name);");*/
    $stmt->bindParam(":name", $tag);
    return $stmt->execute();
}

function createQuestionTag($tag, $questionid) {
    global $conn;
    createTag($tag);
    //echo print_r(getTag($tag));
    //echo getTag($tag)[0]['idtag'];
    $tagid = getTag($tag)[0]['idtag'];
    $stmt = $conn->prepare("INSERT INTO questiontag (idQuestion, idTag)
        VALUES (:questionid, :tagid);");

    $stmt->bindParam(":tagid", $tagid);
    $stmt->bindParam(":questionid", $questionid);
    $stmt->execute();
    return $stmt->fetchAll();
}

?>
