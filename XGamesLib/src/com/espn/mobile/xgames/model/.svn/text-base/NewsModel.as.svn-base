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
	import flash.events.IOErrorEvent;
	import flash.text.ReturnKeyLabel;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * The Video Model is the primary data store for storing all video and pulse related data coming in from the JSON.
	 * The model creates appropriate value objects to parse and store the incoming data. 
	 * The model also places individual service calls whenever a category of sport is changed to get related data.
	 */	
	public class NewsModel extends BaseService
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
		public static const FACEBOOK:String = "facebook";
		public static const INSTAGRAM:String = "instagram";
		public static const PODCAST:String = "podcast";
		public static const GEAR:String = "gear";
		public static const YOUTUBE:String = "youtube";
		
		/**
		 * Class constructor.
		 */	
		public function NewsModel()
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
			//parse(event.target.data);
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
		 * 
		 * Service error handler
		 * 
		 */
		override protected function onError(event:IOErrorEvent):void
		{
			dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.ERROR_CONNECTING_SERVICE, event));
		}

		
		/**
		 * method to parse the incoming news data json.
		 */	
		private function parsePulseData(newsData:Object):void
		{
			try
			{
				//pulseData = new ArrayCollection(newsData.stack.items);
				var pulseItems:Array = newsData.pulse as Array;
				//pulseDataProvider = new ArrayCollection();
				var pulseCollection:Array = new Array();
				for (var i:uint = 0; i < pulseItems.length; i++)
				{
					var vo:PulseItemVO = new PulseItemVO(); 
					if (pulseItems[i].id !=null)
					{
						vo.id = String(pulseItems[i].id);
						//vo.type = FACEBOOK;
						vo.type = String(pulseItems[i].type);
						switch (vo.type)
						{
							case ARTICLE:
								vo.title = String(pulseItems[i].headline); 
								vo.link = "http://" + appConfigModel.settings.clusterServiceIP + String(pulseItems[i].link.url);
								break; 
							case GALLERY:
								vo.title = String(pulseItems[i].title); 
								vo.link = String(pulseItems[i].link.url);
								vo.items = new ArrayCollection(); 
								var images:Array = (pulseItems[i].photos) as Array;
								for (var j:uint = 0; j < images.length; j++)
								{
									var imgVO:ImageGalleryVO = new ImageGalleryVO(); 
									imgVO.url = appConfigModel.localSettings.imageHost + String(images[j].beauty.url);
									imgVO.shareUrl = "http://" + appConfigModel.settings.clusterServiceIP + images[j].link.url;
									imgVO.headline = images[j].headline;
									imgVO.description = images[j].description;
									if (images[j].beauty.credit!=null)
										imgVO.credit = String(images[j].beauty.credit); 
									imgVO.width = Number(images[j].beauty.width); 
									imgVO.height = Number(images[j].beauty.height);
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
								vo.selectedVideoItem.shareUrl = "http://" + appConfigModel.settings.clusterServiceIP + pulseItems[i].link.url;
								break; 
							case TWEET:
								vo.title = String(pulseItems[i].author.name); 
								vo.tweetDescription = String(pulseItems[i].description);
								vo.tweetId = String(pulseItems[i].id);
								vo.tweetAuthorName = String(pulseItems[i].author.name);
								vo.tweetIconUrl = String(pulseItems[i].beauty.url) 
								break;
							case FACEBOOK:
								//facebook parsing code here
								vo.title = "Facebook";
								vo.contentHTML = "<!-- START FB --> <div class='connect'> <iframe src='http://www.facebook.com/plugins/likebox.php?id=102055561963&amp;width=303&amp;connections=0&amp;stream=true&amp;header=false&amp;height=250' scrolling='no' frameborder='0' style='border:none; overflow:hidden; width:303px; height:250px;' allowTransparency='true'></iframe> </div> <!-- END FB -->"
								break; 
							case INSTAGRAM:
								//instagram parsing code here
								vo.title = "srielly";
								vo.instagramProfileURL ="http://images.instagram.com/profiles/profile_496225_75sq_1332863405.jpg";
								vo.instagramImageURL = "http://distilleryimage7.s3.amazonaws.com/b19f815408b011e2afde22000a1c8658_7.jpg";
								break;
							case PODCAST:
								//podcast parsing code here
								break; 
							case GEAR:
								//gear parsing code here
								break; 
							case YOUTUBE:
								//youtube parsing code here 
								vo.title = "Fast Cup Stacking, Oh My God! - Video";
								vo.contentHTML = "<iframe width='420' height='315' src='http://www.youtube.com/embed/8pbFR3jXWi8' frameborder='0' allowfullscreen></iframe>";
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
				sportsData = new ArrayCollection(newsData.hub.categories);
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
				for each(var obj:Object in newsData.hub.categories)
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