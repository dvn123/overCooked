<?php /* Smarty version Smarty-3.1.15, created on 2014-04-30 20:54:41
         compiled from "..\..\templates\common\header.tpl" */ ?>
<?php /*%%SmartyHeaderCode:107845356e138de89f5-76210391%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'c2c2f3a879caf127c3402ab1828ef07f2cfb6c82' => 
    array (
      0 => '..\\..\\templates\\common\\header.tpl',
      1 => 1398884067,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '107845356e138de89f5-76210391',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_5356e138e4a489_12428528',
  'variables' => 
  array (
    'BASE_URL' => 0,
    'USERNAME' => 0,
    'ERROR_MESSAGES' => 0,
    'error' => 0,
    'SUCCESS_MESSAGES' => 0,
    'success' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5356e138e4a489_12428528')) {function content_5356e138e4a489_12428528($_smarty_tpl) {?><!DOCTYPE html>
<html>
<head>
    <title>OverCooked</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
css/bootstrap-3.1.1/css/bootstrap.css" rel="stylesheet">
    <link href="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
css/styles.css" rel="stylesheet">
    <link href = "<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
css/custom.css" rel = "stylesheet">
    <link rel="shortcut icon" href="../../images/logo.ico">
</head>
<body>


<div class="navbar navbar-default navbar-static-top">
    <div class="container">

        <a href="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
" class="navbar-brand"><img src="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
images/food-logo1.png"></a>


        <button class="navbar-toggle" data-toggle="collapse" data-target=".navHeaderCollapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>

        <div class="collapse navbar-collapse navHeaderCollapse">

            <ul class="nav navbar-nav navbar-right pull-left">

                <li class = "active"> <a href = "#"><span style="color:#7d094a;">over</span><span style="color:#a1a616;">Cooked</span></a></li>
                <li ><a href = "#">Fazer Pergunta</a></li>
                <li><a href = "#">Perguntas</a></li>
                <li><a href = "#">Tags</a></li>

            </ul>

            <?php if ($_smarty_tpl->tpl_vars['USERNAME']->value) {?>
                <?php echo $_smarty_tpl->getSubTemplate ('common/menu_logged_in.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

            <?php } else { ?>
                <?php echo $_smarty_tpl->getSubTemplate ('common/menu_logged_out.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

            <?php }?>

        </div>

    </div>
</div>

<div id="error_messages">
    <?php  $_smarty_tpl->tpl_vars['error'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['error']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['ERROR_MESSAGES']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['error']->key => $_smarty_tpl->tpl_vars['error']->value) {
$_smarty_tpl->tpl_vars['error']->_loop = true;
?>
        <div class="container">
            <div class="alert alert-danger fade in">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                <?php echo $_smarty_tpl->tpl_vars['error']->value;?>

            </div>
        </div>
    <?php } ?>
</div>
<div id="success_messages">
    <?php  $_smarty_tpl->tpl_vars['success'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['success']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['SUCCESS_MESSAGES']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['success']->key => $_smarty_tpl->tpl_vars['success']->value) {
$_smarty_tpl->tpl_vars['success']->_loop = true;
?>
        <div class="container">
            <div class="alert alert-success fade in">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                <?php echo $_smarty_tpl->tpl_vars['success']->value;?>

            </div>
        </div>
    <?php } ?>
</div>
<?php }} ?>
