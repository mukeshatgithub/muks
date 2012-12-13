package com.espn.mobile.xgames.model
{
	import com.espn.mobile.xgames.constants.AppConstants;
	import com.espn.mobile.xgames.events.XVoteEvent;
	import com.espn.mobile.xgames.model.vo.VoteResultVO;
	import com.espn.mobile.xgames.model.vo.XVoteVO;
	import com.espn.mobile.xgames.service.BaseService;
	import com.espn.mobile.xgames.utilities.Utils;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import mx.formatters.DateFormatter;
	
	public class PollingModel extends BaseService
	{
		/**
		 * dispatcher is an event dispatcher injected by SWIZ 
		 */
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		private var _voteSuccess:Boolean = false;
		
		private var _voteResultVO:VoteResultVO;
		
		private var pollID:String;
		
		public function get voteStatus():Boolean
		{
			return _voteSuccess;
		}
		
		public function get voteResult():VoteResultVO
		{
			return _voteResultVO;
		}
		
		public function PollingModel()
		{
			super();
		}
		
		
		
		/**
		 * cast vote
		 */		
		public function castVote(pollID:String, voteID:String):void
		{
			this.pollID = pollID;
			var pollingUrl:String = AppConstants.POLLING_URL_PATH + pollID + AppConstants.POLLING_URL_VOTE;//?answer_id =" + voteID;
			read(pollingUrl, new URLVariables(AppConstants.POLLING_URL_ANSWER + voteID), false, URLRequestMethod.POST);
//			read(pollingUrl);
		}
		
		/**
		 * @override
		 * on Result 
		 */		
		override protected function onResult(event:Event):void
		{
			if(pollID) {
				parseResult(JSON.parse(event.target.data as String)); 
				var xVoteVO: XVoteVO = new  XVoteVO();
				xVoteVO.athleteId = pollID;
				xVoteVO.date = Utils.getCurrentDate();
				xVoteVO.name = _voteResultVO.athelteName;
				dispatcher.dispatchEvent(new XVoteEvent(XVoteEvent.ADD_ITEM,xVoteVO));
			} 
		}
		
		private function parseResult(resultJson:Object):void
		{
			_voteResultVO = new VoteResultVO();
			_voteResultVO.athelteName = resultJson.vote.answer.title;
			_voteResultVO.athleteId = resultJson.vote.answer.id;
			_voteResultVO.athleteTotalVotes = Number(resultJson.vote.answer.totalVotes);
			_voteResultVO.votePercentage = Number(resultJson.vote.answer.percentage);
			_voteResultVO.pollClosed = resultJson.closed;
			_voteResultVO.pollId = resultJson.id;
			_voteResultVO.pollTotalVotes = Number(resultJson.totalVotes);
		}
		
		/**
		 *	@override
		 *  onError 
		 */		
		override protected function onError(event:IOErrorEvent):void
		{
			_voteSuccess = false;
			/*if(voteSuccess && pollID) {
				var xVoteVO: XVoteVO = new  XVoteVO();
				xVoteVO.athleteId = pollID;
				xVoteVO.date = Utils.getCurrentDate();
				dispatcher.dispatchEvent(new XVoteEvent(XVoteEvent.ADD_ITEM,xVoteVO));
			} */
		}
		
	}
}