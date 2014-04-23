<?php

include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php'); //dados pessoais
include_once($BASE_DIR .'database/questions.php'); //perguntas pessoais
/*
if (!$_GET['username']) {
    $_SESSION['error_messages'][] = 'Undefined username';
    header("Location: $BASE_URL");
    exit;
}*/

$idUser=getIdUser(amet);//$_GET['username']);
$profile_data=getUserProfile($idUser);
$questions_asked=getQuestionsAsked($idUser);
var_dump(1,$questions_asked);
$questions_answered=getQuestionsAnswered($idUser);
var_dump(2,$questions_answered);
$questions_subscribed=getQuestionsSubscribed($idUser);
var_dump(3,$questions_subscribed);

foreach($questions_asked as $key1 => $question1) {
    $tags1 = getQuestionTags($question1['idquestion']);
    $questions_asked[$key1]['tags'] = $tags1;
}
foreach($questions_answered as $key2 => $question2) {
    $tags2 = getQuestionTags($question2['idquestion']);
    $questions_answered[$key2]['tags'] = $tags2;
}
foreach($questions_subscribed as $key3 => $question3) {
    $tags3 = getQuestionTags($question3['idquestion']);
    $questions_subscribed[$key3]['tags'] = $tags3;
}

$smarty->assign('profile_data', $profile_data);
$smarty->assign('questions_asked', $questions_asked);
$smarty->assign('questions_answered', $questions_answered);
$smarty->assign('questions_subscribed', $questions_subscribed);
$smarty->display('users/profile.tpl');

?>