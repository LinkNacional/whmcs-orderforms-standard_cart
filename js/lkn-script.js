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
        function removePrefix(event) {
            const input = event.target;
            let value = input.value;

            if (value.startsWith('https://www.')) {
                input.value = value.substring(12); // Remove 'https://www.'
            }
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
            input.addEventListener('blur', removePrefix);
            input.addEventListener('blur', validateDomain);
        });
    }
});
