$(document).ready(function() {
  $('.collapsed-hamburger-icon').on('click', function() {
    $('.navbar-collapsible-item:not(.hidden-item)').transition('fade down');
  });

  if (window.innerWidth < 768) {
    $('.navbar-collapsible-item').transition('hide');
  }

  window.addEventListener('resize', function(event) {
    if (window.innerWidth >= 768) {
      $('.navbar-collapsible-item:not(.hidden-item)').transition('show');
    } else {
      $('.navbar-collapsible-item:not(.hidden-item)').transition('hide');
    }
  }, true);
});
