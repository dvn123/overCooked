<?php /* Smarty version Smarty-3.1.15, created on 2014-05-02 12:26:10
         compiled from "..\..\templates\users\edit_profile.tpl" */ ?>
<?php /*%%SmartyHeaderCode:2660553636401c25465-16079489%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '7c4680161ac331aefb8621665afd2dd945fed467' => 
    array (
      0 => '..\\..\\templates\\users\\edit_profile.tpl',
      1 => 1399026367,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '2660553636401c25465-16079489',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_53636401c92a84_88297327',
  'variables' => 
  array (
    'BASE_URL' => 0,
    'profile_data' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_53636401c92a84_88297327')) {function content_53636401c92a84_88297327($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('common/header.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>


<div class="container">
<div class="panel panel-green">
<div class="panel-heading">
    <h3 class="panel-title">Editar perfil</h3>
</div>
<div class="panel-body">

<form class="form-horizontal " action="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
actions/users/edit_profile.php" method="post" accept-charset="UTF-8" role="form">
<div class="form-group">
    <label for="inputName" class="col-sm-2 control-label">Nome</label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="inputName" name="username" placeholder="Nome de utilizador" value="<?php echo $_smarty_tpl->tpl_vars['profile_data']->value['username'];?>
" disabled>
    </div>
</div>
<div class="form-group">
    <label for="inputRealName" class="col-sm-2 control-label">Nome Real</label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="inputRealName" name="realname" placeholder="Nome completo" value="<?php echo $_smarty_tpl->tpl_vars['profile_data']->value['name'];?>
">
    </div>
</div>
<div class="form-group">
    <label for="inputEmail" class="col-sm-2 control-label">Email</label>
    <div class="col-sm-10">
        <input type="email" class="form-control" id="inputEmail" name="email" placeholder="Email" value="<?php echo $_smarty_tpl->tpl_vars['profile_data']->value['email'];?>
" disabled>
    </div>
</div>
<div class="form-group">
    <label for="inputBirthDate" class="col-sm-2 control-label">Data de nascimento</label>
    <div class="col-sm-10">
        <input type="date" class="form-control" id="inputBirthDate" name="birthdate" placeholder="Data de nascimento" value="<?php echo $_smarty_tpl->tpl_vars['profile_data']->value['birthdate'];?>
">
    </div>
</div>
<div class="form-group form-inline">
    <label for="inputGender" class="col-sm-2 control-label">Género</label>
    <div class="col-sm-10">
        <div class="radio">
            <label class="radio-inline">
                <input type="radio" name="optionsRadios" id="genderF" value="option1">
                Feminino
            </label>
        </div>
        <div class="radio">
            <label class="radio-inline">
                <input type="radio" name="optionsRadios" id="genderM" value="option2">
                Masculino
            </label>
        </div>
    </div>
</div>
<div class="form-group">
    <label for="inputCity" class="col-sm-2 control-label">Cidade</label>
    <div class="col-sm-10">
        <input type="text" class="form-control" id="inputCity" name="city" placeholder="Cidade" value="<?php echo $_smarty_tpl->tpl_vars['profile_data']->value['city'];?>
">
    </div>
</div>
<div class="form-group">
<label for="inputCountry" class="col-sm-2 control-label">País</label>
<div class="col-sm-10">
<select id="inputCountry" name="idCountry" class="form-control">
<option value="1">Afghanistan</option>
<option value="2">Albania</option>
<option value="3">Algeria</option>
<option value="4">American Samoa</option>
<option value="5">Andorra</option>
<option value="6">Angola</option>
<option value="7">Anguilla</option>
<option value="8">Antarctica</option>
<option value="9">Antiqua and Barbuda</option>
<option value="10">Argentina</option>
<option value="11">Armenia</option>
<option value="12">Aruba</option>
<option value="13">Australia</option>
<option value="14">Austria</option>
<option value="15">Azerbaijan</option>
<option value="16">Bahamas</option>
<option value="17">Bahrain</option>
<option value="18">Bangladesh</option>
<option value="19">Barbados</option>
<option value="20">Belarus</option>
<option value="21">	Belgium</option>
<option value="22">	Belize</option>
<option value="23">	Benin</option>
<option value="24">	Bermuda</option>
<option value="25">	Bhutan</option>
<option value="26">	Bolivia</option>
<option value="27">	Bosnia and Herzegovina</option>
<option value="28">	Botswana</option>
<option value="29">	Brazil</option>
<option value="30">	British Indian Ocean Territory</option>
<option value="31">	British Virgin Islands</option>
<option value="32">	Brunei</option>
<option value="33">	Bulgaria</option>
<option value="34">	Burkina Faso</option>
<option value="35">	Burma (Myanmar)</option>
<option value="36">	Burundi</option>
<option value="37">	Cambodia</option>
<option value="38">	Cameroon</option>
<option value="39">	Canada</option>
<option value="40">	Cape Verde</option>
<option value="41">	Cayman Islands</option>
<option value="42">	Central African Republic</option>
<option value="43">	Chad</option>
<option value="44">	Chile</option>
<option value="45">	China</option>
<option value="46">	Christmas Island</option>
<option value="47">	Cocos (Keeling) Islands</option>
<option value="48">	Colombia</option>
<option value="49">	Comoros</option>
<option value="50">	Cook Islands</option>
<option value="51">	Costa Rica</option>
<option value="52">	Croatia</option>
<option value="53">	Cuba</option>
<option value="54">	Cyprus</option>
<option value="55">	Czech Republic</option>
<option value="56">	Democratic Republic of the Congo</option>
<option value="57">	Denmark</option>
<option value="58">	Djibouti</option>
<option value="59">	Dominica</option>
<option value="60">	Dominican Republic</option>
<option value="61">	Ecuador</option>
<option value="62">	Egypt</option>
<option value="63">	El Salvador</option>
<option value="64">	Equatorial Guinea</option>
<option value="65">	Eritrea</option>
<option value="66">	Estonia</option>
<option value="67">	Ethiopia</option>
<option value="68">	Falkland Islands</option>
<option value="69">	Faroe Islands</option>
<option value="70">	Fiji</option>
<option value="71">	Finland</option>
<option value="72">	France</option>
<option value="73">	French Polynesia</option>
<option value="74">	Gabon</option>
<option value="75">	Gambia</option>
<option value="76">	Gaza Strip</option>
<option value="77">	Georgia</option>
<option value="78">	Germany</option>
<option value="79">	Ghana</option>
<option value="80">	Gibraltar</option>
<option value="81">	Greece</option>
<option value="82">	Greenland</option>
<option value="83">	Grenada</option>
<option value="84">	Guam</option>
<option value="85">	Guatemala</option>
<option value="86">	Guinea</option>
<option value="87">	Guinea-Bissau</option>
<option value="88">	Guyana</option>
<option value="89">	Haiti</option>
<option value="90">	Honduras</option>
<option value="91">	Hong Kong</option>
<option value="92">	Hungary</option>
<option value="93">	Iceland</option>
<option value="94">	India</option>
<option value="95">	Indonesia</option>
<option value="96">	Iran</option>
<option value="97">	Iraq</option>
<option value="98">Ireland</option>
<option value="99">Isle of Man</option>
<option value="100">Israel</option>
<option value="101">Italy</option>
<option value="102">Ivory Coast</option>
<option value="103">Jamaica</option>
<option value="104">Japan</option>
<option value="105">Jersey</option>
<option value="106">Jordan</option>
<option value="107">Kazakhstan</option>
<option value="108">Kenya</option>
<option value="109">Kiribati</option>
<option value="110">Kosovo</option>
<option value="111">Kuwait</option>
<option value="112">Kyrgyzstan</option>
<option value="113">Laos</option>
<option value="114">Latvia</option>
<option value="115">Lebanon</option>
<option value="116">Lesotho</option>
<option value="117">Liberia</option>
<option value="118">Libya</option>
<option value="119">Liechtenstein</option>
<option value="120">Lithuania</option>
<option value="121">Luxembourg</option>
<option value="122">Macaus</option>
<option value="123">Macedonia</option>
<option value="124">Madagascar</option>
<option value="125">Malawi</option>
<option value="126">Malaysia</option>
<option value="127">Maldives</option>
<option value="128">Mali</option>
<option value="129">Malta</option>
<option value="130">Marshall Islands</option>
<option value="131">Mauritania</option>
<option value="132">Mauritius</option>
<option value="133">Mayotte</option>
<option value="134">Mexico</option>
<option value="135">Micronesia</option>
<option value="136">Moldova</option>
<option value="137">Monaco</option>
<option value="138">Mongolia</option>
<option value="139">Montenegro</option>
<option value="140">Montserrat</option>
<option value="141">Morocco</option>
<option value="142">Mozambique</option>
<option value="143">Namibia</option>
<option value="144">Nauru</option>
<option value="145">Nepal</option>
<option value="146">Netherlands</option>
<option value="147">Netherlands Antilles</option>
<option value="148">New Caledonia</option>
<option value="149">New Zealand</option>
<option value="150">Nicaragua</option>
<option value="151">Niger</option>
<option value="152">Nigeria</option>
<option value="153">Niue</option>
<option value="154">Norfolk Island</option>
<option value="155">North Korea</option>
<option value="156">Northern Mariana Islands</option>
<option value="157">Norway</option>
<option value="158">Oman</option>
<option value="159">Pakistan</option>
<option value="160">Palau</option>
<option value="161">Panama</option>
<option value="162">Papua New Guinea</option>
<option value="163">Paraguay</option>
<option value="164">Peru</option>
<option value="165">Philippines</option>
<option value="166">Pitcairn Islands</option>
<option value="167">Poland</option>
<option value="168" selected>Portugal</option>
<option value="169">Puerto Rico</option>
<option value="170">Qatar</option>
<option value="171">Republic of the Congo</option>
<option value="172">Romania</option>
<option value="173">Russia</option>
<option value="174">Rwanda</option>
<option value="175">Saint Barthelemy</option>
<option value="176">Saint Helena</option>
<option value="177">Saint Kitts and Nevis</option>
<option value="178">Saint Lucia</option>
<option value="179">Saint Martin</option>
<option value="180">Saint Pierre and Miquelon</option>
<option value="181">Saint Vincent and the Grenadines</option>
<option value="182">Samoa</option>
<option value="183">San Marino</option>
<option value="184">Sao Tome and Principe</option>
<option value="185">Saudi Arabia</option>
<option value="186">Senegal</option>
<option value="187">Serbia</option>
<option value="188">Seychelles</option>
<option value="189">Sierra Leone</option>
<option value="190">Singapore</option>
<option value="191">Slovakia</option>
<option value="192">Slovenia</option>
<option value="193">Solomon Islands</option>
<option value="194">Somalia</option>
<option value="195">South Africa</option>
<option value="196">South Korea</option>
<option value="197">Spain</option>
<option value="198">Sri Lanka</option>
<option value="199">Sudan</option>
<option value="200">Suriname</option>
<option value="201">Svalbard</option>
<option value="202">Swaziland</option>
<option value="203">Sweden</option>
<option value="204">Switzerland</option>
<option value="205">Syria</option>
<option value="206">Taiwan</option>
<option value="207">Tajikistan</option>
<option value="208">Tanzania</option>
<option value="209">Thailand</option>
<option value="210">Timor-Leste</option>
<option value="211">Togo</option>
<option value="212">Tokelau</option>
<option value="213">Tonga</option>
<option value="214">Trinidad and Tobago</option>
<option value="215">Tunisia</option>
<option value="216">Turkey</option>
<option value="217">Turkmenistan</option>
<option value="218">Turks and Caicos Islands</option>
<option value="219">Tuvalu</option>
<option value="220">Uganda</option>
<option value="221">Ukraine</option>
<option value="222">United Arab Emirates</option>
<option value="223">United Kingdom</option>
<option value="224">United States</option>
<option value="225">Uruguay</option>
<option value="226">US Virgin Islands</option>
<option value="227">Uzbekistan</option>
<option value="228">Vanuatu</option>
<option value="229">Vatican City</option>
<option value="230">Venezuela</option>
<option value="231">Vietnam</option>
<option value="232">Wallis and Futuna</option>
<option value="233">West Bank</option>
<option value="234">Western Sahara</option>
<option value="235">Yemen</option>
<option value="236">Zambia</option>
<option value="237">Zimbabwe</option>
</select>
</div>
</div>
<div class="form-group">
    <label for="inputAbout" class="col-sm-2 control-label">Sobre mim</label>
    <div class="col-sm-10">
        <textarea type="text" class="form-control" id="inputAbout" name="about" placeholder="Sobre mim" value="<?php echo $_smarty_tpl->tpl_vars['profile_data']->value['about'];?>
">
            </textarea>
    </div>
</div>
<div class="form-group">
    <label for="inputPic" class="col-sm-2 control-label">Foto perfil</label>
    <div class="col-sm-10">
        <input type="file" class="form-control" id="inputEmail" name="email" placeholder="Email" value="<?php echo $_smarty_tpl->tpl_vars['profile_data']->value['email'];?>
">
    </div>
</div>
<div class="form-group">
    <div class="col-sm-10">
        <div class="fileupload fileupload-new" data-provides="fileupload">
    <span class="btn btn-primary btn-file"><span class="fileupload-new">Select file</span>
    <span class="fileupload-exists">Change</span>         <input type="file" /></span>
            <span class="fileupload-preview"></span>
            <a href="#" class="close fileupload-exists" data-dismiss="fileupload" style="float: none">×</a>
        </div>
    </div>
    </div>

<div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
        <button type="submit" class="btn btn-primary">Guardar alterações</button>
    </div>
</div>
</form>
</div>
</div>
</div>

<script src="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
javascript/main.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
javascript/libs/bootstrap/bootstrap.js"></script>

<?php echo $_smarty_tpl->getSubTemplate ('common/footer.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>
<?php }} ?>
