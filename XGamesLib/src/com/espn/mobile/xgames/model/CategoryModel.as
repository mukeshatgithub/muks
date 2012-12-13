package com.espn.mobile.xgames.model
{
	import com.espn.mobile.xgames.events.AppErrorEvent;
	import com.espn.mobile.xgames.model.vo.VideoItemVO;
	import com.espn.mobile.xgames.service.BaseService;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	
	import mx.collections.ArrayCollection;
	
	public class CategoryModel extends BaseService
	{
		
		[Inject]
		public var appConfigModel:AppConfigModel;
		
		[Inject]
		public var newsModel:NewsModel;
		
//		[Inject]
//		public var videoModel:VideoModel;
		
		[Bindable]
		public var  sportsData:ArrayCollection;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		public function CategoryModel()
		{
			super();
		}
		
		/**
		 * 
		 * get filtered data on the basis of category
		 * 
		 */
		public function getCategoryData(url:String):void
		{
			var categoryUrl:String = "http://" + appConfigModel.settings.clusterServiceIP + url;
			read(categoryUrl);
			
		}
		
		/**
		 * 
		 * @override
		 * 
		 */		
		override protected function onResult(event:Event):void
		{
			super.onResult(event);
			parse(event.target.data);
		}
		
		/**
		 * 
		 * @override
		 * 
		 */		
		override protected function onError(event:IOErrorEvent):void
		{
			super.onError(event);
		}
		
		/**
		 * 
		 * @override
		 * 
		 */		
		override public function parse(data:Object):void
		{
			if(data == null)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));

			}
			else
			{
				setSportsData(JSON.parse(data as String));
			}
				
		}
		
		private function setSportsData(sportsObj:Object):void
		{
			try
			{
				sportsData = new ArrayCollection(sportsObj as Array);
				
				var collection:Array = new Array();
				var itemCount:int = 0;
				for each(var obj:Object in sportsData)
				{
					if(itemCount > 23)
						break;
					
					var videoItemVO:VideoItemVO = new VideoItemVO();
					videoItemVO.headline = obj.headline;
					videoItemVO.title = obj.title;
					videoItemVO.imageUrl = "http://" + appConfigModel.settings.imageUrlPrefix + obj.beauty.url;
					videoItemVO.id = obj.id;
					videoItemVO.date = obj.date;
					videoItemVO.videoId = obj.id;
					//videoDataProvider.addItem(videoItemVO);
					collection.push(videoItemVO);
					itemCount++
				}
				//videoDataProvider = tempCollection;
				//videoDataProvider = new ArrayCollection(collection);
				newsModel.videoDataProvider = new ArrayCollection(collection);
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}	
			
		}
		
		/**
		 *	get video url by videoId
		 *  
		 */
		private function getVideoById(id:String):String
		{
			var videoUrl:String = appConfigModel.settings.videoUrlPrefix;
			videoUrl = videoUrl.replace("{id}", id );
			
			return videoUrl;
		}
		
		
	}
}