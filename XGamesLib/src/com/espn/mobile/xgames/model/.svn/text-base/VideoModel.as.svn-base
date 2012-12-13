//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.model
{
	import com.espn.mobile.xgames.constants.AppConstants;
	import com.espn.mobile.xgames.events.AppErrorEvent;
	import com.espn.mobile.xgames.model.vo.CategoryVO;
	import com.espn.mobile.xgames.model.vo.EventListVO;
	import com.espn.mobile.xgames.model.vo.ImageGalleryVO;
	import com.espn.mobile.xgames.model.vo.LinkVO;
	import com.espn.mobile.xgames.model.vo.PulseItemVO;
	import com.espn.mobile.xgames.model.vo.VideoItemVO;
	import com.espn.mobile.xgames.service.BaseService;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.text.ReturnKeyLabel;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * The Video Model is the primary data store for storing all video and pulse related data coming in from the JSON.
	 * The model creates appropriate value objects to parse and store the incoming data. 
	 * The model also places individual service calls whenever a category of sport is changed to get related data.
	 */	
	public class VideoModel extends BaseService
	{
		
		[Inject]
		public var appConfigModel:AppConfigModel;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Bindable]
		public var newsData:Object;
		
		[Bindable]
		public var sportsData:Object;
		
		[Bindable]
		public var videoDataProvider:ArrayCollection;
		
		[Bindable]
		public var categories:ArrayCollection;
		
		[Bindable]
		public var isVideoPlaying:Boolean;
		
		private var keys:Object;
		
		[Bindable]
		public var pulseDataProvider:ArrayCollection;
		
		[Bindable]
		public var selectedCategory:String;
		
		public static const ARTICLE:String = "article"; 
		public static const GALLERY:String = "gallery"; 
		public static const VIDEO:String = "video"; 
		public static const TWEET:String = "tweet";
		
		/**
		 * Class constructor.
		 */	
		public function VideoModel()
		{
			super();
		}
		
		/**
		 * public method to return news from the model.
		 */	
		public function getNews():void
		{
			//	read(appConfigModel.getServicePath(AppConstants.NEWS));
		}
		
		/**
		 * override method for on load result handler.
		 */	
		override protected function onResult(event:Event):void
		{
			super.onResult(event);
			parse(event.target.data);
		}
		
		/**
		 * 
		 * parse JSON data and convert to ActionScript object
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
				newsData = data;
				setSportsData(newsData);
				setCategoriesData(newsData);
				parsePulseData(newsData);
			}
		}
		
		/**
		 * method to parse the incoming news data json.
		 */	
		private function parsePulseData(newsData:Object):void
		{
			try
			{
				//pulseData = new ArrayCollection(newsData.stack.items);
				var pulseItems:Array = newsData.data.pulse as Array;
				//pulseDataProvider = new ArrayCollection();
				var pulseCollection:Array = new Array();
				for (var i:uint = 0; i < pulseItems.length; i++)
				{
					var vo:PulseItemVO = new PulseItemVO(); 
					if (pulseItems[i].id !=null)
					{
						vo.id = String(pulseItems[i].id);
						vo.type = String(pulseItems[i].type);
						switch (vo.type)
						{
							case ARTICLE:
								vo.title = String(pulseItems[i].headline); 
								vo.link = String(pulseItems[i].link.url);
								break; 
							case GALLERY:
								vo.title = String(pulseItems[i].title); 
								vo.link = String(pulseItems[i].link.url);
								vo.items = new ArrayCollection(); 
								var images:Array = (pulseItems[i].photos) as Array;
								for (var j:uint = 0; j < images.length; j++)
								{
									var imgVO:ImageGalleryVO = new ImageGalleryVO(); 
									imgVO.url = appConfigModel.localSettings.imageHost + String(images[j].url);
									if (images[j].credit!=null)
										imgVO.credit = String(images[j].credit); 
									imgVO.width = Number(images[j].width); 
									imgVO.height = Number(images[j].height);
									vo.items.addItem(imgVO);
								}
								break;
							case VIDEO:
								vo.title = String(pulseItems[i].headline); 
								vo.link = appConfigModel.localSettings.imageHost + String(pulseItems[i].beauty.url);
								vo.videoID = String(pulseItems[i].beauty.id);
								vo.selectedVideoItem = new VideoItemVO(); 
								vo.selectedVideoItem.videoId = vo.videoID; 
								vo.selectedVideoItem.title = vo.title; 
								vo.selectedVideoItem.headline = vo.title; 
								vo.selectedVideoItem.imageUrl = vo.link;
								break; 
							case TWEET:
								vo.title = String(pulseItems[i].author.name); 
								vo.tweetDescription = String(pulseItems[i].description);
								vo.tweetId = String(pulseItems[i].id);
								vo.tweetAuthorName = String(pulseItems[i].author.name);
								vo.tweetIconUrl = String(pulseItems[i].beauty.url) 
								break; 
						}
						//trace(vo.type, vo.title, vo.link);
						pulseCollection.push(vo);
					}
				}
				
				pulseDataProvider = new ArrayCollection(pulseCollection);
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			
		}
		
		/**
		 * 
		 * populate the videoDataProvider for with first video set
		 * 
		 */		
		public function setSportsData(newsData:Object):void
		{
			try
			{
				sportsData = new ArrayCollection(newsData.data.hub.categories);
				//var videoArray:Array = sportsData[0];
				//videoDataProvider = new ArrayCollection();
				var collection:Array = new Array();
				for each(var obj:Object in sportsData)
				{
					if(obj.items)
					{
						selectedCategory = obj.link.text.toUpperCase();
						
						for each(var videoItem:Object in obj.items)
						{
							var videoItemVO:VideoItemVO = new VideoItemVO();
							videoItemVO.headline = videoItem.headline;
							videoItemVO.title = videoItem.title;
							videoItemVO.imageUrl = appConfigModel.localSettings.imageHost + videoItem.beauty.url;
							videoItemVO.id = videoItem.id;
							videoItemVO.date = videoItem.date;
							videoItemVO.videoId = videoItem.id;
							//videoDataProvider.addItem(videoItemVO);
							collection.push(videoItemVO);
						}
						
					}
				}
				//videoDataProvider = tempCollection;
				videoDataProvider = new ArrayCollection(collection);
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			
		}
		
		/**
		 * public method to set data for the categories.
		 */	
		public function setCategoriesData(newsData:Object):void
		{
			try
			{
				var collection:Array = new Array();
				for each(var obj:Object in newsData.data.hub.categories)
				{
					var category:CategoryVO = new CategoryVO();
					//	categories.fill(obj);
					category.title = obj.link.text;
					var linkVO:LinkVO = new LinkVO();
					linkVO.api = obj.link.api;
					linkVO.url = obj.link.api;
					category.link = linkVO;
					collection.push(category);
				}
				
				categories = new ArrayCollection(collection);
				
				//Getting the events for the default selected sport 
				//getAthletesData(sportsCategories.getItemAt(0).api, SPORTS_EVENTS);7
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}				
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
		 * method to remove duplicates from the collection.
		 */	
		private function onRemovedDuplicates(item:EventListVO, idx:uint = 0, arr:Array = null):Boolean 
		{
			if (keys.hasOwnProperty(item.listLabel)) {
				/* If the keys Object already has this property,
				return false and discard this item. */
				return false;
			} else {
				/* Else the keys Object does *NOT* already have
				this key, so add this item to the new data
				provider. */
				keys[item.listLabel] = item;
				return true;
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