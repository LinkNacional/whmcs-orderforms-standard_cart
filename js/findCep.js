document.addEventListener('DOMContentLoaded', function () {
  function fetchCepData(url, onSuccess, onError) {
    fetch(url)
      .then(response => response.json())
      .then(onSuccess)
      .catch(error => {
        console.error(`Erro na requisição: ${error}`);
        if (onError) onError();
        showMessage('Erro ao buscar dados. Tente novamente.', true);
      });
  }

  function updateAddressFields(data, country, cityField, stateField, addressField = '') {
    const place = data?.places?.[0] || {};

    const inputCity = document.getElementById('inputCity');
    const inputCountry = document.getElementById('inputCountry');
    const stateInput = document.getElementById('stateinput');
    const stateSelect = document.getElementById('stateselect');
    const inputAddress = document.getElementById('inputAddress');

    if (inputCity) inputCity.value = place[cityField] || '';
    if (inputCountry) inputCountry.value = country;
    if (stateInput) {
      stateInput.style.display = 'block';
      stateInput.value = place[stateField] || '';
    }

    if (stateSelect) stateSelect.style.display = 'none';
    if (addressField && inputAddress) {
      inputAddress.value = place[addressField] || '';
    }
  }

  function showMessage(message, isError = false) {
    const messageContainer = document.getElementById('messageContainer');
    if (messageContainer) {
      messageContainer.textContent = message;
      messageContainer.style.color = isError ? 'red' : 'green';
      messageContainer.style.display = 'block';
    }
  }

  function updateFieldsFromCep(cep = null) {
    cep = cep.replace(/\s+/g, '').replace('-', '');

    const inputAddress = document.getElementById('inputAddress');
    const inputCity = document.getElementById('inputCity');
    const inputState = document.getElementById('stateselect');
    const inputCountry = document.getElementById('inputCountry');
    const labelSelect = document.querySelector("label[for='state']");
    const labelInput = document.querySelector("label[for='stateinput']");

    if (!inputAddress || !inputCity || !inputCountry) {
      console.error('Campos de endereço não encontrados');
      showMessage('Campos de endereço não encontrados.', true);
      return;
    }

    if (/^\d{8}$/.test(cep)) { // Brasil
      fetchCepData(
        `https://viacep.com.br/ws/${cep}/json/`,
        function (data) {
          if (!data.erro) {
            inputAddress.value = data.logradouro;
            inputCity.value = data.localidade;
            inputState.value = data.uf;
            inputCountry.value = 'BR';

            document.getElementById('stateinput').style.display = 'none';
            document.getElementById('stateselect').style.display = 'block';

            // Ajustar exibição dos labels
            labelInput.style.display = 'none';
            labelSelect.style.display = 'inline-block';
            showMessage('Endereço atualizado com sucesso!');
          } else {
            console.error(`Erro: CEP do Brasil não encontrado. CEP: ${cep}`);
            showMessage(`Erro: CEP do Brasil não encontrado. CEP: ${cep}`, true);
          }
        }
      );
    } else if (/^[A-Z]{1,2}\d[A-Z\d]? \d[A-Z]{2}$/.test(cep) || /^[A-Z]{1,2}\d[A-Z\d]?$/.test(cep)) {
      fetchCepData(
        `https://api.zippopotam.us/GB/${cep}`,
        data => {
          updateAddressFields(data, 'GB', 'place name', 'state');
          showMessage('Endereço atualizado com sucesso!');
        }
      );
    } else if (/^\d{5}(-\d{4})?$/.test(cep)) {
      fetchCepData(
        `https://api.zippopotam.us/US/${cep}`,
        data => {
          updateAddressFields(data, 'US', 'place name', 'state', 'street');
          showMessage('Endereço atualizado com sucesso!');
        }
      );
    } else if (/^\d{7}$/.test(cep) || /^\d{4}-\d{3}$/.test(cep)) {
      if (/^\d{7}$/.test(cep)) cep = cep.slice(0, 4) + '-' + cep.slice(4);

      // Usando a API GeoAPI para Portugal
      fetchCepData(`https://json.geoapi.pt/cp/${cep}`, function (data) {
        if (data) {
          inputAddress.value = data.ruas[0] || '';
          inputCity.value = data.Localidade || '';
          inputCountry.value = 'PT';
          inputState.value = data.Distrito || '';

          document.getElementById('stateinput').style.display = 'block';
          document.getElementById('stateselect').style.display = 'none';

          labelSelect.style.display = 'none';
          labelInput.style.display = 'inline-block';
          showMessage('Endereço atualizado com sucesso!');
        } else {
          console.error(`Erro: Código postal de Portugal não encontrado. CEP: ${cep}`);
          showMessage(`Erro: Código postal de Portugal não encontrado. CEP: ${cep}`, true);
        }
      });
    } else {
      console.warn(`Formato de CEP não reconhecido: ${cep}`);
      showMessage(`Formato de CEP não reconhecido: ${cep}`, true);
    }
  }

  const inputPostcode = document.getElementById('inputPostcode');
  if (inputPostcode) {
    inputPostcode.addEventListener('change', function () {
      const cep = this.value;
      updateFieldsFromCep(cep);
    });

    // Chamar a função apenas se o valor for válido
    if (inputPostcode.value) {
      updateFieldsFromCep(inputPostcode.value);
    }
  }

  const countryList = document.querySelectorAll('.country-list .country');
  if (countryList.length > 0) {
    countryList.forEach(function (country) {
      country.addEventListener('click', function () {
        const countryCode = this.getAttribute('data-country-code');
        const inputCountry = document.getElementById('inputCountry');
        if (inputCountry) {
          var select = document.getElementById('inputCountry');
          // Mudar o valor como se fosse um clique do usuário
          select.value = countryCode.toUpperCase();
          const event = new Event('change', { bubbles: true });
          inputCountry.dispatchEvent(event);

          if (select.value !== "BR" && select.value !== "US") {
            document.querySelector("label[for='stateinput']").style.display = 'block';
            document.querySelector("label[for='state']").style.display = 'none';
          }
          document.querySelector("label[for='stateinput']").style.display = 'none';
          document.querySelector("label[for='state']").style.display = 'block';
        }
      });
    });
  }
});
