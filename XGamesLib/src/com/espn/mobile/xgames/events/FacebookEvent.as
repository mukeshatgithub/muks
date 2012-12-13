package com.espn.mobile.xgames.events
{
	import com.espn.mobile.xgames.constants.AppConstants;
	
	import flash.events.Event;
	
	/**
	 * 
	 * FacebookEvent class
	 * 
	 */	
	public class FacebookEvent extends Event
	{
		/**
		 *	@private 
		 */		
		public static const FB_ICON_CLICK:String = "fbIconClick";
		public static const FACEBOOK_ICON_CLICK:String = "facebook_icon_click";
		
		private var _shareUrl:String;
		
		private var _headline:String;
		
		public function get headline():String
		{
			return _headline;
		}
		
		public function set headline(value:String):void
		{
			_headline = value + " " + AppConstants.XGAMES_HASHTAG;
		}
		

		
		public function get shareUrl():String
		{
			return _shareUrl;
		}
		
		public function set shareUrl(value:String):void
		{
			_shareUrl = value;
		}
		
		/**
		 * 
		 * constructor
		 */		
		public function FacebookEvent(type:String = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * 
		 * @override
		 * 
		 */		
		override public function clone():Event
		{
			return new FacebookEvent(type, bubbles);
		}
	}
}