function lkn_update_order_form_with_cached_data() {
    let neighborhood = document.querySelector("#inputNeighborhood");
    let inputAddress = document.querySelector("#inputAddress");
    let address = document.querySelector("#inputAddress1");
    let address2 = document.querySelector("#inputAddress2");
    let houseNumber = document.querySelector("#inputHouseNumber");
    let inputCpf = document.querySelector("#inputCPF");
    let inputDate = document.querySelector("#inputDate");
    let isPessoaJuridica = document.querySelector("#isPessoaJuridica");
    let inputCNPJ = document.querySelector("#inputCNPJ");
    let iCheckIsPessoaJuridica = document.querySelector("#iCheck-isPessoaJuridica");
    let iCheckCustomPhoneInput = document.querySelector("#iCheck-customPhoneInput"); // Novo checkbox

    // Função para atualizar os campos de endereço
    function updateAddressFields() {
        // console.log("Atualizando os campos de endereço...");
        address.value = `${inputAddress.value.trim()}, ${houseNumber.value.trim()}`;
        address2.value = neighborhood.value.trim();
        // console.log("Endereço 1:", address.value);
        // console.log("Endereço 2:", address2.value);
    }


    // Função para atualizar o estado do input "isPessoaJuridica" com base na classe "checked"
    function updateIsPessoaJuridica() {
        if (iCheckIsPessoaJuridica.classList.contains("checked")) {
            isPessoaJuridica.checked = true;
            // console.log("Classe 'checked' encontrada no iCheck-isPessoaJuridica, isPessoaJuridica marcado como true");
        } else {
            isPessoaJuridica.checked = false;
            // console.log("Classe 'checked' não encontrada no iCheck-isPessoaJuridica, isPessoaJuridica marcado como false");
        }
        // Armazena o estado no localStorage
        localStorage.setItem("isPessoaJuridica", isPessoaJuridica.checked);
    }

    // Função para atualizar o estado do checkbox "customPhoneInput"
    function updateCustomPhoneInput() {
        // Verifica o estado do checkbox
        if (iCheckCustomPhoneInput.classList.contains("checked")) {
            document.getElementById('customPhoneInput').checked = true;
            // console.log("Checkbox 'customPhoneInput' marcado como true");
        } else {
            document.getElementById('customPhoneInput').checked = false;
            // console.log("Checkbox 'customPhoneInput' marcado como false");
        }
        // Armazena o estado no localStorage
        localStorage.setItem("customPhoneInput", document.getElementById('customPhoneInput').checked);
    }

    // Observe as mudanças no checkbox iCheck-customPhoneInput
    const observerCustomPhoneInput = new MutationObserver(function (mutationsList) {
        for (let mutation of mutationsList) {
            if (mutation.type === "attributes" && mutation.attributeName === "class") {
                updateCustomPhoneInput();
            }
        }
    });

    // Observe as mudanças na classe 'checked' no elemento iCheck-customPhoneInput
    observerCustomPhoneInput.observe(iCheckCustomPhoneInput, { attributes: true });

    // Observe as mudanças na classe 'checked' no elemento iCheck-isPessoaJuridica
    const observerIsPessoaJuridica = new MutationObserver(function (mutationsList) {
        for (let mutation of mutationsList) {
            if (mutation.type === "attributes" && mutation.attributeName === "class") {
                updateIsPessoaJuridica();
            }
        }
    });

    // Observe as mudanças na classe 'checked' no elemento iCheck-isPessoaJuridica
    observerIsPessoaJuridica.observe(iCheckIsPessoaJuridica, { attributes: true });
    const containerDiv = document.getElementById("containerExistingAccountSelect");

    // Armazenar e recuperar valores de endereço
    if (neighborhood && inputAddress && houseNumber && address && address2 && !containerDiv) {
        // Adiciona ouvintes de evento para os campos de endereço
        neighborhood.addEventListener("change", updateAddressFields);

        // Caso os campos já tenham valores ao carregar a página, faz a atualização imediatamente
        if (address.value && address2.value) {
            let partes = address.value.split(',');

            let rua = partes[0].trim();    // Garante que não haja espaços indesejados
            let numero = partes[1].trim(); // Remove espaços antes e depois do número
            let bairro = address2.value.trim();

            inputAddress.value = rua;
            houseNumber.value = numero;
            neighborhood.value = bairro;
        }
        inputAddress.addEventListener("change", function () {
            // console.log("Alterado inputAddress:", inputAddress.value);
            updateAddressFields();
            localStorage.setItem("address", inputAddress.value);
        });

        houseNumber.addEventListener("change", function () {
            // console.log("Alterado houseNumber:", houseNumber.value);
            updateAddressFields();
            localStorage.setItem("houseNumber", houseNumber.value);
        });

        neighborhood.addEventListener("change", function () {
            // console.log("Alterado neighborhood:", neighborhood.value);
            updateAddressFields();
            localStorage.setItem("neighborhood", neighborhood.value);
        });

        // Recupera os valores do localStorage e preenche os campos de endereço
        if (localStorage.getItem("neighborhood")) {
            neighborhood.value = localStorage.getItem("neighborhood");
            // console.log("Recuperado do localStorage: neighborhood:", neighborhood.value);
        }
        if (localStorage.getItem("address")) {
            inputAddress.value = localStorage.getItem("address");
            // console.log("Recuperado do localStorage: address:", inputAddress.value);
        }
        if (localStorage.getItem("address1")) {
            address.value = localStorage.getItem("address1");
            // console.log("Recuperado do localStorage: address1:", address.value);
        }
        if (localStorage.getItem("address2")) {
            address2.value = localStorage.getItem("address2");
            // console.log("Recuperado do localStorage: address2:", address2.value);
        }
        if (localStorage.getItem("houseNumber")) {
            houseNumber.value = localStorage.getItem("houseNumber");
            // console.log("Recuperado do localStorage: houseNumber:", houseNumber.value);
        }

        // Chama a função de atualização dos campos de endereço assim que os valores são preenchidos
        updateAddressFields();
    }

    // Armazenar os valores de CPF, Data, CNPJ e isPessoaJuridica no localStorage
    inputDate.addEventListener("change", function () {
        // console.log("Alterado inputDate:", inputDate.value);
        localStorage.setItem("inputDate", inputDate.value);
    });

    inputCpf.addEventListener("change", function () {
        // console.log("Alterado inputCPF:", inputCpf.value);
        localStorage.setItem("inputCPF", inputCpf.value);
    });

    inputCNPJ.addEventListener("change", function () {
        // console.log("Alterado inputCNPJ:", inputCNPJ.value);
        localStorage.setItem("inputCNPJ", inputCNPJ.value);
    });

    // Recupera os valores do localStorage e preenche os campos CPF, Data, CNPJ e isPessoaJuridica ao carregar a página
    if (localStorage.getItem("inputDate")) {
        inputDate.value = localStorage.getItem("inputDate");
        // console.log("Recuperado do localStorage: inputDate:", inputDate.value);
    }
    if (localStorage.getItem("inputCPF")) {
        inputCpf.value = localStorage.getItem("inputCPF");
        // console.log("Recuperado do localStorage: inputCPF:", inputCpf.value);
    }
    if (localStorage.getItem("inputCNPJ")) {
        inputCNPJ.value = localStorage.getItem("inputCNPJ");
        // console.log("Recuperado do localStorage: inputCNPJ:", inputCNPJ.value);
    }
    if (localStorage.getItem("isPessoaJuridica") !== null) {
        try {
            isPessoaJuridica.checked = JSON.parse(localStorage.getItem("isPessoaJuridica")); // converte de volta para booleano
        } catch (error) {
            isPessoaJuridica.checked = false
        }
        // console.log("Recuperado do localStorage: isPessoaJuridica:", isPessoaJuridica.checked);

        // Verifica o estado da checkbox ao carregar a página
        if (isPessoaJuridica.checked) {
            iCheckIsPessoaJuridica.classList.add("checked");
            // console.log("Classe 'checked' adicionada ao iCheck-isPessoaJuridica no carregamento");
        } else {
            iCheckIsPessoaJuridica.classList.remove("checked");
            // console.log("Classe 'checked' removida do iCheck-isPessoaJuridica no carregamento");
        }
    }

    // Verifica o estado de 'customPhoneInput' ao carregar a página
    if (localStorage.getItem("customPhoneInput") === "true") {
        iCheckCustomPhoneInput.classList.add("checked");
        document.getElementById('customPhoneInput').checked = true;
        // console.log("Checkbox 'customPhoneInput' marcado com base no localStorage");
    } else {
        iCheckCustomPhoneInput.classList.remove("checked");
        document.getElementById('customPhoneInput').checked = false;
        // console.log("Checkbox 'customPhoneInput' desmarcado com base no localStorage");
    }
}
