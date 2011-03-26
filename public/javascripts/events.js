	
	var Events = {
		
		initialize: function()
		{
			var this_events = this;
			
			var starred = this.getStarred();
			for( var i = 0; i < starred.length; i++ )
			{
				$('span.star.objid-event-'+starred[i]).removeClass('off').addClass('on');
			}
			
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
			
			this.updateStarred();
			// window.localStorage.clear();
		},
		
		onStarred: function( id, is_starred )
		{
			if( is_starred )
				this.addStarred( id );
			else
				this.removeStarred( id );
		},
		
		getStarred: function()
		{
			var starred = window.localStorage.getItem('starred');
			return starred ? starred.split(',') : [];
		},
		
		setStarred: function( new_starred )
		{
			window.localStorage.setItem('starred', new_starred.join(','));
			this.updateStarred();
		},
		
		addStarred: function( id )
		{
			var starred = this.getStarred();
			for( var i = 0; i < starred.length; i++ )
			{
				if( starred[i] == id )
				{
					return false;
				}
			}
			starred.push(parseInt(id));
			this.setStarred( starred );
			return true;
		},
		
		removeStarred: function(id)
		{
			var starred = this.getStarred();
			var new_starred = [];
			for( var i = 0; i < starred.length; i++ )
			{
				if( starred[i] != id )
				{
					new_starred.push(starred[i]);
				}
			}
			
			if( starred.length == new_starred.length )
			{
				return false;
			}
			
			this.setStarred(new_starred);
			return true;
		},
		
		// Sends currently starred items to the server and retrieves HTML for starred items.
		updateStarred: function()
		{
			$.post( window.config.url+'/starred', {starred:this.getStarred()}, function( data )
			{
				$('#starred-list').html(data);
			});
		}
		
	}