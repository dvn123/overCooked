<ul class="nav navbar-nav navbar-right pull-right">
    <li class="dropdown">
        <a class="dropdown-toggle" href="#" data-toggle="dropdown">Login <strong class="caret"></strong></a>
        <div class="dropdown-menu" style="width:300%;padding: 15px; padding-bottom: 15px;">
            <form action="../../actions/users/login.php" method="post" accept-charset="UTF-8">
                <input class="form-control" placeholder="Nome de utilizador" id="user_username" style="margin-bottom: 15px;" type="text" name="username" size="30" />
                <input class="form-control" placeholder="Password" id="user_password" style="margin-bottom: 15px;" type="password" name="password" size="30" />
                <input id="user_remember_me" style="float: left; margin-right: 10px;" type="checkbox" name="user[remember_me]" value="1" />
                <label class="string optional" for="user_remember_me"> Lembrar-me</label>

                <input class="btn btn-primary" style="clear: left; width: 100%; height: 32px; font-size: 13px;" type="submit" name="commit" value="Sign In" />
            </form>
        </div>
    </li>
    <li><a href="{$BASE_URL}pages/users/register.php">Registar</a></li>
</ul>

