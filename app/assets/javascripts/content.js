var page = function () {
	$('.response.menu .item')        
    	.tab();
	$('.ui.dropdown')
	  .dropdown()
	  ;
}

$(document).ready(page)
$(window).bind('page:change', page)
