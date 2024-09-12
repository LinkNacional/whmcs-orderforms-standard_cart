document.addEventListener('DOMContentLoaded', function () {
    const tooltipIcon = document.querySelector('.tooltip-icon');
    const tooltipText = document.querySelector('.tooltip-text');

    if (tooltipIcon && tooltipText) {
        tooltipIcon.addEventListener('mouseover', function () {
            tooltipText.style.visibility = 'visible';
            tooltipText.style.opacity = '1';
        });

        tooltipIcon.addEventListener('mouseout', function () {
            tooltipText.style.visibility = 'hidden';
            tooltipText.style.opacity = '0';
        });
    }

    const inputs = document.querySelectorAll('#registersld, #owndomainsld, #transfersld');

    if (inputs.length > 0) {
        function removePrefixAndSubdomain(event) {
            const input = event.target;
            let value = input.value;

            // Remove o prefixo 'https://' ou 'http://'
            if (value.startsWith('https://')) {
                value = value.substring(8);
            } else if (value.startsWith('http://')) {
                value = value.substring(7);
            }

            // Remove 'www.' se houver
            if (value.startsWith('www.')) {
                value = value.substring(4);
            }

            // Verifica se o domínio contém subdomínios e remove o subdomínio
            const parts = value.split('.');
            if (parts.length > 2) {
                value = parts.slice(parts.length - 2).join('.'); // Mantém apenas o domínio de segundo nível e o TLD
            }

            input.value = value; // Atualiza o valor do input sem o prefixo e subdomínio
        }

        function validateDomain(event) {
            const input = event.target;
            const value = input.value;

            // Regex para validar apenas domínios de segundo nível
            const domainRegex = /^[a-zA-Z0-9-]{1,63}\.[a-zA-Z]{2,}$/;

            if (!domainRegex.test(value)) {
                input.setCustomValidity('Por favor, insira um domínio válido sem subdomínios.');
                input.reportValidity(); // Mostra a mensagem de validação
            } else {
                input.setCustomValidity(''); // Limpa a mensagem de validação se o domínio for válido
            }
        }

        inputs.forEach(input => {
            input.addEventListener('blur', removePrefixAndSubdomain);
            input.addEventListener('blur', validateDomain);
        });
    }

});
