{include file='common/header.tpl'}

<div class="container">
    <div  class="pull-right">
        <form class="navbar-form navbar-right" role="search" action="{$BASE_URL}pages/questions/search.php" method="get" accept-charset="UTF-8">
            <div class="right-inner-addon">
                <i class="glyphicon glyphicon-search"></i>
                <input name="content" type="search"
                       class="form-control"
                       placeholder="Pesquisar" />
            </div>
        </form>
    </div>
</div>

<div class="container">
    <div class="panel panel-green">
        <div class="panel-body">
            {foreach $users as $user}
                <div  class="col-md-3">
                    <div class="panel panel-green">
                        <div class="panel-body">
                            {if $user.imagelink == null}
                                <img src="{$BASE_URL}images/default.png" style="width:50px;height:50px;margin-top:0px;">
                            {else}
                                <img src="{$BASE_URL}images/users/{$user.imagelink}" style="width:50px;height:50px;margin-top:0px;">
                            {/if}
                            <b><span><a href="{$BASE_URL}pages/users/profile.php?username={$user.username}">{$user.username}</a></span></b><br>
                            {$user.country}<br>
                            {$user.score}<br>
                        </div>
                    </div>
                </div>
            {/foreach}
        </div>
    </div>
</div>

{include file='common/footer.tpl'}