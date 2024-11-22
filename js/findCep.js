document.addEventListener('DOMContentLoaded', function () {
  function fetchCepData(url, onSuccess, onError) {
    fetch(url)
      .then(response => response.json())
      .then(onSuccess)

  }

  function updateAddressFields(data, country, cityField, stateField, addressField = '', neighborhoodField = '') {
    const place = data?.places?.[0] || {};

    const inputCity = document.getElementById('inputCity');
    const inputCountry = document.getElementById('inputCountry');
    const stateInput = document.getElementById('stateinput');
    const stateSelect = document.getElementById('stateselect');
    const inputAddress = document.getElementById('inputAddress');
    const inputNeighborhood = document.getElementById('inputNeighborhood');

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
    if (neighborhoodField && inputNeighborhood) {
      inputNeighborhood.value = place[neighborhoodField] || '';
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
    const inputCountry = document.getElementById('inputCountry'); // Ex.: 'BR', 'US'
    const labelSelect = document.querySelector("label[for='state']");
    const labelInput = document.querySelector("label[for='stateinput']");
    const inputHouseNumber = document.getElementById('inputHouseNumber');
    const phoneCode = document.querySelector('.selected-dial-code')?.textContent.trim(); // Ex.: '+55'

    const countryCodes = {
      '+55': 'BR',
      '+44': 'GB',
      '+1': 'US',
      '+351': 'PT',
    };

    const phoneCountry = countryCodes[phoneCode] || null; // Converte o phoneCode para país correspondente

    inputHouseNumber.value = '';

    if (!inputAddress || !inputCity || !inputCountry) {
      console.error('Campos de endereço não encontrados');
      showMessage('Campos de endereço não encontrados.', true);
      return;
    }

    if (!phoneCountry) {
      console.warn('Código de país não reconhecido ou ausente.');
      showMessage('Código de país não reconhecido ou ausente.', true);
      return;
    }

    // Verifica se o país do telefone corresponde ao inputCountry
    if (phoneCountry !== inputCountry.value) {
      console.warn(`O país do telefone (${phoneCountry}) não corresponde ao país do endereço (${inputCountry.value}).`);
      showMessage('País do telefone não corresponde ao país do endereço.', true);
      return;
    }

    if (/^\d{8}$/.test(cep) && phoneCountry === 'BR') { // Brasil
      fetchCepData(
        `https://viacep.com.br/ws/${cep}/json/`,
        function (data) {
          if (!data.erro) {
            inputAddress.value = data.logradouro;
            inputCity.value = data.localidade;
            inputState.value = data.uf;
            inputCountry.value = 'BR';
            document.getElementById('inputNeighborhood').value = data.bairro || '';

            document.getElementById('stateinput').style.display = 'none';
            document.getElementById('stateselect').style.display = 'block';

            labelInput.style.display = 'none';
            labelSelect.style.display = 'inline-block';
            showMessage('Endereço atualizado com sucesso!');
          } else {
            console.error(`Erro: CEP do Brasil não encontrado. CEP: ${cep}`);
            showMessage(`Erro: CEP do Brasil não encontrado. CEP: ${cep}`, true);
          }
        }
      );
    } else if (/^[A-Z]{1,2}\d[A-Z\d]? \d[A-Z]{2}$/.test(cep) && phoneCountry === 'GB') {
      fetchCepData(
        `https://api.zippopotam.us/GB/${cep}`,
        data => {
          updateAddressFields(data, 'GB', 'place name', 'state', '', 'county');
          showMessage('Endereço atualizado com sucesso!');
        }
      );
    } else if (/^\d{5}(-\d{4})?$/.test(cep) && phoneCountry === 'US') {
      fetchCepData(
        `https://api.zippopotam.us/US/${cep}`,
        data => {
          updateAddressFields(data, 'US', 'place name', 'state', 'street', 'neighborhood');
          showMessage('Endereço atualizado com sucesso!');
        }
      );
    } else if ((/^\d{7}$/.test(cep) || /^\d{4}-\d{3}$/.test(cep)) && phoneCountry === 'PT') {
      if (/^\d{7}$/.test(cep)) cep = cep.slice(0, 4) + '-' + cep.slice(4);

      fetchCepData(`https://json.geoapi.pt/cp/${cep}`, function (data) {
        if (data) {
          console.log(data);
          inputAddress.value = data.partes[0].Artéria || '';
          inputCity.value = data.Concelho || '';
          inputCountry.value = 'PT';
          document.getElementById('inputNeighborhood').value = data.Freguesia || '';

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
      console.warn(`Formato de CEP não reconhecido ou país não permitido: ${cep}`);
      showMessage(`Formato de CEP não reconhecido ou país não permitido: ${cep}`, true);
    }

    document.getElementById("inputHouseNumber").focus();
  }

  const inputPostcode = document.getElementById('inputPostcode');
  if (inputPostcode) {
    inputPostcode.addEventListener('change', function () {
      const cep = this.value;
      updateFieldsFromCep(cep);
    });

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


// TODO adicionar campo de complemento e bairro obrigatório

// TODO só pesquisa o cep de acordo com o país