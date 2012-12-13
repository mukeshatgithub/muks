package com.espn.mobile.xgames.ui.managers
{
	import com.espn.mobile.xgames.ui.comp.PopupOverlay;
	
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	
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
	public class StyleablePopUpManager
	{
		
		/**
		 * constructor
		 */		
		public function StyleablePopUpManager()
		{
			super();
		}
		
		private static var contentGrp:PopupOverlay;
	
		public static var isSocialSharingOpen:Boolean = false;
		public static var firstPopUpOpen:Boolean = false;
		
		public static var oldPopupComp:UIComponent;
		public static var newPopupComp:UIComponent;
		
		/**
		 * 
		 * Create Pop Up
		 * 
		 */		
		public static function createPopUp(popupComp:UIComponent):void
		{
			var popupContainer:SkinnableContainer = FlexGlobals.topLevelApplication as SkinnableContainer;
			
			if(isPopUpOpen)
			{
				oldPopupComp = popupComp;
				contentGrp = new PopupOverlay();
				contentGrp.width = popupContainer.width;
				contentGrp.height = popupContainer.height;
				
				popupContainer.addElement(contentGrp);
				
				popupComp.verticalCenter = 0;
				popupComp.horizontalCenter = 0;
				popupContainer.addElement(popupComp);
				contentGrp.addEventListener(MouseEvent.CLICK, onMouseClick);
				firstPopUpOpen = true;
			}
			
			
			if(isSocialSharingOpen)
			{
				newPopupComp = popupComp;
				oldPopupComp.visible = false;
				
				popupComp.verticalCenter = 0;
				popupComp.horizontalCenter = 0;
				popupContainer.addElement(popupComp);
				isSocialSharingOpen = true;
				
			}
				
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
			
			var popupContainer:SkinnableContainer = FlexGlobals.topLevelApplication as SkinnableContainer;
			
			if (newPopupComp)
			{
				popupContainer.removeElement(newPopupComp); 
				newPopupComp = null; 
				popupComp = null;
				isSocialSharingOpen = false;
				oldPopupComp.visible = true;
				
			}
			else if(contentGrp && popupContainer.getElementIndex(contentGrp) != -1) 
			{
				
				popupContainer.removeElement(oldPopupComp); 
				oldPopupComp = null; 
				popupContainer.removeElement(contentGrp);
				contentGrp = null;
				popupComp = null;
				firstPopUpOpen = false;
				
			}
			
		}
		
		/**
		 * Return the existence of the popup
		 */
		public static function get isPopUpOpen():Boolean
		{
			if(!firstPopUpOpen && !isSocialSharingOpen)
				return true;
			return false;
		}
	}
}