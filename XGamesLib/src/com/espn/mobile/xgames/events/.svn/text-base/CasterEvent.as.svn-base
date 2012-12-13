package com.espn.mobile.xgames.events
{
	import flash.events.Event;
	
	public class CasterEvent extends Event
	{
		public static const CASTER_CONNECTED:String = "casterConnected";
		public static const CASTER_CLOSE:String = "casterClose";
		public static const CASTER_DATA:String = "casterData";
		public static const CASTER_ERROR:String = "casterError";
		
		private var _data:*;
		
		public function CasterEvent(type:String, data:* = null)
		{
			super(type, true, false);
			_data = data;
		}
		
		public function get data():*
		{
			return _data;
		}
	}
}