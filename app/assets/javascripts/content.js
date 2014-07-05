var page = function () {
	$('.ui.dropdown')
	  .dropdown()
	  ;
}

$(document).ready(page)
$(window).bind('page:change', page)
