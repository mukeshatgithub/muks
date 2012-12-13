package com.espn.mobile.xgames.events
{
	import com.espn.mobile.xgames.model.vo.alerts.AlertPayloadVO;
	
	import flash.events.Event;
	
	public class NotificationAlertEvent extends Event
	{
		public static const ALERT_RECEIVED:String = "alertReceived";
		public var alertPayload:AlertPayloadVO;
		
		/**
		 * 
		 * @param type
		 * @constructor
		 */		
		public function NotificationAlertEvent(type:String, alertPayload:AlertPayloadVO)
		{
			super(type, true);
			this.alertPayload = alertPayload;
		}
		
		/**
		 * @override 
		 */		
		override public function clone():Event
		{
			return new NotificationAlertEvent(type, alertPayload);
		}
	}
}