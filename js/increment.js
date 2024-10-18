document.addEventListener("DOMContentLoaded", function () {
    let neighborhood = document.querySelector("#inputNeighborhood");
    let inputAddress = document.querySelector("#inputAddress"); 
    let address = document.querySelector("#inputAddress1"); 
    let address2 = document.querySelector("#inputAddress2"); 
    let houseNumber = document.querySelector("#inputHouseNumber");
    let completeOrder = document.querySelector("#btnCompleteOrder");

    if (neighborhood && address && houseNumber && completeOrder && address2) {
        completeOrder.addEventListener("click", function (event) {
            address.value = `${inputAddress.value.trim()}, ${houseNumber.value.trim()}`;
            address2.value = neighborhood.value.trim();
        });
    }

    if (address.value && address2.value) {
        let partes = address.value.split(','); 

        let rua = partes[0].trim();    // Garante que não haja espaços indesejados
        let numero = partes[1].trim(); // Remove espaços antes e depois do número
        let bairro = address2.value.trim();

        inputAddress.value = rua;
        houseNumber.value = numero;
        neighborhood.value = bairro;
    }
});
