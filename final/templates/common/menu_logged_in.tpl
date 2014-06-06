<ul class="nav navbar-nav navbar-right pull-right">
    <li id="profile"> <span><a href="{$BASE_URL}pages/users/profile.php?username={$USERNAME}">
                {if {$PROFILE_PIC} == null}
                    <img src="{$BASE_URL}images/users/default.png" style="width:50px;height:50px;margin-top:0px;">
                {else}
                    <img src="{$BASE_URL}images/users/{$PROFILE_PIC}" style="width:50px;height:50px;margin-top:0px;">
                {/if}
                <span class="text-pink"><b>{$USERNAME}</b></span></a></span></li>

    <li> <a href="{$BASE_URL}actions/users/logout.php">Logout</a> </li>
</ul>