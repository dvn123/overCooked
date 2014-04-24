{include file='common/header.tpl'}

<div class="container">
    <div  class="pull-right">
        <form class="navbar-form navbar-right" role="search">
            <button type="submit" class="btn btn-default">
                <span class="glyphicon glyphicon-search"></span>
                Pesquisa
                <div class="form-group">
                    <input type="text" class="form-control">
                </div>
            </button>
        </form>
    </div>
</div>

<div class="container ">
    <div id="carousel-example-generic" class="carousel slide container" data-ride="carousel" style="padding:0;">

        <ol class="carousel-indicators">
            <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
            <li data-target="#carousel-example-generic" data-slide-to="1"></li>
            <li data-target="#carousel-example-generic" data-slide-to="2"></li>
        </ol>

        <div class="carousel-inner text-center">
            <div class="item active">
                <img src="{$BASE_URL}images/1.png" alt="1" class="img-responsive" style="width:100%">

                <div class="carousel-caption">

                </div>
            </div>


            <div class="item">
                <img src="{$BASE_URL}images/2.png" alt="2" class="img-responsive" style="width:100%">

                <div class="carousel-caption">
                </div>
            </div>

            <div class="item">
                <img src="{$BASE_URL}images/3.png" alt="3" class="img-responsive" style="width:100%">

                <div class="carousel-caption">
                </div>
            </div>

        </div>

        <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
        </a>
        <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
        </a>
    </div>

</div>

<!-- style="width: 900px; margin: 0 auto;"-->
<div class="container">
    <h2 class="voffset4" style="margin-bottom: -35px;">Perguntas</h2>
    <ul class="nav nav-tabs ">
        <li class="active"><a href="#last" data-toggle="tab"><b>Últimas</b></a></li>
        <li><a href="#hot" data-toggle="tab"><b>Quentes</b></a></li>
    </ul>

    <!-- Tab panes -->
    <div class="tab-content">
        <div class="tab-pane active" id="last">
            <table class="table table-hover table-responsive ">
                {foreach $questions as $question}
                    <tr>
                        <td class="col-md-1 text-center">
                            <div class="row text-danger">{$question.score}</div>
                            <div class="row text-danger">votos</div>
                        </td>
                        <td class="col-md-2 text-center text-muted">
                            <div class="row">{$question.numanswers}</div>
                            <div class="row">respostas</div>
                        </td>
                        <td>
                            <div class="row"><b>{$question.title}</b></div>
                            <div class="row">
                                {foreach $question.tags as $tag}
                                    <a href="#" style="text-decoration: none"><span class="tag label label-pink">{$tag.name}</span></a>
                                {/foreach}
                            </div>
                        </td>
                    </tr>
                {/foreach}
            </table>

            <div class="text-center">
                <a href="#" class="btn btn-info" alt="">Ver mais</a>
            </div>
        </div>
        <div class="tab-pane" id="hot">
            <table class="table table-hover table-responsive ">
                {foreach $questions_hot as $question_hot}
                    <tr>
                        <td class="col-md-1 text-center">
                            <div class="row text-danger">{$question_hot.score}</div>
                            <div class="row text-danger">votos</div>
                        </td>
                        <td class="col-md-2 text-center text-muted">
                            <div class="row">{$question_hot.numanswers}</div>
                            <div class="row">respostas</div>
                        </td>
                        <td>
                            <div class="row"><b>{$question_hot.title}</b></div>
                            <div class="row">
                                {foreach $question_hot.tags as $tag}
                                    <a href="#" style="text-decoration: none"><span class="tag label label-pink">{$tag.name}</span></a>
                                {/foreach}
                            </div>
                        </td>
                    </tr>
                {/foreach}
            </table>

            <div class="text-center">
                <a href="#" class="btn btn-info" alt="">Ver mais</a>
            </div>
        </div>
    </div>
</div>

<!-- registo -->
<div class="modal fade" id="registrationModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Registar</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="reg-form" action="../../actions/users/register.php" method="post" accept-charset="UTF-8" role="form">
                    <div class="form-group">
                        <label for="inputName" class="col-sm-2 control-label">Nome</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="inputName" name="username" placeholder="Nome de Utilizador">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputRealName" class="col-sm-2 control-label">Nome Real</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="inputRealName" name="realname" placeholder="Nome Completo">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail" class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" class="form-control" id="inputEmail" name="email" placeholder="Email">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword" class="col-sm-2 control-label">Password</label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="inputPassword" name="password" placeholder="Password">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputCountry" class="col-sm-2 control-label">País</label>
                        <div class="col-sm-10">
                            <select id="inputCountry" name="idCountry" class="form-control">
                                <option value="1">Afghanistan</option>
                                <option value="2">Albania</option>
                                <option value="3">Algeria</option>
                                <option value="4 Samoa">American Samoa</option>
                                <option value="5">Andorra</option>
                                <option value="6">Angola</option>
                                <option value="7">Anguilla</option>
                                <option value="8">Antigua &amp; Barbuda</option>
                                <option value="9">Argentina</option>
                                <option value="10">Armenia</option>
                                <option value="11">Aruba</option>
                                <option value="12">Australia</option>
                                <option value="13">Austria</option>
                                <option value="14">Azerbaijan</option>
                                <option value="15">Bahamas</option>
                                <option value="16">Bahrain</option>
                                <option value="17">Bangladesh</option>
                                <option value="18">Barbados</option>
                                <option value="19">Belarus</option>
                                <option value="20">Belgium</option>
                                <option value="21">Belize</option>
                                <option value="22">Benin</option>
                                <option value="23">Bermuda</option>
                                <option value="24">Bhutan</option>
                                <option value="25">Bolivia</option>
                                <option value="26">Bonaire</option>
                                <option value="27">Bosnia &amp; Herzegovina</option>
                                <option value="28">Botswana</option>
                                <option value="29">Brazil</option>
                                <option value="30 Indian Ocean Ter">British Indian Ocean Ter</option>
                                <option value="31">Brunei</option>
                                <option value="32">Bulgaria</option>
                                <option value="33">Burkina Faso</option>
                                <option value="34">Burundi</option>
                                <option value="35">Cambodia</option>
                                <option value="36">Cameroon</option>
                                <option value="37">Canada</option>
                                <option value="38">Canary Islands</option>
                                <option value="39">Cape Verde</option>
                                <option value="40">Cayman Islands</option>
                                <option value="41">Central African Republic</option>
                                <option value="42">Chad</option>
                                <option value="43">Channel Islands</option>
                                <option value="44">Chile</option>
                                <option value="45">China</option>
                                <option value="46">Christmas Island</option>
                                <option value="47">Cocos Island</option>
                                <option value="48">Colombia</option>
                                <option value="49">Comoros</option>
                                <option value="50">Congo</option>
                                <option value="51">Cook Islands</option>
                                <option value="52">Costa Rica</option>
                                <option value="53">Cote D'Ivoire</option>
                                <option value="54">Croatia</option>
                                <option value="55">Cuba</option>
                                <option value="56">Curacao</option>
                                <option value="57">Cyprus</option>
                                <option value="58">Czech Republic</option>
                                <option value="59">Denmark</option>
                                <option value="60">Djibouti</option>
                                <option value="61">Dominica</option>
                                <option value="62">Dominican Republic</option>
                                <option value="63">East Timor</option>
                                <option value="64">Ecuador</option>
                                <option value="65">Egypt</option>
                                <option value="66">El Salvador</option>
                                <option value="67">Equatorial Guinea</option>
                                <option value="68">Eritrea</option>
                                <option value="69">Estonia</option>
                                <option value="70">Ethiopia</option>
                                <option value="71">Falkland Islands</option>
                                <option value="72">Faroe Islands</option>
                                <option value="73">Fiji</option>
                                <option value="74">Finland</option>
                                <option value="75">France</option>
                                <option value="76">French Guiana</option>
                                <option value="77">French Polynesia</option>
                                <option value="78">French Southern Ter</option>
                                <option value="79">Gabon</option>
                                <option value="80">Gambia</option>
                                <option value="81">Georgia</option>
                                <option value="82">Germany</option>
                                <option value="83">Ghana</option>
                                <option value="84">Gibraltar</option>
                                <option value="85">Great Britain</option>
                                <option value="86">Greece</option>
                                <option value="87">Greenland</option>
                                <option value="88">Grenada</option>
                                <option value="89">Guadeloupe</option>
                                <option value="90">Guam</option>
                                <option value="91">Guatemala</option>
                                <option value="92">Guinea</option>
                                <option value="93">Guyana</option>
                                <option value="94">Haiti</option>
                                <option value="95">Hawaii</option>
                                <option value="96">Honduras</option>
                                <option value="97">Hong Kong</option>
                                <option value="98">Hungary</option>
                                <option value="99">Iceland</option>
                                <option value="100">India</option>
                                <option value="101">Indonesia</option>
                                <option value="102">Iran</option>
                                <option value="103">Iraq</option>
                                <option value="104">Ireland</option>
                                <option value="105">Isle of Man</option>
                                <option value="106">Israel</option>
                                <option value="107">Italy</option>
                                <option value="108">Jamaica</option>
                                <option value="109">Japan</option>
                                <option value="110">Jordan</option>
                                <option value="111">Kazakhstan</option>
                                <option value="112">Kenya</option>
                                <option value="113">Kiribati</option>
                                <option value="114">Korea North</option>
                                <option value="115">Korea South</option>
                                <option value="116">Kuwait</option>
                                <option value="117">Kyrgyzstan</option>
                                <option value="118">Laos</option>
                                <option value="119">Latvia</option>
                                <option value="120">Lebanon</option>
                                <option value="121">Lesotho</option>
                                <option value="122">Liberia</option>
                                <option value="123">Libya</option>
                                <option value="124">Liechtenstein</option>
                                <option value="125">Lithuania</option>
                                <option value="126">Luxembourg</option>
                                <option value="127">Macau</option>
                                <option value="128">Macedonia</option>
                                <option value="129">Madagascar</option>
                                <option value="130">Malaysia</option>
                                <option value="131">Malawi</option>
                                <option value="132">Maldives</option>
                                <option value="133">Mali</option>
                                <option value="134">Malta</option>
                                <option value="135">Marshall Islands</option>
                                <option value="136">Martinique</option>
                                <option value="137">Mauritania</option>
                                <option value="138">Mauritius</option>
                                <option value="139">Mayotte</option>
                                <option value="140">Mexico</option>
                                <option value="141">Midway Islands</option>
                                <option value="142">Moldova</option>
                                <option value="143">Monaco</option>
                                <option value="144">Mongolia</option>
                                <option value="145">Montserrat</option>
                                <option value="146">Morocco</option>
                                <option value="147">Mozambique</option>
                                <option value="148">Myanmar</option>
                                <option value="149">Nambia</option>
                                <option value="150">Nauru</option>
                                <option value="151">Nepal</option>
                                <option value="152">Netherland Antilles</option>
                                <option value="153">Netherlands (Holland, Europe)</option>
                                <option value="154">Nevis</option>
                                <option value="155">New Caledonia</option>
                                <option value="156">New Zealand</option>
                                <option value="157">Nicaragua</option>
                                <option value="158">Niger</option>
                                <option value="159">Nigeria</option>
                                <option value="160">Niue</option>
                                <option value="161">Norfolk Island</option>
                                <option value="162">Norway</option>
                                <option value="163">Oman</option>
                                <option value="164">Pakistan</option>
                                <option value="165">Palau Island</option>
                                <option value="166">Palestine</option>
                                <option value="167">Panama</option>
                                <option value="168">Papua New Guinea</option>
                                <option value="169">Paraguay</option>
                                <option value="170">Peru</option>
                                <option value="171">Philippines</option>
                                <option value="172">Pitcairn Island</option>
                                <option value="173">Poland</option>
                                <option selected="selected" value="174">Portugal</option>
                                <option value="175">Puerto Rico</option>
                                <option value="176">Qatar</option>
                                <option value="177">Republic of Montenegro</option>
                                <option value="178">Republic of Serbia</option>
                                <option value="179">Reunion</option>
                                <option value="180">Romania</option>
                                <option value="181">Russia</option>
                                <option value="182">Rwanda</option>
                                <option value="183">St Barthelemy</option>
                                <option value="184">St Eustatius</option>
                                <option value="185">St Helena</option>
                                <option value="186">St Kitts-Nevis</option>
                                <option value="187">St Lucia</option>
                                <option value="188">St Maarten</option>
                                <option value="189">St Pierre &amp; Miquelon</option>
                                <option value="190">St Vincent &amp; Grenadines</option>
                                <option value="191">Saipan</option>
                                <option value="192">Samoa</option>
                                <option value="193">Samoa American</option>
                                <option value="194">San Marino</option>
                                <option value="195">Sao Tome &amp; Principe</option>
                                <option value="196">Saudi Arabia</option>
                                <option value="197">Senegal</option>
                                <option value="198">Serbia</option>
                                <option value="199">Seychelles</option>
                                <option value="200">Sierra Leone</option>
                                <option value="201">Singapore</option>
                                <option value="202">Slovakia</option>
                                <option value="203">Slovenia</option>
                                <option value="204">Solomon Islands</option>
                                <option value="205">Somalia</option>
                                <option value="206">South Africa</option>
                                <option value="207">Spain</option>
                                <option value="208">Sri Lanka</option>
                                <option value="209">Sudan</option>
                                <option value="210">Suriname</option>
                                <option value="211">Swaziland</option>
                                <option value="212">Sweden</option>
                                <option value="213">Switzerland</option>
                                <option value="214">Syria</option>
                                <option value="215">Tahiti</option>
                                <option value="216">Taiwan</option>
                                <option value="217">Tajikistan</option>
                                <option value="218">Tanzania</option>
                                <option value="219">Thailand</option>
                                <option value="220">Togo</option>
                                <option value="221">Tokelau</option>
                                <option value="222">Tonga</option>
                                <option value="223 &amp; Tobago">Trinidad &amp; Tobago</option>
                                <option value="224">Tunisia</option>
                                <option value="225">Turkey</option>
                                <option value="226">Turkmenistan</option>
                                <option value="227">Turks &amp; Caicos Is</option>
                                <option value="228">Tuvalu</option>
                                <option value="229">Uganda</option>
                                <option value="230">Ukraine</option>
                                <option value="231 Arab Erimates">United Arab Emirates</option>
                                <option value="232">United Kingdom</option>
                                <option value="233 States of America">United States of America</option>
                                <option value="234">Uruguay</option>
                                <option value="235">Uzbekistan</option>
                                <option value="236">Vanuatu</option>
                                <option value="237">Vatican City State</option>
                                <option value="238">Venezuela</option>
                                <option value="239">Vietnam</option>
                                <option value="240">Virgin Islands (Brit)</option>
                                <option value="241">Virgin Islands (USA)</option>
                                <option value="242">Wake Island</option>
                                <option value="243">Wallis &amp; Futana Is</option>
                                <option value="244">Yemen</option>
                                <option value="245">Zaire</option>
                                <option value="246">Zambia</option>
                                <option value="247">Zimbabwe</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="submit" class="btn btn-primary">Regista-te!</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>



<script src="{$BASE_URL}javascript/main.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="{$BASE_URL}javascript/libs/bootstrap/bootstrap.js"></script>

{include file='common/footer.tpl'}