// image slider show
//
    jssor_slider1_starter = function (containerId) {
        var options = {
            $ArrowNavigatorOptions: {
                $Class: $JssorArrowNavigator$,
                $ChanceToShow: 2
            }
        };
        var jssor_slider1 = new $JssorSlider$(containerId, options);
    };
