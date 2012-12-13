package com.espn.mobile.xgames.events
{
	import flash.events.Event;
	
	public class InAppBrowserEvent extends Event
	{
		public static const OPEN_BROWSER:String = "openBrowser";
		public static const BROWSER_CLOSED:String = "browserClosed";
		
		public var defaultTitle:String;
		public var contentUrl:String;
		public var contentType:String = "url";
		
		public function InAppBrowserEvent(type:String = OPEN_BROWSER)
		{
			super(type, true);
		}
		
		override public function clone():Event
		{
			return new InAppBrowserEvent(type);
		}
	}
}