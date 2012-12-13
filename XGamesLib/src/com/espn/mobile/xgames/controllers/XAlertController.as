package com.espn.mobile.xgames.controllers
{
	import com.espn.mobile.xgames.events.NotificationAlertEvent;
	import com.espn.mobile.xgames.events.SimpleMessageEvent;
	import com.espn.mobile.xgames.events.XAlertEvent;
	import com.espn.mobile.xgames.events.XAlertFavoriteEvent;
	import com.espn.mobile.xgames.model.vo.alerts.AlertPayloadVO;
	import com.espn.mobile.xgames.service.XAlertService;
	
	import flash.events.IEventDispatcher;

	public class XAlertController
	{
		private var _xAlertService:XAlertService;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		
		[PostConstruct]
		public function postConstruct():void
		{
			_xAlertService = new XAlertService();
			_xAlertService.addEventListener(XAlertEvent.ALERT_NOT_AVAILABLE, onAlertUnavailableHandler);
			_xAlertService.addEventListener(XAlertEvent.ALERT_REGISTRATION_SUCESSFULL, onAlertSucessfulHander);
			_xAlertService.addEventListener(XAlertEvent.ALERT_REGISTRATION_UNSUCESSFULL, onAlertUnsucessfulHander);
			
			_xAlertService.addEventListener(XAlertEvent.ALERT_LOGIN_SUCESSFULL, onAlertLoginSucessfulHander);
			_xAlertService.addEventListener(XAlertEvent.ALERT_LOGIN_UNSUCESSFULL, onAlertLoginUnsucessfulHander);
			
			_xAlertService.addEventListener(XAlertEvent.ALERT_LOGOUT_SUCESSFULL, onAlertLogoutSucessfulHander);
			_xAlertService.addEventListener(XAlertEvent.ALERT_LOGOUT_UNSUCESSFULL, onAlertLogoutUnsucessfulHander);
			
			_xAlertService.addEventListener(XAlertEvent.ALREADY_REGISTERED, onAlreadyRegisteredHandler);
			_xAlertService.addEventListener(XAlertEvent.NOTIFICATION_RECEIVED, onNotoficationHandler);
			
			_xAlertService.addEventListener(XAlertFavoriteEvent.FAVORITE_ALERT_ON_SUCCESS , onFavoriteOnSuccessHandler);
			_xAlertService.addEventListener(XAlertFavoriteEvent.FAVORITE_ALERT_ON_FAILED , onFavoriteOnFailHandler);
			
			_xAlertService.addEventListener(XAlertFavoriteEvent.FAVORITE_ALERT_OFF_SUCCESS , onFavoriteOffSuccessHandler);
			_xAlertService.addEventListener(XAlertFavoriteEvent.FAVORITE_ALERT_OFF_FAILED , onFavoriteOffFailHandler);
		}
		
		public function handleInvoke(value:Object):void
		{
			_xAlertService.handleInvoke(value);
		}
		
		private function onFavoriteOnSuccessHandler(e:XAlertFavoriteEvent):void
		{
			dispatcher.dispatchEvent(new XAlertFavoriteEvent(XAlertFavoriteEvent.FAVORITE_ALERT_ON_SUCCESS,e.data));
		}
		private function onFavoriteOnFailHandler(e:XAlertFavoriteEvent):void
		{
			dispatcher.dispatchEvent(new XAlertFavoriteEvent(XAlertFavoriteEvent.FAVORITE_ALERT_ON_FAILED,e.data));
		}
		private function onFavoriteOffSuccessHandler(e:XAlertFavoriteEvent):void
		{
			dispatcher.dispatchEvent(new XAlertFavoriteEvent(XAlertFavoriteEvent.FAVORITE_ALERT_OFF_SUCCESS,e.data))
		}
		private function onFavoriteOffFailHandler(e:XAlertFavoriteEvent):void
		{
			dispatcher.dispatchEvent(new XAlertFavoriteEvent(XAlertFavoriteEvent.FAVORITE_ALERT_OFF_FAILED,e.data));
		}
		
		[EventHandler(event="XAlertEvent.INITIALIZE_ALERTS")]
		public function init(e:XAlertEvent):void
		{
			_xAlertService.init(e.appId);
		}
		
		
		private function onNotoficationHandler(e:XAlertEvent):void
		{
			dispatcher.dispatchEvent(new NotificationAlertEvent(NotificationAlertEvent.ALERT_RECEIVED,e.data));
		}
		
		private function onAlreadyRegisteredHandler(e:XAlertEvent):void
		{
			//dispatcher.dispatchEvent(new SimpleMessageEvent(SimpleMessageEvent.SHOW_SIMPLE_MESSAGE,"All set for alert registration."));
		}
		private function onAlertLoginSucessfulHander(e:XAlertEvent):void
		{
			dispatcher.dispatchEvent(new SimpleMessageEvent(SimpleMessageEvent.SHOW_SIMPLE_MESSAGE,"ALERTS HAVE BEEN ENABLED FOR NOW. YOU CAN ALWAYS SWITCH THEM OFF"));
		}
		private function onAlertLoginUnsucessfulHander(e:XAlertEvent):void
		{
			dispatcher.dispatchEvent(new SimpleMessageEvent(SimpleMessageEvent.SHOW_SIMPLE_MESSAGE,"Some problem to enable alerts on your device, please try again after some time."));
		}
		private function onAlertLogoutSucessfulHander(e:XAlertEvent):void
		{
			dispatcher.dispatchEvent(new SimpleMessageEvent(SimpleMessageEvent.SHOW_SIMPLE_MESSAGE,"ALERTS HAVE BEEN DISABLED FOR NOW. YOU CAN ALWAYS SWITCH THEM BACK ON IF YOU LIKE"));
		}
		private function onAlertLogoutUnsucessfulHander(e:XAlertEvent):void
		{
			dispatcher.dispatchEvent(new SimpleMessageEvent(SimpleMessageEvent.SHOW_SIMPLE_MESSAGE,"Some problem to disable alerts on your device, please try again after some time."));
		}
		private function onAlertSucessfulHander(e:XAlertEvent):void
		{
			//dispatcher.dispatchEvent(new SimpleMessageEvent(SimpleMessageEvent.SHOW_SIMPLE_MESSAGE,"All set for alert registration."));
		}
		private function onAlertUnsucessfulHander(e:XAlertEvent):void
		{
			dispatcher.dispatchEvent(new SimpleMessageEvent(SimpleMessageEvent.SHOW_SIMPLE_MESSAGE,"Alerts registration failed this time, plaese try again after some time."));
		}
		
		private function onAlertUnavailableHandler(e:XAlertEvent):void
		{
			//dispatcher.dispatchEvent(new SimpleMessageEvent(SimpleMessageEvent.SHOW_SIMPLE_MESSAGE,"Alerts registration failed this time, plaese try again after some time."));
		}
		
		[EventHandler(event="XAlertEvent.ENABLE_ALERTS")]
		public function enableAlerts(e:XAlertEvent):void
		{
			_xAlertService.enableAlerts();
		}
		
		[EventHandler(event="XAlertEvent.DISABLE_ALERTS")]
		public function disableAlerts():void
		{
			_xAlertService.disableAlerts();
		}
		
		[EventHandler(event="XAlertFavoriteEvent.FAVORITE_ALERT_ON")]
		public function favorite(e:XAlertFavoriteEvent):void
		{
			_xAlertService.favorite(e.data);
		}
		[EventHandler(event="XAlertFavoriteEvent.FAVORITE_ALERT_OFF")]
		public function unFavorite(e:XAlertFavoriteEvent):void
		{
			_xAlertService.unFavorite(e.data);
		}
			
	}
}