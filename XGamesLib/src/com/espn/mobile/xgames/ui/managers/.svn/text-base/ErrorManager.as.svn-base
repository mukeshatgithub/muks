package com.espn.mobile.xgames.ui.managers
{
	import com.espn.mobile.xgames.events.AppErrorEvent;
	import com.espn.mobile.xgames.ui.comp.ErrorPopup;
	import com.espn.mobile.xgames.ui.comp.PopupOverlay;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	
	import spark.components.Group;
	import spark.components.SkinnableContainer;
	
	/**
	 * 
	 * @author rmish8
	 * 
	 * ErrorManager is used to manage the various 'errors in the application'
	 * instances.
	 * 
	 */	
	public class ErrorManager extends EventDispatcher
	{
		public static var IS_TABLET_DEVICE:Boolean = true;
		
		public static var popUpWidth:Number = 450;
		public static var popUpheight:Number = 200;
		
		/**
		 * constructor
		 */		
		public function ErrorManager()
		{
			super();
		}
		
		private static var contentGrp:PopupOverlay;
		private static var errorPopup:ErrorPopup;
		
		/**
		 * 
		 * Create Pop Up
		 * 
		 */
		public static function showError(message:String, showButton:Boolean = true, buttonLabel:String = "CONTINUE", dispatchRetryEvent:Boolean = false):void
		{
			if (!errorPopup)
			{
				var popupContainer:SkinnableContainer = FlexGlobals.topLevelApplication as SkinnableContainer;
				contentGrp = new PopupOverlay();
				contentGrp.width = popupContainer.width;
				contentGrp.height = popupContainer.height;
				
				contentGrp.addEventListener(MouseEvent.CLICK, onContentGrpClick);
				popupContainer.addElement(contentGrp);

				errorPopup = new ErrorPopup();
				if(IS_TABLET_DEVICE)
				{
					errorPopup.popUpWidth = 450; 
					errorPopup.popUpheight = 200; 
					errorPopup.btnContainerWidth = 100;
					errorPopup.btnContainerHeight = 40;
					errorPopup.btnContainerBottom = 20;					
				}
				else
				{
					errorPopup.popUpWidth = 250; 
					errorPopup.popUpheight = 200;
					errorPopup.btnContainerWidth = 80;
					errorPopup.btnContainerHeight = 30;
					errorPopup.btnContainerBottom = 20;
				}
				errorPopup.horizontalCenter = errorPopup.verticalCenter = 0; 
				errorPopup.message = message;
				errorPopup.showContinueBtn = showButton;
				errorPopup.button.text = buttonLabel;
				errorPopup.dispatchRetryEvent = dispatchRetryEvent;
				errorPopup.btnContainer.addEventListener(MouseEvent.CLICK, closePopup);
				popupContainer.addElement(errorPopup);
			}
		}
		
		/**
		 * Remove PopUp
		 */
		protected static function closePopup(event:MouseEvent = null):void
		{
			var popupContainer:SkinnableContainer = FlexGlobals.topLevelApplication as SkinnableContainer;
			if(contentGrp && popupContainer.getElementIndex(contentGrp) != -1)
			{
				popupContainer.removeElement(contentGrp);
			}
			if(errorPopup && popupContainer.getElementIndex(errorPopup) != -1)
			{
				popupContainer.removeElement(errorPopup);
			}
			contentGrp = null;
			errorPopup = null;
		}
		
		private static function onContentGrpClick(e:MouseEvent):void
		{
			if (e.target == contentGrp)
				closePopup();
		}
		

	}
}