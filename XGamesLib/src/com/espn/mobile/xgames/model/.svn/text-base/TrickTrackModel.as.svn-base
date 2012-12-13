package com.espn.mobile.xgames.model
{
	import com.espn.mobile.xgames.events.AppErrorEvent;
	import com.espn.mobile.xgames.events.CasterEvent;
	import com.espn.mobile.xgames.model.vo.CompetitorVO;
	import com.espn.mobile.xgames.model.vo.EventResultVO;
	import com.espn.mobile.xgames.model.vo.ResultEventItemVO;
	import com.espn.mobile.xgames.model.vo.ResultVO;
	import com.espn.mobile.xgames.model.vo.ScoreVO;
	import com.espn.mobile.xgames.model.vo.TrickTrackEventVO;
	import com.espn.mobile.xgames.model.vo.TrickTrackFormatVO;
	import com.espn.mobile.xgames.model.vo.VideoItemVO;
	import com.espn.mobile.xgames.model.vo.XCastVO;
	import com.espn.mobile.xgames.service.BaseService;
	import com.espn.mobile.xgames.service.CasterClient;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	public class TrickTrackModel extends BaseService
	{
		
		[Inject]
		public var appConfigModel:AppConfigModel;
		
		[Bindable]
		public var eventResults:EventResultVO;
		
		[Bindable]
		public var events:ArrayCollection;
		
		[Bindable]
		public var categories:ArrayCollection;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		private static const GET_EVENTS:String = "getEvents"; 
		private static const GET_RESULTS:String = "getResults"; 
		
		[Bindable]
		public var selectedCategory:String;
		
		[Bindable]
		public var selectedEvent:String;
		
		[Bindable]
		public var xCastItem:XCastVO;
		
		[Bindable]
		public var currentRoundCompetitors:ArrayCollection;
		
		private var cache:Dictionary;
		
		private var serviceMethod:String;
		
		private var categoriesJsonData:Object;
		private var eventsJsonData:Object;
		private var resultsJsonData:Object;
		
	/*	[Bindable]
		public var casterUpdatedData:CasterUpdatedResultVO = new CasterUpdatedResultVO();*/
		
		[Bindable]
		public var isCasterUpdated:Boolean = false;

		
		private var _casterClient:CasterClient;
		
		private var _trickCasterClient:CasterClient;
		
		/**
		 * caster trick message index 
		 */		
		private var lastTrickMsgIndex:int;
		
		
		[Bindable]public var overallHype:int;
		
		[Bindable]
		public var trickData:String;
		
		public var trickTrackFormat:TrickTrackFormatVO;
		
		public function TrickTrackModel()
		{
			super();
			cache = new Dictionary();
		}
		
		public function get xCastVideoHTML():String
		{
			// we might need to change some values in the below string (dimensions, id, account etc.)
			return "<iframe src='http://new.livestream.com/accounts/211/events/1690316/player?width=640&height=360&autoPlay=true&mute=false' width='640' height='360' frameborder='0' scrolling='no'> </iframe>" 
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
				categoriesJsonData = data;
				eventsJsonData = data.eventDropDown;
				xCastItem = new XCastVO();
				xCastItem.isActive = data.xcast.active;
				xCastItem.streamUrl = data.xcast.streamURL;
				//selectedCategory = data.data.categories[0].title.toUpperCase();
				//selectedCategory = data.eventDropDown[0].title.toUpperCase();
				selectedEvent = data.eventDropDown[0].title.toUpperCase();
				trickTrackFormat = new TrickTrackFormatVO();
				trickTrackFormat.type = data.results.format.type;
				trickTrackFormat.columns = int(data.results.format.columns);
				trickTrackFormat.total = data.results.format.total;
				//parseCategories();
				parseEvents(eventsJsonData as Array);
			}
		}	
		
		/**
		 * 
		 * get filtered data on the basis of category
		 * 
		 */
		public function getCategoryData(url:String, selectedCategoryItem:String):void
		{
			selectedCategory = selectedCategoryItem.toUpperCase();
			//CHECK if data exits in cache
			if (cache[selectedCategory] != null)
			{
				events = new ArrayCollection(cache[selectedCategory]);
			}
			else
			{
				var categoryUrl:String = "http://" + appConfigModel.settings.clusterServiceIP + url;
				serviceMethod = GET_EVENTS;
				read(categoryUrl);
			}
			
		}
		
		/**
		 * 
		 * get results data on the basis of selected Event
		 * 
		 */
		public function getResultsForEvent(url:String):void
		{
			var resultsUrl:String = "http://" + appConfigModel.settings.clusterServiceIP + url;
			serviceMethod = GET_RESULTS;
			read(resultsUrl);
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
		 * 
		 * @override
		 * 
		 */		
		override protected function onResult(event:Event):void
		{
			super.onResult(event);
			switch (serviceMethod)
			{
				case GET_EVENTS:
					eventsJsonData = JSON.parse(event.target.data);
					var categories:Array = eventsJsonData.data.categories;
					for (var i:uint = 0; i < categories.length; i++)
					{
						if (categories[i].title.toLowerCase() == selectedCategory.toLowerCase())
						{
							parseEvents(categories[i].items as Array);
							break;
						}
					}
					break; 
				case GET_RESULTS:
					resultsJsonData = JSON.parse(event.target.data).results;
					parseEventResults();
					//trace(resultsJsonData.data.results[0].name);
					break;
			}
		}
		
		/**
		 * 
		 * parse JSON data and convert to ActionScript object
		 * 
		 */			
		private function parseCategories():void
		{
			try
			{
				var categoriesData:ArrayCollection = new ArrayCollection(categoriesJsonData.eventDropDown); 
				var collection:Array = new Array();
				for each(var obj:Object in categoriesData)
				{
					var categoryObject:Object = new Object();
					//Skip the all category as no data is being shown for this in the UI
					//and the api calls back to the root URL itself
					//					if (obj.title != "all")
					//					{
					categoryObject.title = String(obj.title); 
					categoryObject.link  = new Object(); 
					categoryObject.link.api = String(obj.link.api); 
					categoryObject.link.url = String(obj.link.url); 
					if (String(categoryObject.title).toLowerCase() == selectedCategory.toLowerCase()) 
					{
						parseEvents(obj.items as Array);
					}
					collection.push(categoryObject);
					//					}
				}
				categories = new ArrayCollection(collection);
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			
		}
		
		/**
		 * 
		 * parse JSON data and convert to ActionScript object
		 * 
		 */			
		private function parseEvents(items:Array):void
		{
			try
			{
				var eventsData:ArrayCollection = new ArrayCollection(items); 
				var collection:Array = new Array();
				for each(var obj:Object in eventsData)
				{
					/*var vo:ResultEventItemVO = new ResultEventItemVO(); 
					vo.eventName = String(obj.subText); 
					vo.imagePath = appConfigModel.localSettings.imageHost + String(obj.photoURL); 
					vo.resultURL = String(obj.link.api);
					vo.shareURL = "http://" + appConfigModel.settings.clusterServiceIP + String(obj.link.url);
					vo.eventId = eventIdForResult(obj.link.api);*/
					var vo:TrickTrackEventVO = new TrickTrackEventVO();
					vo.eventName = obj.title;
					vo.isActive = obj.active;
					vo.link = obj.link;
					
					collection.push(vo);
				}
				//videoDataProvider = tempCollection;
				events = new ArrayCollection(collection);
				cache[selectedCategory] = collection;
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			
		}
		
		
		private function eventIdForResult(from:String):String {
			
			var id:String = "";
			var value:String = from;
			var equalCharPosition:Number = value.search('=');
			id = value.substring(equalCharPosition+1, value.length);
			return id;
		}
		
		
		/**
		 * 
		 * parse JSON data and convert to ActionScript object
		 * 
		 */
		private function parseEventResults():void
		{
			
			var vo:EventResultVO = new EventResultVO(); 
			vo = new EventResultVO(); 
			vo.eventName = String(resultsJsonData.title); 
			vo.eventStatus = String(resultsJsonData.event_status); 
			vo.currentRound = int(resultsJsonData.current_round);
			var resultsData:ArrayCollection = new ArrayCollection(resultsJsonData.items); 
			vo.results = parseResults(resultsData);
			
			eventResults = vo;
			
			for(var i:int = 0; i < eventResults.results.length; i++)
			{
				if(vo.currentRound == resultsData.getItemAt(i).round)
				{
					currentRoundCompetitors = eventResults.results.getItemAt(i).competitors;
				}
			}
		}
		
		
		
		/**
		 * 
		 * parse JSON data and convert to ActionScript object
		 * 
		 */			
		private function parseResults(resultsData:ArrayCollection):ArrayCollection
		{
			try
			{
				var output:ArrayCollection = new ArrayCollection();
				for each(var obj:Object in resultsData)
				{
					var vo:ResultVO = new ResultVO(); 
					vo.roundName = String(obj.name);
					vo.roundNo = int(obj.round); 
					vo.competitors = parseCompetitors(obj.competitors as Array)
					output.addItem(vo);
				}
				return output;
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			return null;
			
		}
		
		
		/**
		 * 
		 * parse JSON data and convert to ActionScript object
		 * 
		 */			
		private function parseCompetitors(clist:Array):ArrayCollection
		{
			try
			{
				var output:ArrayCollection = new ArrayCollection();
				var length:uint = clist.length;
				for (var i:uint = 0; i < length; i++)
				{
					var compVO:CompetitorVO = new CompetitorVO(); 
					compVO.rank = uint(clist[i].rank);
					compVO.bestScore = Number(clist[i].score);
					compVO.id = clist[i].athlete.id; 
					compVO.name = clist[i].athlete.name;
					compVO.country = clist[i].athlete.country;
					compVO.photoURL = appConfigModel.localSettings.imageHost +  clist[i].athlete.photoURL;
					compVO.flagImg = appConfigModel.localSettings.imageHost +  clist[i].athlete.flagImg;
					compVO.gender = clist[i].athlete.gender;
					compVO.athleteLink = clist[i].athlete.link.api;
					compVO.scores = parseScores(clist[i].scores as Array, compVO);
					output.addItem(compVO);
				}
				return output;
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			return null;
			
		}
		
		
		/**
		 * 
		 * parse JSON data and convert to ActionScript object
		 * 
		 */	
		private function parseScores(list:Array, vo:CompetitorVO):ArrayCollection
		{
			try
			{
				var output:ArrayCollection = new ArrayCollection()
				var length:uint = list.length;
				for (var i:uint = 0; i < length; i++)
				{
					var scoreVO:ScoreVO = new ScoreVO(); 
					scoreVO.score = Number(list[i].score);
					scoreVO.runIndex = int(list[i].run);
					scoreVO.trick = list[i].trick as Array; 
					if (list[i].hasOwnProperty("video"))
					{
						scoreVO.video = new VideoItemVO();
						scoreVO.video.videoId = String(list[i].video.beauty.id);
						scoreVO.video.headline = String(list[i].video.headline);
						scoreVO.video.title = String(list[i].video.title);
						scoreVO.video.description = String(list[i].video.description);
						scoreVO.video.date = String(list[i].video.date);
						scoreVO.video.imageUrl = appConfigModel.localSettings.imageHost + String(list[i].video.beauty.url);
						if (scoreVO.score == vo.bestScore)
							vo.bestVideo = scoreVO.video;
					}
					output.addItem(scoreVO); 
				}
				return output;
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			return null;
			
		}
		
		
		//METHODS FOR CASTER BELOW THIS LINE
		
		public function connectToCaster():void
		{
			_casterClient = new CasterClient(CasterClient.CASTER_GET_HYPE);
			_casterClient.addEventListener(CasterEvent.CASTER_CONNECTED, onCasterConnectedHandler);
			_casterClient.addEventListener(CasterEvent.CASTER_ERROR, onCasterErrorHandler);
			_casterClient.addEventListener(CasterEvent.CASTER_DATA, onCasterDataReceivedHandler);
			_casterClient.connect();
			
			/*_trickCasterClient = new CasterClient(CasterClient.CASTER_GET_RESULTS);
			_trickCasterClient.addEventListener(CasterEvent.CASTER_CONNECTED, onTrickCasterConnected);
			_trickCasterClient.addEventListener(CasterEvent.CASTER_ERROR, onTrickCasterError);
			_trickCasterClient.addEventListener(CasterEvent.CASTER_DATA, onTrickDataReceived);
			_trickCasterClient.connect();*/
		}
		
		private function onCasterConnectedHandler(e:CasterEvent):void
		{
		
		}
		private function onCasterErrorHandler(e:CasterEvent):void
		{
			
		}
		private function onCasterDataReceivedHandler(e:CasterEvent):void
		{
			trace("Caster Running");
			var strValue:String = String(e.data);
			if(strValue.indexOf("=value") != -1)
			{
				var arrHype:Array = strValue.split("=value");
				if(parseInt(arrHype[1]) > 100){
					overallHype = parseInt(arrHype[1])/2;
				}else{
					overallHype = parseInt(arrHype[1]);
				}
				
				
			}
			// above implementation is subject to change
			// decode the value and update the hype
			// you may dispatch some event or binding to puch it to the view
			//_overallHype = ??????
		}
		
		/**
		 * on trick caster connected 
		 * 
		 */		
		private function onTrickCasterConnected(e:CasterEvent):void
		{
			
		}
		
		/**
		 * on trick caster connection failure 
		 * 
		 */		
		private function onTrickCasterError(e:CasterEvent):void
		{
			
		}
		
		/**
		 * on trick caster data update 
		 * 
		 */		
		private function onTrickDataReceived(e:CasterEvent):void
		{
			if(e.data && e.data != trickData)
			{
				trickData = e.data;
				//parseTrickData(trickData);
				trace("\n ********" + trickData);
			}
				
			
		}
		
		/**
		 * parse trick date 
		 * 
		 */		
		private function parseTrickData(trickStr:String):void
		{
			var splitForMsgIndex:Array = trickStr.split('=');
			if(int(splitForMsgIndex[0]) > lastTrickMsgIndex)
			{
				lastTrickMsgIndex = int(splitForMsgIndex[0]);
				var tempTrickNResultData:Array = String(splitForMsgIndex[1]).split("\r");
				var tempResultData:Array = String(tempTrickNResultData[0]).split("\t");
				var tempEvtNRoundData:Array = String(tempResultData[0]).split("_");
				var tempRunNScoreData:Array = String(tempResultData[1]).split("_");
				
				//casterUpdatedData = new CasterUpdatedResultVO();
				/*casterUpdatedData.athleteId = tempEvtNRoundData[5];
				casterUpdatedData.roundIndex = int(tempEvtNRoundData[3]);
				casterUpdatedData.score = tempRunNScoreData[1];
				var tempRunStr:String = String(tempRunNScoreData[0]);
				casterUpdatedData.runIndex = int(tempRunStr.substring(2));*/
				
				isCasterUpdated = true;
				//updateFromCaster(casterUpdatedData);
				var tempTrickData:Array = String(tempTrickNResultData[1]).split(" ");
				
				
				trace(lastTrickMsgIndex);
			}
			
			
		}
		
		private function updateFromCaster(updatedData:Object):void
		{
			if(updatedData)
			{
				for(var i:int = 0; i < currentRoundCompetitors.length; i++)
				{
					var competitor:CompetitorVO = currentRoundCompetitors.getItemAt(i) as CompetitorVO;
					if(updatedData.athleteId == competitor.id && eventResults.currentRound == updatedData.roundIndex)
					{
						/*competitor.scores.getItemAt(casterUpdatedData.runIndex - 1).score = casterUpdatedData.score;*/
						currentRoundCompetitors.setItemAt(competitor, i);
						currentRoundCompetitors.refresh();
					}
				}
			}
		}
		
		
		public function closeCaster():void
		{
			if (_casterClient)
				_casterClient.destroy();
			if (_trickCasterClient)
				_trickCasterClient.destroy();
		}
	}
}