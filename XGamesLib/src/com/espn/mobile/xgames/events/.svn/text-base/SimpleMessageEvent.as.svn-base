package com.espn.mobile.xgames.events
{
	import flash.events.Event;
	
	public class SimpleMessageEvent extends Event
	{
		public static const SHOW_SIMPLE_MESSAGE:String = "showSimpleMessage";
		private var _message:String;
		
		public function SimpleMessageEvent(type:String, message:String)
		{
			super(type, true, false);
			_message = message;
		}
		/**
		 * overrride of clone()
		 * 
		 */ 
		override public function clone():Event
		{
			return new SimpleMessageEvent(type, _message);
		}
		
		public function get message():String
		{
			return _message;
		}
	}
}