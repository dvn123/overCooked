<?php /* Smarty version Smarty-3.1.15, created on 2014-05-03 17:10:21
         compiled from "..\..\templates\users\private_profile.tpl" */ ?>
<?php /*%%SmartyHeaderCode:28994535932459dba63-08816998%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'dbd1d38e774754efe07fcc5db626da22321afe33' => 
    array (
      0 => '..\\..\\templates\\users\\private_profile.tpl',
      1 => 1399129598,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '28994535932459dba63-08816998',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_53593245af1026_29217098',
  'variables' => 
  array (
    'profile_data' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_53593245af1026_29217098')) {function content_53593245af1026_29217098($_smarty_tpl) {?><div class="col-lg-4">
    <div id="private"><!--class="voffset4"-->
        <p><b>Nome: </b><?php echo $_smarty_tpl->tpl_vars['profile_data']->value['name'];?>
</p>
        <p><b>Data de nascimento: </b> <?php echo $_smarty_tpl->tpl_vars['profile_data']->value['birthdate'];?>
</p>
        <p><b>Cidade: </b> <?php echo $_smarty_tpl->tpl_vars['profile_data']->value['city'];?>
</p>
        <p><b>Email: </b> <?php echo $_smarty_tpl->tpl_vars['profile_data']->value['email'];?>
</p>
    </div>
    <br>
</div><?php }} ?>
