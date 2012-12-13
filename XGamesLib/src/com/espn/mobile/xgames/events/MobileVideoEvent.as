package com.espn.mobile.xgames.events
{
	import flash.events.Event;
	
	public class MobileVideoEvent extends Event
	{
		public static const LOAD_VIDEO:String = "loadMobileVideo";
		public static const PASS_URL:String = "passVideoURL";
		public static const NOTIFICATION_PASS_URL:String = "NOTIFICATION_PASS_URL";
		
		
		public var videoID:String;
		public var videoURL:String;
		public var videoTitle:String;
		
		
		public function MobileVideoEvent(type:String)
		{
			super(type, true);
		}
		
		override public function clone():Event
		{
			return new MobileVideoEvent(type);
		}
	}
}