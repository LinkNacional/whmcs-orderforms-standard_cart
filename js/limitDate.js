document.addEventListener("DOMContentLoaded", function () {
    let birthDateInput = document.querySelector("#inputDate");

    let today = new Date();
    let year = today.getFullYear();
    let month = String(today.getMonth() + 1).padStart(2, '0');
    let day = String(today.getDate()).padStart(2, '0');

    let minYear = year - 18;
    let minDate = `${minYear}-${month}-${day}`;

    birthDateInput.max = minDate;
});