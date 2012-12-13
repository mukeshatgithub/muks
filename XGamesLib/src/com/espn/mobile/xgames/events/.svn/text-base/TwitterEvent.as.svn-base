package com.espn.mobile.xgames.events
{
	import flash.events.Event;
	import flash.text.ReturnKeyLabel;
	
	public class TwitterEvent extends Event
	{
		public static const TWITTER_ICON_CLICK:String = "onTwitterIconClicked";
		public static const DISPOSE_PIN_VALIDATION:String = "disposeTwitterPinValidation";
		
		private var _shareUrl:String;
		
		public function get shareUrl():String
		{
			return _shareUrl;
		}

		public function set shareUrl(value:String):void
		{
			_shareUrl = value;
		}
		
		/**
		 *	constructor 
		 * 
		 */	
		public function TwitterEvent(type:String = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
		}

		/**
		 *	@override
		 */	
		override public function clone():Event
		{ 
			return new TwitterEvent(type, bubbles);
		}
	}
}