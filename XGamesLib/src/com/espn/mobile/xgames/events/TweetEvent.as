package com.espn.mobile.xgames.events
{
	import com.espn.mobile.xgames.constants.AppConstants;
	
	import flash.events.Event;
	
	public class TweetEvent extends Event
	{
		public static const ON_TWITTER_ICON_CLICK:String = "twIconClick";
		public static const DISPOSE_PIN_VALIDATION:String = "disposePinValidation";
		
		private var _shareUrl:String = " ";
		private var _headline:String = " ";

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
		
		
		public function TweetEvent(type:String = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{ 
			return new TweetEvent(type, bubbles);
		}
	}
}