document.addEventListener("DOMContentLoaded", function () {
    let neighborhood = document.querySelector("#inputNeighborhood");
    let inputAddress = document.querySelector("#inputAddress"); 
    let address = document.querySelector("#inputAddress1"); 
    let address2 = document.querySelector("#inputAddress2"); 
    let houseNumber = document.querySelector("#inputHouseNumber");

    if (neighborhood && inputAddress && houseNumber && address && address2) {
        // Função para atualizar os campos
        function updateAddressFields() {
            address.value = `${inputAddress.value.trim()}, ${houseNumber.value.trim()}`;
            address2.value = neighborhood.value.trim();
        }

        // Adiciona ouvintes de evento para os campos
        inputAddress.addEventListener("change", updateAddressFields);
        houseNumber.addEventListener("change", updateAddressFields);
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
    }
});
