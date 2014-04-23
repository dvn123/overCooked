<?php

include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php'); //dados pessoais
include_once($BASE_DIR .'database/questions.php'); //perguntas pessoais

if (!$_GET['username']) {
    $_SESSION['error_messages'][] = 'Undefined username';
    header("Location: $BASE_URL");
    exit;
}

$idUser= getIdUser($_GET['username']);
$profile_data=getUserProfile($idUser);
$questions_asked=getQuestionsAsked($idUser);
$questions_answered=getQuestionsAnswered($idUser);
$questions_subscribed=getQuestionsSubscribed($idUser);

$smarty->assign('profile_data', $profile_data);
$smarty->assign('questions_asked', $questions_asked);
$smarty->assign('questions_answered', $questions_answered);
$smarty->assign('questions_subscribed', $questions_subscribed);
$smarty->display('users/profile.tpl');

?>