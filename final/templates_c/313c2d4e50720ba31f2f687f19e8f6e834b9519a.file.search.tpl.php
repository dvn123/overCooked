<?php /* Smarty version Smarty-3.1.15, created on 2014-05-03 16:35:16
         compiled from "..\..\templates\questions\search.tpl" */ ?>
<?php /*%%SmartyHeaderCode:221785362c7256880e3-79041629%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '313c2d4e50720ba31f2f687f19e8f6e834b9519a' => 
    array (
      0 => '..\\..\\templates\\questions\\search.tpl',
      1 => 1399017544,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '221785362c7256880e3-79041629',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_5362c725743917_84049929',
  'variables' => 
  array (
    'BASE_URL' => 0,
    'questions' => 0,
    'question' => 0,
    'tag' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_5362c725743917_84049929')) {function content_5362c725743917_84049929($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('common/header.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>


<div class="container">
    <div  class="pull-right">
        <form class="navbar-form navbar-right" role="search" action="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
pages/questions/search.php" method="get" accept-charset="UTF-8">
            <div class="right-inner-addon">
                <i class="glyphicon glyphicon-search"></i>
                <input name="content" type="search"
                       class="form-control"
                       placeholder="Pesquisar" />
            </div>

            <!-- <button type="submit" class="btn btn-default">
                <span class="glyphicon glyphicon-search"></span>
                Pesquisa
                <div class="form-group">
                    <input name="content" type="text" class="form-control">
                </div>
            </button> -->
        </form>
    </div>
</div>

<div class="container">
    <h3 class="col-md-3">Resultados</h3>
</div>
<div class="container voffset4">
    <div  class="col-md-3">
        <ul class="nav nav-pills nav-stacked">
            <li class="active" style="display:inline;"><a href="#">Últimas</a></li>
            <li style="display:inline;"><a href="#">Quentes</a></li>
            <li class = "dropdown" style="display:inline;">
                <a href = "#" class = "dropdown-toggle" data-toggle = "dropdown">Por tag<b class="caret"></b></a>
                <ul class = "dropdown-menu">
                    <li><a href = "#">vegetariano</a></li>
                    <li><a href = "#">arroz</a></li>
                    <li><a href = "#">cozinhaRapida</a></li>
                    <li><a href = "#">bimby</a></li>
                </ul>
            </li>
        </ul>
    </div>

    <div  class="col-md-9">
        <table class="table table-hover table-responsive ">
            <?php  $_smarty_tpl->tpl_vars['question'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['question']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['questions']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['question']->key => $_smarty_tpl->tpl_vars['question']->value) {
$_smarty_tpl->tpl_vars['question']->_loop = true;
?>
                <tr>
                    <td class="col-md-1 text-center">
                        <div class="row text-danger"><?php echo $_smarty_tpl->tpl_vars['question']->value['score'];?>
</div>
                        <div class="row text-danger">votos</div>
                    </td>
                    <td class="col-md-2 text-center text-muted">
                        <div class="row"><?php echo $_smarty_tpl->tpl_vars['question']->value['numanswers1'];?>
</div>
                        <div class="row">respostas</div>
                    </td>
                    <td>
                        <div class="row"><b><?php echo $_smarty_tpl->tpl_vars['question']->value['title'];?>
</b></div>
                        <div class="row">
                            <?php  $_smarty_tpl->tpl_vars['tag'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['tag']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['question']->value['tags']; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['tag']->key => $_smarty_tpl->tpl_vars['tag']->value) {
$_smarty_tpl->tpl_vars['tag']->_loop = true;
?>
                                <a href="#" style="text-decoration: none"><span class="tag label label-pink"><?php echo $_smarty_tpl->tpl_vars['tag']->value['name'];?>
</span></a>
                            <?php } ?>
                        </div>
                    </td>
                </tr>
            <?php } ?>
        </table>

    </div>
</div>



<script src="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
javascript/main.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
javascript/libs/bootstrap/bootstrap.js"></script>

<?php echo $_smarty_tpl->getSubTemplate ('common/footer.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>
<?php }} ?>
