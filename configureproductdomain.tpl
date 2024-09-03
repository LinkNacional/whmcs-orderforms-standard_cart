{include file="orderforms/standard_cart/common.tpl"}
<script>
    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('image-product').onerror = function() {
            this.onerror = null; // Previne loop infinito se a imagem alternativa também não for encontrada
            this.src = '/assets/img/products/product.png';
            console.log('source:' + this.src);
        };
    });
</script>

<style>
    .sidebar-collapsed {
        display: none;
    }

    .cart-body {
        width: 100% !important;
    }

    .product-domain-info {
        margin: -20px 0 10px 0;
        padding: 6px 15px;
        font-size: .85em;
        background-color: #f8f8f8;
        border-top: 1px solid #efefef;
        /* border-bottom: 1px solid #efefef; */
        position: relative;
        overflow: hidden;
    }

    .image-product {
        width: 180px;
        float: right;
        margin-right: 0px;
    }

    .product-domain-info h1 {
        font-size: 26px;
        font-weight: 1000;
        padding-top: 20px;
    }

    .domain-selection-options {
        display: flex;
        flex-direction: row;
        flex-wrap: nowrap;
        padding: 0;
    }


    .options-container {
        display: flex;
        /* Torna o contêiner de opções flexível */
    }



    .domain-selection-options {
        display: flex;
        flex-direction: row;
        flex-wrap: nowrap;
        margin-bottom: 0;
    }



    .options-container {
        display: flex;
        /* Torna o contêiner de opções flexível */
    }

    .options-container label {
        font-size: smaller;
    }



    .domain-input-group {
        width: 100%;
        margin: 0;
        padding: 0;
        display: flex;
    }

    #order-standard_cart .domain-selection-options .option {
        margin: 0 !important;
        padding: 0 !important;
        background-color: white;
        border: none !important;
        border-top-left-radius: 5px !important;
        border-top-right-radius: 5px !important;

    }

    .option-selected {
        background-color: #F7F7F7 !important;

    }

    .input-group {
        display: flex;
        align-items: center;
    }

    #registertld {
        width: 20%;

    }
</style>

<div id="order-standard_cart">

    <div class="row">
        <!-- div class="cart-sidebar">
            {include file="orderforms/standard_cart/sidebar-categories.tpl"}
        </div -->

        <div class="cart-body">
            <div class="header-lined">
                <div class="breadcrumb-lkn">
                    <ul>
                        <li class="ativa">{$LANG.domaincheckerchoosedomain}
                            <hr />
                        </li>
                        <li>{$LANG.orderconfigure}all-none
                            <hr />
                        </li>
                        <li>{$LANG.cartreviewcheckout}
                            <hr />
                        </li>
                        <li>{$LANG.orderForm.checkout}</li>
                    </ul>
                </div>
            </div>
            <div class="row">
                <div class="secondary-cart-body-child">
                    <div class="product-domain-info">
                        <img src="/assets/img/products/{$productinfo.name}.png" class="image-product"
                            id="image-product" />
                        <h1>{$productinfo.name}</h1>
                        <h2 class="font-size-18">{$LANG.domaincheckerchoosedomain}</h2>
                    </div>
                </div>
            </div>
            {include file="orderforms/standard_cart/sidebar-categories-collapsed.tpl"}
            <form id="frmProductDomain">
                <input type="hidden" id="frmProductDomainPid" value="{$pid}" />

                <div class="domain-selection-options">
                    {if $incartdomains}
                        <div class="option">
                            <!-- Container flex para as opções -->
                            <div class="options-container d-flex align-items-center mb-2">
                                <label class="d-flex align-items-center me-3">
                                    <input type="radio" name="domainoption" value="incart" id="selincart" />
                                    {$LANG.cartproductdomainuseincart}
                                </label>
                            </div>
                            <!-- Inputs separados das opções -->
                            <div class="domain-input-group" id="domainincart">
                                <select id="incartsld" name="incartdomain" class="form-control">
                                    {foreach key=num item=incartdomain from=$incartdomains}
                                        <option value="{$incartdomain}">{$incartdomain}</option>
                                    {/foreach}
                                </select>
                                <button type="submit" class="btn btn-primary mt-2">
                                    {$LANG.orderForm.use}
                                </button>
                            </div>
                        </div>
                    {/if}

                    {if $registerdomainenabled}
                        <div class="option">
                            <div class="options-container d-flex align-items-center mb-2">
                                <label class="d-flex align-items-center me-3">
                                    <input type="radio" name="domainoption" value="register" id="selregister"
                                        {if $domainoption eq "register"} checked {/if} />
                                    {$LANG.cartregisterdomainchoice|sprintf2:$companyname}
                                </label>
                            </div>
                        </div>
                    {/if}

                    {if $transferdomainenabled}
                        <div class="option">
                            <div class="options-container d-flex align-items-center mb-2">
                                <label class="d-flex align-items-center me-3">
                                    <input type="radio" name="domainoption" value="transfer" id="seltransfer"
                                        {if $domainoption eq "transfer"} checked {/if} />
                                    {$LANG.carttransferdomainchoice|sprintf2:$companyname}
                                </label>
                            </div>
                        </div>
                    {/if}

                    {if $owndomainenabled}
                        <div class="option">
                            <div class="options-container d-flex align-items-center mb-2">
                                <label class="d-flex align-items-center me-3">
                                    <input type="radio" name="domainoption" value="owndomain" id="selowndomain"
                                        {if $domainoption eq "owndomain"} checked {/if} />
                                    {$LANG.cartexistingdomainchoice|sprintf2:$companyname}
                                </label>
                            </div>
                        </div>
                    {/if}

                    {if $subdomains}
                        <div class="option">
                            <div class="options-container d-flex align-items-center mb-2">
                                <label class="d-flex align-items-center me-3">
                                    <input type="radio" name="domainoption" value="subdomain" id="selsubdomain"
                                        {if $domainoption eq "subdomain"} checked {/if} />
                                    {$LANG.cartsubdomainchoice|sprintf2:$companyname}
                                </label>
                            </div>
                            <div class="domain-input-group" id="domainsubdomain">
                                <div class="input-group mb-2">
                                    <span class="input-group-text">http://</span>
                                    <input type="text" id="subdomainsld" value="{$sld}" placeholder="yourname"
                                        class="form-control" autocapitalize="none" data-toggle="tooltip"
                                        data-placement="top" data-trigger="manual"
                                        title="{lang key='orderForm.enterDomain'}" />
                                </div>

                                <button type="submit" class="btn btn-primary">
                                    {$LANG.orderForm.check}
                                </button>
                            </div>
                        </div>
                    {/if}
                </div>



                <div class="domain-input-group" id="domainregister">
                    <div class="input-group input-group-lg input-group-box">
                        <span class="input-group-text">{$LANG.orderForm.www}</span>
                        <input type="text" id="registersld" value="{$sld}" class="form-control" autocapitalize="none"
                            data-toggle="tooltip" data-placement="top" data-trigger="manual"
                            title="{lang key='orderForm.enterDomain'}" />
                    </div>

                    <button type="submit" class="btn btn-primary">
                        {$LANG.orderForm.check}
                    </button>
                </div>

                <div class="domain-input-group" id="domainowndomain">
                    <div class="input-group mb-2">
                        <span class="input-group-text">{$LANG.orderForm.www}</span>
                        <input type="text" id="owndomainsld" value="{$sld}"
                            placeholder="{lang key='yourdomainplaceholder'}" class="form-control" autocapitalize="none"
                            data-toggle="tooltip" data-placement="top" data-trigger="manual"
                            title="{lang key='orderForm.enterDomain'}" />
                    </div>
                    <input type="text" id="owndomaintld" value="{$tld|substr:1}"
                        placeholder="{$LANG.yourtldplaceholder}" class="form-control mb-2" autocapitalize="none"
                        data-toggle="tooltip" data-placement="top" data-trigger="manual"
                        title="{lang key='orderForm.required'}" />
                    <button type="submit" class="btn btn-primary">
                        {$LANG.orderForm.use}
                    </button>
                </div>

                <div class="domain-input-group" id="domaintransfer">
                    <div class="input-group mb-2">
                        <span class="input-group-text">{$LANG.orderForm.www}</span>
                        <input type="text" id="transfersld" value="{$sld}" class="form-control" autocapitalize="none"
                            data-toggle="tooltip" data-placement="top" data-trigger="manual"
                            title="{lang key='orderForm.enterDomain'}" />
                    </div>

                    <button type="submit" class="btn btn-primary">
                        {$LANG.orderForm.transfer}
                    </button>
                </div>

                {if $freedomaintlds}
                    <p>* <em>{$LANG.orderfreedomainregistration} {$LANG.orderfreedomainappliesto}: {$freedomaintlds}</em>
                    </p>
                {/if}
            </form>





            <div class="clearfix"></div>
            <form method="post" action="{$WEB_ROOT}/cart.php?a=add&pid={$pid}&domainselect=1"
                id="frmProductDomainSelections">

                <div id="DomainSearchResults" class="w-hidden">

                    <div id="searchDomainInfo">
                        <p id="primaryLookupSearching"
                            class="domain-lookup-loader domain-lookup-primary-loader domain-searching domain-checker-result-headline">
                            <i class="fas fa-spinner fa-spin"></i>
                            <span
                                class="domain-lookup-register-loader">{lang key='orderForm.checkingAvailability'}...</span>
                            <span
                                class="domain-lookup-transfer-loader">{lang key='orderForm.verifyingTransferEligibility'}...</span>
                            <span class="domain-lookup-other-loader">{lang key='orderForm.verifyingDomain'}...</span>
                        </p>
                        <div id="primaryLookupResult"
                            class="domain-lookup-result domain-lookup-primary-results w-hidden">
                            <div class="domain-unavailable domain-checker-unavailable headline">
                                {lang key='orderForm.domainIsUnavailable'}</div>
                            <div class="domain-available domain-checker-available headline" style="color: #0C71C3;">
                                {$LANG.domainavailablemessage}</div>
                            <div class="btn btn-primary domain-contact-support headline">{$LANG.domainContactUs}</div>
                            <div class="transfer-eligible">
                                <p class="domain-checker-available headline">{lang key='orderForm.transferEligible'}</p>
                                <p>{lang key='orderForm.transferUnlockBeforeContinuing'}</p>
                            </div>
                            <div class="transfer-not-eligible">
                                <p class="domain-checker-unavailable headline">
                                    {lang key='orderForm.transferNotEligible'}</p>
                                <p>{lang key='orderForm.transferNotRegistered'}</p>
                                <p>{lang key='orderForm.trasnferRecentlyRegistered'}</p>
                                <p>{lang key='orderForm.transferAlternativelyRegister'}</p>
                            </div>
                            <div class="domain-invalid">
                                <p class="domain-checker-unavailable headline">{lang key='orderForm.domainInvalid'}</p>
                                <p>
                                    {lang key='orderForm.domainLetterOrNumber'}<span
                                        class="domain-length-restrictions">{lang key='orderForm.domainLengthRequirements'}</span><br />
                                    {lang key='orderForm.domainInvalidCheckEntry'}
                                </p>
                            </div>
                            <div class="domain-tld-unavailable">
                                <p class="domain-checker-unavailable headline">{lang key='orderForm.domainNotSupported'}
                                </p>
                            </div>
                            <div id="idnLanguageSelector" class="margin-10 idn-language-selector idn-language w-hidden">
                                <div class="row">
                                    <div
                                        class="col-sm-10 col-sm-offset-1 col-lg-8 col-lg-offset-2 offset-sm-1 offset-lg-2">
                                        <div class="margin-10 text-center">
                                            {lang key='cart.idnLanguageDescription'}
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div
                                        class="col-sm-8 col-lg-6 col-sm-offset-2 col-lg-offset-3 offset-sm-2 offset-lg-3">
                                        <div class="form-group">
                                            <select name="idnlanguage" class="form-control">
                                                <option value="">{lang key='cart.idnLanguage'}</option>
                                                {foreach $idnLanguages as $idnLanguageKey => $idnLanguage}
                                                    <option value="{$idnLanguageKey}">
                                                        {lang key='idnLanguage.'|cat:$idnLanguageKey}</option>
                                                {/foreach}
                                            </select>
                                            <div class="field-error-msg">
                                                {lang key='cart.selectIdnLanguageForRegister'}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="domain-price">
                                <span
                                    class="register-price-label">{lang key='orderForm.domainPriceRegisterLabel'}</span>
                                <span
                                    class="transfer-price-label w-hidden">{lang key='orderForm.domainPriceTransferLabel'}</span>
                                <span class="price"></span>
                            </div>
                            <p class="domain-error domain-checker-unavailable headline"></p>
                            <input type="hidden" id="resultDomainOption" name="domainoption" />
                            <input type="hidden" id="resultDomain" name="domains[]" />
                            <input type="hidden" id="resultDomainPricingTerm" />
                        </div>
                        <div class="text-center">
                            <button id="btnDomainContinue" type="submit" class="btn btn-primary btn-lg w-hidden fixed"
                                disabled="disabled"
                                style="background-color:#DAE300;border:none;color:#343B45;width:100%;"> {$LANG.continue}
                                &nbsp;<i class="fas fa-arrow-circle-right"></i>
                            </button>
                        </div>
                    </div>

                    {if $registerdomainenabled}
                        {if $spotlightTlds}
                            <div id="spotlightTlds" class="spotlight-tlds clearfix w-hidden">
                                <div class="spotlight-tlds-container">
                                    {foreach $spotlightTlds as $key => $data}
                                        <div class="spotlight-tld-container spotlight-tld-container-{$spotlightTlds|count}">
                                            <div id="spotlight{$data.tldNoDots}" class="spotlight-tld">
                                                {if $data.group}
                                                    <div class="spotlight-tld-{$data.group}">{$data.groupDisplayName}</div>
                                                {/if}
                                                {$data.tld}
                                                <span class="domain-lookup-loader domain-lookup-spotlight-loader">
                                                    <i class="fas fa-spinner fa-spin"></i>
                                                </span>
                                                <div class="domain-lookup-result">
                                                    <button type="button" class="btn unavailable w-hidden" disabled="disabled">
                                                        {lang key='domainunavailable'}
                                                    </button>
                                                    <button type="button" class="btn invalid w-hidden" disabled="disabled">
                                                        {lang key='domainunavailable'}
                                                    </button>
                                                    <span class="available price w-hidden">{$data.register}</span>
                                                    <button type="button" class="btn btn-add-to-cart product-domain w-hidden"
                                                        data-whois="0" data-domain="">
                                                        <span class="to-add">{lang key='orderForm.add'}</span>
                                                        <span class="loading">
                                                            <i class="fas fa-spinner fa-spin"></i> {lang key='loading'}
                                                        </span>
                                                        <span class="added"><i class="far fa-shopping-cart"></i>
                                                            {lang key='domaincheckeradded'}</span>
                                                        <span class="unavailable">{$LANG.domaincheckertaken}</span>
                                                    </button>
                                                    <button type="button" class="btn btn-primary domain-contact-support w-hidden">
                                                        {lang key='domainChecker.contactSupport'}
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    {/foreach}
                                </div>
                            </div>
                        {/if}

                        <div class="suggested-domains w-hidden">
                            <div class="panel-heading card-header">
                                {lang key='orderForm.suggestedDomains'}
                            </div>
                            <div id="suggestionsLoader"
                                class="card-body panel-body domain-lookup-loader domain-lookup-suggestions-loader">
                                <i class="fas fa-spinner fa-spin"></i> {lang key='orderForm.generatingSuggestions'}
                            </div>
                            <div id="domainSuggestions" class="domain-lookup-result list-group w-hidden">
                                <div class="domain-suggestion list-group-item w-hidden">
                                    <button type="button" class="btn btn-add-to-cart product-domain btn-add-to-cart-mobile"
                                        data-whois="1" data-domain="">
                                        <span class="to-add"><i class="fa fa-plus" aria-hidden="true"></i></span>
                                        <span class="loading">
                                            <i class="fas fa-spinner fa-spin"></i> {lang key='loading'}
                                        </span>
                                        <span class="added">{lang key='domaincheckeradded'}</span>
                                        <span class="unavailable">{$LANG.domaincheckertaken}</span>
                                    </button>
                                    <span class="domain"></span><span class="extension"></span>
                                    <div class="actions">
                                        <span class="price"></span>
                                        <span class="promo w-hidden"></span>
                                        <button type="button" class="btn btn-add-to-cart product-domain" data-whois="1"
                                            data-domain="" style="border-color: #fff;background-color: #f6f6f6;">
                                            <span class="to-add">{$LANG.addtocart}</span>
                                            <span class="loading">
                                                <i class="fas fa-spinner fa-spin"></i> {lang key='loading'}
                                            </span>
                                            <span class="added">{lang key='domaincheckeradded'}</span>
                                            <span class="unavailable">{$LANG.domaincheckertaken}</span>
                                        </button>
                                        <button type="button"
                                            class="btn btn-primary domain-contact-support w-hidden">{lang key='domainChecker.contactSupport'}</button>

                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer card-footer more-suggestions text-center w-hidden">
                                <a id="moreSuggestions" href="#"
                                    onclick="loadMoreSuggestions();return false;">{lang key='domainsmoresuggestions'}</a>
                                <span id="noMoreSuggestions"
                                    class="no-more small w-hidden">{lang key='domaincheckernomoresuggestions'}</span>
                            </div>
                            <div class="text-center text-muted domain-suggestions-warning">
                                <p>{lang key='domainssuggestionswarnings'}</p>
                            </div>
                        </div>
                    {/if}
                </div>

                <!-- div class="text-center">
                    <button id="btnDomainContinue" type="submit" class="btn btn-primary btn-lg w-hidden" disabled="disabled" style="background-color:#DAE300;border:none;color:#343B45;width:100%;">
                        {$LANG.continue}
                        &nbsp;<i class="fas fa-arrow-circle-right"></i>
                    </button>
                </div -->
            </form>
        </div>
    </div>
</div>

{include file="orderforms/standard_cart/recommendations-modal.tpl"}

<script>
    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('frmProductDomain').addEventListener('submit', function(event) {
            // Rolagem até o elemento do formulário
            document.getElementById('frmProductDomain').scrollIntoView({
                behavior: 'smooth' // Isso fará com que o scroll seja suave
            });
        });
    });
</script>