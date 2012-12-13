package com.espn.mobile.xgames.events
{
	import com.espn.mobile.xgames.model.vo.AppConfigVO;
	
	import flash.events.Event;
	
	public class XEvent extends Event
	{
		
		public static const SAVE_X_SETTINGS:String = "saveSettings";
		public static const UPDATE_X_SETTINGS:String = "updateSettings";
		
		
		private var _data:AppConfigVO;
		
		public function XEvent(type:String, data:AppConfigVO = null)
		{
			super(type, true, false);
			_data = data;
		}
		
		public function get data():AppConfigVO
		{
			return _data;
		}
	}
}