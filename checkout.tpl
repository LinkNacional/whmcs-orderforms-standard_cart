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

<style>
    .card {
        padding: 20px;
        border: 1px solid rgba(0, 0, 0, .125) !important;
        border-radius: .25rem !important;
        margin-bottom: 40px;
    }
</style>

<div
    id="order-standard_cart"
    style="max-width: 825px;"
>
    <div class="row">
        <!--div class="cart-sidebar">
            {include file="orderforms/standard_cart/sidebar-categories.tpl"}
        </div-->
        <div
            class="cart-body"
            style="width: unset; padd"
        >
            <div class="header-lined">
                <div class="breadcrumb-lkn">
                    <ul>
                        <li class="done">
                            <p>{$LANG.domaincheckerchoosedomain}</p>
                            <div class="hor-line"></div>
                        </li>
                        <li class="done">
                            <a href="cart.php?a=confproduct&i=0">
                                <p>{$LANG.orderconfigure}</p>
                            </a>
                            <div class="hor-line"></div>
                        </li>
                        <li class="done">
                            <a href="cart.php?a=view">
                                <p>{$LANG.cartreviewcheckout}</p>
                            </a>
                            <div class="hor-line"></div>
                        </li>
                        <li class="ativa">
                            <p>{$LANG.orderForm.checkout}</p>
                        </li>
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
                                            value="{$loginemail}"
                                        >
                                        <div style="text-align: right;">
                                            <a
                                                href="password/reset"
                                                target="_blank"
                                            >Esqueci minha senha?</a>
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
                                        <i class="fas fa-user"></i> {$LANG.domaincontactdetails['Full Name']}
                                    </label>
                                    <input
                                        id="inputFullname"
                                        type="text"
                                        name="fullName"
                                        class="field form-control"
                                        required
                                    >
                                </div>
                            </div>
                            <div style="display: none;">
                                <input
                                    type="hidden"
                                    name="firstname"
                                >
                            </div>

                            <div style="display: none;">
                                <input
                                    type="hidden"
                                    name="lastname"
                                >
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
                                        <i class="fas fa-phone"></i>
                                        {$LANG.orderForm.phoneNumber}
                                    </label>
                                    <input
                                        type="text"
                                        id="inputPhone"
                                        name="inputPhone"
                                        class="form-control"
                                        required
                                        maxlength="18"
                                    >
                                    <input
                                        style="display: none;"
                                        name="phonenumber"
                                        type="hidden"
                                    >
                                </div>

                                {$isWhatsappField}
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
                                        required
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
                                <div class="form-group has-error">
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
                                        required
                                    >
                                    <span
                                        style="color: #E30068; display: none;"
                                        class="help-block"
                                    >
                                        Código Postal não encontrado. Por favor, informe um Código Postal válido.
                                    </span>
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div>
                                    <label
                                        for="inputAddress1"
                                        class="field-icon"
                                    >
                                        <i class="far fa-building"></i> {$LANG.orderForm.streetAddress}
                                    </label>
                                    <input
                                        name="address1"
                                        id="inputAddress1"
                                        class="field form-control"
                                        required
                                    >
                                </div>
                            </div>

                            <div class="col-sm-6">
                                <div>
                                    <label
                                        for="inputNumber"
                                        class="field-icon"
                                    >
                                        <i class="fas fa-map-signs"></i> {$LANG.number}
                                    </label>
                                    <input
                                        type="text"
                                        name="stateNumber"
                                        id="inputNumber"
                                        class="field form-control"
                                        required
                                    >
                                </div>
                            </div>


                            <div class="col-sm-12">
                                <div>
                                    <label
                                        for="inputAddress2"
                                        class="field-icon"
                                    >
                                        <i class="fas fa-map-marker-alt"></i> {$LANG.neighborhood}
                                    </label>
                                    <input
                                        type="text"
                                        name="address2"
                                        id="inputAddress2"
                                        class="field form-control"
                                        required
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
                                        required
                                    >
                                </div>
                            </div>

                            <div class="col-sm-12">
                                <div>
                                    <label
                                        for="inputAddressComponent"
                                        class="field-icon"
                                    >
                                        <i class="fas fa-map-marker-alt"></i>
                                        {$LANG.orderForm.streetAddress2}
                                    </label>
                                    <input
                                        type="text"
                                        id="inputAddressComponent"
                                        name="inputAddressComponent"
                                        class="field form-control"
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
                                            value="{$clientsdetails.tax_id}"
                                        >
                                    </div>
                                </div>
                            {/if}
                        </div>
                    </div>
                    <div
                        class="card mb-4"
                        id="taxDataCard"
                    >
                        <h3 class="card-title">Dados Fiscais (Opcional)</h3>

                        <div
                            id="pt-fiscal-data-cont"
                            class="row"
                        >
                            <div
                                id="nif-pos"
                                class="col-sm-6"
                            ></div>
                        </div>

                        <div
                            id="br-fiscal-data-cont"
                            class="row"
                        >
                            <div
                                id="cpfRealPos"
                                class="col-sm-6"
                            >
                            </div>

                            {* Data de nascimento *}
                            <div
                                id="birthDatePos"
                                class="form-group col-sm-6"
                            >
                                <label>{$LANG['lkn']['Birthdate']}</label>
                                <div
                                    class="container row d-flex"
                                    style="gap: 5px;"
                                >
                                    <div>
                                        <select
                                            id="inputBirthDateDay"
                                            name="birthDateDay"
                                            class="form-control custom-select"
                                            style="max-width: max-content; cursor: pointer;"
                                        >
                                            <option value="">{$LANG['lkn']['day']}</option>
                                            {for $day=1 to 31}
                                                <option value="{$day}">{$day}</option>
                                            {/for}
                                        </select>
                                        <small class="form-text text-muted">{$LANG['lkn']['day']}</small>
                                    </div>

                                    <div>
                                        <select
                                            id="inputBirthDateMonth"
                                            name="birthDateMonth"
                                            class="form-control custom-select"
                                            style="max-width: max-content; cursor: pointer;"
                                        >
                                            <option value="">{$LANG['lkn']['month']}</option>
                                            <option value="1">{lang key='dateTime.january'}</option>
                                            <option value="2">{lang key='dateTime.february'}</option>
                                            <option value="3">{lang key='dateTime.march'}</option>
                                            <option value="4">{lang key='dateTime.april'}</option>
                                            <option value="5">{lang key='dateTime.may'}</option>
                                            <option value="6">{lang key='dateTime.june'}</option>
                                            <option value="7">{lang key='dateTime.july'}</option>
                                            <option value="8">{lang key='dateTime.august'}</option>
                                            <option value="9">{lang key='dateTime.september'}</option>
                                            <option value="10">{lang key='dateTime.october'}</option>
                                            <option value="11">{lang key='dateTime.november'}</option>
                                            <option value="12">{lang key='dateTime.december'}</option>
                                        </select>
                                        <small class="form-text text-muted">{$LANG['lkn']['month']}</small>
                                    </div>
                                    <div>
                                        <select
                                            id="inputBirthDateYear"
                                            name="birthDateYear"
                                            class="form-control custom-select"
                                            style="max-width: max-content; cursor: pointer;"
                                        >
                                            <option value="">{$LANG['lkn']['year']}</option>
                                            {for $year=$smarty.now|date_format:"%Y" - 100 to $smarty.now|date_format:"%Y"}
                                                <option value="{$year}">{$year}</option>
                                            {/for}
                                        </select>
                                        <small class="form-text text-muted">{$LANG['lkn']['year']}</small>
                                    </div>
                                </div>
                            </div>

                            <div
                                id="isLegalPersonPos"
                                class="col-sm-12"
                            >
                            </div>

                            <div
                                id="cnpjPos"
                                class="col-sm-6"
                            >
                            </div>
                        </div>

                        <div class="form-group">
                            <label>CPF</label>
                            <div class="control">
                                <input
                                    type="text"
                                    name="inputCPF"
                                    id="inputCPF"
                                    class="field form-control"
                                    maxlength="14"
                                >
                            </div>
                        </div>

                        <div class="form-group">
                            <label>NIF</label>
                            <div class="control">
                                <input
                                    type="text"
                                    name="inputNIF"
                                    id="inputNIF"
                                    class="field form-control"
                                    maxlength="9"
                                >
                            </div>
                        </div>


                        <div class="form-group">
                            <div>
                                <input
                                    type="checkbox"
                                    id="isLegalPerson"
                                    name="isLegalPerson"
                                >
                                <label
                                    for="isLegalPerson"
                                    style="margin: 0px;"
                                >É pessoa jurídica?</label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>CNPJ</label>
                            <div class="control">
                                <input
                                    type="text"
                                    id="inputCNPJ"
                                    class="field form-control"
                                    name="inputCNPJ"
                                    maxlength="18"
                                >
                            </div>
                        </div>
                    </div>
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
                                            id="inputCountry"
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
                            <div class="form-group">
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
        </div>
        </form>
    </div>
</div>
</div>

<!-- Modal -->
<div
    id="clientDetailsModal"
    class="modal fade"
    tabindex="-1"
    role="dialog"
>
    <div
        class="modal-dialog modal-sm"
        role="document"
    >
        <div
            class="modal-content"
            style="min-height: 250px;"
        >
            <div class="modal-header">
                <h5 class="modal-title"></h5>
            </div>
            <div class="modal-body">
                <p></p>
            </div>
            <div class="modal-footer">
                <button
                    type="button"
                    class="btn btn-sm btn-block btn-primary"
                    data-dismiss="modal"
                >{$LANG['lkn']['Close']}</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    const LKN_LANG = {$LANG['lkn']|@json_encode}
</script>
<script
    type="text/javascript"
    src="{$BASE_PATH_JS}/jquery.payment.js"
></script>
<script>
    var hideCvcOnCheckoutForExistingCard = '{if $canUseCreditOnCheckout && $applyCredit && ($creditBalance->toNumeric() >= $total->toNumeric())}1{else}0{/if}';
</script>
{include file="orderforms/standard_cart/recommendations-modal.tpl"}
<script
    src="templates/twenty-one-child/js/libs/vanilla-masker.min.js"
    data-autoinit="true"
></script>
<script src="templates/twenty-one-child/js/libs/intlTelInput/intlTelInput.min.js"></script>
<script src="{assetPath file='lkn-order-form-register.js'}?v={$versionHash}"></script>
