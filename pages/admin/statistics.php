<?php
include_once('../../config/init.php');

if( $_SESSION['usergroup'] != 'admin') {
    $_SESSION['error_messages'][] = 'Ação não permitida';
    header("Location: $BASE_URL");
    exit;
}

$smarty->display('admin/statistics.tpl');
?>