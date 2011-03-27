module EventsHelper
	# Creates a integer representation of year and month.
	# Used to render schedule.
	def make_month_stamp time
		return time.year * 100 + time.month
	end
	
	
	# Renders a progress bar by given passed an total days
	def render_progress passed, total
	
		s = '<div class="progress bar">';
		(passed).times do
			s << '<span class="p"></span>'
		end
		s<< '<span class="c"></span>'
		(total-passed-1).times do
			s << '<span class="r"></span>'
		end
		s << '</div>'
		
		return s.html_safe
	end
end
