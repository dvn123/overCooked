<ul class="nav navbar-nav navbar-right pull-right">
    <li> <span><a href="{$BASE_URL}pages/users/profile.php?username={$USERNAME}">
                <!--<img src="../../images/default.png" style="width:50px;height:50px;margin-top:0px;"> </img> -->
                {if $profile_data.imagelink == null}
                    <img src="{$BASE_URL}images/default.png" style="width:50px;height:50px;margin-top:0px;">
                {else}
                    <img src="{$BASE_URL}images/users/{$profile_data.imagelink}" style="width:50px;height:50px;margin-top:0px;">
                {/if}
                <span class="text-pink"><b>{$USERNAME}</b></span></a></span></li>
    <li> </li>
    <li> <a href="{$BASE_URL}actions/users/logout.php">Logout</a> </li>
</ul>