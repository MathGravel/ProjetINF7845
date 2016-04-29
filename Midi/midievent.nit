module midievent

import cartesian
import midinote
import midimessage


class MidiEvent
	var deltaTime : Int
	var startTime : Int
	var eventFlag : Byte
	var note : nullable Byte = null
	var velocity : nullable Byte= null
	var keyPressure : nullable Byte= null
	var chanPRessure : nullable Byte= null
	var controlNum : nullable Byte= null
	var controlValue : nullable Byte= null
	var pitchBend : nullable Int= null
	var messag : nullable Message= null
	var raw : Bytes

	init
	do
		assert raw.length > 0
		if eventFlag == 0xffu8 then
			assert raw.length > 1
			var vals = self.getLengthBody(2)
			messag = new MetaMessage(eventFlag,vals.f,raw[0],vals.e)
		else if eventFlag == 0xf0u8 or eventFlag == 0xf7u8 then
			var vals = self.getLengthBody(1)
			messag = new SystemMessage(eventFlag,vals.e,vals.f)
		else if eventFlag.is_between(0xB0u8,0xBFu8) and raw[1] < 0x80u8 then
			messag = new ChannelModeMessage(eventFlag,raw[1],raw[2])
		else if eventFlag >= 0x80u8 then
			var second : nullable Byte
			if raw.length < 3 then 
				second = null
			else
				second = raw[2]
			end 
			messag = new ChannelVoiceMessage(eventFlag,raw[1],second)
			messag.as(ChannelVoiceMessage).setStartingTime(startTime)
		else
			print "Event {eventFlag}"
			abort
		end

	end

	fun getLengthBody( startPos : Int) : Pair[Bytes,Bytes]
	do
		var bodyStart = -1
		for i in [startPos .. raw.length] do
			if raw[i] < 0x80u8 then
				bodyStart = i
				break
			end
		end
		assert bodyStart > -1
		return  new Pair[Bytes,Bytes](raw.slice(startPos,bodyStart),raw.slice_from(bodyStart))
	end


	redef fun to_s: String
	do
		var str = "Starttime {startTime} Delta {deltaTime} EventFlag {eventFlag} \n"
		if messag != null then
			str = str + messag.to_s
		end 
		return str
	end


end
