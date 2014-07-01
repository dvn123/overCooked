<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');
include_once($BASE_DIR .'database/list_users.php');

if ($_GET['content']) {
    $content = trim($_GET['content']);
} 

$type2 = "name";
$order = "asc";

if($_GET['type'] && $_GET['order']) {

    $order = $_GET['order'];
    $selection_down = '';
    $selection_up = '';

    $type2 = $_GET['type'];
    $selection_date = '';
    $selection_answers = '';
    $selection_score = '';

    switch ($type2) {
        case "name":
        if($order === 'asc' || $order === "desc")
            $users = getUsers("username", $order);
        else
            $users = getUsers("username", "ASC");

        if($order === "desc")
            $selection_down = 'active';
        else
            $selection_up = 'active';

        $selection_name = 'active';
        break;
        case "score":

        if($order === 'asc' || $order === "desc")
            $users = getUsers("score", $order);
        else
            $users = getUsers("score", "DESC");

        if($order === "asc")
            $selection_up = 'active';
        else
            $selection_down = 'active';

        $selection_score = 'active';
        break;
        case "moderator":

        if($order === 'asc' || $order === "desc")
            $users = getUsersModerator($order);
        else
            $users = getUsersModerator("ASC");

        if($order === "desc")
            $selection_down = 'active';
        else
            $selection_up = 'active';

        $selection_mod = 'active';
        break;
        default:
        $users = getUsers("username", "ASC");
        $selection_name = 'active';
        $selection_score = '';
        $selection_moderator = '';
        $selection_down = '';
        $selection_up = 'active';
        $type2 = "name";
        $order = "asc";
        break;
    }
}
else {
    $users = getUsers("username", "ASC");
    $selection_name = 'active';
    $selection_score = '';
    $selection_moderator = '';
    $selection_up = 'active';
    $selection_down = '';
    $type2 = "name";
    $order = "asc";
}


$smarty->assign("selection_name", $selection_name);
$smarty->assign("selection_score", $selection_score);
$smarty->assign("selection_mod", $selection_mod);
$smarty->assign("selection_down", $selection_down);
$smarty->assign("selection_up", $selection_up);
$smarty->assign("content",$content);

$smarty->assign("order",$order);
$smarty->assign("type",$type2);
$smarty->assign('users', $users);


$smarty->display('users/list_users.tpl');
?>