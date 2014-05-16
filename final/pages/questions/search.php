<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/questions.php');

if (!$_GET['content']) {
    $_SESSION['error_messages'][] = 'Pesquisa inválida';
    header("Location: $BASE_URL");
    exit;
}
$tmp = trim($_GET['content']);
$content = str_replace(' ', '&', $tmp);

$questions = searchQuestions($content);

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

foreach($questions as $key => $question) {
    $tags = getQuestionTags($question['idquestion']);
    $questions[$key]['tags'] = $tags;
    $questions = getDate2($question, $questions, $key);
}

$smarty->assign("questions", $questions);

$smarty->display('questions/search.tpl');
?>