$(document).ready(function () {
    function updateFieldsFromCep(cep) {
        // Remove qualquer espaço ou hífen do CEP
        cep = cep.replace(/\s+/g, '').replace('-', '');

        // Verifica se o CEP é do Brasil (8 dígitos)
        if (/^\d{8}$/.test(cep)) {
            console.log(`Verificando CEP do Brasil: ${cep}`);
            $.getJSON(`https://viacep.com.br/ws/${cep}/json/`, function (data) {
                if (!data.erro) {
                    $('#inputAddress1').val(data.logradouro);
                    $('#inputCity').val(data.localidade);
                    $('#stateselect').val(data.uf);
                    $('#inputCountry').val('BR');
                    $('#stateinput').hide();
                    $('#stateselect').show();
                } else {
                    console.error(`Erro: CEP do Brasil não encontrado. CEP: ${cep}`);
                }
            }).fail(function (jqxhr, textStatus, error) {
                console.error(`Erro na requisição ViaCEP: ${textStatus}, ${error}`);
            });
        }
        // Verifica se o CEP é de Portugal (4 dígitos + 3 dígitos)
        else if (/^\d{4}-\d{3}$/.test(cep)) {
            console.log(`Verificando Código Postal de Portugal: ${cep}`);
            $.getJSON(`https://api.zippopotam.us/PT/${cep}`, function (data) {
                if (data && data.places && data.places.length > 0) {
                    $('#inputCity').val(data.places[0]['place name']);
                    $('#inputCountry').val('PT');
                    $('#stateinput').show();
                    $('#stateselect').hide();
                } else {
                    console.error(`Erro: Código postal de Portugal não encontrado. CEP: ${cep}`);
                }
            }).fail(function (jqxhr, textStatus, error) {
                console.error(`Erro na requisição zippopotam.us: ${textStatus}, ${error}`);
            });
        }
        // Verifica se o código postal é do Canadá (6 dígitos no formato A1A 1A1)
        // Verifica se o código postal é do Reino Unido (6 ou 7 caracteres)
        else if (/^[A-Z]{1,2}\d[A-Z\d]? \d[A-Z]{2}$/.test(cep) || /^[A-Z]{1,2}\d[A-Z\d]?$/.test(cep)) {
            console.log(`Verificando Código Postal do Reino Unido: ${cep}`);
            $.getJSON(`https://api.zippopotam.us/GB/${cep}`, function (data) {
                if (data && data.places && data.places.length > 0) {
                    $('#inputCity').val(data.places[0]['place name']);
                    $('#inputCountry').val('GB');
                    $('#stateinput').show();
                    $('#stateselect').hide();
                } else {
                    console.error(`Erro: Código postal do Reino Unido não encontrado. CEP: ${cep}`);
                }
            }).fail(function (jqxhr, textStatus, error) {
                console.error(`Erro na requisição zippopotam.us: ${textStatus}, ${error}`);
            });
        }
        // Verifica se o código postal é dos EUA (5 dígitos ou 5+4 dígitos)
        else if (/^\d{5}(-\d{4})?$/.test(cep)) {
            console.log(`Verificando Código Postal dos EUA: ${cep}`);
            $.getJSON(`https://api.zippopotam.us/US/${cep}`, function (data) {
                if (data && data.places && data.places.length > 0) {
                    // A API Zippopotam.us pode não fornecer o nome da rua. 
                    // Se a API não fornecer o nome da rua, você pode usar outra API como o Google Maps.
                    $('#inputAddress1').val(''); // Ou obtenha o endereço da resposta da API se disponível
                    $('#inputCity').val(data.places[0]['place name']);
                    $('#inputCountry').val('US');
                    $('#stateinput').show();
                    $('#stateselect').hide();
                } else {
                    console.error(`Erro: Código postal dos EUA não encontrado. CEP: ${cep}`);
                }
            }).fail(function (jqxhr, textStatus, error) {
                console.error(`Erro na requisição zippopotam.us: ${textStatus}, ${error}`);
            });
        } else {
            console.error('CEP/Código Postal inválido. Certifique-se de inserir um CEP válido.');
        }
    }



    // Evento para quando o CEP for alterado
    $('#inputPostcode').on('change', function () {
        var cep = $(this).val();
        updateFieldsFromCep(cep);
    });

    $('.country-list').on('click', '.country', function () {
        // Obtém o código do país da opção selecionada
        var countryCode = $(this).data('country-code');


        // Atualiza o valor do campo #inputCountry com o código do país
        $('#inputCountry').val(countryCode.toUpperCase());

    });
});
