<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/tags.php');

$type2 = "name";
$order = "asc";

if($_GET['type'] && $_GET['order']) {
    $type2 = $_GET['type'];
    $order = $_GET['order'];
}
    $selection_name = '';
    $selection_freq = '';

    switch ($type2) {
        case "name":
            $type = "name";
            $selection_name = 'active';
            break;
        case "freq":
            $type = "freq";
            $selection_freq = 'active';
            break;
        default:
            $type = "name";
            $selection_date = 'active';
            $type2 ="name";
            break;
    }

    if(!($order === 'asc' || $order === "desc"))
    {
        $order = "desc";
    }

    $tags = getTagsByParam($type, $order);
    $s = sizeof($tags);
    $tags['len'] = $s-1;

    $selection_down = '';
    $selection_up = '';

    if($order === "desc")
        $selection_down = 'active';
    else
        $selection_up = 'active';

$smarty->assign("tags", $tags);

$smarty->assign("selection_name", $selection_name);
$smarty->assign("selection_freq", $selection_freq);

$smarty->assign("selection_down", $selection_down);
$smarty->assign("selection_up", $selection_up);

$smarty->assign("type",$type2);
$smarty->assign("order",$order);
if(isset($_GET['search']))
{
	$sea = $_GET['search'];
	$smarty->assign("search",$sea);
}

$smarty->display('lists/tags.tpl');
?>