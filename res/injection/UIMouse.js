var setupScrolling = function(objectID){

	if(!swfobject)return null;
	
	var flashObject = document.getElementsByName(objectID)[0];
	var eventListenerObject = flashObject;
	var isWebkit = false;
		
	if (navigator && navigator.vendor){
		isWebkit = navigator.vendor.match("Apple") || navigator.vendor.match("Google");
	}
	
	// some events will need to point to the containing object tag
	if (isWebkit && flashObject.parentNode.tagName.toLowerCase() == "object")
	{
		eventListenerObject = flashObject.parentNode;
	}
		
	var dispatch = function(event){
		var deltaX = 0;
		var deltaY = 0;
		
		// getting event if internet explorer.
		if(!event)
			event = window.event;
			
		// IE/Webkit/Opera
		if(event.wheelDelta){
		
			// horizontal scrolling is supported in webkit.
			if(event.wheelDeltaX){
				// Webkit can scroll two directions simultaneously
				deltaX = event.wheelDeltaX;
				deltaY = event.wheelDeltaY;
			}else{
				// fallback to vertical scrolling only, interface.
				deltaY = event.wheelDelta;
			}
			// normalize the delta value.
			deltaX /= 120;
			deltaY /= 120;
			
			// Opera case (the delta is inverted by default), opera doesn't support horizontal scrolling.
			if (window.opera){
				deltaY = -deltaY;
			}
					
		}// Firefox 
		else if(event.detail){
			deltaY = -event.detail/1.5;
			// horizontal scroling is supported in > 3.1
			if(event.axis == event.HORIZONTAL_AXIS){
				deltaX = deltaY;
				deltaY = 0;
			}
		}
		// prevents the default behaivor.
		if(event.preventDefault)
			event.preventDefault();
			
		// dispatch the event to flash.
		try{
			flashObject.scrollEvent(deltaX, deltaY);
		}catch(all){}
	}
	
	// triggerd when scrolling accords in the window.
	var deltaDispatcher = function(event){
		// dispatches the event to flash.
		dispatch(event);
	}
	
	// adding listners to the window.
	if(window.addEventListner){
		if(isWebKit){
			window.onmousewheel = deltaDispatcher;
		}else{
			window.addEventListener("DOMMouseScroll", deltaDispatcher, false);
		}
	}else{
		document.onmousewheel = deltaDispatcher;
	}
	
	// end impl.
}