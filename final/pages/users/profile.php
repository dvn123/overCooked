<?php

include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php'); //dados pessoais
include_once($BASE_DIR .'database/questions.php'); //perguntas pessoais

if (!$_GET['username']) {
    $_SESSION['error_messages'][] = 'Undefined username';
    header("Location: $BASE_URL");
    exit;
}

$idUser=getIdUser($_GET['username']);

if($idUser==null) {
    $_SESSION['error_messages'][] = 'Invalid username';
    header("Location: $BASE_URL");
    exit;
}

$profile_data=getUserProfile($idUser);
$questions_asked=getQuestionsAsked($idUser);
$questions_answered=getQuestionsAnswered($idUser);
$questions_subscribed=getQuestionsSubscribed($idUser);

/**
 * @param $question
 * @param $questions
 * @param $key
 * @return mixed
 */
function getDate2($question, $questions, $key)
{
    $timeFirst = strtotime($question['date']);
    $timeSecond = time();
    $difference = $timeSecond - $timeFirst;

    if ($difference < 60) {
        $seconds = ' segundos';
        if ($difference == 1)
            $seconds = ' segundo';
        $questions[$key]['date2'] = 'há ' . $difference % 60 . $seconds;
        return $questions;
    } elseif ($difference < 3600) {
        $minutes = ' minutos';
        if ($difference >= 60 && $difference <= 120)
            $minutes = ' minuto';
        $questions[$key]['date2'] = 'há ' . $difference / 60 % 60 . $minutes;
        return $questions;
    } else if ($difference < 86400) {
        $hours = ' horas';
        if ($difference >= 60 && $difference <= 120)
            $hours = ' hora';
        $questions[$key]['date2'] = 'há ' . $difference / 3600 % 24 . $hours;
        return $questions;
    } else if ($difference < 86400 * 7) {
        $hours = ' dias';
        $data = $difference / 86400 % 7;
        if ($data == 1)
            $hours = ' dia';
        $questions[$key]['date2'] = 'há ' . $data . $hours;
        return $questions;
    }
    else if ($difference < 604800  * 52) {
        $text = ' semanas';
        $data = $difference / 604800 % 52;
        if ($data == 1)
            $text = ' semana';
        $questions[$key]['date2'] = 'há ' . $data . $text;
        return $questions;
    }
    else {
        $text = ' anos';
        $data = $difference / 31556926 % 12;
        if ($data == 1)
            $text = ' ano';
        $questions[$key]['date2'] = 'há ' . $data . $text;
        return $questions;
    }
    /*else {
          $date = new DateTime($question['date']);
          $questions[$key]['date2'] = $date->format('d-m-Y');
     }*/
}

foreach($questions_asked as $key => $question) {
    $tags = getQuestionTags($question['idquestion']);
    $questions_asked[$key]['tags'] = $tags;
    $questions_asked = getDate2($question, $questions_asked, $key);
}

foreach($questions_answered as $key => $question) {
    $tags = getQuestionTags($question['idquestion']);
    $questions_answered[$key]['tags'] = $tags;
    $questions_answered = getDate2($question, $questions_answered, $key);
}

foreach($questions_subscribed as $key => $question) {
    $tags3= getQuestionTags($question['idquestion']);
    $questions_subscribed[$key]['tags'] = $tags;
    $questions_subscribed = getDate2($question, $questions_subscribed, $key);
}
$profile_data['birthdate'] = date('d-m-Y',strtotime($profile_data['birthdate']));
$profile_data['registrationdate'] = date('d-m-Y',strtotime($profile_data['registrationdate']));

$smarty->assign('username_edit', $_GET['username']);
$smarty->assign('profile_data', $profile_data);
$smarty->assign('questions_asked', $questions_asked);
$smarty->assign('questions_answered', $questions_answered);
$smarty->assign('questions_subscribed', $questions_subscribed);
$smarty->display('users/profile.tpl');

?>