module ContentHelper
	
		def current_page?(page)
			params[:action] == page
		end

end
