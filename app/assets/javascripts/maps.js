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
