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
$get = str_replace(' ', '+', $tmp);

$type2 = "date";
$order = "desc";


if($_GET['type'] && $_GET['order']) {
    $type2 = $_GET['type'];
    $order = $_GET['order'];

    $selection_date = '';
    $selection_answers = '';
    $selection_score = '';

    switch ($type2) {
        case "date":
            $type = "question.idQuestion";
            $selection_date = 'active';
            break;
        case "score":
            $type = "question.score";
            $selection_score = 'active';
            break;
        case "answers":
            $type = "numAnswers1";
            $selection_answers = 'active';
            break;
        default:
            $type = "question.idQuestion";
            $selection_date = 'active';
            $type2 ="date";
            break;
    }

    if($order === 'asc' || $order === "desc")
        if($type)
            $questions = searchQuestions($content,$type, $order);
        else
            $questions = searchQuestions($content,$type,$order);
    else {
        $order = "desc";
        if($type)
            $questions = searchQuestions($content,$type, $order);
        else
            $questions = searchQuestions($content,$type,$order);
    }

    $selection_down = '';
    $selection_up = '';

    if($order === "desc")
        $selection_down = 'active';
    else
        $selection_up = 'active';




}
else {
    $questions = searchQuestions($content,"question.idQuestion", "DESC");
    $selection_date = 'active';
    $selection_answers = '';
    $selection_score = '';

    $selection_down = 'active';
    $selection_up = '';
}



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
$smarty->assign("get", $get);

$smarty->assign("selection_date", $selection_date);
$smarty->assign("selection_answers", $selection_answers);
$smarty->assign("selection_score", $selection_score);

$smarty->assign("selection_down", $selection_down);
$smarty->assign("selection_up", $selection_up);

$smarty->assign("type",$type2);
$smarty->assign("order",$order);




$smarty->display('questions/search.tpl');
?>