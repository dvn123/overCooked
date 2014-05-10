<?php
include_once('../../config/init.php');
include_once($BASE_DIR .'database/admin.php');
//TODO CHECK ADMIN
/*if(!isset($_SESSION['username'])) {
    $_SESSION['error_messages'][] = 'Não tem permissões para criar uma pergunta';
    echo '401';
    exit;
}*/

if (!isset($_GET['num'])) {
    $_SESSION['error_messages'][] = 'Campos Invalidos!';
    $_SESSION['form_values'] = $_GET;
    echo '400';
    exit;
} else {
    if($_GET['num'] == "") {
        $_SESSION['error_messages'][] = 'Campos Invalidos!';
        $_SESSION['form_values'] = $_GET;
        echo '400';
        exit;
    }
}

if (($age = getAgeDistribution()) && ($countriesActivity = getMostActiveCountries($_GET['num'])) && ($countryUsers = getCountriesWithMostUsers($_GET['num']))) {
    //$_SESSION['success_messages'][] = 'Criação de Pergunta bem sucedida!';
    $array = array($age, $countriesActivity, $countryUsers);
    echo json_encode($array);
    exit;
} else {
    $_SESSION['error_messages'][] = 'A criação de pergunta falhou!';
    echo '400';
    exit;
}
?>
