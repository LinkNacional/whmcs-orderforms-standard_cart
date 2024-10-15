document.addEventListener("DOMContentLoaded", function () {
    let neighborhood = document.querySelector("#inputNeighborhood");
    let inputAddress = document.querySelector("#inputAddress"); 
    let address = document.querySelector("#inputAddress1"); 
    let address2 = document.querySelector("#inputAddress2"); 
    let houseNumber = document.querySelector("#inputHouseNumber");
    let completeOrder = document.querySelector("#btnCompleteOrder");

    if (neighborhood && address && houseNumber && completeOrder && address2) {
        completeOrder.addEventListener("click", function (event) {
            address.value = `${inputAddress.value}, ${houseNumber.value}`;
            address2.value = neighborhood.value;
        });
    }
});

