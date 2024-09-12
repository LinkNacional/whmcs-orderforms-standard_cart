document.addEventListener('DOMContentLoaded', function() {
    var options = document.querySelectorAll('.option');
    var domainInputGroups = {
        register: document.getElementById('domainregister'),
        transfer: document.getElementById('domaintransfer'),
        owndomain: document.getElementById('domainowndomain')
    };
    var form = document.getElementById('frmProductDomain');

    function updateVisibleInput(selectedValue) {
        // Remove a classe 'option-selected' de todas as opções
        options.forEach(function(option) {
            option.classList.remove('option-selected');
        });

        // Esconde todos os grupos de input
        for (var key in domainInputGroups) {
            if (domainInputGroups.hasOwnProperty(key)) {
                domainInputGroups[key].style.display = 'none';
            }
        }

        if (selectedValue && domainInputGroups[selectedValue]) {
            var selectedOption = Array.prototype.find.call(options, function(option) {
                return option.querySelector('input[value="' + selectedValue + '"]');
            });

            if (selectedOption) {
                selectedOption.classList.add('option-selected');
            }

            domainInputGroups[selectedValue].style.display = 'flex';
        }
    }

    // Inicializar visibilidade com base na seleção atual do radio button
    updateVisibleInput(document.querySelector('input[name="domainoption"]:checked').value);

    // Adiciona evento de clique para cada opção
    options.forEach(function(option) {
        option.addEventListener('click', function(event) {
            event.preventDefault();
            var selectedValue = this.querySelector('input[type="radio"]').value;
            updateVisibleInput(selectedValue);
        });
    });

    // Evento de submit do formulário
    form.addEventListener('submit', function(event) {
        // Exibe o grupo de entrada correspondente à opção 'register'
        updateVisibleInput('register');
    });
});