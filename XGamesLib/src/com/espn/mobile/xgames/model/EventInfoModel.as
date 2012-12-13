//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.model
{
	import com.espn.mobile.xgames.events.AppErrorEvent;
	import com.espn.mobile.xgames.model.vo.EventInfoVO;
	import com.espn.mobile.xgames.service.BaseService;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	
	import mx.collections.ArrayCollection;
	
	/**
	 * Model to store all data related to the Event Info View.
	 */	
	public class EventInfoModel extends BaseService
	{
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		
		private var _completeJSON:Object;
		
		private static const MAP_ID:String ="map"; 
		private static const GENERAL_INFO_ID:String ="generalInfo"; 
		private static const EXPLORE_XFEST_ID:String ="exploreXFest"; 
		private static const SPONSORS_ID:String ="sponsors"; 
		private static const GUEST_SERVICES_ID:String ="guestServices"; 
		private static const STAFF_INFORMATION_ID:String ="staffInformation"; 

		private static const MAP:String ="MAP"; 
		private static const GENERAL_INFO:String ="GENERAL INFORMATION"; 
		private static const EXPLORE_XFEST:String ="EXPLORE X FEST"; 
		private static const SPONSORS:String ="SPONSORS"; 
		private static const GUEST_SERVICES:String ="GUEST SERVICES"; 
		private static const STAFF_INFORMATION:String ="STAFF INFORMATION"; 

		
		[Bindable]public var title:String;
		[Bindable]public var description:String;
		[Bindable]public var staffInfo:String;
		
		[Bindable]public var sections:ArrayCollection;
		/**
		 * Class constructor.
		 */	
		public function EventInfoModel()
		{
			super();
		}
		
		
		
		override protected function onResult(event:Event):void
		{
			super.onResult(event);
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
		override public function parse(data:Object):void
		{
			
			if(data == null)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			else if(data)
			{
				_completeJSON = data;
				title = String(data.data.title).toUpperCase();
				description = String(data.data.defaultText);
				staffInfo = "http://workxevents.com/staff/aspen";//String(data.data.staff-info);
				
				var arrItems:Array = data.data.items;
				if(arrItems)
				{
					var items:Array = new Array();
					for(var i:int = 0; i < arrItems.length; i++)
					{
						var label:String = String(arrItems[i].title).toUpperCase();
						var type:String;
						switch (arrItems[i].subType)
						{
							case MAP_ID:
								type = MAP; 
								break; 
							case GENERAL_INFO_ID:
								type = GENERAL_INFO;
								break; 
							case EXPLORE_XFEST_ID:
								type = EXPLORE_XFEST;
								break; 
							case SPONSORS_ID:
								type = SPONSORS; 
								break; 
							case GUEST_SERVICES_ID:
								type = GUEST_SERVICES;
								break; 
							default:
								type = "DEFAULT"; 
								break; 
						}
						var objVO:EventInfoVO = new EventInfoVO(type, label,arrItems[i].body);
						items.push(objVO);
					}
				}
				if (staffInfo && staffInfo!="")
				{
					var vo:EventInfoVO = new EventInfoVO(STAFF_INFORMATION, STAFF_INFORMATION, staffInfo);
					items.push(vo);
				}
				
				sections = new ArrayCollection(items);
			}
		}

	}
}