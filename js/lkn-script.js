document.addEventListener('DOMContentLoaded', function () {
    var options = document.querySelectorAll('.option');
    var domainInputGroups = {
        register: document.getElementById('domainregister'),
        transfer: document.getElementById('domaintransfer'),
        owndomain: document.getElementById('domainowndomain')
    };
    var form = document.getElementById('frmProductDomain');

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
    var initialSelectedValue = document.querySelector('input[name="domainoption"]:checked').value;
    updateVisibleInput(initialSelectedValue);

    // Adiciona evento de clique para cada opção
    options.forEach(function (option) {
        option.addEventListener('click', function (event) {
            event.preventDefault();
            var selectedValue = this.querySelector('input[type="radio"]').value;
            updateVisibleInput(selectedValue);
        });
    });

    // Evento de submit do formulário
    form.addEventListener('submit', function (event) {
        event.preventDefault(); // Impede o comportamento padrão de envio do formulário

        // Pega o valor atual da opção selecionada antes do envio
        var selectedValue = document.querySelector('input[name="domainoption"]:checked').value;

        // Mantém o input visível correto após o envio
        updateVisibleInput(selectedValue);

        // Aqui você pode adicionar a lógica de envio via AJAX ou remover o event.preventDefault para submeter normalmente
        console.log("Formulário enviado com a opção:", selectedValue);
    });
});
