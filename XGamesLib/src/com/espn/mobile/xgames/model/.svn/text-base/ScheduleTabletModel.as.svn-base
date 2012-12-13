//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.xgames.model
{
	import com.espn.mobile.xgames.events.AppErrorEvent;
	import com.espn.mobile.xgames.events.ScheduleParsingEvent;
	import com.espn.mobile.xgames.model.vo.ScheduleItemVO;
	import com.espn.mobile.xgames.model.vo.ScheduleVO;
	import com.espn.mobile.xgames.service.BaseService;
	import com.espn.mobile.xgames.utilities.Utils;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	/**
	 * Model to store all data related to the Schedule View.
	 */	
	public class ScheduleTabletModel extends BaseService
	{
		/**
		 * IEventDispatcher.
		 */	
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		/**
		 * ScheduleVO object.
		 */
		[Bindable]
		public var scheduleVO:ScheduleVO;
		
		/**
		 * ScheduleVO object.
		 */
		[Bindable]
		public var scheduleVO_event:ScheduleVO;
		
		/**
		 * ArrayCollection object to store the sub categories.
		 */
		[Bindable]
		public var scheduleSubCategoryList:ArrayCollection;
		
		/**
		 * ArrayCollection object to store the sub categories.
		 */
		[Bindable]
		public var scheduleSubCategoryList_event:ArrayCollection;
		
		/**
		 * Array collection for categorised schedule.
		 */
		[Bindable]
		public var categoriesedDataProvider:ArrayCollection;
	
		/**
		 * App Configuration
		 */
		[Inject]
		public var appConfigModel:AppConfigModel;
		
		/** json data */
		private var jsonData:Object;
		
		/**
		 * Schedule data object
		 */
		private var scheduleData:Object;
		
		/**
		 * Variable to check the schedule type
		 */
		private var isInPersonSchedule:Boolean = false;
		
		[Bindable]
		public var selectedCategory:String;
		
		//Constants
		private const CATEGORY:String = "cat";
		private const SUB_CATEGORY:String = "subcat";
		
		public static const FILTER_BY_DATE:String = "date";
		public static const FILTER_BY_EVENT:String = "event";
		public static const FILTER_BY_SPORT:String = "sport";
		public static const FILTER_BY_NETWORK:String = "network";
		
		public static const FILTER_BY_DATE_DATAFIELD:String = "date";
		public static const FILTER_BY_EVENT_DATAFIELD:String = "eventName";
		public static const FILTER_BY_SPORT_DATAFIELD:String = "sport";
		public static const FILTER_BY_NETWORK_DATAFIELD:String = "network";
		public static const FILTER_BY_UTC_DATE_DATAFIELD:String = "utcDate";
		
		public static const SORT_BY_TIME_FIELD:String = "time";
		
		public static const SCHEDULE_TITLE_IN_PERSON:String = "In Person"
		
		
		/**
		 * Class constructor.
		 */	
		public function ScheduleTabletModel()
		{
			super();
		}
		
		/**
		 * override method for on load result handler.
		 */	
		override protected function onResult(event:Event):void
		{
			super.onResult(event);
			
			try
			{
				//Parse the JSON data
				if(event.target.data)
				{
					jsonData = JSON.parse(event.target.data);
					parseSchedule(isInPersonSchedule, jsonData as Array);
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
		override public function parse(data:Object):void
		{
			
			if(data == null)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			else if(data)
			{
				scheduleData = data;
				parseScheduleData();
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
		
		private var _isTvDataPresent:Boolean;
		
		/**
		 * This method will be used to get the schedule data for diffrent
		 * types like the TV Schedule or the In Person Schedule. This will
		 * call the read method of baseService to connect to the service
		 */
		public function getScheduleList(url:String, isInPerson:Boolean):void
		{
			try
			{
				isInPersonSchedule = isInPerson;
				var scheduleUrl:String = "http://" + appConfigModel.settings.clusterServiceIP + url ;
				
				read(scheduleUrl);
			}
			catch(e:Error)
			{
				dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			
		}
		
		private var scheduleDataListCount:Number = 0;
		private var parsedListCount:Number = 0;
		/**
		 * This method is used to parse the schedule data into
		 * the schedule object
		 */
		private function parseScheduleData(): void {
			
			if(scheduleData.data && scheduleData.data.categories && (scheduleData.data.categories as Array).length > 0) {
				
				var categoryList:Array = scheduleData.data.categories;
				var categoryListSize:Number = categoryList.length;
				scheduleDataListCount = categoryListSize;
				if(categoryListSize > 1)
					_isTvDataPresent = true;
				else
					_isTvDataPresent = false;
				
				for(var categoryListCounter:Number = 0; categoryListCounter < categoryListSize; categoryListCounter++) {
					
					if(categoryList[categoryListCounter].link.text && categoryList[categoryListCounter].link.text == SCHEDULE_TITLE_IN_PERSON) {
						if(categoryList[categoryListCounter].items)
							parseSchedule(true, categoryList[categoryListCounter].items);
						else
							getScheduleList(categoryList[categoryListCounter].link.api, true);
					} else{
						if(categoryList[categoryListCounter].items)
							parseSchedule(false, categoryList[categoryListCounter].items);
						else
							getScheduleList(categoryList[categoryListCounter].link.api, false);
					}
				}				
			}
		}

		
		/**
		 * This method is used to parse the schedule data into
		 * the schedule object
		 */
		private function parseSchedule(isInPerson:Boolean, itemsArray:Array):void {

			var scheduleEventCollection:ArrayCollection = new ArrayCollection();
			var dataArray:Array = itemsArray;
			
			if(dataArray)
			{
				for(var count:Number = 0; count < dataArray.length; count++) {
					
					var scheduleItemVO:ScheduleItemVO = new ScheduleItemVO();
					if(dataArray[count].date) {
						scheduleItemVO.date = Utils.getUpdatedDate(dataArray[count].date);
						scheduleItemVO.utcDate = dataArray[count].date;
					}
					
					if(dataArray[count].events && (dataArray[count].events as Array).length > 0) {
						
						var eventArray:Array = dataArray[count].events as Array;
						if(eventArray) {
							
							for(var num:Number=0; num<eventArray.length; num++) {
								if(num>0) {
									scheduleItemVO = new ScheduleItemVO();
									scheduleItemVO.date = Utils.getUpdatedDate(dataArray[count].date);
									scheduleItemVO.utcDate = dataArray[count].date;
								}
								if(eventArray[num].eventId)
									scheduleItemVO.eventId = eventArray[num].eventId;
								if(eventArray[num].eventName)
									scheduleItemVO.eventName = eventArray[num].eventName;
								if(eventArray[num].network)
									scheduleItemVO.network = eventArray[num].network;
								if(eventArray[num].sport)
									scheduleItemVO.sport = eventArray[num].sport;
								if(eventArray[num].time)
									scheduleItemVO.time = eventArray[num].time;
								if(eventArray[num].timezone)
									scheduleItemVO.timezone = eventArray[num].timezone;
								if(eventArray[num].venue)
									scheduleItemVO.venue = eventArray[num].venue;
								scheduleItemVO.dateTime = scheduleItemVO.date + "   " + scheduleItemVO.time;
								if(eventArray[num].watchESPNURL) {
									scheduleItemVO.watchESPNURL = eventArray[num].watchESPNURL;
								}
								
								scheduleEventCollection.addItem(scheduleItemVO);
							}
						}
					}
				}
			}
			
			if(!isInPerson) {				
				scheduleVO_event = new ScheduleVO();
				scheduleVO_event.eventList = scheduleEventCollection;
				setSubCategoryList(isInPerson);
				//groupDataByCategory(FILTER_BY_EVENT);
			} else {				
				scheduleVO = new ScheduleVO();
				scheduleVO.eventList = scheduleEventCollection;
				setSubCategoryList(isInPerson);				
				groupDataByCategory(FILTER_BY_DATE_DATAFIELD);
			}
			
			parsedListCount++;
			
			if(parsedListCount == scheduleDataListCount) {
				var scheduleParsingEvent:ScheduleParsingEvent = new ScheduleParsingEvent(ScheduleParsingEvent.SCHEDULE_DATA_LOADED);
				dispatcher.dispatchEvent(scheduleParsingEvent);
				parsedListCount = 0;
			}
		}
		
		/**
		 * Method to fetch arrayCollection as per the category and sub category selected.
		 */
		public function getScheduleData(filterParam:String, filterParamValue:String, isDate:Boolean=false): ArrayCollection {
			
			var activeScheduleCollection:ArrayCollection = new ArrayCollection();
			var tempScheduleVO:ScheduleVO = scheduleVO;
			
			if(isDate && scheduleVO_event) {
				
				tempScheduleVO = scheduleVO_event;
				activeScheduleCollection = setEventList(activeScheduleCollection, tempScheduleVO, filterParamValue, FILTER_BY_DATE);
				
			} else if(scheduleVO) {			
				
				tempScheduleVO = scheduleVO;
				switch(filterParam.toLowerCase())
				{
					case FILTER_BY_DATE:
					{
						activeScheduleCollection = setEventList(activeScheduleCollection, tempScheduleVO, filterParamValue, FILTER_BY_DATE);
						break;
					}						
					case FILTER_BY_NETWORK:
					{
						activeScheduleCollection = setEventList(activeScheduleCollection, tempScheduleVO, filterParamValue, FILTER_BY_NETWORK);
						break;
					}						
					case FILTER_BY_SPORT:
					{
						activeScheduleCollection = setEventList(activeScheduleCollection, tempScheduleVO, filterParamValue, FILTER_BY_SPORT);
						break;
					}						
					default:
					{
						break;
					}
				}				
			}				
			return activeScheduleCollection;
		}
		
		
		/**
		 * Method to insert the ScheduleItemVO to the arraycollection
		 */
		private function setEventList(activeScheduleCollection:ArrayCollection, tempScheduleVO:ScheduleVO, filterParamValue:String, categoryItem:String) : ArrayCollection {
			
			if(tempScheduleVO.eventList) {
				for(var count:Number = 0; count < tempScheduleVO.eventList.length; count++) {
					var scheduleItemVO:ScheduleItemVO = tempScheduleVO.eventList.getItemAt(count) as ScheduleItemVO;
					
					if(categoryItem == FILTER_BY_EVENT) {
						categoryItem = FILTER_BY_EVENT_DATAFIELD;
					}
					if(scheduleItemVO[categoryItem].toString().toLowerCase() == filterParamValue.toLowerCase()) {
						activeScheduleCollection.addItem(scheduleItemVO);
					}
				}
			}
			
			
			var sortByTime:SortField = new SortField(SORT_BY_TIME_FIELD);
			//Create a Sort object to sort the ArrrayCollection.
			var sort:Sort = new Sort();
			sort.fields = [sortByTime];
			// Sort the collection
			activeScheduleCollection.sort = sort;
			// Refresh the collection view to show the sort.
			activeScheduleCollection.refresh();
			
			return activeScheduleCollection;			
		}
		
		
		/**
		 * Method to  set the sub categort arrayCollection i.e. scheduleSubCategoryList.
		 */
		private function setSubCategoryList(isInPerson:Boolean):void {
			
			var eventList:ArrayCollection;
			var item:Object;
			var itemDictionary:Dictionary;			
			var scheduleItemVO:ScheduleItemVO;			
			
			var tempArray:Array = new Array();
			
			if(!isInPerson && scheduleVO_event && scheduleVO_event.eventList) {
				
				eventList = scheduleVO_event.eventList;				
				itemDictionary = new Dictionary();
				
				for(var count:Number = 0; count < eventList.length; count++) {						
					scheduleItemVO = eventList.getItemAt(count) as ScheduleItemVO;
					
					item = new Object();
					item.cat = FILTER_BY_DATE;
					item.subcat = scheduleItemVO.date;
					
					if(!itemDictionary[scheduleItemVO.date]) {
						tempArray.push(item);
						itemDictionary[scheduleItemVO.date] = item;	
					}
					
					item = new Object();
					item.cat = FILTER_BY_EVENT;
					item.subcat = scheduleItemVO.eventName;
					if(!itemDictionary[scheduleItemVO.eventName]) {
						tempArray.push(item);
						itemDictionary[scheduleItemVO.eventName] = item;	
					}
					
					item = new Object();
					item.cat = FILTER_BY_NETWORK;
					item.subcat = scheduleItemVO.network;
					if(!itemDictionary[scheduleItemVO.network]) {
						tempArray.push(item);
						itemDictionary[scheduleItemVO.network] = item;	
					}
					
					item = new Object();
					item.cat = FILTER_BY_SPORT;
					item.subcat = scheduleItemVO.sport;
					if(!itemDictionary[scheduleItemVO.sport]){
						tempArray.push(item);
						itemDictionary[scheduleItemVO.sport] = item;	
					}
				}
				
				scheduleSubCategoryList_event = new ArrayCollection(tempArray);
				
			} else if(scheduleVO && scheduleVO.eventList) {
				
				eventList = scheduleVO.eventList;				
				itemDictionary = new Dictionary();
				for(var count_event:Number = 0; count_event < eventList.length; count_event++) {						
					scheduleItemVO = eventList.getItemAt(count_event) as ScheduleItemVO;
					
					item = new Object();
					item.cat = FILTER_BY_DATE;
					item.subcat = scheduleItemVO.date;
					
					if(!itemDictionary[scheduleItemVO.date]) {
						tempArray.push(item);
						itemDictionary[scheduleItemVO.date] = item;	
					}					
					
					item = new Object();
					item.cat = FILTER_BY_EVENT;
					item.subcat = scheduleItemVO.eventName;
					if(!itemDictionary[scheduleItemVO.eventName]) {
						tempArray.push(item);
						itemDictionary[scheduleItemVO.eventName] = item;	
					}
					
					item = new Object();
					item.cat = FILTER_BY_NETWORK;
					item.subcat = scheduleItemVO.network;
					if(!itemDictionary[scheduleItemVO.network]) {
						tempArray.push(item);
						itemDictionary[scheduleItemVO.network] = item;	
					}
					
					item = new Object();
					item.cat = FILTER_BY_SPORT;
					item.subcat = scheduleItemVO.sport;
					if(!itemDictionary[scheduleItemVO.sport]){
						tempArray.push(item);
						itemDictionary[scheduleItemVO.sport] = item;	
					}
				}		
				
				scheduleSubCategoryList = new ArrayCollection(tempArray);
			}
			
		}
		
		/**
		 * This method will be used to group the data 
		 * based on the category selected
		 */
		public function groupDataByCategory(categoryItem:String):void
		{
			var scheduleData:ScheduleVO;
			var collection:ArrayCollection;
			
			if(categoryItem == FILTER_BY_EVENT || categoryItem == FILTER_BY_NETWORK)
			{
				scheduleData = scheduleVO_event;
				
				if(categoryItem == FILTER_BY_EVENT) 
					categoryItem = FILTER_BY_UTC_DATE_DATAFIELD;
			}
			else
			{
				if(categoryItem == FILTER_BY_DATE)
					categoryItem=FILTER_BY_UTC_DATE_DATAFIELD;
				
				scheduleData = scheduleVO;		
			}
				
			var groupField:String = categoryItem;
			//Initialize SortField objects for sort fields: based on category
			var sortByCategory:SortField = new SortField(groupField);
			var sortByTime:SortField = new SortField(SORT_BY_TIME_FIELD);
			//Create a Sort object to sort the ArrrayCollection.
			var sort:Sort = new Sort();
			sort.fields = [sortByCategory, sortByTime];
			// Sort the collection
			scheduleData.eventList.sort = sort;
			// Refresh the collection view to show the sort.
			scheduleData.eventList.refresh();
			
			var groupedScheduleData:ScheduleVO;
			collection = new ArrayCollection();
			
			for(var voIndex:int = 0; voIndex < scheduleData.eventList.length; voIndex++)
			{
				var currentEventVO:ScheduleItemVO = scheduleData.eventList.getItemAt(voIndex) as ScheduleItemVO;
				if(voIndex == 0)
				{
					groupedScheduleData = new ScheduleVO();
					groupedScheduleData.eventList = new ArrayCollection();
					
					if(categoryItem == FILTER_BY_UTC_DATE_DATAFIELD)
						groupedScheduleData.rowHeader = Utils.getUpdatedDate(currentEventVO[groupField]).toUpperCase();
					else
						groupedScheduleData.rowHeader = currentEventVO[groupField].toUpperCase();
					
				}
				else if(voIndex > 0 && currentEventVO[groupField] !=  scheduleData.eventList.getItemAt(voIndex-1)[groupField])
				{
					collection.addItem(groupedScheduleData);
					groupedScheduleData = new ScheduleVO();
					groupedScheduleData.eventList = new ArrayCollection();
					
					if(categoryItem == FILTER_BY_UTC_DATE_DATAFIELD)
						groupedScheduleData.rowHeader = Utils.getUpdatedDate(currentEventVO[groupField]).toUpperCase();
					else
						groupedScheduleData.rowHeader = currentEventVO[groupField].toUpperCase();
				}
				groupedScheduleData.eventList.addItem(currentEventVO);
			}
			collection.addItem(groupedScheduleData);
			
			//Set the data provider
			categoriesedDataProvider = collection;
		}
		
		
		
	}
}