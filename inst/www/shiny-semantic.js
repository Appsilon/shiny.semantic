$(document).ready(function() {
  $('.collapsed-hamburger-icon').on('click', function() {
    $('.navbar-collapisble-item').transition('fade down');
  });

  if (window.innerWidth < 768) {
    $('.navbar-collapisble-item').transition('hide');
  }

  window.addEventListener('resize', function(event) {
    if (window.innerWidth >= 768) {
      $('.navbar-collapisble-item').transition('show');
    } else {
      $('.navbar-collapisble-item').transition('hide');
    }
  }, true);
});
