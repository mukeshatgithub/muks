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
	import com.espn.mobile.xgames.events.ClusterDataEvent;
	import com.espn.mobile.xgames.model.vo.ClusterVO;
	import com.espn.mobile.xgames.model.vo.EventListVO;
	import com.espn.mobile.xgames.model.vo.PulseItemVO;
	import com.espn.mobile.xgames.model.vo.VideoItemVO;
	import com.espn.mobile.xgames.service.BaseService;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLVariables;
	import flash.text.ReturnKeyLabel;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * Model to store all data related to the News View.
	 */	
	public class ClusterModel extends BaseService
	{
		
		[Inject]
		public var appConfigModel:AppConfigModel;
		
		public var selectedClusterVO:ClusterVO;
		
		public var clusterDataArray:Array;
		
		[Bindable]
		public var clusters:ArrayCollection;
		
		public var activeCluster:Number;
		
		public var currentQueueIndex:Number;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		
		/**
		 * Class constructor.
		 */	
		public function ClusterModel()
		{
			super();
		}
		
		/**
		 * public method to return news from the model.
		 */	
		public function getCluster():void
		{
			//var param:URLVariables = new URLVariables();
			read(appConfigModel.getServicePath(AppConstants.CLUSTER));
		}
		
		/**
		 * override method for on load result handler.
		 */	
		override protected function onResult(event:Event):void
		{
			super.onResult(event);
			parseCluster(event.target.data);
			
		}
		
		/**
		 * 
		 * parse JSON data and convert to ActionScript object
		 * 
		 */		
		private function parseCluster(result:String):void
		{
			try
			{
				var clusterObj:Object = JSON.parse(result);
				
				// Get the numbers of clusters
				var totalClusters:int = clusterObj.clusters.length;
				
				activeCluster = clusterObj.activeCluster;
				
				//Set the clusterDataArray length to caontain the all the clsuters data
				clusterDataArray = new Array(totalClusters)
				
				//Caontain the all the clsuters data
				clusters = new ArrayCollection();
				
				for(var i:int = 0; i < totalClusters; i++)
				{
					
					var tempClusterVO:Object = clusterObj.clusters[i];
					
					var clusterVO:ClusterVO = new ClusterVO();
					clusterVO.index = i;
					clusterVO.title = tempClusterVO.title;
					clusterVO.type = tempClusterVO.type;
					if (tempClusterVO.hasOwnProperty("link"))
						clusterVO.url = tempClusterVO.link.api; 
					else 
						clusterVO.url = tempClusterVO.url;
					clusters.addItem(clusterVO);
					
				}
				
				clusterDataArray[activeCluster] = clusterObj.clusters[activeCluster].data;
				
				selectedClusterVO = clusters.getItemAt(activeCluster) as ClusterVO;
				dispatchEvent(new ClusterDataEvent(ClusterDataEvent.CLUSTER_DATA_LOADED));
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			
		}
		
		
	}
}