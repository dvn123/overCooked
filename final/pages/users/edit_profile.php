<?php

include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php'); //dados pessoais

if (!$_GET['username']) {
    $_SESSION['error_messages'][] = 'Username não definido';
    header("Location: $BASE_URL");
    exit;
}

if ($_GET['username']!==$_SESSION['username']) {
    $_SESSION['error_messages'][] = 'Ação não permitida';
    header("Location: $BASE_URL");
    exit;
}

$idUser=getIdUser($_GET['username']);

if($idUser==null) {
    $_SESSION['error_messages'][] = 'Username inválido';
    header("Location: $BASE_URL");
    exit;
}

$profile_data=getUserProfile($idUser);
$profile_data['birthdate']= date('Y-m-d',strtotime($profile_data['birthdate']));

$smarty->assign('username_edit', $_GET['username']);
$smarty->assign('profile_data', $profile_data);
$smarty->display('users/edit_profile.tpl');

?>