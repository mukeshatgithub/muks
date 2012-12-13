package com.espn.mobile.xgames.service
{
	import com.espn.mobile.xgames.events.CasterEvent;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.external.*;
	import flash.net.XMLSocket;
	import flash.utils.setTimeout;
	
	
	[Event(name="casterConnected", 	type="com.espn.mobile.xgames.events.CasterEvent")]
	[Event(name="casterClose", 		type="com.espn.mobile.xgames.events.CasterEvent")]
	[Event(name="casterData", 		type="com.espn.mobile.xgames.events.CasterEvent")]
	[Event(name="casterError", 		type="com.espn.mobile.xgames.events.CasterEvent")]
	
	public class CasterClient extends EventDispatcher
	{
		
		private var casterBuffer:Array = new Array();
		private var isProcessing:Boolean = false;
		private var headerReceived:Boolean = false;
		private var isFirstMessage:Boolean = true;
		private var connectionAttempts:Number = 0;
		private var isPolling:Boolean = false;
		private var casterSocket:XMLSocket = new XMLSocket();
		private var currentSnapshotId:String = '';
		private var casterMessage:String;
		
		
		// connection information
		private var sessionName:String;//"uber-games";
		private var host:String = "core-qa.caster.espn.go.com";//"core.caster.espn.go.com";
		private var port:int = 80;
		private var pollMode:String = 'absolute';
		private var baseURL:String = 'proxy.espn.go.com/sports/caster/snapshot'//'espn.go.com/aggregator/cached/tea/caster/snapshot';
		private var duration:int = 1000;
		
		public static const CASTER_GET_HYPE:String = "getHype";
		//public static const CASTER_GET_RESULTS:String = "getResults_1";
		
		
		
		
		/**
		 * 
		 */
		public function CasterClient(sessionName:String):void
		{
			this.sessionName = sessionName;
			casterSocket.addEventListener(Event.CONNECT, onCasterConnectHandler);
			casterSocket.addEventListener(Event.CLOSE, onCasterCloseHandler);
			casterSocket.addEventListener(IOErrorEvent.IO_ERROR, onCasterErrorHandler);
			casterSocket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onCasterErrorHandler);
			casterSocket.addEventListener(DataEvent.DATA, onCasterDataHandler);
			
		}
		
		
		public function connect():void
		{
			casterSocket.connect(host, port);
		}
		
		public function destroy():void
		{
			if(casterSocket)
			{
				
				casterSocket.close();
				casterSocket.removeEventListener(Event.CONNECT, onCasterConnectHandler);
				//casterSocket.removeEventListener(Event.CLOSE, onCasterCloseHandler);
				casterSocket.removeEventListener(IOErrorEvent.IO_ERROR, onCasterErrorHandler);
				casterSocket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onCasterErrorHandler);
				casterSocket.removeEventListener(DataEvent.DATA, onCasterDataHandler);
				casterSocket = null;
			}
		}
		
			
		
		private function tryToConnect():void
		{
			casterSocket.connect(host, port);
		}
		
		
		private function onCasterCloseHandler(e:Event):void
		{
			//outPutText += "\n socket close";
			//ExternalInterface.call(_level0.jsFunction, "connectionStatus", "closed")
			if(connectionAttempts<5){
				setTimeout(tryToConnect, 5000);
				connectionAttempts++;
			}
			else{
				startPollingMode();
			}
		}
		
		private function onCasterConnectHandler(e:Event):void
		{
			casterSocket.send("GET /" + sessionName + " HTTP/1.0\r\n\r\n");
			//stopPollingMode();
			dispatchEvent(new CasterEvent(CasterEvent.CASTER_CONNECTED));
		}
		
		private function onCasterErrorHandler(e:Event):void
		{
			dispatchEvent(new CasterEvent(CasterEvent.CASTER_ERROR,"Socket Error"));// pull this error message from error resource bundle
			startPollingMode();
		}
		
		private function onCasterDataHandler(e:DataEvent):void
		{
			var casterMessage:String = e.data;
			// below part is unknown and require infomration before we use it
			//==============================================================
			if(!headerReceived) 
			{
				if(casterMessage.substr(0,4)=="HTTP") 
				{
					headerReceived = true;
					return;
				}
			}
			var delimPos:Number = casterMessage.indexOf("=");
			var messType:String = casterMessage.substring(0,delimPos);
			var casterSnap:String = casterMessage.substring(0,delimPos);
			if (isNaN(Number(messType)))
			{
				if (messType == "z")
				{
					//outPutText += "\n system reset";
				} 
				else if (messType == "s")
				{
					//outPutText += "\n system ping";
				}
			}  
			else 
			{
				sendToBuffer(casterMessage);
				if(isFirstMessage) 
				{
					isFirstMessage = false;
					isProcessing = true;
					getSnapshots(currentSnapshotId,casterSnap);
				}
				else if(!isProcessing)
				{
					processBuffer();
				}
			}
			dispatchEvent(new CasterEvent(CasterEvent.CASTER_DATA,casterMessage));
		}
		
		
		
		private function processCasterMessage(casterMessage:String):void
		{
			var delimPos:Number = casterMessage.indexOf("=");
			var snapshotId:String = casterMessage.substring(0,delimPos);
			/*if (Number(snapshotId) != Number.NaN && Number(snapshotId)>Number(currentSnapshotId)){
			var snapshotData:String = '';
			if ((delimPos+1) < casterMessage.length){
			snapshotData = casterMessage.substring(delimPos+1);
			}
			currentSnapshotId = snapshotId;
			processSnapshots(parseDataMessage(snapshotData));	
			}*/
		}
		
		private function sendToBuffer(casterMessage:String):void
		{
			casterBuffer.push(casterMessage);
		}
		
		private function processBuffer():void
		{
			while(casterBuffer.length>0){
				processCasterMessage(casterBuffer.shift().toString());
			}
		}
		
		private function startPollingMode():void {
			if(!isPolling){
				pollSnapshots();
				//intervalId = setInterval(pollSnapshots, duration);
				isPolling = true;
			}
		}
		
		private function stopPollingMode():void {
			if(isPolling){
				//clearInterval(intervalId);
				isPolling = false;
			}
		}
		
		private function pollSnapshots():void{
			getSnapshots(currentSnapshotId, currentSnapshotId);
		}
		
		private function processSnapshots(snapshots:Array):void {
			//ExternalInterface.call(_level0.jsFunction, currentSnapshotId, snapshots);
			trace('process snapshots '+snapshots);
		}
		
		private function getSnapshots(startId:String, endId:String):void
		{
		 	/*var my_xml:XML = new XML();
			my_xml.ignoreWhite=true;
			
			var url:String = "";
			if(pollMode!="relative"){
				url = "http://"+baseURL+"?sessionId="+sessionName+"&masterSnap="+startId+"&casterSnap="+endId+"&rand="+new Date().getTime();
			}
			else{
				url = baseURL+"?sessionId="+sessionName+"&masterSnap="+startId+"&casterSnap="+endId+"&rand="+new Date().getTime();
			}*/
			//my_xml.load (url);
		}
		
		private function parseDataMessage(dataMessage:String):Array 
		{
			var theResult:Array = new Array();
			var encodedObjs:Array = dataMessage.split(String.fromCharCode(13));
			for (var encObj:Object in encodedObjs) {
				var theObj:Object = parseEncodedObject(encodedObjs[encObj]);
				if(theObj!=null){
					theResult.push(theObj);
				}
			}
			return theResult;
		}
		
		private function parseEncodedObject(encObj:String):Object {
			var theObj:Object = null;
			var segments:Array = encObj.split(String.fromCharCode(9));
			if (segments.length == 2) {
				theObj = new Object();
				theObj["objId"] = segments[0];
				var encProps:Array = segments[1].split(String.fromCharCode(10));
				for (var encProp:String in encProps) {
					if (encProps[encProp].length>1) {
						var indexHexStr:String = encProps[encProp].substring(0, 2);
						var decodedIndex:Number = parseInt(indexHexStr, 16);
						if (decodedIndex>50000) {
							//bad decode
						}
						// subtract four from the encoded value because 0-32 are off limits 
						// so all indexes have 32 added to them.
						if (encProps[encProp].length>2) {
							theObj[""+decodedIndex] = encProps[encProp].substring(2);
						}
						else {
							theObj[""+decodedIndex] = "";
						}
					}
				}
			}
			return theObj;
		}
		
		
	}
}