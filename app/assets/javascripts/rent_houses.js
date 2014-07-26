//= require jquery.easing.min
//= require jquery.address
// image slider show
//= require jssor.slider.min
//= require leaflet
//= require leaflet.markercluster-src

var jssor_slider1 = null;
jssor_slider1_starter = function (containerId) {
  var options = {
    $ArrowNavigatorOptions: {
      $Class: $JssorArrowNavigator$,
      $ChanceToShow: 2
    }
  };
  if( jssor_slider1 ){
    delete jssor_slider1;
  }
  jssor_slider1 = new $JssorSlider$(containerId, options);
};

var rent_page = function () {


  // add input field by jQuery
  var max_input = 5;
  var inputs_wrapper = $('.img_input_wrapper');
  var add_button = $('.add_more_button');

  var x = inputs_wrapper.length;
  var fieldCount = 1;

  $(add_button).click( function(e) {

    if ( x <= max_input ){
      fieldCount++;

      $(inputs_wrapper).append('<div><div class="ui left labeled icon input">' +
        '<input id="rent_house_img" name="img[]" type="text" >' +
        '<i class="photo icon"></i>' +
        '<div class="ui corner label">' +
        '<i class="icon asterisk"></i> </div>'+ 
        '<a href="#" class="removeclass">×</a></div>'
        );
      x++;
    }
    return false;
  });

  $('body').on('click', '.removeclass', function(e){

    if( x > 1 ){
      $(this).parent('div').remove();
      x--;
    }
    return false;
  })
}

$(document).ready(rent_page)
