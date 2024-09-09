document.addEventListener('DOMContentLoaded', function () {
    const tooltipIcon = document.querySelector('.tooltip-icon');
    const tooltipText = document.querySelector('.tooltip-text');

    tooltipIcon.addEventListener('mouseover', function () {
        tooltipText.style.visibility = 'visible';
        tooltipText.style.opacity = '1';
    });

    tooltipIcon.addEventListener('mouseout', function () {
        tooltipText.style.visibility = 'hidden';
        tooltipText.style.opacity = '0';
    });
});
