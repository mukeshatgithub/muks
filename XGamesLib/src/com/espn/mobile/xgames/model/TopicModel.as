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
	import com.espn.mobile.xgames.model.vo.TopicVO;
	import com.espn.mobile.xgames.service.BaseService;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * TopicModel
	 */
	public class TopicModel extends BaseService
	{
		/** instance of appConfigModel */
		
		[Inject]
		public var appConfigModel:AppConfigModel;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		
		/** topic collection */
		[Bindable]
		public var topics:ArrayCollection;

		/** currrent selected topic */
		[Bindable]
		public var selectedTopic:TopicVO;
		
		/** selected topic index */
		[Bindable]
		public var selectedTopicIndex:Number = -1;

		/**
		 * Constrcutor - TopicModel()
		 * 
		 */ 
		public function TopicModel()
		{
			super();
		}
		
		/**
		 * to get all the current topics
		 * 
		 */ 
		/*public function getAllTopics():void
		{
			//read(appConfigModel.getServicePath(AppConstants.TOPICS));	
		}*/
		
		/**
		 * Result handler - onResult
		 * 
		 */ 
		override protected function onResult(event:Event):void
		{
			try
			{
				super.onResult(event);
				
				var topicsArr:Array = new Array(JSON.parse(event.target.data))[0];
				topics = new ArrayCollection();
				
				for(var i:int = 0; i < topicsArr.length; i++)
				{
					
					var currObj:Object = topicsArr[i]; // NOPMD
					
					var topicVO:TopicVO = new TopicVO(); // NOPMD
					topicVO.xGamesID = topicVO.xGamesID;
					topicVO.eventID = currObj.eventID;
					topicVO.roundID = currObj.roundID;
					topicVO.topic = currObj.topic;
					topicVO.topicId = currObj.topicId;
					topicVO.startTime = currObj.startTime;
					topicVO.endTime = currObj.endTime;
					topicVO.accummulatedHype = currObj.accummulatedHype;
					topicVO.hype = currObj.hype;
					
					topics.addItem(topicVO);
					
				}
				
				if(!selectedTopic)
					selectedTopicIndex = 0;
				else
				{
					var currIndex:Number = selectedTopicIndex;
					selectedTopicIndex = currIndex;
				}
				
				selectedTopic = TopicVO(topics.getItemAt(selectedTopicIndex));

			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
				
		}

	}
}