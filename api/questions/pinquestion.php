<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/questions.php');
include_once($BASE_DIR .'database/users.php');

if(!isset($_SESSION['username'])) {
    echo '401';
    exit;
}

$idUser = getIdUser($_SESSION['username']);

if (!isset($_POST['value']) || !isset($_POST['idQuestion'])) {
    echo '400';
    exit;
}

if (setQuestionSubscribed("$idUser",$_POST['idQuestion'],$_POST['value'])) {
    echo'200';
} else {
    echo '400';
}
?>
