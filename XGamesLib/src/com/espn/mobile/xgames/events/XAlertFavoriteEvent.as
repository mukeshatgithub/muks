package com.espn.mobile.xgames.events
{
	import com.espn.mobile.xgames.model.vo.alerts.XAlertFavoriteVO;
	
	import flash.events.Event;
	
	public class XAlertFavoriteEvent extends Event
	{
		public static const FAVORITE_ALERT_ON:String = "favoriteAlertOn";
		public static const FAVORITE_ALERT_OFF:String = "favoriteAlertOff";
		
		public static const FAVORITE_ALERT_ON_SUCCESS:String = "favoriteAlertOnSuccess";
		public static const FAVORITE_ALERT_ON_FAILED:String = "favoriteAlertOnFail";
		
		public static const FAVORITE_ALERT_OFF_SUCCESS:String = "favoriteAlertOffSuccess";
		public static const FAVORITE_ALERT_OFF_FAILED:String = "favoriteAlertOffFail";
		
		public static const ON_IOERROR:String = "onIOError";
		
		public var error:String;
		
		
			
		private var _data:XAlertFavoriteVO;
		
		public function XAlertFavoriteEvent(type:String, data:XAlertFavoriteVO=null)
		{
			super(type, true, false);
			_data = data;
		}
		
		override public function clone():Event
		{
			return new XAlertFavoriteEvent(type, _data);
		}
		
		public function get data():XAlertFavoriteVO
		{
			return _data;
		}
	}
}