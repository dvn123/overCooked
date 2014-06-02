<?php

include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');
include_once($BASE_DIR .'database/admin.php');
/*
if(!isset($_SESSION['username'])) {
    echo '401';
    exit;
}*/

if (!isset($_POST['username'])) {
    echo '400';
    exit;
}

$idUser=getIdUser($_POST['username']);

if (relegateUser($idUser)) {
    echo'200';
} else {
    echo '400';
}

?>
