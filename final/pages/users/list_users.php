<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');

$users = getUsersByName();

$smarty->assign('users', $users);
$smarty->display('users/list_users.tpl');

?>