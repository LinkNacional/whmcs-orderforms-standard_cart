{include file="orderforms/standard_cart/common.tpl"}

<script>
var _localLang = {
    'addToCart': '{$LANG.orderForm.addToCart|escape}',
    'addedToCartRemove': '{$LANG.orderForm.addedToCartRemove|escape}'
}

document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('image-product').onerror = function() {
        this.onerror = null; // Previne loop infinito se a imagem alternativa também não for encontrada
        this.src = 'assets/img/products/product.png';
        console.log('source:'+this.src);
    };
});
</script>
<style>
.cart-body{ width:100% !important; }
.sidebar-collapsed{ display:none; }
.navbar.navbar-expand-xl.main-navbar-wrapper,form.form-inline.ml-auto{ display:none; }

.order-summary { background-color: #fff;border-bottom: 0; }
#order-standard_cart .order-summary{ font-size: 1.2em; background-color: #fff; border-bottom: 0; border-radius: 0; }
#order-standard_cart .order-summary h2 {
    color:#121519;
    border-left: 2px solid #dae300;
    padding-left: 15px;
    margin: 20px 15px 15px 0px;
    font-weight: 100; 
    font-size: 17px;
    text-align: left;
    }
.summary-container { background-color: #ffffff !important;boder-radius:0 !important;border:solid 1px #f8f8f8 !important;}

#order-standard_cart .field-container { margin: auto 0; }
#order-standard_cart .secondary-cart-body-child {
    width: 100%;
    position: relative;
    min-height: 1px;
    padding-right: 15px;
    padding-left: 15px;
}
#order-standard_cart .panel-addon .panel-body label {
    font-size: 1.5em;
}
#order-standard_cart .product-description{
    font-size: 12px;
}
#order-standard_cart label { font-weight: bold; font-size: 15px; }
.icheckbox_square-blue{ display:none;}

#order-standard_cart .panel-addon .panel-price {
width:60%;
}
#order-standard_cart .panel-addon .panel-add {
width:40%;
margin-top: -25px;
margin-left: auto;
border-radius:0;
background-color:#f7f7f7;
color:#121519;
}
#order-standard_cart .panel-addon-selected .panel-add{
    background-color:#538b8c !important;
    color:#fff;
}
#order-standard_cart .panel-addon:hover { background-color:#f4f4f4;}
#order-standard_cart .panel-addon-selected { border: 1px solid #538b8c !important; }
#order-standard_cart .panel-addon{ background-color:#f7f7f7; border: 1px solid rgba(0, 0, 0, .03);}
.image-product{
    width:380px;
    margin-right:50px;
}
#productAddonsContainer h5{ border-left: 2px solid #dae300;
    padding-left: 15px;
    margin: 20px 15px 15px 0px;
    font-weight: 100;}

#order-standard_cart .secondary-cart-sidebar { padding-top:17px;}
#btnCompleteProductConfig { width:100%; background-color: #DAE300;border: 0;color: #343B45;}
.breadcrumb-lkn { width:100%; background-color:#f7f7f7; padding: 20px 0 15px 0px; border: 1px solid #f6f6f6; margin-bottom: 20px; }


.breadcrumb-lkn ul { width:90%; /*list-style-type: none;*/ margin: auto; }
.breadcrumb-lkn ul li { color: #dfdfdf; display: flex; /* margin-right: 10px; list-style-image: url('icone.png'); */ font-size: 15px; font-weight: 400; }

.breadcrumb-lkn ul li.ativa::before {
    content: '';
    display: block;
    width: 25px; /* Diâmetro do círculo */
    height: 25px; /* Diâmetro do círculo */
    border-radius: 50%; /* Faz com que o elemento seja um círculo */
    background-color:#f4f4f4;
    border: 5px solid #DAE300; /* Cor da borda */
    margin-right: 20px; /* Espaçamento entre o círculo e o texto */
}
.ativa, .done { color: #121519 !important; }

.breadcrumb-lkn ul li.done::before {
    content: '';
    display: block;
    width: 25px; /* Diâmetro do círculo */
    height: 25px; /* Diâmetro do círculo */
    border-radius: 50%; /* Faz com que o elemento seja um círculo */
    border: 5px solid #DAE300; /* Cor da borda */
    background-color: #DAE300;
    margin-right: 20px; /* Espaçamento entre o círculo e o texto */
}
.breadcrumb-lkn ul li::before {
    content: '';
    display: block;
    width: 25px; /* Diâmetro do círculo */
    height: 25px; /* Diâmetro do círculo */
    border-radius: 50%; /* Faz com que o elemento seja um círculo */
    border: 5px solid #dfdfdf; /* Cor da borda */
    background-color: #dfdfdf;
    margin-right: 20px; /* Espaçamento entre o círculo e o texto */
}


/* Estilos adicionais para a borda circular 
.breadcrumb-lkn ul li:last-child::before {
    border-color: #DAE300; /* Cor da borda do último círculo */
}*/
@media (max-width: 1023px) {
.breadcrumb-lkn ul { display: none;}
}
@media (min-width: 1024px) {
#order-standard_cart .product-info { display:flex !important;}
.breadcrumb-lkn ul { display: flex !important;}
.breadcrumb-lkn hr{ width: 90px;margin: 13px 0 0 15px;}
.breadcrumb-lkn hr{ width: 90px; margin: 13px 0 0 15px; }
}


</style>
<div id="order-standard_cart">
    <div class="row">
        <!--div class="cart-sidebar">
            {include file="orderforms/standard_cart/sidebar-categories.tpl"}
        </div-->
        <div class="cart-body">

            <div class="header-lined">
                <!--h1 class="font-size-36">{$LANG.orderconfigure}</h1-->
                <div class="breadcrumb-lkn"> <ul><li class="done">Escolher o domínio <hr /></li/><li class="ativa">Adicionais <hr /></li><li>Revisar pedido <hr /></li><li>Pagamento</li></ul></div>
            </div>

            {include file="orderforms/standard_cart/sidebar-categories-collapsed.tpl"}

            <form id="frmConfigureProduct">
                <input type="hidden" name="configure" value="true" />
                <input type="hidden" name="i" value="{$i}" />

                <!-- MOVE TO HERE -->
                <div class="row">
                    <div class="secondary-cart-body-child">
                        <!--p>{$LANG.orderForm.configureDesiredOptions}</p-->

                        <div class="product-info">
                            <img src="assets/img/products/{$productinfo.name}.png" class="image-product" id="image-product" />
                            <!-- p class="product-title">{$productinfo.name}</p>
                            <p>{$productinfo.description}</p -->
                            {if $pricing.type eq "recurring"}
                            <div class="field-container">
                                <div class="form-group">
                                    <label for="inputBillingcycle">{$LANG.cartchoosecycle}</label>
                                    <br>
                                    <select name="billingcycle" id="inputBillingcycle" class="form-control select-inline custom-select" onchange="updateConfigurableOptions({$i}, this.value); return false">
                                        {if $pricing.monthly}
                                            <option value="monthly"{if $billingcycle eq "monthly"} selected{/if}>
                                                {$pricing.monthly}
                                            </option>
                                        {/if}
                                        {if $pricing.quarterly}
                                            <option value="quarterly"{if $billingcycle eq "quarterly"} selected{/if}>
                                                {$pricing.quarterly}
                                            </option>
                                        {/if}
                                        {if $pricing.semiannually}
                                            <option value="semiannually"{if $billingcycle eq "semiannually"} selected{/if}>
                                                {$pricing.semiannually}
                                            </option>
                                        {/if}
                                        {if $pricing.annually}
                                            <option value="annually"{if $billingcycle eq "annually"} selected{/if}>
                                                {$pricing.annually}
                                            </option>
                                        {/if}
                                        {if $pricing.biennially}
                                            <option value="biennially"{if $billingcycle eq "biennially"} selected{/if}>
                                                {$pricing.biennially}
                                            </option>
                                        {/if}
                                        {if $pricing.triennially}
                                            <option value="triennially"{if $billingcycle eq "triennially"} selected{/if}>
                                                {$pricing.triennially}
                                            </option>
                                        {/if}
                                    </select>
                                </div>
                            </div>
                        {/if}
                        </div>

                        <div class="alert alert-danger w-hidden" role="alert" id="containerProductValidationErrors">
                            <p>{$LANG.orderForm.correctErrors}:</p>
                            <ul id="containerProductValidationErrorsList"></ul>
                        </div>

                    </div>
                </div><!-- MOVE TO HERE END -->
                
                
                <div class="row">
                    <div class="secondary-cart-body">

                        <!-- REMOVE FROM HERE -->
                        {if count($metrics) > 0}
                                <div class="sub-heading">
                                    <span class="primary-bg-color">{$LANG.metrics.title}</span>
                                </div>

                                <p>{$LANG.metrics.explanation}</p>

                                <ul>
                                    {foreach $metrics as $metric}
                                        <li>
                                            {$metric.displayName}
                                            -
                                            {if count($metric.pricing) > 1}
                                                {$LANG.metrics.startingFrom} {$metric.lowestPrice} / {if $metric.unitName}{$metric.unitName}{else}{$LANG.metrics.unit}{/if}
                                                <button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#modalMetricPricing-{$metric.systemName}">
                                                    {$LANG.metrics.viewPricing}
                                                </button>
                                            {elseif count($metric.pricing) == 1}
                                                {$metric.lowestPrice} / {if $metric.unitName}{$metric.unitName}{else}{$LANG.metrics.unit}{/if}
                                                {if $metric.includedQuantity > 0} ({$metric.includedQuantity} {$LANG.metrics.includedNotCounted}){/if}
                                            {/if}
                                            {include file="$template/usagebillingpricing.tpl"}
                                        </li>
                                    {/foreach}
                                </ul>

                                <br>
                            {/if}

                            {if $productinfo.type eq "server"}
                                <div class="sub-heading">
                                    <span class="primary-bg-color">{$LANG.cartconfigserver}</span>
                                </div>

                                <div class="field-container">

                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputHostname">{$LANG.serverhostname}</label>
                                                <input type="text" name="hostname" class="form-control" id="inputHostname" value="{$server.hostname}" placeholder="servername.example.com">
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputRootpw">{$LANG.serverrootpw}</label>
                                                <input type="password" name="rootpw" class="form-control" id="inputRootpw" value="{$server.rootpw}">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputNs1prefix">{$LANG.serverns1prefix}</label>
                                                <input type="text" name="ns1prefix" class="form-control" id="inputNs1prefix" value="{$server.ns1prefix}" placeholder="ns1">
                                            </div>
                                        </div>
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputNs2prefix">{$LANG.serverns2prefix}</label>
                                                <input type="text" name="ns2prefix" class="form-control" id="inputNs2prefix" value="{$server.ns2prefix}" placeholder="ns2">
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            {/if}

                            {if $configurableoptions}
                                <div class="sub-heading">
                                    <span class="primary-bg-color">{$LANG.orderconfigpackage}</span>
                                </div>
                                <div class="product-configurable-options" id="productConfigurableOptions">
                                    <div class="row">
                                        {foreach $configurableoptions as $num => $configoption}
                                        {if $configoption.optiontype eq 1}
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label for="inputConfigOption{$configoption.id}">{$configoption.optionname}</label>
                                                    <select name="configoption[{$configoption.id}]" id="inputConfigOption{$configoption.id}" class="form-control">
                                                        {foreach key=num2 item=options from=$configoption.options}
                                                            <option value="{$options.id}"{if $configoption.selectedvalue eq $options.id} selected="selected"{/if}>
                                                                {$options.name}
                                                            </option>
                                                        {/foreach}
                                                    </select>
                                                </div>
                                            </div>
                                        {elseif $configoption.optiontype eq 2}
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label for="inputConfigOption{$configoption.id}">{$configoption.optionname}</label>
                                                    {foreach key=num2 item=options from=$configoption.options}
                                                        <br />
                                                        <label>
                                                            <input type="radio" name="configoption[{$configoption.id}]" value="{$options.id}"{if $configoption.selectedvalue eq $options.id} checked="checked"{/if} />
                                                            {if $options.name}
                                                                {$options.name}
                                                            {else}
                                                                {$LANG.enable}
                                                            {/if}
                                                        </label>
                                                    {/foreach}
                                                </div>
                                            </div>
                                        {elseif $configoption.optiontype eq 3}
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label for="inputConfigOption{$configoption.id}">{$configoption.optionname}</label>
                                                    <br />
                                                    <label>
                                                        <input type="checkbox" name="configoption[{$configoption.id}]" id="inputConfigOption{$configoption.id}" value="1"{if $configoption.selectedqty} checked{/if} />
                                                        {if $configoption.options.0.name}
                                                            {$configoption.options.0.name}
                                                        {else}
                                                            {$LANG.enable}
                                                        {/if}
                                                    </label>
                                                </div>
                                            </div>
                                        {elseif $configoption.optiontype eq 4}
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <label for="inputConfigOption{$configoption.id}">{$configoption.optionname}</label>
                                                    {if $configoption.qtymaximum}
                                                    {if !$rangesliderincluded}
                                                        <script type="text/javascript" src="{$BASE_PATH_JS}/ion.rangeSlider.min.js"></script>
                                                    <link href="{$BASE_PATH_CSS}/ion.rangeSlider.css" rel="stylesheet">
                                                    <link href="{$BASE_PATH_CSS}/ion.rangeSlider.skinModern.css" rel="stylesheet">
                                                        {assign var='rangesliderincluded' value=true}
                                                    {/if}
                                                        <input type="text" name="configoption[{$configoption.id}]" value="{if $configoption.selectedqty}{$configoption.selectedqty}{else}{$configoption.qtyminimum}{/if}" id="inputConfigOption{$configoption.id}" class="form-control" />
                                                        <script>
                                                            var sliderTimeoutId = null;
                                                            var sliderRangeDifference = {$configoption.qtymaximum} - {$configoption.qtyminimum};
                                                            // The largest size that looks nice on most screens.
                                                            var sliderStepThreshold = 25;
                                                            // Check if there are too many to display individually.
                                                            var setLargerMarkers = sliderRangeDifference > sliderStepThreshold;

                                                            jQuery("#inputConfigOption{$configoption.id}").ionRangeSlider({
                                                                min: {$configoption.qtyminimum},
                                                                max: {$configoption.qtymaximum},
                                                                grid: true,
                                                                grid_snap: setLargerMarkers ? false : true,
                                                                onChange: function() {
                                                                    if (sliderTimeoutId) {
                                                                        clearTimeout(sliderTimeoutId);
                                                                    }

                                                                    sliderTimeoutId = setTimeout(function() {
                                                                        sliderTimeoutId = null;
                                                                        recalctotals();
                                                                    }, 250);
                                                                }
                                                            });
                                                        </script>
                                                    {else}
                                                        <div>
                                                            <input type="number" name="configoption[{$configoption.id}]" value="{if $configoption.selectedqty}{$configoption.selectedqty}{else}{$configoption.qtyminimum}{/if}" id="inputConfigOption{$configoption.id}" min="{$configoption.qtyminimum}" onchange="recalctotals()" onkeyup="recalctotals()" class="form-control form-control-qty" />
                                                            <span class="form-control-static form-control-static-inline">
                                                                    x {$configoption.options.0.name}
                                                                </span>
                                                        </div>
                                                    {/if}
                                                </div>
                                            </div>
                                        {/if}
                                        {if $num % 2 != 0}
                                    </div>
                                    <div class="row">
                                        {/if}
                                        {/foreach}
                                    </div>
                                </div>

                            {/if}

                            {if $customfields}

                                <div class="sub-heading pb-1">
                                    <span class="primary-bg-color">{$LANG.orderadditionalrequiredinfo}<br><i><small>{lang key='orderForm.requiredField'}</small></i></span>
                                </div>

                                <div class="field-container">
                                    {foreach $customfields as $customfield}
                                        <div class="form-group">
                                            <label for="customfield{$customfield.id}">{$customfield.name} {$customfield.required}</label>
                                            {$customfield.input}
                                            {if $customfield.description}
                                                <span class="field-help-text">
                                                    {$customfield.description}
                                                </span>
                                            {/if}
                                        </div>
                                    {/foreach}
                                </div>

                            {/if}

                            {if $addons || count($addonsPromoOutput) > 0}

                                <div id="productAddonsContainer">
                                    <h5>{$LANG.cartavailableaddons}</h5>

                                    {foreach $addonsPromoOutput as $output}
                                        <div>
                                            {$output}
                                        </div>
                                    {/foreach}

                                    <div class="row addon-products">
                                        {foreach $addons as $addon}
                                            <div class="col-sm-{if count($addons) > 1}6{else}12{/if}">
                                                <div class="panel card panel-default panel-addon{if $addon.status} panel-addon-selected{/if}">
                                                    <div class="panel-body card-body">
                                                        <label>
                                                            <input type="checkbox" name="addons[{$addon.id}]"{if $addon.status} checked{/if} />
                                                            {$addon.name}
                                                        </label><br />
                                                        <span class="product-description">{$addon.description}</span>
                                                    </div>
                                                    <div class="panel-price">
                                                        {$addon.pricing}
                                                    </div>
                                                    <div class="panel-add">
                                                        <i class="fas fa-plus"></i>
                                                        {$LANG.addtocart}
                                                    </div>
                                                </div>
                                            </div>
                                        {/foreach}
                                    </div>
                                </div>
                            {/if}

                            <!-- div class="alert alert-warning info-text-sm">
                                <i class="fas fa-question-circle"></i>
                                {$LANG.orderForm.haveQuestionsContact} <a href="{$WEB_ROOT}/contact.php" target="_blank" class="alert-link">{$LANG.orderForm.haveQuestionsClickHere}</a>
                            </div -->
                    </div>

                    <div class="secondary-cart-sidebar" id="scrollingPanelContainer">

                        <div id="orderSummary">
                            <div class="order-summary">
                                <div class="loader" id="orderSummaryLoader">
                                    <i class="fas fa-fw fa-sync fa-spin"></i>
                                </div>
                                <h2 class="font-size-30">{$LANG.ordersummary}</h2>
                                <div class="summary-container" id="producttotal"></div>
                            </div>
                            <div class="text-center">
                                <button type="submit" id="btnCompleteProductConfig" class="btn btn-primary btn-lg">
                                    {$LANG.continue}
                                    <i class="fas fa-arrow-circle-right"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                </div>

            </form>
        </div>
    </div>
</div>

<script>recalctotals();</script>

{include file="orderforms/standard_cart/recommendations-modal.tpl"}
