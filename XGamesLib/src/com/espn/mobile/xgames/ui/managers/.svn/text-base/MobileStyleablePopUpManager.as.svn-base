package com.espn.mobile.xgames.ui.managers
{
	import com.greensock.TweenLite;
	import com.greensock.events.TweenEvent;
	import com.espn.mobile.xgames.constants.AppConstants;
	import com.espn.mobile.xgames.ui.comp.PopupOverlay;
	
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	import mx.effects.Tween;
	import mx.events.EffectEvent;
	
	import spark.components.Group;
	import spark.components.SkinnableContainer;
	
	/**
	 * 
	 * @author rmish8
	 * 
	 * StyleablePopUpManager is used to manage the various 'StyleablePopUp'
	 * instances.
	 * 
	 */	
	public class MobileStyleablePopUpManager
	{
		
		/**
		 * constructor
		 */		
		public function MobileStyleablePopUpManager()
		{
			super();
		}
		
		public static var parent:Group;
		
		private static var contentGrp:PopupOverlay;
		
		public static var isPopupOpen:Boolean = false;
		
		
		/**
		 * 
		 * Create Pop Up
		 * 
		 */		
		public static function createPopUp(popupComp:UIComponent, blnShow:Boolean = true):void
		{
			isPopupOpen = true;
			parent.visible = true;
			parent.percentWidth = 100;
			
			if(!contentGrp)
				contentGrp = new PopupOverlay();
			
			if(!blnShow)
				contentGrp.right = - AppConstants.APP_WIDTH;
			
			contentGrp.percentWidth = 100;
			contentGrp.height = parent.stage.height;
			
			popupComp.percentWidth = 100;
			popupComp.height = parent.stage.height;
			
			contentGrp.left = AppConstants.APP_WIDTH;
			
			if(contentGrp.numElements > 0)
			{
				contentGrp.removeAllElements();
			}
			
			contentGrp.addElement(popupComp);
			contentGrp.addEventListener(MouseEvent.CLICK, onMouseClick);
			
			parent.addElement(contentGrp);
			TweenLite.to(contentGrp,0.5,{left:0});
		}
		
		public static function show():void
		{
			//TweenLite.to(contentGrp, 0.5, {right:0});
		}
		
		/**
		 * Event listener for removing the popup
		 */
		protected static function onMouseClick(e:MouseEvent):void
		{
			if (e.target == contentGrp)
				removePopUp(contentGrp);
			
			
		}
		
		/**
		 * Remove PopUp
		 */		
		public static function removePopUp(popupComp:UIComponent):void
		{
			isPopupOpen = false;
			
			if(contentGrp)
			//Animation to remove the popup
				TweenLite.to(contentGrp,0.5,{left:AppConstants.APP_WIDTH});
			
			//Delayed function call when animation is completed
			TweenLite.delayedCall(0.5, onEffectComplete);
			popupComp = null;
		}
		
		/**
		 * This function will be called when the animation is completed
		 * to remove the elements from the content group
		 */
		protected static function onEffectComplete():void
		{
			/*parent.visible = false;
			parent.removeAllElements();
			contentGrp = null;*/
		}
		
	}
}