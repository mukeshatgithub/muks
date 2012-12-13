//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.service 
{
	import com.espn.mobile.xgames.events.AppErrorEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.ReturnKeyLabel;
	
	/**
	 * This class is responsible to load XMLs and Services and return the data.
	 * 
	 * 
	 * */
	public class BaseService extends EventDispatcher
	{
		public static var isServiceConnecting:Boolean; // NOPMD
		
		/** instance of webserviceURL */
		private var webserviceURL:URLRequest;

		/** instance of webserviceURL */
		private var lastUpdateTime:Date;
		private var lastEventResult:Event;
		
		
		
		public static const READ : String = "read";
		public static const ADD : String = "add";
		public static const DELTE : String = "delete";
		public static const UPDATE : String = "update";
		
		/** current action  */
		private var _serviceAction:String;
		
		public function get serviceAction():String
		{
			return _serviceAction;
		}
		

		/**
		 * Constructor BaseService()
		 * 
		 */ 
		public function BaseService() 
		{
			
		}
		
		/**
		 * 
		 * parse JSON data and convert to ActionScript object
		 * 
		 */		
		public function parse(data:Object):void
		{
		}
		
		/**
		 * loadXML() - Load the configuratuion XML
		 * 
		 */ 
		public function loadXML(xmlPath:String):void 
		{
			webserviceURL = new URLRequest(xmlPath);
			connectWebservice();
		}
		
		/**
		 * Rest read opeartation
		 * 
		 */ 
		public function read(servicePath:String, params:URLVariables = null, isDelayAllow:Boolean = false, methodType:String = URLRequestMethod.GET):void 
		{
			// set the modelAction
			_serviceAction = READ;
			
			
			
			/*
			
			Remove the checking for last update time.
			*/
			//if(isRefresh() || !isDelayAllow)
			
			
			if(true)
			{
			
				//trace("Read Called");
				webserviceURL = new URLRequest(servicePath);
				webserviceURL.method = methodType;
				
				if(params != null)
					webserviceURL.data = params;
				
				connectWebservice();			
			}
			else
			{
				onResult(lastEventResult);
			}
		}
		
		
		/**
		 * Rest - write
		 * 
		 */ 
		public function write(servicePath:String, params:Object = null):void // NOPMD
		{
			trace(servicePath);
			webserviceURL = new URLRequest(servicePath);
			webserviceURL.requestHeaders = [new URLRequestHeader("Content-Type", "application/json")]; 
			webserviceURL.method = URLRequestMethod.PUT;
			
			if(params != null)
				webserviceURL.data =  JSON.stringify(params);
			
			connectWebservice();			
		}
		
		
		private function connectWebservice():void
		{
			var objHTTP:URLLoader = new URLLoader();
			
			objHTTP.addEventListener(Event.COMPLETE, onResult);
			objHTTP.addEventListener(IOErrorEvent.IO_ERROR, onError);
			
			isServiceConnecting = true;
			
			objHTTP.load(webserviceURL);
			
		}
		
		/**
		 * Result handler - onResult
		 * 
		 */ 
		protected function onResult(event:Event):void
		{
			isServiceConnecting = false;

			switch(_serviceAction)
			{
				case READ:
				{
					lastEventResult = event;
					lastUpdateTime = new Date();
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
		/**
		 * Error handler - onError
		 * 
		 */ 
		protected function onError(event:IOErrorEvent):void
		{
			//Alert.show("Error in connecting service \n" + evt.text);
			trace("xml error " + event.toString());
			//this.dispatchEvent(new AppErrorEvent(AppErrorEvent.ERROR_CONNECTING_SERVICE, event));
			
			isServiceConnecting = false;
		}
		
		private function isRefresh():Boolean
		{
			if(lastUpdateTime)
			{
				var now:Date = new Date();
				
				if(now.date > lastUpdateTime.date)
					return true;
				
				var currMin:Number = ( now.hours * 60 ) + now.minutes;
				var prevMin:Number = ( lastUpdateTime.hours * 60 ) + lastUpdateTime.minutes;
				
				var diffMin:Number = currMin - prevMin; 
				if( diffMin > 30)
					return true;
				else
					return false;
				
			}
			
			return true;
		}
		
	} // end class
} // end package