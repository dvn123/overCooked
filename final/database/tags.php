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

?>
