package com.espn.mobile.xgames.events
{
	import flash.events.Event;
	
	public class XGamesANEEvent extends Event
	{
		public static const ANE_WATCH_ESPN:String = "ANE_WATCH_ESPN";
		public static const ANE_PLAY_VIDEO:String = "ANE_PLAY_VIDEO";
		
		private var _data:Object;
		
		public function XGamesANEEvent(type:String, data:Object = null)
		{
			super(type, true, false);
			_data = data;
		}
		
		public function get data():Object
		{
			return _data;
		}
	}
}