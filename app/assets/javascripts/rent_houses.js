	//= require jquery.easing.min
	//= require jquery.address
	// image slider show

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
					
					$(inputs_wrapper).append('<div><div class="ui left labeled icon input"> \
											 <input id="rent_house_img" name="img[]" type="text" > \
													<i class="photo icon"></i> \
													<div class="ui corner label"> \
														<i class="icon asterisk"></i> \
													</div> \
											<a href="#" class="removeclass">×</a></div>'
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
	$(window).bind('page:change', rent_page)
