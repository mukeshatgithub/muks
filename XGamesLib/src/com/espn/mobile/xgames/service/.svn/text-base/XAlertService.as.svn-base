package com.espn.mobile.xgames.service
{
	import com.espn.mobile.xgames.constants.AppConstants;
	import com.espn.mobile.xgames.constants.XAlertConstants;
	import com.espn.mobile.xgames.events.AppErrorEvent;
	import com.espn.mobile.xgames.events.SimpleMessageEvent;
	import com.espn.mobile.xgames.events.XAlertEvent;
	import com.espn.mobile.xgames.events.XAlertFavoriteEvent;
	import com.espn.mobile.xgames.model.vo.alerts.AlertPayloadVO;
	import com.espn.mobile.xgames.model.vo.alerts.XAlertFavoriteVO;
	
	import flash.desktop.Clipboard;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.RemoteNotificationEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.notifications.NotificationStyle;
	import flash.notifications.RemoteNotifier;
	import flash.notifications.RemoteNotifierSubscribeOptions;
	import flash.system.Capabilities;
	import flash.system.System;
	
	import mx.core.FlexGlobals;
	
	import spark.components.TextArea;
	import spark.managers.PersistenceManager;
	
	[Event(name="registrationSucessfull", type="com.espn.mobile.xgames.events.XAlertEvent")] //NOPMD
	[Event(name="registrationUnsucessfull", type="com.espn.mobile.xgames.events.XAlertEvent")] //NOPMD
	[Event(name="loginSucessfull", type="com.espn.mobile.xgames.events.XAlertEvent")] //NOPMD
	[Event(name="loginUnsucessfull", type="com.espn.mobile.xgames.events.XAlertEvent")] //NOPMD
	[Event(name="logoutSucessfull", type="com.espn.mobile.xgames.events.XAlertEvent")] //NOPMD
	[Event(name="logoutUnsucessfull", type="com.espn.mobile.xgames.events.XAlertEvent")] //NOPMD
	[Event(name="alertAreNotAvailable", type="com.espn.mobile.xgames.events.XAlertEvent")] //NOPMD
	[Event(name="alreadyRegistered", type="com.espn.mobile.xgames.events.XAlertEvent")] //NOPMD
	[Event(name="internalServerError", type="com.espn.mobile.xgames.events.XAlertEvent")] //NOPMD
	
	[Event(name="favoriteAlertOnSuccess", type="com.espn.mobile.xgames.events.XAlertFavoriteEvent")] //NOPMD
	[Event(name="favoriteAlertOnSuccess", type="com.espn.mobile.xgames.events.XAlertFavoriteEvent")] //NOPMD
	[Event(name="favoriteAlertOffSuccess", type="com.espn.mobile.xgames.events.XAlertFavoriteEvent")] //NOPMD
	[Event(name="favoriteAlertOffSuccess", type="com.espn.mobile.xgames.events.XAlertFavoriteEvent")] //NOPMD
	
	/**
	 * This class is responsible to provide the common behaviour for puch notifications (iOS only) 
	 */
	public class XAlertService extends EventDispatcher
	{
		// fixed
		
		
		private static const SUCCESS:String = "success";
		
		
		
		
		//variable
		private var _xAlertsFormat:String;
		private var _xAlertsSwid:String;
		private var _aspnToken:String;
		private var _isRegistered:Boolean;
		
		// dono
		private var _channelUri:String;
		
		// internal usage
		private var _pm:PersistenceManager = new PersistenceManager();
		private var _urlRequest:URLRequest;
		private var _urlLoader:URLLoader = new URLLoader();
		private var _urlString:String;
		private var _swid:String;
		private var _appId:String;
		
		
		
		private var _remoteNotifier:RemoteNotifier = new RemoteNotifier();
		private var _subscribeOptions:RemoteNotifierSubscribeOptions = new RemoteNotifierSubscribeOptions();
		private var _preferredStyles:Vector.<String> = new Vector.<String>();
		
		
		/**
		 * Constructor funciton 
		 */
		public function XAlertService()
		{
			
		}
		
		private function genrateSWID():void
		{
			var urlRequest:URLRequest = new URLRequest(XAlertConstants.SWID_URL);
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onSWIDError);
			urlLoader.addEventListener(Event.COMPLETE,onSWIDCompleteHandler);
			urlLoader.load(urlRequest);
		}
		
		private function onSWIDError(e:IOErrorEvent):void
		{
			dispatchEvent(new XAlertEvent(XAlertEvent.SERVER_ERROR));
		}
		private function onSWIDCompleteHandler(e:Event):void
		{
			try
			{
				var obj:Object = JSON.parse(e.target.data.toString());
				_swid = obj.UUID;
				_pm.setProperty(XAlertConstants.PM_SWID,_swid);
				registerDevice();
			}
			catch(e:Error)
			{
				//track error log here
			}
		}
		
		
		/**
		 * This function will initialize the alerts integration and will do all the primary groundwork,
		 * If the push notifications are supported the it will register the user at ESPN for alerts.
		 * You may need to call this function every time on application activate handler, it will automatically check if the user has been
		 * already register or APNS token is changed and register teh user again.
		 * @param	None
		 * @return	None
		 * 
		 */
		public function init(value:String):void
		{
			_appId = value;
			var existingSWID:String = String(_pm.getProperty(XAlertConstants.PM_SWID));
			if(existingSWID != "null")
			{
				registerDevice();
			}
			else
			{
				genrateSWID();
			}
			
		}
		
		/**
		 * register the device for alerts
		 * @param	None
		 * @return	None 
		 */
		private function registerDevice():void
		{
			if(supportPushNotification())
			{
				_preferredStyles.push(NotificationStyle.ALERT, NotificationStyle.BADGE, NotificationStyle.SOUND );
				_subscribeOptions.notificationStyles = _preferredStyles;
				_remoteNotifier.addEventListener(RemoteNotificationEvent.TOKEN, onTokenHandler)
				_remoteNotifier.addEventListener(RemoteNotificationEvent.NOTIFICATION, onNotificationHandler);
				_remoteNotifier.subscribe(_subscribeOptions);
			}
			else
			{
				_isRegistered = false;
				this.dispatchEvent(new XAlertEvent(XAlertEvent.ALERT_NOT_AVAILABLE));
			}
		}
		
		
		/**
		 * Will be called automatically when user launches the app from notification launcher.
		 * To be used with iOS only
		 * @param	RemoteNotificationEvent
		 * @return	None	
		 */
		private var objAlertPayloadVO:AlertPayloadVO;
		
		private function onNotificationHandler(e:RemoteNotificationEvent):void
		{
			handleInvoke(e.data);
		}
		
		
		public function handleInvoke(value:Object):void
		{
			objAlertPayloadVO = new AlertPayloadVO();
			try
			{
				objAlertPayloadVO.alertBodyId = value.alertBodyId;
				objAlertPayloadVO.alertId = value.alertId;
				
				var alertMessage:String = value.aps.toString();
				alertMessage = alertMessage.split("\n").join("");
				alertMessage = getAlertMessage(alertMessage);
				objAlertPayloadVO.message = alertMessage;
				
				var strAlertString:String = XAlertConstants.ALERT_DETAIL_URL+objAlertPayloadVO.alertId+XAlertConstants.ESPN_API_KEY;
				var urlRequest:URLRequest = new URLRequest(strAlertString);
				var urlLoader:URLLoader = new URLLoader();
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onAlertErrorHandler);
				urlLoader.addEventListener(Event.COMPLETE,onAlertContentHandler);
				urlLoader.load(urlRequest);
				
			}
			catch(error:Error) 
			{
				trace("Error:"+error.message);
			}
		}
		
		
		private function onAlertContentHandler(e:Event):void
		{
			try
			{
				var obj:Object = JSON.parse(e.target.data.toString());
				parseNotification(obj);
			} 
			catch(error:Error) 
			{
				
			}
		}
		private function onAlertErrorHandler(e:IOErrorEvent):void
		{
			trace("--")
		}
		
		private function getAlertMessage(value:String):String
		{
			var patternStrPrefix:String = "body = \"";
			var patternStr:String = ".+";
			var patternStrPostfix:String = " \";";
			var pattern:RegExp = new RegExp(patternStrPrefix + patternStr + patternStrPostfix, "i");
			var nStr:String = pattern.exec(value);
			nStr = nStr.split(patternStrPostfix)[0];
			nStr = nStr.split(patternStrPrefix)[1];
			return nStr;

		}
		
		/**
		 * Will be called when iOS return the token to app
		 * @param	RemoteNotificationEvent
		 * @return	None
		 * 
		 */
		public function onTokenHandler(e:RemoteNotificationEvent):void
		{
			
			_aspnToken = e.tokenId;
			var existingToken:String = String(_pm.getProperty(XAlertConstants.ASPN_TOKEN));
			if(existingToken != _aspnToken)
			{
				// you got a different token this time, get it registered
				registerUser(_aspnToken);
			}
			else
			{
				// DEVICE ALREADY REGISTERED 
				_aspnToken = existingToken;
				_isRegistered = true;
				dispatchEvent(new XAlertEvent(XAlertEvent.ALREADY_REGISTERED));
			}
			//TextArea(FlexGlobals.topLevelApplication.debugText).text = _aspnToken;
		}
		
		/**
		 * This function will register the user device for alerts.
		 * @param	String	:	ASPN token from iOS/APNS
		 * @return	None 
		 * 
		 */
		private function registerUser(value:String):void
		{
			_urlString = new String( XAlertConstants.BASE_URL + XAlertConstants.ALERT_REGISTER_DEVICE + XAlertConstants.QUERY_STRING + XAlertConstants.ESPN_API_KEY + XAlertConstants.ASPN_TOKEN + _aspnToken +  _appId + XAlertConstants.FORMAT_IOS + XAlertConstants.SWID + XAlertConstants.SWID_START + _swid + XAlertConstants.SWID_END );
			_urlRequest = new URLRequest(_urlString);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
			_urlLoader.addEventListener(Event.COMPLETE,onCompleteHandler);
			_urlLoader.load(_urlRequest);
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void
		{
			_isRegistered = false;
			dispatchEvent(new XAlertEvent(XAlertEvent.ALERT_REGISTRATION_UNSUCESSFULL));
		}
		private function onCompleteHandler(e:Event):void
		{
			_isRegistered = true;
			_pm.setProperty(XAlertConstants.ASPN_TOKEN,_aspnToken);
			var obj:Object = JSON.parse(e.target.data.toString());
			if(obj.status == SUCCESS)
			{
				dispatchEvent(new XAlertEvent(XAlertEvent.ALERT_REGISTRATION_SUCESSFULL));
			}
			else
			{
				dispatchEvent(new XAlertEvent(XAlertEvent.ALERT_REGISTRATION_UNSUCESSFULL));
			}
			
		}
		/**
		 * Will return true if notification are supported by the platform.
		 * To be used with iOS only
		 * @param	None
		 * @return 	Boolean
		 */
		private function supportPushNotification():Boolean
		{
			return (RemoteNotifier.supportedNotificationStyles.toString() != " ") ? true:false;
		}
		/**
		 * This function will request for disabling alerts, 
		 * This will dispatch:
		 * <code>
		 * XAlertEvent.ALERT_LOGOUT_UNSUCESSFULL
		 * XAlertEvent.ALERT_LOGOUT_SUCESSFULL
		 * </code>
		 * @param	None
		 * @Return	None 
		 * 
		 */
		public function enableAlerts():void
		{
			var urlString:String = new String( XAlertConstants.BASE_URL + XAlertConstants.ALERTS_LOGIN + XAlertConstants.QUERY_STRING + XAlertConstants.ESPN_API_KEY + XAlertConstants.ASPN_TOKEN + _aspnToken +  _appId + XAlertConstants.FORMAT_IOS + XAlertConstants.SWID + XAlertConstants.SWID_START + _swid + XAlertConstants.SWID_END );
			var urlRequest:URLRequest = new URLRequest(urlString);
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onEnableAlertIOErrorHandler);
			urlLoader.addEventListener(Event.COMPLETE,onEnableAlertCompleteHandler);
			urlLoader.load(urlRequest);
		}
		
		private function onEnableAlertIOErrorHandler(e:IOErrorEvent):void
		{
			dispatchEvent(new XAlertEvent(XAlertEvent.ALERT_LOGIN_UNSUCESSFULL));
		}
		private function onEnableAlertCompleteHandler(e:Event):void
		{
			var obj:Object = JSON.parse(e.target.data.toString());
			if(obj.status == SUCCESS)
			{
				dispatchEvent(new XAlertEvent(XAlertEvent.ALERT_LOGIN_SUCESSFULL));
			}
			else
			{
				dispatchEvent(new XAlertEvent(XAlertEvent.ALERT_LOGIN_UNSUCESSFULL));
			}
		}
		
		/**
		 * This function will request for disabling alerts, 
		 * This will dispatch:
		 * <code>
		 * XAlertEvent.ALERT_LOGOUT_UNSUCESSFULL
		 * XAlertEvent.ALERT_LOGOUT_SUCESSFULL
		 * </code>
		 * @param	None
		 * @Return	None 
		 * 
		 */
		public function disableAlerts():void
		{
			var urlString:String = new String( XAlertConstants.BASE_URL + XAlertConstants.ALERTS_LOGOUT + XAlertConstants.QUERY_STRING + XAlertConstants.ESPN_API_KEY + XAlertConstants.ASPN_TOKEN + _aspnToken +  _appId + XAlertConstants.FORMAT_IOS + XAlertConstants.SWID + XAlertConstants.SWID_START + _swid + XAlertConstants.SWID_END );
			var urlRequest:URLRequest = new URLRequest(urlString);
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onDisableAlertIOErrorHandler);
			urlLoader.addEventListener(Event.COMPLETE,onDisableAlertCompleteHandler);
			urlLoader.load(urlRequest);
		}
		
		/**
		 * 
		 * 
		 */
		private function onDisableAlertIOErrorHandler(e:IOErrorEvent):void
		{
			dispatchEvent(new XAlertEvent(XAlertEvent.ALERT_LOGOUT_UNSUCESSFULL));
		}
		
		/**
		 * 
		 * 
		 */
		private function onDisableAlertCompleteHandler(e:Event):void
		{
			var obj:Object = JSON.parse(e.target.data.toString());
			if(obj.status == SUCCESS)
			{
				dispatchEvent(new XAlertEvent(XAlertEvent.ALERT_LOGOUT_SUCESSFULL));
			}
			else
			{
				dispatchEvent(new XAlertEvent(XAlertEvent.ALERT_LOGOUT_UNSUCESSFULL));
			}
		}
		
		public function getSWID():String
		{
			return _swid;
		}
		
		public function favorite(value:XAlertFavoriteVO):void
		{
			var urlString:String = new String( XAlertConstants.BASE_URL + XAlertConstants.FAVORITE_ALERTS_ON + XAlertConstants.QUERY_STRING + XAlertConstants.FAVORITE_ALERT_ON_OFF_KEY + value.appId +":"+ value.type +":"+ value.keyName +":"+ value.favoriteId + _appId + XAlertConstants.FORMAT_IOS + XAlertConstants.ESPN_API_KEY + XAlertConstants.SWID + XAlertConstants.SWID_START + _swid + XAlertConstants.SWID_END); 
			var urlRequest:URLRequest = new URLRequest(urlString);
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onFavoriteOnIOErrorHandler);
			
			urlLoader.addEventListener(Event.COMPLETE,function(e:Event):void
			{
				var obj:Object = JSON.parse(e.target.data.toString());
				if(obj.status == SUCCESS)
				{
					dispatchEvent(new XAlertFavoriteEvent(XAlertFavoriteEvent.FAVORITE_ALERT_ON_SUCCESS,value));
				}
				else
				{
					dispatchEvent(new XAlertFavoriteEvent(XAlertFavoriteEvent.FAVORITE_ALERT_ON_FAILED));
				}
			
			});
			urlLoader.load(urlRequest);
		}
		
		public function unFavorite (value:XAlertFavoriteVO):void
		{
			var urlString:String = new String( XAlertConstants.BASE_URL + XAlertConstants.FAVORITE_ALERTS_OFF + XAlertConstants.QUERY_STRING + XAlertConstants.FAVORITE_ALERT_ON_OFF_KEY + value.appId +":"+ value.type +":"+ value.keyName +":"+ value.favoriteId + _appId + XAlertConstants.FORMAT_IOS + XAlertConstants.ESPN_API_KEY + XAlertConstants.SWID + XAlertConstants.SWID_START + _swid + XAlertConstants.SWID_END); 
			
			var urlRequest:URLRequest = new URLRequest(urlString);
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onFavoriteOffIOErrorHandler);
			urlLoader.addEventListener(Event.COMPLETE,function(e:Event):void
			{
				var obj:Object = JSON.parse(e.target.data.toString());
				if(obj.status == SUCCESS)
				{
					dispatchEvent(new XAlertFavoriteEvent(XAlertFavoriteEvent.FAVORITE_ALERT_OFF_SUCCESS,value));
				}
				else
				{
					dispatchEvent(new XAlertFavoriteEvent(XAlertFavoriteEvent.FAVORITE_ALERT_OFF_FAILED));
				}
				
			});
			urlLoader.load(urlRequest);	
		}
		
		private function onFavoriteOnIOErrorHandler(e:IOErrorEvent):void
		{
			dispatchEvent(new XAlertFavoriteEvent(XAlertFavoriteEvent.FAVORITE_ALERT_ON_FAILED));
		}
		
		
		private function onFavoriteOffIOErrorHandler(e:IOErrorEvent):void
		{
			dispatchEvent(new XAlertFavoriteEvent(XAlertFavoriteEvent.FAVORITE_ALERT_OFF_FAILED));
		}
		private function onFavoriteOffCompleteHandler(e:Event):void
		{
			var obj:Object = JSON.parse(e.target.data.toString());
			if(obj.status == SUCCESS)
			{
				dispatchEvent(new XAlertFavoriteEvent(XAlertFavoriteEvent.FAVORITE_ALERT_OFF_SUCCESS));
			}
			else
			{
				dispatchEvent(new XAlertFavoriteEvent(XAlertFavoriteEvent.FAVORITE_ALERT_OFF_FAILED));
			}
		}
		
		private function parseNotification(value:Object):void
		{
			try
			{
				if(objAlertPayloadVO)
				{
					if(value.data.storyId == "-1" && value.data.videoId == "-1")
					{
						objAlertPayloadVO.isBreakingNews = true;
						dispatchEvent(new XAlertEvent(XAlertEvent.NOTIFICATION_RECEIVED,objAlertPayloadVO));
					}
					else if(value.data.storyId != "-1")
					{
						objAlertPayloadVO.isBreakingNews = false;
						objAlertPayloadVO.contentType = XAlertConstants.NOTIFICATION_TYPE_ARTICLE;
						objAlertPayloadVO.contentId = value.data.storyId;
						dispatchEvent(new XAlertEvent(XAlertEvent.NOTIFICATION_RECEIVED,objAlertPayloadVO));
					}
					else if(value.data.videoId != "-1")
					{
						objAlertPayloadVO.isBreakingNews = false;
						objAlertPayloadVO.contentType = XAlertConstants.NOTIFICATION_TYPE_VIDEO;
						objAlertPayloadVO.contentId = value.data.videoId;
						dispatchEvent(new XAlertEvent(XAlertEvent.NOTIFICATION_RECEIVED,objAlertPayloadVO));
					}
					else if(value.data.storyId != "-1" && value.data.videoId != "-1")
					{
						objAlertPayloadVO.isBreakingNews = false;
						objAlertPayloadVO.contentType = XAlertConstants.NOTIFICATION_TYPE_VIDEO;
						objAlertPayloadVO.contentId = value.data.videoId;
						dispatchEvent(new XAlertEvent(XAlertEvent.NOTIFICATION_RECEIVED,objAlertPayloadVO));
					}
				}
			} 
			catch(error:Error) 
			{
				//dispatcher.dispatchEvent(new AppErrorEvent(AppErrorEvent.INVALID_DATA_FORMAT, null));
			}
			
		}
		
		
	}
}