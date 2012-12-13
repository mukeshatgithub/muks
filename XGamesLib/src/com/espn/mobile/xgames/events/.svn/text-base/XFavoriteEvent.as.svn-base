package com.espn.mobile.xgames.events
{
	import com.espn.mobile.xgames.model.vo.XFavoriteVO;
	
	import flash.events.Event;
	
	public class XFavoriteEvent extends Event
	{
		
		public static const REMOVE_ITEM:String = "removeItem";
		public static const ADD_ITEM:String = "addItem";
		private var _data:XFavoriteVO;
		
		public static const MOBILE_APP_SUCESS:String = "mobileAppSucess";
		public static const MOBILE_APP_FAILED:String = "mobileAppFailed";
		
		public function XFavoriteEvent(type:String, data:XFavoriteVO = null):void
		{
			super(type, true, false);
			_data = data;
		}
		
		public function get data():XFavoriteVO
		{
			return _data;
		}
	}
}