{include file="orderforms/standard_cart/common.tpl"}
<script>
    var _localLang = {
        'addToCart': '{$LANG.orderForm.addToCart|escape}',
        'addedToCartRemove': '{$LANG.orderForm.addedToCartRemove|escape}'
    }
</script>
<style>
    .sidebar-collapsed,
    .form-inline.ml-auto,
    .navbar.navbar-expand-xl.main-navbar-wrapper {
        display: none;
    }

    .domains-lista {
        width: 45%;
        display: inline-grid;
        border: 1px solid #e7e7e7;
        background-color: #f8f8f8;
        margin: 10px;
        padding: 7px 35px 13px 35px;
    }

    .row.addon-products {
        margin-top: 20px;
    }

    #order-standard_cart .panel-addon .panel-body label {
        font-size: 1.4em !important;
    }

    #order-standard_cart .panel-addon {
        text-align: left !important;
    }

    #order-standard_cart .panel-addon .panel-price {
        background-color: unset !important;
    }

    .panel-price {
        font-weight: bolder !important;
    }

    .addonlista {
        padding: 15px;
        border: 1px solid #f8f8f8;
    }

    .addonlista:hover {
        background-color: #fff !important;
        border: 1px solid #efefef;
    }

    @media only screen and (max-width: 961px) {
        .domains-lista {
            width: 98%;
        }
    }
</style>

<div id="order-standard_cart">

    <div class="row">
        <!-- div class="cart-sidebar">
            {include file="orderforms/standard_cart/sidebar-categories.tpl"}
        </div -->
        <div class="cart-body" style="width:100%;">
            <div class="header-lined">
                <!--h1 class="font-size-36">{$LANG.orderconfigure}</h1-->
                <div class="breadcrumb-lkn">
                    <ul>
                        <li class="done">{$LANG.domaincheckerchoosedomain}
                            <hr />
                        </li />
                        <li class="ativa">{$LANG.orderconfigure}
                            <hr />
                        </li>
                        <li>{$LANG.cartreviewcheckout}
                            <hr />
                        </li>
                        <li>{$LANG.orderForm.checkout}</li>
                    </ul>
                </div>
            </div>
            <div class="header-lined">
                <h1 class="font-size-36">{$LANG.cartdomainsconfig}</h1>
            </div>
            {include file="orderforms/standard_cart/sidebar-categories-collapsed.tpl"}

            <form method="post" action="{$smarty.server.PHP_SELF}?a=confdomains" id="frmConfigureDomains">
                <input type="hidden" name="update" value="true" />

                <p>{$LANG.orderForm.reviewDomainAndAddons}</p>

                {if $errormessage}
                    <div class="alert alert-danger" role="alert">
                        <p>{$LANG.orderForm.correctErrors}:</p>
                        <ul>
                            {$errormessage}
                        </ul>
                    </div>
                {/if}

                {foreach $domains as $num => $domain}
                    <div class="domains-lista">
                        <div style="border-bottom: 1px solid #e7e7e7;margin: 10px 0 20px 0;font-size: 1.4em;">
                            <span>{$domain.domain}</span>
                        </div>

                        <div>

                            {$LANG.orderregperiod} {$domain.regperiod} {$LANG.orderyears} <br />


                            <!-- {$LANG.hosting}
                                {if $domain.hosting}<span style="color:#009900;">{$LANG.cartdomainshashosting}</span>{else}<br /><a href="{$WEB_ROOT}/cart.php" style="color: #0C71C3;">{$LANG.cartdomainsnohosting}</a>{/if} -->

                            {if $domain.eppenabled}
                                <div class="col-sm-12" style="margin-top:10px;">
                                    <div class="form-group prepend-icon">
                                        <input type="text" name="epp[{$num}]" id="inputEppcode{$num}" value="{$domain.eppvalue}"
                                            class="field" placeholder="{$LANG.domaineppcode}" />
                                        <label for="inputEppcode{$num}" class="field-icon">
                                            <i class="fas fa-lock"></i>
                                        </label>
                                        <span class="field-help-text">
                                            {$LANG.domaineppcodedesc}
                                        </span>
                                    </div>
                                </div>
                            {/if}
                        </div>

                        {if $domain.dnsmanagement || $domain.emailforwarding || $domain.idprotection}
                            <div class="row addon-products">

                                {if $domain.dnsmanagement}
                                    <!-- div class="col-sm-{math equation="12 / numAddons" numAddons=$domain.addonsCount} mb-3" -->
                                    <div class="addonlista">
                                        <div
                                            class="panel panel-default panel-addon{if $domain.dnsmanagementselected} panel-addon-selected{/if}">
                                            <div class="panel-body">
                                                <label>
                                                    <input type="checkbox" name="dnsmanagement[{$num}]"
                                                        {if $domain.dnsmanagementselected} checked{/if} />
                                                    {$LANG.domaindnsmanagement}
                                                </label><br />
                                                {$LANG.domainaddonsdnsmanagementinfo}
                                            </div>
                                            <div class="panel-price">
                                                {$domain.dnsmanagementprice} / {$domain.regperiod} {$LANG.orderyears}
                                            </div>
                                            <!-- div class="panel-add">
                                            <i class="fas fa-plus"></i>
                                            {$LANG.orderForm.addToCart}
                                        </div -->
                                        </div>
                                    </div>
                                {/if}

                                {if $domain.idprotection}
                                    <!-- div class="col-sm-{math equation="12 / numAddons" numAddons=$domain.addonsCount} mb-3" -->
                                    <div class="addonlista">
                                        <div
                                            class="panel panel-default panel-addon{if $domain.idprotectionselected} panel-addon-selected{/if}">
                                            <div class="panel-body">
                                                <label>
                                                    <input type="checkbox" name="idprotection[{$num}]"
                                                        {if $domain.idprotectionselected} checked{/if} />
                                                    {$LANG.domainidprotection}
                                                </label><br />
                                                {$LANG.domainaddonsidprotectioninfo}
                                            </div>
                                            <div class="panel-price">
                                                {$domain.idprotectionprice} / {$domain.regperiod} {$LANG.orderyears}
                                            </div>
                                            <!-- div class="panel-add">
                                            <i class="fas fa-plus"></i>
                                            {$LANG.orderForm.addToCart}
                                        </div -->
                                        </div>
                                    </div>
                                {/if}

                                {if $domain.emailforwarding}
                                    <!-- div class="col-sm-{math equation="12 / numAddons" numAddons=$domain.addonsCount} mb-3" -->
                                    <div class="addonlista">
                                        <div
                                            class="panel panel-default panel-addon{if $domain.emailforwardingselected} panel-addon-selected{/if}">
                                            <div class="panel-body">
                                                <label>
                                                    <input type="checkbox" name="emailforwarding[{$num}]"
                                                        {if $domain.emailforwardingselected} checked{/if} />
                                                    {$LANG.domainemailforwarding}
                                                </label><br />
                                                {$LANG.domainaddonsemailforwardinginfo}
                                            </div>
                                            <div class="panel-price">
                                                {$domain.emailforwardingprice} / {$domain.regperiod} {$LANG.orderyears}
                                            </div>
                                            <!-- div class="panel-add">
                                            <i class="fas fa-plus"></i>
                                            {$LANG.orderForm.addToCart}
                                        </div -->
                                        </div>
                                    </div>
                                {/if}

                            </div>
                        {/if}
                        {foreach from=$domain.fields key=domainfieldname item=domainfield}
                            <div class="" style="margin-top:15px;">
                                <div>{$domainfieldname}:
                                    <span class="field-help-text">{$domainfield}</span>
                                </div>
                            </div>
                        {/foreach}
                    </div>

                {/foreach}

                {if $atleastonenohosting}
                    <!-- div class="domains-nameserver">
                        <div class="sub-heading">
                            <span class="primary-bg-color">{$LANG.domainnameservers}</span>
                        </div>

                        <p>{$LANG.cartnameserversdesc}</p>

                        <div class="row">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label for="inputNs1">{$LANG.domainnameserver1}</label>
                                    <input type="text" class="form-control" id="inputNs1" name="domainns1" value="{$domainns1}" />
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label for="inputNs2">{$LANG.domainnameserver2}</label>
                                    <input type="text" class="form-control" id="inputNs2" name="domainns2" value="{$domainns2}" />
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label for="inputNs3">{$LANG.domainnameserver3}</label>
                                    <input type="text" class="form-control" id="inputNs3" name="domainns3" value="{$domainns3}" />
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label for="inputNs1">{$LANG.domainnameserver4}</label>
                                    <input type="text" class="form-control" id="inputNs4" name="domainns4" value="{$domainns4}" />
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label for="inputNs5">{$LANG.domainnameserver5}</label>
                                    <input type="text" class="form-control" id="inputNs5" name="domainns5" value="{$domainns5}" />
                                </div>
                            </div>
                        </div>
                    </div -->
                {/if}

                <div class="text-center pt-4">
                    <button type="submit" class="btn btn-primary btn-lg"
                        style="background-color:#DAE300;border:none;color:#343B45;width:100%;">
                        {$LANG.continue}
                        &nbsp;<i class="fas fa-arrow-circle-right"></i>
                    </button>
                </div>

            </form>
        </div>
    </div>
</div>

{include file="orderforms/standard_cart/recommendations-modal.tpl"}