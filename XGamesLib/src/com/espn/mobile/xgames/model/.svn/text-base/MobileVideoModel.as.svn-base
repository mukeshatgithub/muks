//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.model
{
	import com.espn.mobile.xgames.events.AppErrorEvent;
	import com.espn.mobile.xgames.events.MobileVideoEvent;
	import com.espn.mobile.xgames.service.BaseService;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * 
	 * @author rmish8
	 * 
	 * VideoModel is used to get and parse the Video
	 * from the Service API. VideoModel also maintains 
	 * a cache for loaded videos to avoid the serive calls
	 * to load the same video.
	 * 
	 */	
	public class MobileVideoModel extends BaseService
	{
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Inject]
		public var appConfigModel:AppConfigModel;
		
		[Bindable]
		public var videoUrl:String;
		
		public var videoId:String;
		public var videoTitle:String;
		public var videoHeadline:String;
		
		private var _fromNotification:Boolean = false;
		
		private var videoCache:Dictionary = new Dictionary();
		
		public var mobileVideoEvent:MobileVideoEvent;
		
		/**
		 *	@override 
		 * 	Result handler override
		 * 
		 */		
		override protected function onResult(event:Event):void
		{
			try
			{
				super.onResult(event);
				var videoResultObj:Object = JSON.parse(event.target.data as String);
				videoUrl = videoResultObj.videos[0].links.mobile.source.href;
				videoCache[videoId] = videoUrl;
				videoTitle = videoResultObj.videos[0].headline;
				videoHeadline = videoResultObj.videos[0].headline;
				
				if(_fromNotification) {
					//dispatch the video event for notification
					mobileVideoEvent = new MobileVideoEvent(MobileVideoEvent.NOTIFICATION_PASS_URL);
					mobileVideoEvent.videoURL = videoCache[videoId];
					if(this.videoTitle)
						mobileVideoEvent.videoTitle = this.videoTitle;
					dispatcher.dispatchEvent(mobileVideoEvent);
				} else {
					//Dispatch the event to play the video
					mobileVideoEvent = new MobileVideoEvent(MobileVideoEvent.PASS_URL);
					mobileVideoEvent.videoURL = videoCache[videoId];
					dispatchEvent(mobileVideoEvent);
				}
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			
		}
		
		/**
		 *	@constructor 
		 * 
		 */		
		public function MobileVideoModel()
		{
			super();
		}
		
		/**
		 *	get video url by videoId
		 *  
		 */
		public function getVideoById(videoId:String, fromNotification:Boolean=false):void
		{
			this._fromNotification = fromNotification;
			this.videoId = videoId;
			this.videoUrl = "";
			var videoUrl:String = appConfigModel.localSettings.videoHost;
			videoUrl = videoUrl.replace("{id}", videoId);
			if(!videoCache[videoId]) {
				read(videoUrl);
			} else {
			    this.videoUrl = videoCache[videoId];
				
				//Dispatch the event to play the video
				if(_fromNotification) {
					
					//dispatch the video event for notification
					mobileVideoEvent = new MobileVideoEvent(MobileVideoEvent.NOTIFICATION_PASS_URL);
					mobileVideoEvent.videoURL = videoCache[videoId];
					if(this.videoTitle)
						mobileVideoEvent.videoTitle = this.videoTitle;
					dispatcher.dispatchEvent(mobileVideoEvent);
					
				} else {
					mobileVideoEvent = new MobileVideoEvent(MobileVideoEvent.PASS_URL);
					mobileVideoEvent.videoURL = videoCache[videoId];
					dispatchEvent(mobileVideoEvent);
				}
				
			}
		}
		
	}
}