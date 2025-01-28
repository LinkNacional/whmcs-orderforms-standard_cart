<script>
    // Define state tab index value
    var statesTab = 10;
    // Do not enforce state input client side
    var stateNotRequired = true;
</script>
{include file="orderforms/standard_cart/common.tpl"}
<script
    type="text/javascript"
    src="{$BASE_PATH_JS}/StatesDropdown.js"
></script>
<script
    type="text/javascript"
    src="{$BASE_PATH_JS}/PasswordStrength.js"
></script>
<script>
    window.langPasswordStrength = "{$LANG.pwstrength}";
    window.langPasswordWeak = "{$LANG.pwstrengthweak}";
    window.langPasswordModerate = "{$LANG.pwstrengthmoderate}";
    window.langPasswordStrong = "{$LANG.pwstrengthstrong}";
    const systemURL = "{$systemURL}";
</script>

<script
    type="text/javascript"
    src="{assetPath file='increment.js'}"
></script>
<script
    type="text/javascript"
    src="{assetPath file='limitDate.js'}"
></script>
<script
    type="text/javascript"
    src="{assetPath file='findCep.js'}"
></script>
<script
    type="text/javascript"
    src="{assetPath file='mask.js'}"
></script>
{if $isWhatsappField}
    <script
        type="text/javascript"
        src="{assetPath file='validationsInApi.js'}"
    ></script>

{/if}

<style>
    .card {
        padding: 20px;
        border: 1px solid rgba(0, 0, 0, .125) !important;
        border-radius: .25rem !important;
        margin-bottom: 40px;
    }

    /* Estilizando o input */
    input {
        color: rgb(37, 0, 0) !important;
        /* Cor do texto digitado */
        font-weight: 600 !important;
        font-size: 16px;
        /* Tamanho do texto digitado */
        padding: 10px;
    }

    select option {
        color: rgb(37, 0, 0) !important;
        /* Cor do texto digitado */
        font-weight: 600 !important;
    }

    select {
        color: rgb(37, 0, 0) !important;
        /* Cor do texto digitado */
        font-weight: 600 !important;
    }


    @media (max-width: 600px) {

        .h3,
        h3 {
            font-size: 16px !important;
        }

        .card {
            margin-bottom: 24px;
        }
    }

    #order-standard_cart .field,
    #order-standard_cart .form-control {
        font-size: 13px;
    }

    .cart-body {
        width: 100% !important;
    }

    .top-nav li a[href*="clientarea.php"],
    .top-nav li a[href*="register.php"] {
        display: none;
    }

    #main-menu {
        display: none;
    }

    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        background-color: rgba(0, 0, 0, 0.6);
        /* Cor de fundo com mais transparência */
        transition: opacity 0.3s ease;
        /* Transição suave para exibir */
    }

    .modal-content {
        background-color: #ffffff;
        margin: 5% auto;
        padding: 30px 40px;
        border-radius: 8px;
        /* Cantos arredondados */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        /* Sombra para destaque */
        width: 90%;
        max-width: 450px;
        position: relative;
        animation: fadeIn 0.4s;
        /* Animação de entrada */
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(-20px);
        }

        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .close-btn {
        color: #333;
        position: absolute;
        top: 15px;
        right: 15px;
        font-size: 20px;
        font-weight: bold;
        padding: 5px;
        cursor: pointer;
        transition: color 0.3s;
    }

    .close-btn:hover {
        color: #e74c3c;
        /* Destacar ao passar o mouse */
    }

    .modal-header {
        font-size: 22px;
        font-weight: bold;
        text-align: center;
        margin-bottom: 15px;
        color: #333;
    }

    .modal-body {
        font-size: 16px;
        line-height: 1.5;
        color: #555;
        text-align: center;
    }

    #missingFieldsList {
        margin-top: 15px;
        padding-left: 20px;
        list-style-type: disc;
        text-align: left;
        color: #555;
    }

    .modal-footer {
        text-align: center;
        margin-top: 20px;
    }

    .modal-footer button {
        padding: 10px 20px;
        background-color: #3498db;
        color: #ffffff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .modal-footer button:hover {
        background-color: #2980b9;
    }

    .invalid-field {
        border: 1px solid red !important;
    }
</style>

<div id="order-standard_cart">


    <div class="row">
        <!--div class="cart-sidebar">
            {include file="orderforms/standard_cart/sidebar-categories.tpl"}
        </div-->
        <div class="cart-body">
            <div class="header-lined">
                <div class="breadcrumb-lkn">
                    <ul>
                        <li class="done">{$LANG.domaincheckerchoosedomain}
                            <hr />
                        </li>
                        <li class="done"><a href="cart.php?a=confproduct&i=0">{$LANG.orderconfigure}</a>
                            <hr />
                        </li>
                        <li class="done"><a href="cart.php?a=view">{$LANG.cartreviewcheckout}</a>
                            <hr />
                        </li>
                        <li class="ativa">{$LANG.orderForm.checkout}</li>
                    </ul>
                </div>
            </div>
            <div class="header-lined">
                <h1 class="font-size-36">{$LANG.orderForm.checkout}</h1>
                <p class="text-sm-left overflow-hidden">{lang key='orderForm.enterPersonalDetails'}</p>
            </div>
            {include file="orderforms/standard_cart/sidebar-categories-collapsed.tpl"}

            {if !$loggedin}
                <div class="already-registered">
                    <div>
                        <button
                            type="button"
                            class="btn-checkout"
                            id="btnNewUserSignup"
                        >
                            {$LANG.orderForm.createAccount}
                        </button>
                        <button
                            type="button"
                            class="btn-checkout"
                            id="btnAlreadyRegistered"
                        >
                            {$LANG.orderForm.alreadyRegistered}
                        </button>
                    </div>
                </div>
            {/if}

            {if $errormessage}
                <div
                    class="alert alert-danger checkout-error-feedback"
                    role="alert"
                >
                    <p>{$LANG.orderForm.correctErrors}:</p>
                    <ul>
                        {$errormessage}
                    </ul>
                </div>
                <div class="clearfix"></div>
            {/if}

            <form
                method="post"
                action="{$smarty.server.PHP_SELF}?a=checkout"
                name="orderfrm"
                id="frmCheckout"
            >
                <input
                    type="hidden"
                    name="checkout"
                    value="true"
                />
                <input
                    type="hidden"
                    name="custtype"
                    id="inputCustType"
                    value="{$custtype}"
                />

                {if $custtype neq "new" && $loggedin}
                    <!-- div class="sub-heading">
                        <span class="primary-bg-color">
                            {lang key='switchAccount.title'}
                        </span>
                    </div -->
                    <div
                        id="containerExistingAccountSelect"
                        class="row account-select-container"
                        style="margin-bottom: 15px;"
                    >
                        {foreach $accounts as $account}

                            <div class="col-sm-{if $accounts->count() == 1}12{else}6{/if}">
                                <div class="account{if $selectedAccountId == $account->id} active{/if}">
                                    <label
                                        class="radio-inline"
                                        for="account{$account->id}"
                                    >
                                        <input
                                            id="account{$account->id}"
                                            class="account-select{if $account->isClosed || $account->noPermission || $inExpressCheckout} disabled{/if}"
                                            type="radio"
                                            name="account_id"
                                            value="{$account->id}"
                                            {if $account->isClosed || $account->noPermission || $inExpressCheckout}
                                                disabled="disabled"
                                                {/if}{if $selectedAccountId == $account->id}
                                                checked="checked"
                                            {/if}
                                        >
                                        <span class="address">
                                            <strong>{$LANG.useMyAccount}</strong>

                                            <strong>

                                                {if $account->company}{$account->company}{else}{$account->fullName}{/if}
                                            </strong>
                                            {if $account->isClosed || $account->noPermission}
                                                <span class="label label-default">
                                                    {if $account->isClosed}
                                                        {lang key='closed'}
                                                    {else}
                                                        {lang key='noPermission'}
                                                    {/if}
                                                </span>
                                            {elseif $account->currencyCode}
                                                <span class="label label-info">
                                                    {$account->currencyCode}
                                                </span>
                                            {/if}
                                            <br>

                                            <span class="small">
                                                {$account->address1}{if $account->address2}, {$account->address2}{/if}<br>
                                                {if $account->city}{$account->city},{/if}
                                                {if $account->state} {$account->state},{/if}
                                                {if $account->postcode} {$account->postcode},{/if}
                                                {$account->countryName}
                                            </span>
                                        </span>
                                    </label>
                                </div>
                            </div>
                        {/foreach}
                        <div
                            class="col-sm-12"
                            style="display: none;"
                        >
                            <div
                                class="account border-bottom{if !$selectedAccountId || !is_numeric($selectedAccountId)} active{/if}">
                                <label class="radio-inline">
                                    <input
                                        class="account-select"
                                        type="radio"
                                        name="account_id"
                                        value="new"
                                        {if !$selectedAccountId || !is_numeric($selectedAccountId)}
                                            checked="checked"
                                            {/if}{if $inExpressCheckout}
                                            disabled="disabled"
                                            class="disabled"
                                        {/if}
                                    >
                                    {lang key='orderForm.createAccount'}
                                </label>
                            </div>
                        </div>
                    </div>
                {/if}
                {if !$loggedin}
                    <div
                        id="containerExistingUserSignin"
                        {if $loggedin || $custtype neq "existing"}
                            class="w-hidden"
                        {/if}
                    >
                        <div class="card mb-4">
                            <h3 class="card-title">{$LANG.orderForm.existingCustomerLogin}</h3>

                            <div
                                class="alert alert-danger w-hidden"
                                id="existingLoginMessage"
                            ></div>

                            <div class="row">
                                <div class="col-sm-6">
                                    <div>
                                        <label
                                            for="inputLoginEmail"
                                            class="field-icon"
                                        >
                                            <i class="fas fa-envelope"></i> {$LANG.orderForm.emailAddress}
                                        </label>
                                        <input
                                            type="text"
                                            name="loginemail"
                                            id="inputLoginEmail"
                                            class="field form-control"
                                            placeholder="{$LANG.orderForm.emailAddress}"
                                            value="{$loginemail}"
                                        >
                                        <div style="text-align: right;">
                                            <a href="password/reset">Esqueci minha senha?</a>
                                        </div>
                                    </div>
                                    <div>
                                        <label
                                            for="inputLoginPassword"
                                            class="field-icon"
                                        >
                                            <i class="fas fa-lock"></i> {$LANG.clientareapassword}
                                        </label>
                                        <input
                                            type="password"
                                            name="loginpassword"
                                            id="inputLoginPassword"
                                            class="field form-control"
                                            placeholder="{$LANG.clientareapassword}"
                                        >
                                    </div>
                                </div>
                            </div>

                            <div style="margin-top:15px;">
                                <button
                                    type="button"
                                    id="btnExistingLogin"
                                    class="btn btn-primary btn-md"
                                >
                                    <span id="existingLoginButton">{lang key='login'}</span>
                                    <span
                                        id="existingLoginPleaseWait"
                                        class="w-hidden"
                                    >{lang key='pleasewait'}</span>
                                </button>
                            </div>

                            <!-- {include file="orderforms/standard_cart/linkedaccounts.tpl" linkContext="checkout-existing"} -->
                        </div>
                    </div>
                {/if}

                <div
                    id="containerNewUserSignup"
                    {if $custtype === 'existing' || (is_numeric($selectedAccountId) && $selectedAccountId > 0) || ($loggedin && $accounts->count() > 0 && $selectedAccountId !== 'new')}
                        class="w-hidden"
                    {/if}
                >

                    <!-- div{if $loggedin} class="w-hidden"{/if}>
                        {include file="orderforms/standard_cart/linkedaccounts.tpl" linkContext="checkout-new"}
                    </div -->

                    <div class="card mb-4">
                        <h3 class="card-title">{$LANG.orderForm.personalInformation}</h3>

                        <div class="row">
                            <div class="col-sm-6">
                                <div>
                                    <label
                                        for="fullName"
                                        class="field-icon"
                                    >
                                        <i class="fas fa-user"></i> {$LANG.orderForm.firstName}
                                    </label>
                                    <input
                                        type="text"
                                        name="fullName"
                                        id="fullName"
                                        class="field form-control"
                                        placeholder="{$LANG.orderForm.firstName}"
                                        value="{$clientsdetails.firstname}"
                                        required
                                    >
                                </div>
                            </div>
                            <div
                                class="col-sm-6"
                                style="display: none;"
                            >
                                <div>
                                    <label
                                        for="inputFirstName"
                                        class="field-icon"
                                    >
                                        <i class="fas fa-user"></i> {$LANG.orderForm.firstName}
                                    </label>
                                    <input
                                        type="text"
                                        name="firstname"
                                        id="inputFirstName"
                                        class="field form-control"
                                        placeholder="{$LANG.orderForm.firstName}"
                                        value="{$clientsdetails.firstname}"
                                    >
                                </div>
                            </div>
                            <div
                                class="col-sm-6"
                                style="display: none;"
                            >
                                <div class="form-group prepend-icon">
                                    <label
                                        for="inputLastName"
                                        class="field-icon"
                                    >
                                        <i class="fas fa-user"></i>
                                    </label>
                                    <input
                                        type="text"
                                        name="lastname"
                                        id="inputLastName"
                                        class="field form-control"
                                        placeholder="{$LANG.orderForm.lastName}"
                                        value="{$clientsdetails.lastname}"
                                    >
                                </div>

                            </div>

                            <div class="col-sm-6">
                                <div>
                                    <label
                                        for="inputEmail"
                                        class="field-icon"
                                    >
                                        <i class="fas fa-envelope"></i> {$LANG.orderForm.emailAddress}
                                    </label>
                                    <input
                                        type="email"
                                        name="email"
                                        id="inputEmail"
                                        class="field form-control"
                                        placeholder="{$LANG.orderForm.emailAddress}"
                                        value="{$clientsdetails.email}"
                                        required
                                    >
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div>
                                    <label
                                        for="inputPhone"
                                        class="field-icon"
                                    >
                                        <i class="fas fa-phone"></i> {$LANG.orderForm.phoneNumber}
                                    </label>
                                    <input
                                        type="tel"
                                        name="phonenumber"
                                        id="inputPhone"
                                        class="field form-control"
                                        placeholder="{$LANG.orderForm.phoneNumber}"
                                        value="{$clientsdetails.phonenumber}"
                                        required
                                        inputmode="numeric"
                                    >
                                </div>
                                {if $isWhatsappField}
                                    {$isWhatsappField}
                                {/if}
                            </div>


                        </div>
                    </div>

                    <div class="card mb-4">
                        <h3 class="card-title">{$LANG.orderForm.billingAddress}</h3>
                        <div class="row">
                            <div class="col-sm-6">
                                <div>
                                    <label
                                        for="inputCountry"
                                        class="field-icon"
                                        id="inputCountryIcon"
                                    >
                                        <i class="fas fa-globe"></i> {$LANG['orderForm']['country']}
                                    </label>
                                    <select
                                        name="country"
                                        id="inputCountry"
                                        class="field form-control"
                                    >
                                        {foreach $countries as $countrycode => $countrylabel}
                                            <option
                                                value="{$countrycode}"
                                                {if (!$country && $countrycode == $defaultcountry) || $countrycode eq $country}
                                                selected{/if}
                                            >
                                                {$countrylabel}
                                            </option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div>
                                    <label
                                        for="inputPostcode"
                                        class="field-icon"
                                    >
                                        <i class="fas fa-certificate"></i> {$LANG.orderForm.postcode}
                                    </label>
                                    <input
                                        type="text"
                                        name="postcode"
                                        id="inputPostcode"
                                        class="field form-control"
                                        placeholder="{$LANG.orderForm.postcode}"
                                        required
                                        value="{$clientsdetails.postcode}"
                                    >
                                </div>
                            </div>
                            <!--div class="col-sm-12">
                                <!-- div>
                                    <label for="inputCompanyName" class="field-icon">
                                        <i class="fas fa-building"></i>
                                    </label>
                                    <input type="text" name="companyname" id="inputCompanyName" class="field form-control" placeholder="{$LANG.orderForm.companyName} ({$LANG.orderForm.optional})" value="{$clientsdetails.companyname}">
                                </div>
                            </div -->
                            <div class="col-sm-6">
                                <div>
                                    <label
                                        for="inputAddress"
                                        class="field-icon"
                                        id="inputAddressLabel"
                                    >
                                        <i class="fas fa-map-signs"></i> {$LANG.orderForm.streetAddress}
                                    </label>
                                    <input
                                        type="text"
                                        id="inputAddress"
                                        class="field form-control"
                                        placeholder="{$LANG.orderForm.streetAddress}"
                                        value=""
                                        required
                                    >
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div>
                                    <label
                                        for="inputHouseNumber"
                                        class="field-icon"
                                        id="inputHouseNumberLabel"
                                    >
                                        <i class="fas fa-map-signs"></i> {$LANG.number}
                                    </label>
                                    <input
                                        type="text"
                                        name="stateNumber"
                                        id="inputHouseNumber"
                                        class="field form-control"
                                        placeholder="{$LANG.number}"
                                        value=""
                                        required
                                    >
                                </div>
                            </div>
                            <div
                                class="col-sm-12"
                                style="display: none;"
                            >
                                <div>
                                    <label
                                        for="inputAddress1"
                                        class="field-icon"
                                    >
                                        <i class="far fa-building"></i> {$LANG.orderForm.streetAddress}
                                    </label>
                                    <input
                                        type="hidden"
                                        name="address1"
                                        id="inputAddress1"
                                        class="field form-control"
                                        placeholder="{$LANG.orderForm.streetAddress}"
                                        value="{$clientsdetails.address1}"
                                    >
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div>
                                    <label
                                        for="inputNeighborhood"
                                        class="field-icon"
                                    >
                                        <i class="fas fa-map-marker-alt"></i> {$LANG.neighborhood}
                                    </label>
                                    <input
                                        type="text"
                                        id="inputNeighborhood"
                                        class="field form-control"
                                        placeholder="{$LANG.neighborhood}"
                                        required
                                    >
                                </div>
                            </div>
                            <div
                                class="col-sm-12"
                                style="display: none;"
                            >
                                <div>
                                    <label
                                        for="inputAddress2"
                                        class="field-icon"
                                    >
                                        <i class="fas fa-map-marker-alt"></i> {$LANG.orderForm.streetAddress2}
                                    </label>
                                    <input
                                        type="text"
                                        name="address2"
                                        id="inputAddress2"
                                        class="field form-control"
                                        placeholder="{$LANG.orderForm.streetAddress2}"
                                        value="{$clientsdetails.address2}"
                                    >
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div>
                                    <label
                                        for="inputCity"
                                        class="field-icon"
                                    >
                                        <i class="far fa-building"></i> {$LANG.orderForm.city}
                                    </label>
                                    <input
                                        type="text"
                                        name="city"
                                        id="inputCity"
                                        class="field form-control"
                                        placeholder="{$LANG.orderForm.city}"
                                        value="{$clientsdetails.city}"
                                        required
                                    >
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div>
                                    <label
                                        for="state"
                                        class="field-icon"
                                        id="inputStateIcon"
                                    >
                                        <i class="fas fa-map-signs"></i> {$LANG.orderForm.state}
                                    </label>
                                    <label
                                        for="stateinput"
                                        class="field-icon"
                                        id="inputStateIcon"
                                    >
                                        <i class="fas fa-map-signs"></i> {$LANG.orderForm.state}
                                    </label>
                                    <input
                                        type="text"
                                        name="state"
                                        id="inputState"
                                        class="field form-control"
                                        placeholder="{$LANG.orderForm.state}"
                                        value="{$clientsdetails.state}"
                                    >
                                </div>
                            </div>

                            {if $showTaxIdField}
                                <div class="col-sm-12">
                                    <div class="form-group prepend-icon">
                                        <label
                                            for="inputTaxId"
                                            class="field-icon"
                                        >
                                            <i class="fas fa-building"></i>
                                        </label>
                                        <input
                                            type="text"
                                            name="tax_id"
                                            id="inputTaxId"
                                            class="field form-control"
                                            placeholder="{$taxLabel} ({$LANG.orderForm.optional})"
                                            value="{$clientsdetails.tax_id}"
                                        >
                                    </div>
                                </div>
                            {/if}
                        </div>
                    </div>
                    <div
                        class="card mb-4"
                        id="lkn-optional"
                        style="display: none;"
                    >
                        <h3 class="card-title">Dados Fiscais (Opcional)</h3>
                        <div class="row">
                            <div
                                class="col-sm-6"
                                style="display: flex"
                            >
                                <div id="cpfField">
                                    <label
                                        for="inputCPF"
                                        class="field-icon"
                                    >CPF</label>
                                    <input
                                        type="text"
                                        name="inputCPF"
                                        id="inputCPF"
                                        class="field form-control"
                                        placeholder="123.456.789-10"
                                        inputmode="numeric"
                                        maxlength="14"
                                        oninput="this.value = maskCPF(this.value)"
                                    >
                                </div>
                                <div
                                    id="nifField"
                                    style="display: none;"
                                >
                                    <label
                                        for="inputNIF"
                                        class="field-icon"
                                    >NIF</label>
                                    <input
                                        type="text"
                                        name="inputNIF"
                                        id="inputNIF"
                                        class="field form-control"
                                        placeholder="Ex: 123456789"
                                        maxlength="9"
                                    >
                                </div>
                            </div>
                            <div
                                class="col-sm-6"
                                id="dobField"
                                style="display: none;"
                            >
                                <div>
                                    <label
                                        for="inputDate"
                                        class="field-icon"
                                    >Data de nascimento:</label>
                                    <input
                                        type="date"
                                        name="inputDate"
                                        id="inputDate"
                                        class="field form-control"
                                    >
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div id="isCNPJ">
                                    <input
                                        type="checkbox"
                                        id="isPessoaJuridica"
                                        name="isCNPJ"
                                    >
                                    <label
                                        for="isPessoaJuridica"
                                        class="field-icon"
                                    >É pessoa jurídica?</label>
                                </div>
                            </div>
                            <div
                                class="col-sm-6"
                                style="display: none;"
                                id="lkn-input-cnpj"
                            >
                                <div>
                                    <label
                                        for="inputCNPJ"
                                        class="field-icon"
                                    >CNPJ:</label>
                                    <input
                                        type="text"
                                        id="inputCNPJ"
                                        class="field form-control"
                                        placeholder="12.345.678/0001-95"
                                        name="inputCNPJ"
                                        oninput="this.value = maskCNPJ(this.value)"
                                        maxlength="18"
                                    >
                                </div>
                            </div>
                        </div>
                    </div>


                    {* {if $customfields}
                        <!-- div class="sub-heading">
     {if $customfield.description}{/if}

                        {/foreach}
</div></div -->
                    {/if} *}

                </div>

                {if $domainsinorder}

                    <div class="card mb-4">
                        <h3 class="card-title">{$LANG.domainregistrantinfo}</h3>
                        <p class="small text-muted">{$LANG.orderForm.domainAlternativeContact}</p>

                        <div class="row margin-bottom">
                            <div class="col-sm-6">
                                <select
                                    name="contact"
                                    id="inputDomainContact"
                                    class="field form-control"
                                >
                                    <option value="">{$LANG.usedefaultcontact}</option>
                                    {foreach $domaincontacts as $domcontact}
                                        <option
                                            value="{$domcontact.id}"
                                            {if $contact == $domcontact.id}
                                            selected{/if}
                                        >
                                            {$domcontact.name}
                                        </option>
                                    {/foreach}
                                    <option
                                        value="addingnew"
                                        {if $contact == "addingnew"}
                                        selected{/if}
                                    >
                                        {$LANG.clientareanavaddcontact}...
                                    </option>
                                </select>
                            </div>
                        </div>

                        <div{if $contact neq "addingnew"}
                                class="w-hidden"
                            {/if}
                        >
                            <div
                                class="row"
                                id="domainRegistrantInputFields"
                            >
                                <div class="col-sm-6">
                                    <div>
                                        <label
                                            for="inputDCFirstName"
                                            class="field-icon"
                                        >
                                            <i class="fas fa-user"></i> {$LANG.orderForm.firstName}
                                        </label>
                                        <input
                                            type="text"
                                            name="domaincontactfirstname"
                                            id="inputDCFirstName"
                                            class="field form-control"
                                            placeholder="{$LANG.orderForm.firstName}"
                                            value="{$domaincontact.firstname}"
                                        >
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div>
                                        <label
                                            for="inputDCLastName"
                                            class="field-icon"
                                        >
                                            <i class="fas fa-user"></i> {$LANG.orderForm.lastName}
                                        </label>
                                        <input
                                            type="text"
                                            name="domaincontactlastname"
                                            id="inputDCLastName"
                                            class="field form-control"
                                            placeholder="{$LANG.orderForm.lastName}"
                                            value="{$domaincontact.lastname}"
                                        >
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div>
                                        <label
                                            for="inputDCEmail"
                                            class="field-icon"
                                        >
                                            <i class="fas fa-envelope"></i> {$LANG.orderForm.emailAddress}
                                        </label>
                                        <input
                                            type="email"
                                            name="domaincontactemail"
                                            id="inputDCEmail"
                                            class="field form-control"
                                            placeholder="{$LANG.orderForm.emailAddress}"
                                            value="{$domaincontact.email}"
                                        >
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div>
                                        <label
                                            for="inputDCPhone"
                                            class="field-icon"
                                        >
                                            <i class="fas fa-phone"></i> {$LANG.orderForm.phoneNumber}
                                        </label>
                                        <input
                                            type="tel"
                                            name="domaincontactphonenumber"
                                            id="inputDCPhone"
                                            class="field form-control"
                                            placeholder="{$LANG.orderForm.phoneNumber}"
                                            value="{$domaincontact.phonenumber}"
                                        >
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div>
                                        <label
                                            for="inputDCCompanyName"
                                            class="field-icon"
                                        >
                                            <i class="fas fa-building"></i> {$LANG.orderForm.companyName}
                                        </label>
                                        <input
                                            type="text"
                                            name="domaincontactcompanyname"
                                            id="inputDCCompanyName"
                                            class="field form-control"
                                            placeholder="{$LANG.orderForm.companyName} ({$LANG.orderForm.optional})"
                                            value="{$domaincontact.companyname}"
                                        >
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div>
                                        <label
                                            for="inputDCAddress1"
                                            class="field-icon"
                                        >
                                            <i class="far fa-building"></i> {$LANG.orderForm.streetAddress}
                                        </label>
                                        <input
                                            type="text"
                                            name="domaincontactaddress1"
                                            id="inputDCAddress1"
                                            class="field form-control"
                                            placeholder="{$LANG.orderForm.streetAddress}"
                                            value="{$domaincontact.address1}"
                                        >
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div>
                                        <label
                                            for="inputDCAddress2"
                                            class="field-icon"
                                        >
                                            <i class="fas fa-map-marker-alt"></i> {$LANG.orderForm.streetAddress2}
                                        </label>
                                        <input
                                            type="text"
                                            name="domaincontactaddress2"
                                            id="inputDCAddress2"
                                            class="field form-control"
                                            placeholder="{$LANG.orderForm.streetAddress2}"
                                            value="{$domaincontact.address2}"
                                        >
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div>
                                        <label
                                            for="inputDCCity"
                                            class="field-icon"
                                        >
                                            <i class="far fa-building"></i> {$LANG.orderForm.city}
                                        </label>
                                        <input
                                            type="text"
                                            name="domaincontactcity"
                                            id="inputDCCity"
                                            class="field form-control"
                                            placeholder="{$LANG.orderForm.city}"
                                            value="{$domaincontact.city}"
                                        >
                                    </div>
                                </div>
                                <div class="col-sm-5">
                                    <div>
                                        <label
                                            for="inputDCState"
                                            class="field-icon"
                                        >
                                            <i class="fas fa-map-signs"></i> {$LANG.orderForm.state}
                                        </label>
                                        <input
                                            type="text"
                                            name="domaincontactstate"
                                            id="inputDCState"
                                            class="field form-control"
                                            placeholder="{$LANG.orderForm.state}"
                                            value="{$domaincontact.state}"
                                        >
                                    </div>
                                </div>
                                <div class="col-sm-3">
                                    <div>
                                        <label
                                            for="inputDCPostcode"
                                            class="field-icon"
                                        >
                                            <i class="fas fa-certificate"></i> {$LANG.orderForm.postcode}
                                        </label>
                                        <input
                                            type="text"
                                            name="domaincontactpostcode"
                                            id="inputDCPostcode"
                                            class="field form-control"
                                            placeholder="{$LANG.orderForm.postcode}"
                                            value="{$domaincontact.postcode}"
                                        >
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div>
                                        <label
                                            for="inputDCCountry"
                                            class="field-icon"
                                            id="inputCountryIcon"
                                        >
                                            <i class="fas fa-globe"></i> {$LANG.orderForm.country}
                                        </label>
                                        <select
                                            name="domaincontactcountry"
                                            id="inputDCCountry"
                                            class="field form-control"
                                        >
                                            {foreach $countries as $countrycode => $countrylabel}
                                                <option
                                                    value="{$countrycode}"
                                                    {if (!$domaincontact.country && $countrycode == $defaultcountry) || $countrycode eq $domaincontact.country}
                                                    selected{/if}
                                                >
                                                    {$countrylabel}
                                                </option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <div>
                                        <label
                                            for="inputDCTaxId"
                                            class="field-icon"
                                        >
                                            <i class="fas fa-building"></i> {$taxLabel} ({$LANG.orderForm.optional})
                                        </label>
                                        <input
                                            type="text"
                                            name="domaincontacttax_id"
                                            id="inputDCTaxId"
                                            class="field form-control"
                                            placeholder="{$taxLabel} ({$LANG.orderForm.optional})"
                                            value="{$domaincontact.tax_id}"
                                        >
                                    </div>
                                </div>
                            </div>
                    </div>
            </div>

        {/if}

        {if !$loggedin}

            <div
                id="containerNewUserSecurity"
                {if (!$loggedin && $custtype eq "existing") || ($remote_auth_prelinked && !$securityquestions)}
                    class="w-hidden"
                {/if}
            >


                <div class="card mb-4">
                    <h3 class="card-title">{$LANG.orderForm.accountSecurity}</h3>

                    <div
                        id="containerPassword"
                        class="row{if $remote_auth_prelinked && $securityquestions} w-hidden{/if}"
                    >
                        <div
                            id="passwdFeedback"
                            class="alert alert-info text-center col-sm-12 w-hidden"
                        ></div>
                        <div class="col-sm-6">
                            <div>
                                <label
                                    for="inputNewPassword1"
                                    class="field-icon"
                                >
                                    <i class="fas fa-lock"></i> {$LANG.clientareaconfirmpassword}
                                </label>
                                <input
                                    type="password"
                                    name="password"
                                    id="inputNewPassword1"
                                    data-error-threshold="{$pwStrengthErrorThreshold}"
                                    data-warning-threshold="{$pwStrengthWarningThreshold}"
                                    class="field form-control"
                                    placeholder="{$LANG.clientareapassword}"
                                    required
                                    {if $remote_auth_prelinked}
                                        value="{$password}"
                                    {/if}
                                >
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div>
                                <label
                                    for="inputNewPassword2"
                                    class="field-icon"
                                >
                                    <i class="fas fa-lock"></i> {$LANG.clientareaconfirmpassword}
                                </label>
                                <input
                                    type="password"
                                    name="password2"
                                    id="inputNewPassword2"
                                    class="field form-control"
                                    placeholder="{$LANG.clientareaconfirmpassword}"
                                    {if $remote_auth_prelinked}
                                        value="{$password}"
                                    {/if}
                                >
                            </div>
                        </div>
                        <!-- div class="col-sm-6">
                                    <button type="button" class="btn btn-default btn-sm generate-password" data-targetfields="inputNewPassword1,inputNewPassword2">
                                        {$LANG.generatePassword.btnLabel}
                                    </button>
                                </div -->
                        <div class="col-sm-6">
                            <div class="password-strength-meter">
                                <div class="progress">
                                    <div
                                        class="progress-bar progress-bar-success progress-bar-striped"
                                        role="progressbar"
                                        aria-valuenow="0"
                                        aria-valuemin="0"
                                        aria-valuemax="100"
                                        id="passwordStrengthMeterBar"
                                    >
                                    </div>
                                </div>
                                <p
                                    class="text-center small text-muted"
                                    id="passwordStrengthTextLabel"
                                >
                                    {$LANG.pwstrength}:
                                    {$LANG.pwstrengthenter}</p>
                            </div>
                        </div>
                    </div>
                    {if $securityquestions}
                        <div class="row">
                            <div class="col-sm-6">
                                <select
                                    name="securityqid"
                                    id="inputSecurityQId"
                                    class="field form-control"
                                >
                                    <option value="">{$LANG.clientareasecurityquestion}</option>
                                    {foreach $securityquestions as $question}
                                        <option
                                            value="{$question.id}"
                                            {if $question.id eq $securityqid}
                                            selected{/if}
                                        >
                                            {$question.question}
                                        </option>
                                    {/foreach}
                                </select>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group prepend-icon">
                                    <label
                                        for="inputSecurityQAns"
                                        class="field-icon"
                                    >
                                        <i class="fas fa-lock"></i>
                                    </label>
                                    <input
                                        type="password"
                                        name="securityqans"
                                        id="inputSecurityQAns"
                                        class="field form-control"
                                        placeholder="{$LANG.clientareasecurityanswer}"
                                    >
                                </div>
                            </div>
                        </div>
                    {/if}
                </div>
            </div>
        {/if}

        {foreach $hookOutput as $output}
            <div>
                {$output}
            </div>
        {/foreach}

        <div class="card mb-4">
            <h3 class="card-title">{$LANG.orderForm.paymentDetails}</h3>

            <div
                role="alert"
                id="totalDueToday"
            >
                {$LANG.ordertotalduetoday}: &nbsp; <strong id="totalCartPrice">{$total}</strong>
            </div>

            <div
                id="applyCreditContainer"
                class="apply-credit-container{if !$canUseCreditOnCheckout} w-hidden{/if}"
                data-apply-credit="{$applyCredit}"
            >
                <p>{lang key='cart.availableCreditBalance' amount=$creditBalance}</p>

                <label class="radio">
                    <input
                        id="useCreditOnCheckout"
                        type="radio"
                        name="applycredit"
                        value="1"
                        {if $applyCredit}
                        checked{/if}
                    >
                    <span
                        id="spanFullCredit"
                        {if !($creditBalance->toNumeric() >= $total->toNumeric())}
                            class="w-hidden"
                        {/if}
                    >
                        {lang key='cart.applyCreditAmountNoFurtherPayment' amount=$total}
                    </span>
                    <span
                        id="spanUseCredit"
                        {if $creditBalance->toNumeric() >= $total->toNumeric()}
                            class="w-hidden"
                        {/if}
                    >
                        {lang key='cart.applyCreditAmount' amount=$creditBalance}
                    </span>
                </label>
                <label class="radio">
                    <input
                        id="skipCreditOnCheckout"
                        type="radio"
                        name="applycredit"
                        value="0"
                        {if !$applyCredit}
                        checked{/if}
                    >
                    {lang key='cart.applyCreditSkip' amount=$creditBalance}
                </label>
            </div>

            {if !$inExpressCheckout}
                <div
                    id="paymentGatewaysContainer"
                    class="form-group"
                >
                    <div class=" text-center">
                        <p>{$LANG.avCompleteOrder}</p>
                    </div>
                    <div
                        class="text-center"
                        style="display: none;"
                    >
                        {foreach $gateways as $gateway}
                            <label class="radio-inline">
                                <input
                                    type="radio"
                                    name="paymentmethod"
                                    value="{$gateway.sysname}"
                                    data-payment-type="{$gateway.payment_type}"
                                    data-show-local="{$gateway.show_local_cards}"
                                    data-remote-inputs="{$gateway.uses_remote_inputs}"
                                    class="payment-methods{if $gateway.type eq "CC"} is-credit-card{/if}"
                                    {if $selectedgateway eq $gateway.sysname}
                                    checked{/if}
                                />
                                {$gateway.name}
                            </label>
                        {/foreach}
                    </div>
                </div>

                <div class="alert alert-danger text-center gateway-errors w-hidden"></div>

                <div class="clearfix"></div>

                <div id="paymentGatewayInput"></div>

                <div
                    class="cc-input-container{if $selectedgatewaytype neq "CC"} w-hidden{/if}"
                    id="creditCardInputFields"
                >
                    {if $client}
                        <div
                            id="existingCardsContainer"
                            class="existing-cc-grid"
                        >
                            {include file="orderforms/standard_cart/includes/existing-paymethods.tpl"}
                        </div>
                    {/if}
                    <div
                        class="row cvv-input"
                        id="existingCardInfo"
                    >
                        <div class="col-lg-3 col-sm-4">
                            <div class="form-group prepend-icon">
                                <label
                                    for="inputCardCVV2"
                                    class="field-icon"
                                >
                                    <i class="fas fa-barcode"></i>
                                </label>
                                <div class="input-group">
                                    <input
                                        type="tel"
                                        name="cccvv"
                                        id="inputCardCVV2"
                                        class="field form-control"
                                        placeholder="{$LANG.creditcardcvvnumbershort}"
                                        autocomplete="cc-cvc"
                                    >
                                    <span class="input-group-btn input-group-append">
                                        <button
                                            type="button"
                                            class="btn btn-default"
                                            data-toggle="popover"
                                            data-placement="bottom"
                                            data-content="<img src='{$BASE_PATH_IMG}/ccv.gif' width='210' />"
                                        >
                                            ?
                                        </button>
                                    </span>
                                </div>
                                <span class="field-error-msg">{lang key="paymentMethodsManage.cvcNumberNotValid"}</span>
                            </div>
                        </div>
                    </div>

                    <ul>
                        <li>
                            <label class="radio-inline">
                                <input
                                    type="radio"
                                    name="ccinfo"
                                    value="new"
                                    id="new"
                                    {if !$client || $client->payMethods->count() === 0}
                                        checked="checked"
                                    {/if}
                                />
                                &nbsp;
                                {lang key='creditcardenternewcard'}
                            </label>
                        </li>
                    </ul>

                    <div
                        class="row"
                        id="newCardInfo"
                    >
                        <div
                            id="cardNumberContainer"
                            class="col-sm-6 new-card-container"
                        >
                            <div class="form-group prepend-icon">
                                <label
                                    for="inputCardNumber"
                                    class="field-icon"
                                >
                                    <i class="fas fa-credit-card"></i>
                                </label>
                                <input
                                    type="tel"
                                    name="ccnumber"
                                    id="inputCardNumber"
                                    class="field form-control cc-number-field"
                                    placeholder="{$LANG.orderForm.cardNumber}"
                                    autocomplete="cc-number"
                                    data-message-unsupported="{lang key='paymentMethodsManage.unsupportedCardType'}"
                                    data-message-invalid="{lang key='paymentMethodsManage.cardNumberNotValid'}"
                                    data-supported-cards="{$supportedCardTypes}"
                                />
                                <span class="field-error-msg"></span>
                            </div>
                        </div>
                        <div class="col-sm-3 new-card-container">
                            <div class="form-group prepend-icon">
                                <label
                                    for="inputCardExpiry"
                                    class="field-icon"
                                >
                                    <i class="fas fa-calendar-alt"></i>
                                </label>
                                <input
                                    type="tel"
                                    name="ccexpirydate"
                                    id="inputCardExpiry"
                                    class="field form-control"
                                    placeholder="MM / YY{if $showccissuestart} ({$LANG.creditcardcardexpires}){/if}"
                                    autocomplete="cc-exp"
                                >
                                <span class="field-error-msg">{lang key="paymentMethodsManage.expiryDateNotValid"}</span>
                            </div>
                        </div>
                        <div
                            class="col-sm-3"
                            id="cvv-field-container"
                        >
                            <div class="form-group prepend-icon">
                                <label
                                    for="inputCardCVV"
                                    class="field-icon"
                                >
                                    <i class="fas fa-barcode"></i>
                                </label>
                                <div class="input-group">
                                    <input
                                        type="tel"
                                        name="cccvv"
                                        id="inputCardCVV"
                                        class="field form-control"
                                        placeholder="{$LANG.creditcardcvvnumbershort}"
                                        autocomplete="cc-cvc"
                                    >
                                    <span class="input-group-btn input-group-append">
                                        <button
                                            type="button"
                                            class="btn btn-default"
                                            data-toggle="popover"
                                            data-placement="bottom"
                                            data-content="<img src='{$BASE_PATH_IMG}/ccv.gif' width='210' />"
                                        >
                                            ?
                                        </button>
                                    </span><br>
                                </div>
                                <span class="field-error-msg">{lang key="paymentMethodsManage.cvcNumberNotValid"}</span>
                            </div>
                        </div>
                        {if $showccissuestart}
                            <div class="col-sm-3 col-sm-offset-6 new-card-container offset-sm-6">
                                <div class="form-group prepend-icon">
                                    <label
                                        for="inputCardStart"
                                        class="field-icon"
                                    >
                                        <i class="far fa-calendar-check"></i>
                                    </label>
                                    <input
                                        type="tel"
                                        name="ccstartdate"
                                        id="inputCardStart"
                                        class="field form-control"
                                        placeholder="MM / YY ({$LANG.creditcardcardstart})"
                                        autocomplete="cc-exp"
                                    >
                                </div>
                            </div>
                            <div class="col-sm-3 new-card-container">
                                <div class="form-group prepend-icon">
                                    <label
                                        for="inputCardIssue"
                                        class="field-icon"
                                    >
                                        <i class="fas fa-asterisk"></i>
                                    </label>
                                    <input
                                        type="tel"
                                        name="ccissuenum"
                                        id="inputCardIssue"
                                        class="field form-control"
                                        placeholder="{$LANG.creditcardcardissuenum}"
                                    >
                                </div>
                            </div>
                        {/if}
                    </div>
                    <div id="newCardSaveSettings">
                        <div class="row form-group new-card-container">
                            <div
                                id="inputDescriptionContainer"
                                class="col-md-6"
                            >
                                <div class="prepend-icon">
                                    <label
                                        for="inputDescription"
                                        class="field-icon"
                                    >
                                        <i class="fas fa-pencil"></i>
                                    </label>
                                    <input
                                        type="text"
                                        class="field form-control"
                                        id="inputDescription"
                                        name="ccdescription"
                                        autocomplete="off"
                                        value=""
                                        placeholder="{$LANG.paymentMethods.descriptionInput} {$LANG.paymentMethodsManage.optional}"
                                    />
                                </div>
                            </div>
                            {if $allowClientsToRemoveCards}
                                <div
                                    id="inputNoStoreContainer"
                                    class="col-md-6"
                                    style="line-height: 32px;"
                                >
                                    <input
                                        type="hidden"
                                        name="nostore"
                                        value="1"
                                    >
                                    <input
                                        type="checkbox"
                                        class="toggle-switch-success no-icheck"
                                        data-size="mini"
                                        checked="checked"
                                        name="nostore"
                                        id="inputNoStore"
                                        value="0"
                                        data-on-text="{lang key='yes'}"
                                        data-off-text="{lang key='no'}"
                                    >
                                    <label
                                        for="inputNoStore"
                                        class="checkbox-inline no-padding"
                                    >
                                        &nbsp;&nbsp;
                                        {$LANG.creditCardStore}
                                    </label>
                                </div>
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
        {else}
            {if $expressCheckoutOutput}
                {$expressCheckoutOutput}
            {else}
                <p align="center">
                    {lang key='paymentPreApproved' gateway=$expressCheckoutGateway}
                </p>
            {/if}
        {/if}

        {if $shownotesfield}
            {* <div class="card mb-4">
                        <h3 class="card-title">{$LANG.orderForm.additionalNotes}</h3>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <textarea name="notes" class="field form-control" rows="4"
                                        placeholder="{$LANG.ordernotesdescription}">{$orderNotes}</textarea>
                                </div>
                            </div>
                        </div>
                    </div> *}
        {/if}

        {if $showMarketingEmailOptIn}
            {* <div class="marketing-email-optin">
                        <h4 class="font-size-18">{lang key='emailMarketing.joinOurMailingList'}</h4>
                        <p>{$marketingEmailOptInMessage}</p>
                        <input type="checkbox" name="marketingoptin" value="1" {if $marketingEmailOptIn} checked{/if}
                            class="no-icheck toggle-switch-success" data-size="small" data-on-text="{lang key='yes'}"
                            data-off-text="{lang key='no'}">
                    </div> *}
        {/if}
        <div
            id="errorModal"
            style="display: none;"
            class="modal"
        >
            <div
                class="modal-dialog modal-sm"
                role="document"
            >
                <div
                    class="modal-content"
                    style="min-height: 250px;"
                >

                    <!-- Cabeçalho do modal com botão de fechamento -->
                    <div class="modal-header">
                        <span
                            class="close-btn"
                            onclick="closeModal()"
                        >&times;</span>
                        <h5 class="modal-title">{$LANG.requiredFieldsNotFilled}</h5>
                    </div>

                    <!-- Corpo do modal com a mensagem de erro -->
                    <div class="modal-body">

                        <p id="errorMessage"></p>
                    </div>

                    <!-- Rodapé com botão de fechamento -->
                    <div
                        class="modal-footer"
                        style="display: flex;"
                    >
                        <button
                            type="button"
                            class="btn btn-sm btn-block btn-primary"
                            onclick="closeModal()"
                        >Fechar</button>
                    </div>

                </div>
            </div>
        </div>
        <div class="text-center">
            {if $accepttos}
                <p
                    id="tos-root-container"
                    style="display: none;"
                >
                    <label class="checkbox-inline">
                        <input
                            type="checkbox"
                            name="accepttos"
                            id="accepttos"
                        />
                        &nbsp;
                        {$LANG.ordertosagreement}
                        <a
                            href="{$tosurl}"
                            target="_blank"
                        >{$LANG.ordertos}</a>
                    </label>
                </p>
            {/if}
            {if $captcha}
                <div class="text-center margin-bottom">
                    {include file="$template/includes/captcha.tpl"}
                </div>
            {/if}

            <button
                style="background-color:#DAE300;border:none;color:#343B45;width:100%;"
                type="submit"
                id="btnCompleteOrder"
                class="btn btn-primary btn-lg {if $captcha}{$captcha->getButtonClass($captchaForm)}{/if}"
                {if $cartitems==0}disabled="disabled"
                {/if}
                onclick="showSpinner(event)"
            >
                <span id="btnText">
                    {if $inExpressCheckout}{$LANG.confirmAndPay}{else}{$LANG.completeorder}{/if}
                    &nbsp;<i class="fas fa-arrow-circle-right"></i>
                </span>
                <span
                    id="spinner"
                    style="display:none;"
                >
                    <i class="fas fa-spinner fa-spin"></i>
                </span>
            </button>
            <script>
                const tosRootContainer = document.getElementById('tos-root-container')
                const btnNewUserSignup = document.getElementById('btnNewUserSignup')
                const btnAlreadyRegistered = document.getElementById('btnAlreadyRegistered')

                function onClickBtnNewUserSignup() {
                    tosRootContainer.style.display = 'block'
                }

                function onClickBtnAlreadyRegistered() {
                    tosRootContainer.style.display = 'none'
                }

                if (btnNewUserSignup) {

                    btnNewUserSignup.addEventListener('click', onClickBtnNewUserSignup)
                }

                if (btnAlreadyRegistered) {
                    btnAlreadyRegistered.addEventListener('click', onClickBtnAlreadyRegistered)
                }

                const observer = new MutationObserver((mutationsList) => {
                    for (const mutation of mutationsList) {
                        const btnCompleteOrder = document.getElementById("btnCompleteOrder")

                        if (!['none', ''].includes(btnCompleteOrder?.style?.display)) {
                            tosRootContainer.style.display = 'block'

                            observer.disconnect();

                            break;
                        }
                    }
                });

                observer.observe(document.body, { childList: true, subtree: true });

                // Função para validar o CPF
                function validateCPF(cpf) {
                    // Verifica se o CPF é do tipo string
                    if (typeof cpf !== 'string') return false

                    // Substitui todos os caracteres que não forem números
                    cpf = cpf.replace(/[\s.-]*/igm, '')

                    // Valida se o valor passado é uma sequência inválida padrão ou com tamanho maior que 11 caracteres
                    if (
                        !cpf ||
                        cpf.length !== 11 ||
                        cpf === '00000000000' ||
                        cpf === '11111111111' ||
                        cpf === '22222222222' ||
                        cpf === '33333333333' ||
                        cpf === '44444444444' ||
                        cpf === '55555555555' ||
                        cpf === '66666666666' ||
                        cpf === '77777777777' ||
                        cpf === '88888888888' ||
                        cpf === '99999999999'
                    ) {
                        return false
                    }
                    // Declaração das variáveis
                    let soma = 0
                    let resto
                    let i = 1

                    // Percorre o array de caracteres validando os números antes do dígito verificador
                    for (i = 1; i <= 9; i++) { soma = soma + parseInt(cpf.substring(i - 1, i)) * (11 - i) }
                    resto = (soma * 10) % 11
                    if ((resto === 10) || (resto === 11)) resto = 0
                    if (resto !== parseInt(cpf.substring(9, 10))) return false

                    // Reseta a variável soma
                    soma = 0

                    // Valida os dígitos verificadores
                    for (i = 1; i <= 10; i++) { soma = soma + parseInt(cpf.substring(i - 1, i)) * (12 - i) }
                    resto = (soma * 10) % 11
                    if ((resto === 10) || (resto === 11)) resto = 0
                    if (resto !== parseInt(cpf.substring(10, 11))) return false
                    // Se passar por todas as validações retorna true
                    return true
                }

                // Função para validar o CNPJ
                function validateCNPJ(value) {
                    if (!value) return false

                    if (value === null || value === '') {
                        return false
                    }

                    // Aceita receber o valor como string, número ou array com todos os dígitos
                    const validTypes =
                        typeof value === 'string' || Number.isInteger(value) || Array.isArray(value)

                    // Elimina valor em formato inválido
                    if (!validTypes) return false

                    // Guarda um array com todos os dígitos do valor
                    const match = value.toString().match(/\d/g)
                    const numbers = Array.isArray(match) ? match.map(Number) : []

                    // Valida se tiver 15 dígitos retirando o primeiro 0
                    if (numbers[0] === 0) {
                        if (numbers[14] !== undefined && numbers[14] !== null) {
                            numbers.shift()
                        }
                    }

                    // Valida a quantidade de dígitos
                    if (numbers.length !== 14) return false

                    // Elimina inválidos com todos os dígitos iguais
                    const items = [...new Set(numbers)]
                    if (items.length === 1) return false

                    // Cálculo validador
                    const calc = (x) => {
                        const slice = numbers.slice(0, x)
                        let factor = x - 7
                        let sum = 0

                        for (let i = x; i >= 1; i--) {
                            const n = slice[x - i]
                            sum += n * factor--
                            if (factor < 2) factor = 9
                        }

                        const result = 11 - (sum % 11)

                        return result > 9 ? 0 : result
                    }

                    // Separa os 2 últimos dígitos de verificadores
                    const digits = numbers.slice(12)

                    // Valida 1o. dígito verificador
                    const digit0 = calc(12)
                    if (digit0 !== digits[0]) return false

                    // Valida 2o. dígito verificador
                    const digit1 = calc(13)
                    if (digit1 === digits[1]) {
                        return true
                    } else {
                        return false
                    }
                }

                function validateBirthday(date) {
                    const dateArr = date.split('-');

                    if (dateArr.length !== 3) {
                        return false;
                    }

                    if (dateArr[0].length !== 4) {
                        return false;
                    }

                    if (dateArr[1] < 1 || dateArr[1] > 12) {
                        return false;
                    }

                    if (dateArr[2] < 1 || dateArr[2] > 31) {
                        return false;
                    }

                    return true;
                }

                async function showSpinner(event) {
                    const containerDiv = document.getElementById("containerExistingAccountSelect");

                    if (!containerDiv) {
                        // Impede a submissão do formulário inicialmente
                        event.preventDefault();

                        let missingFields = [];

                        // Encontra os campos obrigatórios
                        const requiredFields = document.querySelectorAll(
                            'input[required], select[required], textarea[required]'
                        );

                        // Limpa qualquer borda vermelha de campos anteriores
                        requiredFields.forEach((field) => {
                            field.classList.remove('invalid-field'); // Remove a borda vermelha anterior
                        });

                        const cnpj = document.getElementById('inputCNPJ');
                        const cpf = document.getElementById('inputCPF');
                        const iCheckIsPessoaJuridica = document.querySelector("#iCheck-isPessoaJuridica");

                        // Validação do CPF
                        if (cpf && cpf.value && !validateCPF(cpf.value.trim())) {
                            event.preventDefault();
                            cpf.classList.add('invalid-field')
                            // Mensagem de erro: Por favor preencha o campo CNPJ corretamente
                            missingFields.push("{$LANG.requiredFieldMessage}<strong>CPF corretamente</strong>");
                            showErrorModal(missingFields);
                            cpf.focus();
                            return;
                        }

                        // Validação do CNPJ
                        if (iCheckIsPessoaJuridica.classList.contains("checked") && cnpj && !validateCNPJ(cnpj.value
                                .trim())) {
                            event.preventDefault();
                            cnpj.classList.add('invalid-field');
                            // Mensagem de erro: Por favor preencha o campo CNPJ corretamente
                            missingFields.push("{$LANG.requiredFieldMessage}<strong>CNPJ corretamente</strong>");
                            showErrorModal(missingFields);
                            cnpj.focus();
                            return;
                        }

                        const inputDate = document.getElementById('inputDate');

                        if (inputDate && inputDate.value && !validateBirthday(inputDate.value.trim())) {
                            event.preventDefault();
                            inputDate.classList.add('invalid-field');
                            // Mensagem de erro: Por favor preencha o campo Data de Nascimento corretamente
                            missingFields.push("{$LANG.requiredFieldMessage}<strong>Data de Nascimento corretamente</strong>");
                            showErrorModal(missingFields);
                            inputDate.focus();
                            return;
                        }

                        // Verifica se os campos obrigatórios estão preenchidos, parando no primeiro erro
                        for (const field of requiredFields) {
                            if (!field.value.trim()) { // Garante que o valor não esteja vazio ou apenas com espaços
                                const label = document.querySelector('label[for="' + field.id + '"]');
                                missingFields.push("{$LANG.requiredFieldMessage}<strong>" + (label ? label.textContent : (field.name || field.id)) + "</strong>");

                                // Adiciona a borda vermelha no campo de entrada que está faltando
                                field.classList.add('invalid-field');

                                // Exibe o modal com a primeira mensagem de erro e interrompe a função
                                showErrorModal(missingFields);
                                return;
                            }
                        }

                        // Validação do campo fullName para conter mais de uma palavra
                        const fullName = document.getElementById('fullName');
                        if (fullName && fullName.value.trim().split(" ").length < 2) {
                            missingFields.push("{$LANG.fullNameError}");
                            fullName.classList.add('invalid-field');
                            showErrorModal(missingFields);
                            return;
                        }

                        // Validação de senha
                        const password1 = document.getElementById('inputNewPassword1');
                        const password2 = document.getElementById('inputNewPassword2');
                        if (password1 && password2 && password1.value !== password2.value) {
                            missingFields.push("{$LANG.passwordsDoNotMatch}");
                            password1.classList.add('invalid-field');
                            password2.classList.add('invalid-field');
                            showErrorModal(missingFields);
                            return;
                        }

                        let email = document.getElementById("inputEmail");
                        if (email) {
                            try {
                                let email_validate = await makeRequest(systemURL +
                                    "/modules/addons/lknwhmcsdcc/api.php", "POST", {
                                        action: "validate-email",
                                        email: email.value
                                    });

                                if (email_validate.success != "OK") {
                                    // Usando o código de erro para buscar a tradução no WHMCS
                                    let errorMessage = getLangMessage(email_validate.error_code);
                                    missingFields.push(errorMessage);
                                    email.classList.add('invalid-field');
                                    showErrorModal("{$requiredFieldMessage}"+missingFields);
                                    return;
                                }
                            } catch (error) {
                                missingFields.push("Erro ao validar o e-mail. Tente novamente mais tarde.");
                                showErrorModal(missingFields);
                                return;
                            }
                        }

                        // Função para retornar a mensagem de erro baseada no código
                        function getLangMessage(errorCode) {
                            switch (errorCode) {
                                case 100:
                                    return '{$LANG.invalidEmailFormat}'; // Formato de email inválido
                                case 101:
                                    return '{$LANG.invalidEmailSyntax}'; // Sintaxe de email inválida
                                case 102:
                                    return '{$LANG.emailSyntaxCheckFailed}'; // Falha na verificação de sintaxe
                                case 103:
                                    return '{$LANG.emailUnreachable}'; // E-mail inalcansável
                                case 104:
                                    return '{$LANG.actionInvalid}'; // Ação inválida
                                case 105:
                                    return '{$LANG.methodNotSupported}'; // Método não suportado
                                default:
                                    return '{$LANG.unknownError}'; // Erro desconhecido
                            }
                        }


                        // Se todas as validações passarem, exibe o spinner e submete o formulário
                        document.getElementById('btnText').style.display = 'none';
                        document.getElementById('spinner').style.display = 'inline-block';

                        const form = event.target.closest('form');
                        if (form) {
                            form.submit();
                        }
                    }
                }

                function showErrorModal(missingFields) {
                    document.getElementById('errorMessage').innerHTML = missingFields.join('<br>');
                    document.getElementById('errorModal').style.display = 'block';
                }

                function closeModal() {
                    document.getElementById('errorModal').style.display = 'none';
                    const firstInvalidField = document.querySelector('.invalid-field');
                    if (firstInvalidField) {
                        firstInvalidField.focus();
                    }
                }

                window.onclick = function(event) {
                    const modal = document.getElementById('errorModal');
                    if (event.target === modal) {
                        closeModal();
                    }
                }

                document.addEventListener('DOMContentLoaded', function() {
                    document.querySelectorAll('input[required], select[required], textarea[required]').forEach((
                        field) => {
                        field.addEventListener('input', function() {
                            if (this.value.trim()) {
                                this.classList.remove('invalid-field');
                            }
                        });
                    });
                });
            </script>


            <script>
                document.addEventListener("DOMContentLoaded", function() {
                    // Recupera os valores de inputFirstName e inputLastName e coloca no fullName
                    var firstName = document.getElementById('inputFirstName').value.trim();
                    var lastName = document.getElementById('inputLastName').value.trim();

                    // Se ambos os valores existirem, combine-os no campo fullName
                    if (firstName || lastName) {
                        document.getElementById('fullName').value = firstName + ' ' + lastName;
                    }

                    // Adiciona o evento de mudança ao campo fullName para separar em primeiro nome e sobrenome
                    document.querySelector("#fullName").addEventListener("change", function() {
                        var fullName = document.getElementById('fullName').value.trim();

                        // Divide o nome completo em partes
                        var nameParts = fullName.split(' ');

                        // O primeiro nome será a primeira palavra
                        var firstName = nameParts[0];

                        // O sobrenome será o resto das palavras
                        var lastName = nameParts.slice(1).join(' ');

                        // Preenche os campos "Primeiro Nome" e "Sobrenome"
                        document.getElementById('inputFirstName').value = firstName;
                        document.getElementById('inputLastName').value = lastName;
                    });
                });
            </script>
            <script>
                document.addEventListener("DOMContentLoaded", function() {
                    const countryInput = document.getElementById('inputCountry');
                    const optionalField = document.querySelector('#lkn-optional');
                    const cpfField = document.getElementById('cpfField');
                    const nifField = document.getElementById('nifField');
                    const dobField = document.getElementById('dobField');
                    const isCNPJ = document.getElementById("isCNPJ");

                    const isPessoaJuridica = document.getElementById('isPessoaJuridica');
                    const cnpjField = document.getElementById('lkn-input-cnpj');
                    const cnpj = document.getElementById('inputCNPJ');
                    const checkBoxWrapper = document.getElementById('iCheck-isPessoaJuridica');

                    function toggleCNPJField() {
                        if (countryInput.value === 'BR' && (isPessoaJuridica.checked || checkBoxWrapper
                                .classList
                                .contains(
                                    'checked'))) {
                            cnpjField.style.display = 'flex'; // Mostra o campo CNPJ
                        } else {
                            cnpjField.style.display = 'none'; // Esconde o campo CNPJ

                        }
                    }

                    // Chama a função inicialmente para verificar o estado do checkbox
                    toggleCNPJField();

                    // Cria um observador para monitorar mudanças nas classes do checkbox
                    const observer = new MutationObserver(function(mutations) {
                        mutations.forEach(function(mutation) {
                            if (mutation.attributeName === 'class') {
                                toggleCNPJField
                                    (); // Chama a função se a classe mudar
                            }
                        });
                    });

                    // Configura o observador para observar o atributo de classe
                    observer.observe(checkBoxWrapper, {
                        attributes: true // Observa mudanças em atributos
                    });

                    // Também é bom adicionar um listener para o próprio checkbox
                    isPessoaJuridica.addEventListener('change', toggleCNPJField);

                    function toggleOptionalField() {
                        const country = countryInput.value;
                        const containerDiv = document.getElementById("containerExistingAccountSelect");

                        toggleCNPJField()

                        if (containerDiv && optionalField) { // Verifica se ambos os elementos existem



                            const requiredFields = document.querySelectorAll("[required]");

                            requiredFields.forEach(field => {
                                if (field.offsetParent === null) { // Verifica se o campo está oculto
                                    field.removeAttribute(
                                        "required"); // Remove `required` de campos não focáveis
                                }
                            });


                            if (window.getComputedStyle(containerDiv).display !== "none") {
                                optionalField.style.setProperty("display", "none",
                                    "important"); // Define "display: none !important"
                            } else {
                                optionalField.style.display = (country === 'BR' || country === 'PT') ? "block" :
                                    "none";
                            }
                        }

                        if (country === 'BR') {
                            optionalField.style.display = "block";

                            cpfField.style.display = "block";
                            nifField.style.display = "none";
                            dobField.style.display = "block"; // Exibe a data de nascimento para o Brasil
                            isCNPJ.style.display = "block";
                        } else if (country === 'PT') {
                            optionalField.style.display = "block";

                            cpfField.style.display = "none";
                            nifField.style.display = "block"; // Exibe o NIF para Portugal
                            dobField.style.display = "none"; // Oculta a data de nascimento
                            isCNPJ.style.display = "none";

                        } else {
                            optionalField.style.display = "none";
                        }
                    }


                    // Inicializa a verificação ao carregar a página
                    toggleOptionalField();

                    // Adiciona um ouvinte de eventos para o campo de entrada
                    countryInput.addEventListener('change', toggleOptionalField);

                    // Função para atualizar a lista de países preferidos
                    function atualizarPaisFavoritos() {
                        // Países favoritos que você deseja (usando os códigos dos países)
                        const paisesFavoritos = ['br', 'us', 'mz',
                            'pt'
                        ]; // Brasil, Estados Unidos, Moçambique, Portugal

                        // Seleciona a lista de países
                        const countryList = document.querySelector('.country-list');

                        // Seleciona todos os itens de países da lista
                        const allCountries = Array.from(countryList.querySelectorAll('.country'));

                        // Remove os países antigos com a classe 'preferred'
                        allCountries.forEach(country => {
                            country.classList.remove('preferred');
                        });

                        // Filtra os países preferidos, garantindo que não existam duplicatas
                        const favoritosUnicos = allCountries.filter((countryItem, index, self) => {
                            const countryCode = countryItem.getAttribute('data-country-code');
                            return paisesFavoritos.includes(countryCode) && self.findIndex(item => item
                                .getAttribute('data-country-code') === countryCode) === index;
                        });

                        // Filtra os países restantes (não favoritos)
                        const outros = allCountries.filter(countryItem =>
                            !paisesFavoritos.includes(countryItem.getAttribute('data-country-code'))
                        );

                        // Limpa a lista e remove todos os itens (inclusive o divider)
                        countryList.innerHTML = '';

                        // Adiciona os países favoritos únicos no topo da lista
                        favoritosUnicos.forEach(favorito => {
                            favorito.classList.add(
                                'preferred'); // Marca os favoritos com a classe 'preferred'
                            countryList.appendChild(favorito); // Adiciona cada favorito no topo
                        });

                        // Adiciona o divider após os favoritos (se houver)
                        const divider = document.createElement('li');
                        divider.classList.add('divider'); // Cria o elemento 'divider'
                        countryList.appendChild(divider); // Adiciona o divider após os favoritos

                        // Adiciona os outros países após o divider
                        outros.forEach(outro => {
                            countryList.appendChild(outro); // Adiciona os países restantes
                        });
                    }

                    // Chama a função para atualizar os países favoritos
                    atualizarPaisFavoritos();
                });
            </script>




        </div>
        </form>

        {if $servedOverSsl}
            <!-- div class="alert alert-warning checkout-security-msg">
                    <i class="fas fa-lock"></i>
                    {$LANG.ordersecure} (<strong>{$ipaddress}</strong>) {$LANG.ordersecure2}
                    <div class="clearfix"></div>
                </div -->
        {/if}
    </div>
</div>
</div>
{if $isWhatsappField}
    <script>
        document.getElementById('inputCountry').addEventListener('mousedown', function(e) {
            e.preventDefault(); // Impede a interação com o select
        });
    </script>
{/if}






<script
    type="text/javascript"
    src="{$BASE_PATH_JS}/jquery.payment.js"
></script>
<script>
    var hideCvcOnCheckoutForExistingCard = '{if $canUseCreditOnCheckout && $applyCredit && ($creditBalance->toNumeric() >= $total->toNumeric())}1{else}0{/if}';
</script>
{include file="orderforms/standard_cart/recommendations-modal.tpl"}
