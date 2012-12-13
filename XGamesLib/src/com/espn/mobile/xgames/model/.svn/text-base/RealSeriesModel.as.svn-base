//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.model
{
	import com.espn.mobile.xgames.events.AppErrorEvent;
	import com.espn.mobile.xgames.model.vo.CompetitorVO;
	import com.espn.mobile.xgames.model.vo.ContestantVO;
	import com.espn.mobile.xgames.model.vo.MatchVO;
	import com.espn.mobile.xgames.model.vo.RealSeriesRoundVO;
	import com.espn.mobile.xgames.model.vo.RoundVO;
	import com.espn.mobile.xgames.model.vo.VideoItemVO;
	import com.espn.mobile.xgames.service.BaseService;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * Model to store all data related to the Real Series View.
	 */	
	public class RealSeriesModel extends BaseService
	{
		
		[Inject]
		public var appConfigModel:AppConfigModel;
		
		[Bindable]
		public var rounds:ArrayCollection;
		
		[Bindable]
		public var shareUrl:String;

		[Bindable]
		public var finalMatch:MatchVO;
		
		[Bindable]
		public var roundData:RoundVO;

		[Bindable]
		public var currentRound:uint;

		
		[Bindable]
		public var categories:ArrayCollection;
		
		[Bindable]
		public var mobileCategories:ArrayCollection;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		[Bindable]
		public var numberOfAtheletes:uint;
		
		[Bindable]
		public var enableVoting:Boolean = true;
		
		[Bindable]
		public var introText:String;
		
		private var currentParsingRound:uint = 1;
		private var numAtheletes:uint = 0;
		
		private static const GET_ROUND_RESULTS:String = "getResults"; 
		
		private var serviceMethod:String;
		
		private var categoriesJsonData:Object;
		private var resultsJsonData:Object;
		private var roundCollection:Array;
		
		
		
		/**
		 * Class constructor.
		 */	
		public function RealSeriesModel()
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
				currentParsingRound = 1;
				categoriesJsonData = data;
				introText = String(data.data.text);
				parseCategories();
				rounds = new ArrayCollection();
				roundCollection = new Array();
				shareUrl = "http://" + appConfigModel.settings.clusterServiceIP + data.link.url;
				//GET THE RESULTS FOR FIRST ROUND
				var url:String = categories.getItemAt(currentParsingRound).url; 
				trace("GETTING DATA FOR ROUND : " + currentParsingRound + " FROM : " + url); 
				getResultsForRound(url);
			}
			//categories = new ArrayCollection(eventsJsonData.data.sports);
			//parseEvents();
			//parseCompetitors();
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
		 * parse JSON data and convert to ActionScript object
		 * 
		 */			
		private function parseCategories():void
		{
			try
			{
				currentRound = uint(categoriesJsonData.data.round);	
				
				var categoriesData:ArrayCollection = new ArrayCollection(categoriesJsonData.data.categories); 
				var collection:Array = new Array();
				var mobileCollection:Array = new Array();
				var titleObject:Object = new Object(); 
				titleObject.title = "BRACKET";
				titleObject.status = "bracket"; //DEFAULT MENU ITEM// WILL NOT FETCH ANY DATA FROM SERVER
				collection.push(titleObject);
				
				var roundNumber:uint = 1;
				for each(var obj:Object in categoriesData)
				{
					var object:RealSeriesRoundVO = new RealSeriesRoundVO(); 
					object.title = String(obj.link.text); 
					object.url = String(obj.link.api);
					object.headline = String(obj.headline);
					object.status = String(obj.status);
					object.endDate = int(obj.endDate);
					object.roundNumber = roundNumber++;
					collection.push(object);
					mobileCollection.push(object);
				}
				
				var winnerCat:RealSeriesRoundVO = new RealSeriesRoundVO();
				winnerCat.title = "WINNER";
				winnerCat.url = String(obj.link.api);
				winnerCat.status = "winner";
				winnerCat.roundNumber = object.roundNumber + 1;
				winnerCat.headline = String(obj.headline);
				winnerCat.endDate = int(obj.endDate);
				collection.push(winnerCat);
				mobileCollection.push(winnerCat);
				//videoDataProvider = tempCollection;
				categories = new ArrayCollection(collection);
				mobileCategories = new ArrayCollection(mobileCollection);
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			
		}
		
		/**
		 * 
		 * get results data on the basis of selected Event
		 * 
		 */
		public function getResultsForRound(url:String):void
		{
			var resultsUrl:String = "http://" + appConfigModel.settings.clusterServiceIP + url;
			serviceMethod = GET_ROUND_RESULTS;
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
				case GET_ROUND_RESULTS:
					resultsJsonData = JSON.parse(event.target.data);
					parseRoundResults();
					//trace(resultsJsonData.data.results[0].name);
					break;
			}
			//GET THE NEXT ROUND RESULT
			if (currentParsingRound < currentRound)
			{
				currentParsingRound++; 
				var url:String = categories.getItemAt(currentParsingRound).url; 
				trace("GETTING DATA FOR ROUND : " + currentParsingRound + " FROM : " + url); 
				getResultsForRound(url);
			}
		}
		
		/**
		 * 
		 * parse JSON data and convert to ActionScript object
		 * 
		 */			
		private function parseRoundResults():void
		{
			try
			{
				var roundVO:RoundVO = new RoundVO(); 
				roundVO.roundID = uint(resultsJsonData.round);
				roundVO.shareUrl = "http://" + appConfigModel.settings.clusterServiceIP + resultsJsonData.categories[resultsJsonData.round - 1].link.url;
				roundVO.matches = parseMatches();
				roundCollection.push(roundVO);
				roundData = roundVO;
				if (currentParsingRound == currentRound)
				{
					rounds = new ArrayCollection(roundCollection);
					trace("TOTAL ROUNDS : " + rounds.length);					
				}
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
		private function parseMatches():ArrayCollection
		{
			try
			{
				var matchData:ArrayCollection = new ArrayCollection(resultsJsonData.categories[resultsJsonData.round - 1].items as Array);
				var roundStatus:String = resultsJsonData.categories[resultsJsonData.round - 1].status;
				var output:ArrayCollection = new ArrayCollection();
				numAtheletes = 0;
				for each(var obj:Object in matchData)
				{
					var matchVO:MatchVO = new MatchVO(); 
					matchVO.matchID = Number(obj.id);
					matchVO.totalVotes = Number(obj.totalVotes); 
					matchVO.firstContestant = parseContestant(obj.items[0], obj.morePoll.answers);
					matchVO.secondContestant = parseContestant(obj.items[1], obj.morePoll.answers);
					if(obj.hasOwnProperty("judgeWinner"))
					{
						matchVO.judgeWinner = parseJudgeWinner(obj.judgeWinner);
					}
					matchVO.pollID = obj.pollId;
					matchVO.status = roundStatus;
					if (currentParsingRound == 1)
						numAtheletes+=2;
					//trace(matchVO.toString());
					output.addItem(matchVO);
				}
				if (currentParsingRound == 1)
					numberOfAtheletes = numAtheletes;
				
				if(matchData.length == 1)
					finalMatch = output.getItemAt(0) as MatchVO;
				//trace(numberOfAtheletes);
				return output;
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			return null;
		}
		
		
		private function parseContestant(obj:Object, answers:Array=null):ContestantVO
		{
			try
			{
				var vo:ContestantVO = new ContestantVO(); 
				vo.id = obj.id; 
				vo.name = obj.name; 
				//vo.athleteURL = "http://" + appConfigModel.settings.clusterServiceIP + obj.link.api;
				vo.photoURL = appConfigModel.localSettings.imageHost + obj.photoURL;
				var videoItem:VideoItemVO = new VideoItemVO();
				videoItem.videoId = String(obj.video.id);
				videoItem.headline = obj.video.headline;
				videoItem.title = obj.video.title;
				videoItem.description = obj.video.description;
				videoItem.imageUrl = appConfigModel.localSettings.imageHost + obj.video.beauty.url;
				videoItem.shareUrl = "http://" + appConfigModel.settings.clusterServiceIP + obj.video.link.url;
				vo.videoItem = videoItem;
				vo.title = obj.title; 
				vo.voteCount = obj.voteCount; 
				vo.votePercentage = obj.votePct; 
				vo.etc = obj.etc;
				
				for(var i:int=0; i<answers.length; i++)
				{
					if(String(answers[i].title).toUpperCase() == vo.name)
					{
						vo.athleteId = answers[i].id;
					}
				}
				return vo;
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			return null;
			
		}
		
		private function parseJudgeWinner(obj:Object):ContestantVO
		{
			
			try
			{
				var vo:ContestantVO = new ContestantVO(); 
				vo.name = obj.name;
				vo.photoURL = appConfigModel.localSettings.imageHost + obj.photoURL;
				
				
				var videoItem:VideoItemVO = new VideoItemVO();
				videoItem.videoId = String(obj.video.id);
				videoItem.headline = obj.video.headline;
				videoItem.title = obj.video.title;
				videoItem.description = obj.video.description;
				videoItem.imageUrl = appConfigModel.localSettings.imageHost + obj.video.beauty.url;
				vo.videoItem = videoItem;
				
				return vo;
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			return null;
		}
		
		
		/*public function filterResultForRound(roundID:uint):void
		{
			var output:RoundVO;
			for (var i:uint = 0; i< rounds.length; i++)
			{
				var vo:RoundVO = rounds.getItemAt(i) as RoundVO;
				if (vo.roundID == roundID)
				{
					output = vo; 
					break;
				}
			}
			roundData = output;
		}*/

		
		
		
	}
}