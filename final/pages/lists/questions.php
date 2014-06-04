<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/questions.php');
include_once($BASE_DIR .'database/tags.php');


if(!$_GET['param'])
    $param = 'last';
else if($_GET['param'] == 'hot' || $_GET['param'] == 'tag' || $_GET['param'] == 'subscription')
    $param = $_GET['param'];
else
    $param = 'last';


$type2 = $_GET['type'];
$order = $_GET['order'];

$selection_date = '';
$selection_answers = '';
$selection_score = '';

$selection_last = '';
$selection_hot = '';
$selection_subscription = '';
$selection_tag = '';

//type
switch ($type2) {
    case "date":
        $type = "idQuestion";
        $selection_date = 'active';
        break;
    case "score":
        $type = "score";
        $selection_score = 'active';
        break;
    case "answers":
        $type = "numAnswers";
        $selection_answers = 'active';
        break;
    default:
        $type = "idQuestion";
        $selection_date = 'active';
        $type2 ="date";
        break;
}

//order
if(!($order === 'asc' || $order === "desc"))
    $order = "desc";

$selection_down = '';
$selection_up = '';

if($order === "desc")
    $selection_down = 'active';
else
    $selection_up = 'active';


//getQuestions
switch ($param) {
    case "last":
        $questions = getQuestionsByDate(50,1,$type, $order);
        $selection_last = 'active';
        break;
    case "hot":
        $questions = getQuestionsHot(50,1,$type, $order);
        $selection_hot = 'active';
        $selection_date = 'disabled';
        $selection_answers = 'disabled';
        $selection_score = 'disabled';
        $selection_down = 'disabled';
        $selection_up = 'disabled';
        break;
    case "tag":
        $questions = getQuestionsByTag('nabo',50,1,$type,$order);//ByTag(50,1,$type, $order);
        $selection_tag = 'active';
        break;
    case "subscription":
        include_once($BASE_DIR .'database/users.php');
        $user = getIdUser($_SESSION['username']);
        $questions = getQuestionsSubscribed($user,50,1,$type, $order);
        $selection_subscription = 'active';
        break;

}




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
}

foreach($questions as $key => $question) {
    $tags = getQuestionTags($question['idquestion']);
    $questions[$key]['tags'] = $tags;
    $questions = getDate2($question, $questions, $key);
}

$tmp = trim($_GET['param']);
$content = str_replace(' ', '&', $tmp);
$get = str_replace(' ', '+', $tmp);

$smarty->assign("questions", $questions);
$smarty->assign("get", $get);

$smarty->assign("selection_date", $selection_date);
$smarty->assign("selection_answers", $selection_answers);
$smarty->assign("selection_score", $selection_score);

$smarty->assign("selection_down", $selection_down);
$smarty->assign("selection_up", $selection_up);


$smarty->assign("selection_last", $selection_last);
$smarty->assign("selection_hot", $selection_hot);
$smarty->assign("selection_subscription", $selection_subscription);
$smarty->assign("selection_tag", $selection_tag);


$smarty->assign("type",$type2);
$smarty->assign("order",$order);

$smarty->display('lists/questions.tpl');
?>