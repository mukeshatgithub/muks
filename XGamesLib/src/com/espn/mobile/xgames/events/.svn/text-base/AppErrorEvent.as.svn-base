//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.events
{
	import flash.events.Event;
	
	/**
	 * AppDataEvent
	 */
	public class AppErrorEvent extends Event
	{
		public static const NETWORK_FAILURE:String = "networkFailure";
		public static const ERROR_CONNECTING_SERVICE:String = "errorConnectingService";
		public static const INVALID_DATA_FORMAT:String = "invalidDataFormat";
		public static const INVALID_VIDEO_URL:String = "invalidVideoUrl";
		public static const RETRY_CALLBACK:String = "retryCallBack";
		public static const SQLITE_ERROR:String = "sqliteError";
		public static const ERROR_CLOSED:String = "errorClosed";
		
		/**
		 * variable to hold error details
		 */ 
		private var _data:Object;
		
		/**
		 * Event constructor
		 * 
		 */ 
		public function AppErrorEvent(type:String, data:Object, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			this._data = data;
			super(type, bubbles, cancelable);
		}
		
		/**
		 * overrride of clone()
		 * 
		 */ 
		override public function clone():Event
		{
			return new AppErrorEvent(type, _data, true);
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		

	}
}