<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/users.php');
if($_SESSION['username'] !== null) {
    header("Location: $BASE_URL");
    exit;
}
else
    $smarty->display('users/register.tpl');
?>
