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
	
	def render_date time
		return time.day.to_s + " " + time.strftime('%B')
	end
	
	def render_time time
		return time.hour.to_s + ":" + time.strftime('%M')
	end
	
	# As there seems to be problem with rendering %B %e with strftime, I made this
	# helper to use for rendering event dates
	def render_time_span event
		# return time.strftime("%c")
		s = render_date( event.starts_at ) + ' ' + render_time( event.starts_at );
		s << ' <span class="slash">/</span> '
		if event.ends_at
			if event.starts_at.month == event.ends_at.month and event.starts_at.year == event.ends_at.year
				s << render_time( event.ends_at )
			else
				s << render_date( event.ends_at ) + ' ' + render_time( event.ends_at )
			end
		else
			s << "N/A"
		end
		
		return s.html_safe;
	end
end
