//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.model
{
	import com.espn.mobile.xgames.events.AppErrorEvent;
	import com.espn.mobile.xgames.events.CasterEvent;
	import com.espn.mobile.xgames.model.vo.CasterUpdatedResultVO;
	import com.espn.mobile.xgames.model.vo.CompetitorVO;
	import com.espn.mobile.xgames.model.vo.EventResultVO;
	import com.espn.mobile.xgames.model.vo.ResultEventItemVO;
	import com.espn.mobile.xgames.model.vo.ResultVO;
	import com.espn.mobile.xgames.model.vo.ScoreVO;
	import com.espn.mobile.xgames.model.vo.VideoItemVO;
	import com.espn.mobile.xgames.service.BaseService;
	import com.espn.mobile.xgames.service.CasterClient;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * Model to store all data related to the Results View.
	 */	
	public class ResultsModel extends BaseService
	{
		/**
		 * Class constructor.
		 */	
		
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
		
		private var resultSessionId:String;
		
		[Bindable]
		public var selectedCategory:String;
		
		
		[Bindable]
		public var isCasterUpdated:Boolean = false;
		
		private var casterUpdatedData:CasterUpdatedResultVO;
		
		/**
		 * caster result message index 
		 */		
		private var lastResultMsgIndex:int;
		
		private var cache:Dictionary;
		
		private var _resultCasterClient:CasterClient;
		
		[Bindable]
		public var resultCasterData:String;
		
		private var serviceMethod:String;

		private var categoriesJsonData:Object;
		private var eventsJsonData:Object;
		private var resultsJsonData:Object;
		
		public static var resultEventFavId:String;
		
		public function ResultsModel()
		{
			super();
			cache = new Dictionary();
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
				selectedCategory = data.data.categories[0].title.toUpperCase();
				parseCategories();
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
		 * Service error handler
		 * 
		 */
		override protected function onError(event:IOErrorEvent):void
		{
			dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.ERROR_CONNECTING_SERVICE, event));
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
					resultsJsonData = JSON.parse(event.target.data);
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
				var categoriesData:ArrayCollection = new ArrayCollection(categoriesJsonData.data.categories); 
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
					var vo:ResultEventItemVO = new ResultEventItemVO(); 
					vo.eventName = String(obj.subText); 
					vo.imagePath = appConfigModel.localSettings.imageHost + String(obj.photoURL); 
					vo.resultURL = String(obj.link.api);
					vo.shareURL = "http://" + appConfigModel.settings.clusterServiceIP + String(obj.link.url);
					vo.eventId = eventIdForResult(obj.link.api);
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
			vo.eventName = String(resultsJsonData.data.title); 
			vo.eventStatus = String(resultsJsonData.data.event_status); 
			vo.currentRound = int(resultsJsonData.data.current_round);
			resultSessionId = String(resultsJsonData.data.session);
			if (resultsJsonData.data.hasOwnProperty("format"))
			{
				vo.columnLabel = String(resultsJsonData.data.format.type).toUpperCase();
				vo.totalLabel = String(resultsJsonData.data.format.total).toUpperCase();
			}
			var resultsData:ArrayCollection = new ArrayCollection(resultsJsonData.data.items); 
			vo.results = parseResults(resultsData);
			eventResults = vo;
			
			/*if(_resultCasterClient)
			{
				_resultCasterClient.removeEventListener(CasterEvent.CASTER_CONNECTED, onResultCasterConnected);
				_resultCasterClient.removeEventListener(CasterEvent.CASTER_ERROR, onResultCasterError);
				_resultCasterClient.removeEventListener(CasterEvent.CASTER_DATA, onResultDataReceived);
				_resultCasterClient.destroy();
			}
			else
			{
				connectToCaster();
				
			}*/
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
					compVO.photoURL = clist[i].athlete.photoURL;
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
		 * Returns the best video for each competitor based on the highest score of the person
		 * @param list
		 * @return 
		 * 
		 */		
		private function getBestVideo(competitor:CompetitorVO, list:Array):VideoItemVO
		{
			var output:VideoItemVO;
			var minValue:Number = Number.MAX_VALUE; 
			var maxValue:Number = -1; 
			
			//Find maximum value in list
			for each (var obj:Object in list)
			{
				if (obj.score > maxValue)
					maxValue = obj.score;
				
				if (obj.score < minValue)
					minValue = obj.score;
			}
			
			var length:uint = list.length;
			//trace("MAXIMUM SCORE IS : " + maxValue);
			for (var i:uint = 0; i < length; i++)
			{
				var score:Number =  Number(list[i].score);
				if (list[i].hasOwnProperty("video") && score == maxValue )
				{
					//trace("SCORE MATCHED WITH : " + score);
					output = new VideoItemVO();
					output.videoId = String(list[i].video.beauty.id);
					output.headline = String(list[i].video.headline);
					output.title = String(list[i].video.title);
					output.description = String(list[i].video.description);
					output.date = String(list[i].video.date);
					output.imageUrl = appConfigModel.localSettings.imageHost + String(list[i].video.beauty.url);
					output.shareUrl = "http://" + appConfigModel.settings.clusterServiceIP + String(list[i].video.link.url);
				}
			}
			return output;
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
				var bestVideoIdentified:Boolean = false;
				var output:ArrayCollection = new ArrayCollection()
				var length:uint = list.length;
				for (var i:uint = 0; i < length; i++)
				{
					var scoreVO:ScoreVO = new ScoreVO(); 
					scoreVO.score = Number(list[i].score);
					//scoreVO.trick = String(list[i].trick); 
					if (list[i].hasOwnProperty("video"))
					{
						scoreVO.video = new VideoItemVO();
						scoreVO.video.videoId = String(list[i].video.beauty.id);
						scoreVO.video.headline = String(list[i].video.headline);
						scoreVO.video.title = String(list[i].video.title);
						scoreVO.video.description = String(list[i].video.description);
						scoreVO.video.date = String(list[i].video.date);
						scoreVO.video.imageUrl = appConfigModel.localSettings.imageHost + String(list[i].video.beauty.url);
						scoreVO.video.shareUrl = "http://" + appConfigModel.settings.clusterServiceIP + String(list[i].video.link.url);
						if (!bestVideoIdentified)
						{
							vo.bestVideo = getBestVideo(vo, list);
							bestVideoIdentified = true;
						}
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
			_resultCasterClient = new CasterClient(resultSessionId);
			_resultCasterClient.addEventListener(CasterEvent.CASTER_CONNECTED, onResultCasterConnected);
			_resultCasterClient.addEventListener(CasterEvent.CASTER_ERROR, onResultCasterError);
			_resultCasterClient.addEventListener(CasterEvent.CASTER_DATA, onResultDataReceived);
			_resultCasterClient.connect();
		}
		
		/**
		 * on trick caster connected 
		 * 
		 */		
		private function onResultCasterConnected(e:CasterEvent):void
		{
			
		}
		
		/**
		 * on trick caster connection failure 
		 * 
		 */		
		private function onResultCasterError(e:CasterEvent):void
		{
			
		}
		
		/**
		 * on trick caster data update 
		 * 
		 */		
		private function onResultDataReceived(e:CasterEvent):void
		{
			if(e.data)
			{
				resultCasterData = e.data;
				parseCasterData(resultCasterData);
				trace("\n ********" + resultCasterData);
			}
			
			
		}
		
		
		/**
		 * parse caster data
		 * 
		 */		
		private function parseCasterData(trickStr:String):void
		{
			var splitForMsgIndex:Array = trickStr.split('=');
			if(int(splitForMsgIndex[0]) > lastResultMsgIndex)
			{
				lastResultMsgIndex = int(splitForMsgIndex[0]);
				var tempTrickNResultData:Array = String(splitForMsgIndex[1]).split("\r");
				var tempResultData:Array = String(tempTrickNResultData[0]).split("\t");
				var tempEvtNRoundData:Array = String(tempResultData[0]).split("_");
				var tempRunNScoreData:Array = String(tempResultData[1]).split("_");
				
				casterUpdatedData = new CasterUpdatedResultVO();
				casterUpdatedData.athleteId = tempEvtNRoundData[3];
				casterUpdatedData.roundIndex = int(tempEvtNRoundData[1]);
				casterUpdatedData.score = tempRunNScoreData[1];
				var tempRunStr:String = String(tempRunNScoreData[0]);
				casterUpdatedData.runIndex = int(tempRunStr.substring(2));
				
				// temp code begins
				/*casterUpdatedData.athleteId = "2389";
				casterUpdatedData.roundIndex = 2;
				casterUpdatedData.runIndex = 0;
				casterUpdatedData.score = String(34 + count);*/
				//count++;
				// temp code ends
				
				isCasterUpdated = true;
				updateResultFromCaster(casterUpdatedData);
				//updateFromCaster(casterUpdatedData);
				var tempTrickData:Array = String(tempTrickNResultData[1]).split(" ");
				
				
			}
			
			
		}
		
		
		private function updateResultFromCaster(data:CasterUpdatedResultVO):void
		{
			if(!eventResults)
				return;
			if(data.roundIndex == eventResults.currentRound)
			{
				var tempEvt:EventResultVO = eventResults;
				for(var i:int = 0; i < tempEvt.results.length; i++)
				{
					var result:ResultVO = tempEvt.results.getItemAt(i) as ResultVO
					if(result.roundNo == eventResults.currentRound)
					{
						for(var j:int = 0; j < result.competitors.length; j++)
						{
							var competitor:CompetitorVO = result.competitors.getItemAt(j) as CompetitorVO;
							if(competitor.id == data.athleteId)
							{
								for(var k:int = 0; k < competitor.scores.length; k++)
								{
									var score:ScoreVO = competitor.scores.getItemAt(k) as ScoreVO;
									if(score.runIndex == data.runIndex)
									{
										score.score = Number(data.score);
										break;
									}
								}
								break;
							}
						}
						break;
					}
				}
			}
			eventResults = new EventResultVO();
			eventResults = tempEvt;
		}
	}
}