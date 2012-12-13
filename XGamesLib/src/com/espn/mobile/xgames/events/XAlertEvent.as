package com.espn.mobile.xgames.events
{
	import com.espn.mobile.xgames.model.vo.alerts.AlertPayloadVO;
	
	import flash.events.Event;
	
	public class XAlertEvent extends Event
	{
		
		public static const ALERT_REGISTRATION_SUCESSFULL:String = "registrationSucessfull";
		public static const ALERT_REGISTRATION_UNSUCESSFULL:String = "registrationUnsucessfull";
		public static const ALERT_LOGIN_SUCESSFULL:String = "loginSucessfull";
		public static const ALERT_LOGIN_UNSUCESSFULL:String = "loginUnsucessfull";
		public static const ALERT_LOGOUT_SUCESSFULL:String = "logoutSucessfull";
		public static const ALERT_LOGOUT_UNSUCESSFULL:String = "logoutUnsucessfull";
		public static const ALERT_NOT_AVAILABLE:String = "alertAreNotAvailable";
		public static const ALERT_IOS_NOTIFICATION:String = "alertIosNotification";
		
		public static const INITIALIZE_ALERTS:String = "initializeAlerts";
		public static const ENABLE_ALERTS:String = "enableAlerts";
		public static const DISABLE_ALERTS:String = "disableAlerts";
		
		public static const NOTIFICATION_RECEIVED:String = "notofcationreceived";
		public static const PARSE_NOTIFICATION:String = "parseNotification";
		
		
		
		public static const SERVER_ERROR:String = "serverError";
		
		
		
		public static const ALREADY_REGISTERED:String = "alreadyRegistered";
		
		private var _data:AlertPayloadVO;
		public var appId:String;
		public var rawPayload:Object;
		
		public function XAlertEvent(type:String, data:AlertPayloadVO = null)
		{
			super(type, true, false);
			_data = data;
		}
		
		/**
		 * overrride of clone()
		 * 
		 */ 
		override public function clone():Event
		{
			return new XAlertEvent(type, _data);
		}
		
		public function get data():AlertPayloadVO
		{
			return _data;
		}
	}
}