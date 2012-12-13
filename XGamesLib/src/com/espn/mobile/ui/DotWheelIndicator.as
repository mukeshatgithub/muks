//////////////////////////////////////////////////////
//
//
//
//
//////////////////////////////////////////////////////
package com.espn.mobile.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	
	import spark.core.SpriteVisualElement;
	
	[Event(name="complete", type="Event.COMPLETE")]	//NOPMD
	
	/**
	 * DotWheel is a alternative custom loading indicator with configurable round dots.
	 * <p>The usage is similar to the LoadingIndicator class in the Flex SDK.
	 * One major difference you have to keep in mind, is that this component will not 
	 * take care of different DPI values as the SDK class does.</p>
	 */
	public class DotWheelIndicator extends SpriteVisualElement
	{
		/**
		 * The list of all dots
		 */
		protected var dots:Array = new Array();
		/**
		 * Number of dots
		 */
		protected var amount:uint;
		/**
		 * Interval between the appearance of two dots in frames
		 */
		protected var turnInterval:uint;
		/**
		 * the counter for the turnInterval
		 */
		protected var turnCounter:uint;
		/**
		 * Interval for fading dots in frames
		 */
		protected var fadeInterval:uint;
		/**
		 * Current position/dot
		 */
		protected var current:uint;
		/**
		 * Counter for decomposing, gets his value from <code>fadeInterval</code>
		 */ 
		protected var decomposeCounter:uint
		
		/**
		 * Constructor.
		 * @param amount The number of dots in the circle
		 * @param radius The radius of the circle, measured to the center of the dots
		 * @param dotSize The size of the a single dot
		 * @param dotColor The color of the dots
		 * @param turnInterval The time between the appearance of the dots in frames
		 * @param fadeInterval The time for a dot to fade in frames
		 */
		public function DotWheelIndicator(amount:uint = 8, 
										  radius:uint = 20, 
										  dotSize:uint = 15, 
										  dotColor:uint = 0xffffff, 
										  lineSize:uint = 2, 
										  lineColor:uint = 0, 
										  turnInterval:uint = 3, 
										  fadeInterval:uint = 30)
		{
			super();
			this.amount = amount;
			this.turnInterval = turnInterval;
			this.fadeInterval = fadeInterval;
			build(amount, radius, dotSize, dotColor, lineSize, lineColor, fadeInterval);
		}
		/**
		 * Start the indicator. 
		 * Note that the indicator will not be started automatically on construction.
		 */
		public function start():void
		{
			current = 0;
			turnCounter = 0;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(Event.ENTER_FRAME, onDecompose);
		}
		/**
		 * Stop the indicator.
		 */
		public function stop():void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.ENTER_FRAME, onDecompose);
			decomposeCounter = fadeInterval;
		}
		/**
		 * @inherit
		 */
		protected function onEnterFrame(event:Event):void
		{
			if (--turnCounter > 0)
				return;
			
			turnCounter = turnInterval;
			(dots[current] as Dot).show();
			if (++current == amount) 
				current = 0;
		}
		/**
		 * @private
		 */
		protected function onDecompose(event:Event):void
		{
			if (--decomposeCounter > 0)
				return;
			removeEventListener(Event.ENTER_FRAME, onDecompose);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		/**
		 * @private
		 */
		protected function build(amount:uint, radius:uint, dotSize:uint, dotColor:uint, lineSize:uint, lineColor:uint, fadeCount:uint):void
		{
			var dot:Sprite;
			var angle:Number = 2 * Math.PI / amount;
			var _angle:Number;
			for (var n:uint = 0; n < amount; n++)
			{
				dot = new Dot(dotSize, dotColor, lineSize, lineColor, fadeCount);
				addChild(dot);
				dots.push(dot);
				_angle = angle * n;
				dot.x = Math.cos(_angle) * radius;
				dot.y = Math.sin(_angle) * radius;
				dot.alpha = 0;
			}
		}
	}
}
import flash.display.Sprite;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

import org.osmf.events.TimeEvent;

class Dot extends Sprite
{	
	private var fadingFrames:uint;
	private var currentFrame:uint;
	
	public function Dot(dotSize:uint, dotColor:uint, lineSize:uint, lineColor:uint, fadingFrames:Number)
	{
		this.fadingFrames = fadingFrames
		create(dotSize, dotColor, lineSize, lineColor);
	}
	private function create(dotSize:uint, dotColor:uint, lineSize:uint, lineColor:uint):void
	{
		graphics.beginFill(dotColor);
		graphics.lineStyle(lineSize, lineColor);
		graphics.drawCircle(0, 0, dotSize / 2);
		graphics.endFill();
	}
	public function show():void
	{
		currentFrame = fadingFrames;
		alpha = 1;
		scaleX = 1; 
		scaleY = 1;
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	private function onEnterFrame(event:Event):void
	{
		scaleX = scaleY = alpha = --currentFrame / fadingFrames;
		if (currentFrame == 0)
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	}
}


