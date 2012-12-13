//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.model
{
	import com.espn.mobile.xgames.events.AppErrorEvent;
	import com.espn.mobile.xgames.events.AthleteDataEvent;
	import com.espn.mobile.xgames.events.XFavoriteEvent;
	import com.espn.mobile.xgames.model.vo.AthleteVO;
	import com.espn.mobile.xgames.model.vo.CategoryVO;
	import com.espn.mobile.xgames.model.vo.EventListVO;
	import com.espn.mobile.xgames.model.vo.LinkVO;
	import com.espn.mobile.xgames.model.vo.SportsEventsVO;
	import com.espn.mobile.xgames.service.BaseService;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.text.ReturnKeyLabel;
	import flash.utils.flash_proxy;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.states.OverrideBase;
	import mx.utils.NameUtil;
	
	import org.osmf.net.SwitchingRuleBase;
	
	/**
	 * Model to store all data related to the Athletes view.
	 */	
	public class AthletesModel extends BaseService
	{
		
		public static const SPORTS_CATEGORIES:String = "sportsCategories";
		public static const SPORTS_EVENTS:String = "sportsEvents";
		public static const ATHLETES_LIST:String = "athletesList";
		public static const ATHLETE_INFO:String = "athleteInfo";
		
		[Inject]
		/**
		 * App config model 
		 */
		public var appConfigModel:AppConfigModel;
		
		[Bindable]
		/**
		 * Data provider for sports categories
		 */
		public var sportsCategories:ArrayCollection;
		
		[Bindable]
		/**
		 * Data provider for sports events
		 */
		public var eventsDataProvider:ArrayCollection;
		
		
		/**
		 * Data provider for sports events
		 */
		[Bindable]
		public var favoriteAthlete:ArrayCollection;
		
		
		
		[Bindable]
		/**
		 * Data provider for athletes data
		 */
		public var athletesDataProvider:ArrayCollection;
		
		[Bindable]
		/**
		 * Data provider for all athletes data
		 */
		public var allAthletes:ArrayCollection;
		
		[Bindable]
		/**
		 * Data information for a athlete
		 */
		public var athleteData:AthleteVO;
		
		[Bindable]
		public var showAthleteLoader:Boolean = true;
		
		/**
		 * Variable to store the current data action
		 */
		public var modelAction:String;
		
		/** json data */
		private var jsonData:Object;
		
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Bindable]
		public var selectedCategory:String;
		
		public static var athleteFavId:String;
		
		/**
		 * Class constructor.
		 */	
		public function AthletesModel()
		{
			super();
		}
		
		/**
		 * This function will be used to parse the response 
		 * returned by the service to the respective VO
		 */
		override public function parse(data:Object):void
		{
			if(data==null)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			else
			{
				// Get the data for athletes 
			//	getAthletesData(data.url, SPORTS_CATEGORIES);
				//parse here
				parseAthletesData(data.data);
			}
		}
		
		/**
		 * This method will be used to get the data related to athletes
		 * like the sports categories, events, athletesInfo. This will 
		 * call the read method of baseService to connect to the service
		 */
		public function getAthletesData(url:String, athleteAction:String):void
		{
			try
			{
				modelAction = athleteAction;
				var athleteUrl:String = "http://" + appConfigModel.settings.clusterServiceIP + url ;
				read(athleteUrl);
				showAthleteLoader = true;
				
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
				
			}
			
		}
		
		/**
		 * override method for on load result handler.
		 */	
		override protected function onResult(event:Event):void
		{
			super.onResult(event);
			
			try
			{
				switch(modelAction)
				{
					case SPORTS_CATEGORIES:
					{
						/* Parse the JSON and set the data */
						jsonData = JSON.parse(event.target.data);
						setCategoriesData(jsonData.data);
						break;
					}
						
					case SPORTS_EVENTS:
					{
						/* Parse the JSON and set the data */
						jsonData = JSON.parse(event.target.data);
						
						if(jsonData && jsonData.data && jsonData.data.categories)
						{
							for(var i:int=0; i< jsonData.data.categories.length; i++)
							{
								var obj:Object = jsonData.data.categories[i];
								
								if(obj.items)
									setEventsData(obj);
							}
						}
						
						
						break;
					}
						
					case ATHLETES_LIST:
					{
						/* Parse the JSON and set the data */
						jsonData = JSON.parse(event.target.data);
						setAthletesData(jsonData.data);
						break;	
					}
						
					case ATHLETE_INFO:
					{
						/* Parse the JSON and set the data */
						jsonData = JSON.parse(event.target.data);
						setAthleteData(jsonData.data);
						break;
					}
					default:
					{
						break;
					}
				}
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			
		}
		
		/**
		 * override method for on load error handler.
		 */	
		override protected function onError(event:IOErrorEvent):void
		{	
			dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.ERROR_CONNECTING_SERVICE, null));
			showAthleteLoader = false;
		}
		
		private function parseAthletesData(data:Object):void
		{
			try
			{
				setCategoriesData(data);
				//setEventsData(data);
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
		}
		
		/**
		 * This method will be used to set the data provider 
		 * for sports categories. 
		 * 
		 */
		private function setCategoriesData(data:Object):void
		{		
			if(data == null)
				return;
			
			try
			{
				var collection:Array = new Array();
				for each(var obj:Object in data.categories)
				{
					var categories:CategoryVO = new CategoryVO();
				//	categories.fill(obj);
					categories.title = obj.title;
					var linkVO:LinkVO = new LinkVO();
					linkVO.api = obj.link.api;
					linkVO.url = obj.link.url;
					categories.link = linkVO;
					collection.push(categories);
					
					if(obj.items)
					{
						
					}
				}
				
				setAthletesData(data);
				
				sportsCategories = new ArrayCollection(collection);
				
				//Getting the events for the default selected sport 
				//getAthletesData(sportsCategories.getItemAt(0).api, SPORTS_EVENTS);
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			
		}
		
		/**
		 * This method will be used to set the data provider 
		 * for athletes
		 */
		private function setAthletesData(data:Object):void
		{
			try
			{
				var athletes:ArrayCollection = new ArrayCollection(data.categories);
				var itemsConllection:Array = new Array();
				
				for each (var obj:Object in athletes) 
				{
					if(obj.items)
					{
						selectedCategory = obj.title.toUpperCase();
						
						for each(var item:Object in obj.items)
						{
							var athleteVO:AthleteVO = new AthleteVO();
							//athleteVO.fill(obj);
							athleteVO.id = item.id as Number;
							athleteVO.photoURL = appConfigModel.localSettings.imageHost + item.photoURL;
							athleteVO.name = item.name;
							athleteVO.gender = item.gender;
							athleteVO.isFavorite = isAthleteFavorite(item.id);
							
							var linkVO:LinkVO = new LinkVO();
							linkVO.api = item.link.api;
							linkVO.url = item.link.url;
							
							athleteVO.link = linkVO;
							itemsConllection.push(athleteVO);
						}
					}
				}
				
				athletesDataProvider = new ArrayCollection(itemsConllection);
				
				if(selectedCategory == "ALL")
				{
					allAthletes = new ArrayCollection(itemsConllection);
				}
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
		}
		
		/**
		 * 
		 */ 		
		private function isAthleteFavorite(id:Number):Boolean{
			for(var i:Number = 0; i < favoriteAthlete.length;i++){
				if(favoriteAthlete.getItemAt(i) == id){
					return true;
				}
			}
			return false;
		}
		
		
		[Inject(source="xModel.favoriteList", bind="true")]
		public function set athleteFavorite(value:ArrayCollection):void
		{
			var athleteFavoriteID:Array = new Array();
			for(var i:Number = 0; i < value.length;i++){
				if(value[i].type == "athlete"){
					athleteFavoriteID.push(value[i].favId);
				}
			}
			favoriteAthlete = new ArrayCollection(athleteFavoriteID);
		}
		
		
		/**
		 * This method will be used to set the data for the selected 
		 * athlete
		 */ 
		private function setAthleteData(data:Object):void
		{
			if(data==null)
				return;
			try
			{
				
				var tempAthleteData:AthleteVO = new AthleteVO();
				
				tempAthleteData.id = data.athleteID as Number;
				tempAthleteData.name = data.athleteName;
				tempAthleteData.sport = data.sport;
				tempAthleteData.gender = data.gender;
				tempAthleteData.age = data.age as Number;
				tempAthleteData.birthdate = data.birthdate as Number;	
				tempAthleteData.height = data.height as Number;
				tempAthleteData.weight = data.weight as Number;
				tempAthleteData.nickname = data.nickname;
				tempAthleteData.country = data.country;
				tempAthleteData.flagImg = appConfigModel.localSettings.imageHost + data.flagImg;
				tempAthleteData.city = data.city;
				tempAthleteData.state = data.state;
				tempAthleteData.bio = data.bio;
				tempAthleteData.photoURL = appConfigModel.localSettings.imageHost + data.photoURL;
				
				if(!data.athleteWebsiteURL || (data.athleteWebsiteURL && data.athleteWebsiteURL == "N/A")) {
					tempAthleteData.athleteWebsiteURL = "http://" + appConfigModel.settings.serverIPAdress + "xgames/athlete/" +tempAthleteData.id + "/";
				} else {
					tempAthleteData.athleteWebsiteURL = data.athleteWebsiteURL;
				}
				tempAthleteData.athleteSpotifyKey = data.athleteSpotifyKey;
				tempAthleteData.twitter = data.twitter;
				tempAthleteData.isFavorite = isAthleteFavorite(data.athleteID);
				
				athleteData =  tempAthleteData;

			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			
		}
		
		
		
		/**
		 * This method will be used to set the data provider 
		 * for athletes
		 */
		private function setEventsData(data:Object):void
		{
			if(data==null)
				return;
			
			try
			{
				var itemsCollection:Array = new Array();
				
				for each (var obj:Object in data.items) 
				{
					var eventList:SportsEventsVO = new SportsEventsVO();
				//	eventList.fill(obj);
					eventList.name = obj.title;
					eventList.id=obj.id;
					var linkVO:LinkVO = new LinkVO();
					linkVO.api = obj.link.api;
					linkVO.url = obj.link.url;
					eventList.link = linkVO;
					itemsCollection.push(eventList);
				}
				
				eventsDataProvider = new ArrayCollection(itemsCollection);
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
		
		}
		
	}
}