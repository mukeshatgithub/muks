//////////////////////////////////////////////////////
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.model
{
	import com.espn.mobile.xgames.constants.AppConstants;
	import com.espn.mobile.xgames.events.AppErrorEvent;
	import com.espn.mobile.xgames.events.CasterEvent;
	import com.espn.mobile.xgames.events.ServiceEvent;
	import com.espn.mobile.xgames.model.vo.CuePointVO;
	import com.espn.mobile.xgames.model.vo.HypeChartVO;
	import com.espn.mobile.xgames.model.vo.HypeVO;
	import com.espn.mobile.xgames.model.vo.TopicVO;
	import com.espn.mobile.xgames.model.vo.VideoItemVO;
	import com.espn.mobile.xgames.service.BaseService;
	import com.espn.mobile.xgames.service.CasterClient;
	import com.espn.mobile.xgames.utilities.Utils;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * HypeModel
	 */
	public class HypeModel extends BaseService
	{
		
		/** dispatcher */
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		public static const GET_CHART_DATA : String = "getChartData";
		public static const XGAMES_ID:String = "201301";
		public static const TWITTER:String = "3";
		public static const FACEBOOK:String = "4";
		public static const DEVICE:String = "2";
		public static const CUE:String = "cue";
		
		/** instance of  appConfigModel */
		//private var appConfigModel:AppConfigModel = AppConfigModel.getInstance();
		
		[Inject]
		public var appConfigModel:AppConfigModel;
		
		/** json data */
		private var jsonData:Object;
		
		/** hype chart collection */
		[Bindable]
		public var currentChartData:ArrayCollection;
		
		[Bindable]
		public var eventDates:ArrayCollection; 
		
		[Bindable]
		public var overallHype:int;
		
		public var clusterTitle:String;
		
		/**
		 * Dictionary to mantain caching of data
		 **/
		private var chartData:Dictionary;
		
		
		/**
		 * Time interval for the data pull
		 **/
		private var timeInterval:Number;
		private var modelAction:String;
		
		[Inject]
		/**
		 * Instance of app config model
		 */
		public var localConfigModel:AppConfigModel;
		
		public var shareUrl:String = "";

		
		/**
		 * Variable for caster
		 */
		private var _casterClient:CasterClient;
		
		/**
		 * Constructor -  HypeModel()
		 * 
		 */ 
		public function HypeModel()
		{
			super();
			chartData = new Dictionary();
			var dateCollection:Array = new Array();
			for (var i:uint = 0; i < 4; i++)
			{
				var date:Date = new Date(2012, 10, i+24, 0,0,0,0); 
				dateCollection.push(date);
			}
			eventDates = new ArrayCollection(dateCollection);
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
				getHypeSharingText(data);
				clusterTitle = String(data.title);
				//initOverallHype(data);
				//getHypeChartData(XGAMES_ID, "2012-09-24"); 
				
				if(data.link && data.link) {
					shareUrl = "http://" + appConfigModel.settings.clusterServiceIP + data.link.url;
				}
			}
			
		}
		
		
		/**
		 * parse to get the hypesharing text from the data
		 * 
		 */ 
		private function getHypeSharingText(data:Object):void
		{
			var hypeObject:Object = data.hype; 
			if (hypeObject.hasOwnProperty('socialText'))
			{
				//trace(localConfigModel.localSettings.hypeSharingText);
				appConfigModel.localSettings.hypeSharingText = String(hypeObject.socialText);
				//trace(localConfigModel.localSettings.hypeSharingText);
			}
				
		}
		
		/**
		 * addHype - add hype for a selected topic
		 * 
		 */ 
		public function getHypeChartData(xgamesId:String, date:String):void 
		{
			modelAction = GET_CHART_DATA;
			//var serviceURL:String = "http://xgames.qa.espn.go.com/test/hypeGraph";
			var serviceURL:String;
			switch (date)
			{
				case "1124":
					serviceURL = "/assets/json/hypeGraph1124.json";
					break; 
				case "1125":
					serviceURL = "/assets/json/hypeGraph1125.json";
					break; 
				case "1126":
					serviceURL = "/assets/json/hypeGraph1126.json";
					break; 
				case "1127":
					serviceURL = "/assets/json/hypeGraph1127.json";
					break; 
				default:
					serviceURL = "/assets/json/hypeGraph1124.json";
					break; 					
			}
			read(serviceURL);
		}
		
		/**
		 * addHype - add hype for a selected topic
		 * 
		 */ 
		public function addHype(hypeVO:Object):void // NOPMD
		{
			/*modelAction = ADD;
			
			var serviceURL:String = appConfigModel.getServicePath(AppConstants.HYPES);
			serviceURL = serviceURL.replace("{id}", hypeVO.topicID);
			
			write(serviceURL, hypeVO);	*/
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
		 * Result handler - onResult
		 * 
		 */ 
		override protected function onResult(event:Event):void
		{
			super.onResult(event);
			
			switch(modelAction)
			{
				case GET_CHART_DATA:
				{
					jsonData = JSON.parse(event.target.data);
					parseChartData();
					parseCueData(); 
					break;
				}
				default:
				{
					break;
				}
			}
			
			/*switch(serviceAction)
			{
			case ADD:
			{
			dispatcher.dispatchEvent(new ServiceEvent(ServiceEvent.REFRESH_TOPICS));
			break;
			}
			case DELTE:
			{
			// TO DO FOR DELETE
			break;
			}
			default:
			{
			break;
			}
			}*/
			
			
		}
		
		private function parseCueData():void
		{
			var cueData:ArrayCollection = new ArrayCollection(jsonData.cueList);
			
			/*for (var i:uint = 0; i < 100; i+=5)
			{
			var vo:CuePointVO = new CuePointVO(); 
			vo.id = String(i); 
			vo.cueNumber = i; 
			vo.title = "HELLO THERE " + String(i); 
			vo.imageURL = "";
			vo.shareURL = ""; 
			vo.type = CuePointVO.ARTICLE; 
			//Update the Hype Chart data 
			if (vo.cueNumber >=0 && vo.cueNumber < currentChartData.length)
			{
			var hypeChartVO:HypeChartVO = currentChartData.getItemAt(vo.cueNumber) as HypeChartVO; 
			hypeChartVO.cuePoint = vo; 
			currentChartData.setItemAt(hypeChartVO, vo.cueNumber);
			//currentChartData.setItemAt(hypeChartVO, uint(110*Math.random()));
			}
			}*/
			for (var i:uint = 0; i < cueData.length; i++)
			{
				var obj:Object = cueData.getItemAt(i) as Object;
				var vo:CuePointVO = new CuePointVO(); 
				vo.id = obj.id; 
				vo.cueNumber = int(obj.cueNumber); 
				vo.title = String(obj.item.headline); 
				vo.imageURL = appConfigModel.localSettings.imageHost + String(obj.item.beauty.url);
				vo.shareURL = "http:" + appConfigModel.settings.clusterServiceIP + String(obj.item.link.url); 
				vo.type = String(obj.item.type); 
				if (vo.type.toLowerCase() == CuePointVO.ARTICLE) 
				{
					vo.articleId = vo.id;
					vo.shareURL = "http://" + appConfigModel.settings.clusterServiceIP + String(obj.item.link.url);
				}
				if (vo.type.toLowerCase() == CuePointVO.VIDEO) 
				{
					vo.videoItem = new VideoItemVO(); 
					vo.videoItem.videoId = String(obj.item.id); 
					vo.videoItem.title = String(obj.item.title); 
					vo.videoItem.headline = String(obj.item.headline); 
					vo.videoItem.imageUrl = appConfigModel.localSettings.imageHost + String(obj.item.beauty.url);
					
				}
				
				//Update the Hype Chart data 
				if (vo.cueNumber >=0 && vo.cueNumber < currentChartData.length)
				{
					var hypeChartVO:HypeChartVO = currentChartData.getItemAt(vo.cueNumber) as HypeChartVO; 
					hypeChartVO.cuePoint = vo; 
					currentChartData.setItemAt(hypeChartVO, vo.cueNumber);
					//currentChartData.setItemAt(hypeChartVO, uint(110*Math.random()));
				}
			}
			
		}
		
		private function parseChartData():void
		{
			try
			{
				timeInterval = Number(jsonData.timeInterval); 
				var hypeData:ArrayCollection = new ArrayCollection(jsonData.items);
				var collection:ArrayCollection = new ArrayCollection();
				var objCount:uint = 0; 
				for each(var obj:Object in hypeData)
				{
					var valueArray:Array = String(obj.value).split(", ");
					var type:String = String(obj.type);
					var hypeChartVO:HypeChartVO;
					var length:uint = valueArray.length;
					for (var i:uint =0; i < length; i++)
					{
						if (objCount == 0)
							hypeChartVO = new HypeChartVO(); 
						else 
							hypeChartVO = collection.getItemAt(i) as HypeChartVO; 
						switch (String(type))
						{
							case FACEBOOK:
								hypeChartVO.facebookHype = Number(valueArray[i]);
								break; 
							case TWITTER:
								hypeChartVO.twitterHype = Number(valueArray[i]);
								break; 
							case DEVICE:
								hypeChartVO.deviceHype = Number(valueArray[i]);
								break; 
						}
						
						var date:Date = new Date(int(jsonData.startDate)*1000);
						date.setMinutes(date.minutes + i*(timeInterval)/60);
						hypeChartVO.time = date;
						
						if (objCount == 0)
						{
							collection.addItem(hypeChartVO);
						}
						else
						{
							collection.setItemAt(hypeChartVO, i);
						}
					}
					objCount++;
				}
				
				/*for( var j:uint = 0; j < collection.length; j++)
				{
				var vo:HypeChartVO = collection.getItemAt(j) as HypeChartVO; 
				trace(vo.toString());
				}
				
				trace(collection.length);
				*/
				currentChartData = ArrayCollection(collection);
				trace("PARSING COMPLETE");
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			
		}
		
		/**
		 * This method will be used to connect to caster
		 * client to get the overall hype value for hype
		 * meter
		 */
		public function connectToCaster():void
		{
			_casterClient = new CasterClient(CasterClient.CASTER_GET_HYPE);
			_casterClient.addEventListener(CasterEvent.CASTER_CONNECTED, onCasterConnectedHandler);
			_casterClient.addEventListener(CasterEvent.CASTER_ERROR, onCasterErrorHandler);
			_casterClient.addEventListener(CasterEvent.CASTER_DATA, onCasterDataReceivedHandler);
			_casterClient.connect();
		}
		
		/**
		 * Handler method for caster connect event
		 */
		private function onCasterConnectedHandler(e:CasterEvent):void
		{
			trace("Caster Connected");
		}
		
		/**
		 * Handler method for caster error event
		 */
		private function onCasterErrorHandler(e:CasterEvent):void
		{
			trace("Caster Error");	
		}
		
		/**
		 * Handller method for caster data receive
		 */
		private function onCasterDataReceivedHandler(e:CasterEvent):void
		{
			trace("Caster Running");
			var strValue:String = String(e.data);
			if(strValue.indexOf("=value") != -1)
			{
				var arrHype:Array = strValue.split("=value");
				if(parseInt(arrHype[1]) > 0){
					overallHype = parseInt(arrHype[1])/2;
				}else{
					overallHype = 0;
				}
			}
		}
		
		public function closeCaster():void
		{
			_casterClient.destroy();
		}
	}
}