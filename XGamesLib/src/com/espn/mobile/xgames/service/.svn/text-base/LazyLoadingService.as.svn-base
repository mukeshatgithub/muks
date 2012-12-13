//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.service 
{
	import com.espn.mobile.xgames.events.AppErrorEvent;
	import com.espn.mobile.xgames.events.LazyLoadingServiceEvent;
	
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
	import flash.utils.setTimeout;
	
	/**
	 * This class is responsible to load XMLs and Services and return the data.
	 * 
	 * 
	 * */
	public class LazyLoadingService extends EventDispatcher
	{
		public static var isServiceConnecting:Boolean; // NOPMD
		
		/** instance of webserviceURL */
		private var webserviceURL:URLRequest;

		/** instance of webserviceURL */
		private var lastEventResult:Event;

		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		/**
		 * Constructor BaseService()
		 * 
		 */ 
		public function LazyLoadingService() 
		{
			
		}
		
		[PostConstruct]
		public function onReady():void
		{
			trace(dispatcher);
		}
		
		/**
		 * Rest read opeartation
		 * 
		 */ 
		public function read(servicePath:String):void 
		{
			
				//trace("Read Called  "+servicePath);
				webserviceURL = new URLRequest(servicePath);
				webserviceURL.method = URLRequestMethod.GET;
				
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
			
			lastEventResult = event;
			
			fireEvent();
			//setTimeout(fireEvent, 1000);
			//lastEventResult = event;
		}
		
		private function fireEvent():void
		{
			try
			{
				var data:Object = JSON.parse(lastEventResult.target.data.toString());
				dispatchEvent(new LazyLoadingServiceEvent(LazyLoadingServiceEvent.SERVICE_LOADED, data));
			}
			catch(e:Error)
			{
				dispatchEvent(new LazyLoadingServiceEvent(LazyLoadingServiceEvent.SERVICE_LOADED, new Object()));
				dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
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
			
			//dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.ERROR_CONNECTING_SERVICE, event));
			isServiceConnecting = false;
			fireEvent();
		}
		
	} // end class
} // end package