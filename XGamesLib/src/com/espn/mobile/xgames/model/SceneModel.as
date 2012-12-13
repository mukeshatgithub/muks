//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.model
{
	import com.espn.mobile.xgames.events.AppErrorEvent;
	import com.espn.mobile.xgames.model.vo.ImageGalleryVO;
	import com.espn.mobile.xgames.model.vo.PulseItemVO;
	import com.espn.mobile.xgames.model.vo.VideoItemVO;
	import com.espn.mobile.xgames.service.BaseService;
	
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * Model to store all data related to the Event Info View.
	 */	
	public class SceneModel extends BaseService
	{
		/**
		 * App configuration model.
		 */			
		[Inject]
		public var appConfigModel:AppConfigModel;
		
		/**
		 * Data provider for the video player.
		 */			
		[Bindable]	
		public var videoDataProvider:ArrayCollection;
		
		/**
		 * JSON data object holder
		 */			
		private var sceneData:Object;
	
		
		/**
		 * Data provider for the pulse.
		 */			
		[Bindable]
		public var pulseDataProvider:ArrayCollection;		
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
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
		public function SceneModel()
		{
			super();
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
				sceneData = data; 
				parsePulseData();
				parseVideoData();
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
		private function parsePulseData():void
		{
			try
			{
	
				var pulseItems:Array = sceneData.data.pulse.items as Array;
				var pulseCollection:Array = new Array();
				for (var i:uint = 0; i < pulseItems.length; i++)
				{
					var vo:PulseItemVO = new PulseItemVO(); 
					if (pulseItems[i].id !=null)
					{
						vo.id = String(pulseItems[i].id);
						if (pulseItems[i].hasOwnProperty('type'))
						{
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
		 * populate the videoDataProvider for with video set
		 * 
		 */		
		private function parseVideoData():void
		{
			try
			{
				var videoData:ArrayCollection = new ArrayCollection(sceneData.data.mem.items);
				videoDataProvider = new ArrayCollection();
				var collection:Array = new Array();
				for each(var obj:Object in videoData)
				{
					var videoItemVO:VideoItemVO = new VideoItemVO();
					videoItemVO.headline = obj.headline;
					videoItemVO.title = videoItemVO.headline;
					videoItemVO.imageUrl = appConfigModel.localSettings.imageHost + obj.beauty.url;
					videoItemVO.id = obj.id;
					videoItemVO.date = obj.date;
					videoItemVO.videoId = obj.beauty.id;
					videoItemVO.credit = obj.beauty.credit;
					collection.push(videoItemVO);
				}
				videoDataProvider = new ArrayCollection(collection);
			}
			catch(e:Error)
			{
				dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
		}
		
		
		
	}
}