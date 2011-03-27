	
	var Events = {
		
		initialize: function()
		{
			var this_events = this;
			
			$(document).delegate( 'span.star', 'click', function( e )
			{
				e.preventDefault();
				e.stopPropagation();
				
				var id = Util.getObjId(this);
				var other = $('.'+ id[0] +' span.star');
				
				if( $(this).hasClass('on') )
				{
					this_events.onStarred( id[2], false );
					other.each( function() {
						$(this).removeClass('on').addClass('off');
					});
				}
				else
				{
					this_events.onStarred( id[2], true );
					other.each( function() {
						$(this).removeClass('off').addClass('on');
					});
				}
			});
			
			$(document).delegate( '.box.event', 'hover', function(e)
			{
				var id = Util.getObjId(this);
				if( e.type == 'mouseenter' )
				{
					$('.box.event.'+ id[0]).each( function()
					{
						$(this).addClass('hover');
					});
				}
				else
				{
					$('.box.event.'+ id[0]).each( function()
					{
						$(this).removeClass('hover');
					});
				}
			});
			
			// ToDo: Update starred items?
		},
		
		onStarred: function( id, is_starred )
		{
			console.log( window.config );
			var url = window.config.url +"/events/star/"+ ( is_starred ? 'on' : 'off' ) +'/'+id;
			$.get( url, null, function( data )
			{
				$("#starred-list").html( data );
				$("#starred-list .new").fadeIn();
			});
		}
	}