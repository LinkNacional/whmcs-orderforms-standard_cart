document.addEventListener('DOMContentLoaded', function () {
    var options = document.querySelectorAll('.option');
    var domainInputGroups = {
        register: document.getElementById('domainregister'),
        transfer: document.getElementById('domaintransfer'),
        owndomain: document.getElementById('domainowndomain')
    };
    var form = document.getElementById('frmProductDomain');

    // Verifica se todos os elementos necessários existem
    if (!options.length || !domainInputGroups.register || !domainInputGroups.transfer || !domainInputGroups.owndomain || !form) {
        console.error('Um ou mais elementos necessários não foram encontrados.');
        return; // Interrompe a execução se algum elemento não for encontrado
    }

    function updateVisibleInput(selectedValue) {
        // Remove a classe 'option-selected' de todas as opções
        options.forEach(function (option) {
            option.classList.remove('option-selected');
        });

        // Esconde todos os grupos de input
        for (var key in domainInputGroups) {
            if (domainInputGroups.hasOwnProperty(key)) {
                domainInputGroups[key].style.display = 'none';
            }
        }

        // Mostra o grupo de entrada correspondente e adiciona a classe 'option-selected'
        if (selectedValue && domainInputGroups[selectedValue]) {
            var selectedOption = Array.prototype.find.call(options, function (option) {
                return option.querySelector('input[value="' + selectedValue + '"]');
            });

            if (selectedOption) {
                selectedOption.classList.add('option-selected');
            }

            domainInputGroups[selectedValue].style.display = 'flex';
        }
    }

    // Inicializar visibilidade com base na seleção atual do radio button
    var initialSelectedInput = document.querySelector('input[name="domainoption"]:checked');
    var initialSelectedValue = initialSelectedInput ? initialSelectedInput.value : null;
    if (initialSelectedValue) {
        updateVisibleInput(initialSelectedValue);
    }

    // Adiciona evento de clique para cada opção
    options.forEach(function (option) {
        var radioInput = option.querySelector('input[type="radio"]');
        if (radioInput) {
            option.addEventListener('click', function (event) {
                event.preventDefault();
                var selectedValue = radioInput.value;
                updateVisibleInput(selectedValue);
            });
        }
    });

    // Evento de submit do formulário
    form.addEventListener('submit', function (event) {
        event.preventDefault(); // Impede o comportamento padrão de envio do formulário

        // Pega o valor atual da opção selecionada antes do envio
        var selectedInput = document.querySelector('input[name="domainoption"]:checked');
        var selectedValue = selectedInput ? selectedInput.value : null;

        // Mantém o input visível correto após o envio
        if (selectedValue) {
            updateVisibleInput(selectedValue);
        }

        // Aqui você pode adicionar a lógica de envio via AJAX ou remover o event.preventDefault para submeter normalmente
        console.log("Formulário enviado com a opção:", selectedValue);
    });

    // Eventos para os botões
    var selRegister = document.getElementById('selregister');
    var selTransfer = document.getElementById('seltransfer');
    var selOwnDomain = document.getElementById('selowndomain');

    if (selRegister) {
        selRegister.addEventListener('click', function () {
            var registerSld = document.getElementById('registersld');
            if (registerSld) {
                registerSld.focus(); // Dá o foco no campo de entrada de domínio para registro
            }
        });
    }

    if (selTransfer) {
        selTransfer.addEventListener('click', function () {
            var transferSld = document.getElementById('transfersld');
            if (transferSld) {
                transferSld.focus(); // Dá o foco no campo de entrada de domínio para transferência
            }
        });
    }

    if (selOwnDomain) {
        selOwnDomain.addEventListener('click', function () {
            var ownDomainSld = document.getElementById('owndomainsld');
            if (ownDomainSld) {
                ownDomainSld.focus(); // Dá o foco no campo de entrada de domínio para uso do próprio domínio
            }
        });
    }

    // Foco inicial no campo de entrada para o domínio
    var initialField = document.getElementById('registersld');
    if (initialField) {
        initialField.focus();
    }
});
