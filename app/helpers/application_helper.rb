module ApplicationHelper

	def nav_link(link_text, link_path)
		class_name = "item " + (current_page?(link_path) ? "active" : "")
		#if sub-menu under account
		class_name = "item active" if link_text == "Account" && request.env['PATH_INFO'].match(/\/users\/(\d)*\/((edit))/)
		link_to link_text, link_path, class: class_name
	end
end
