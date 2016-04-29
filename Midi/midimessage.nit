module midimessage

import midinote


redef class Byte

	fun get_Channel : Int
	do
		return (self & 0x0Fu8).to_i
	end

end


abstract class Message
	var statusByte : Byte
	type I: Object
	var data : I 


	fun isNoteOnEvent: Bool do return false
	fun isNoteOffEvent: Bool do return false
	fun isMetaEvent: Bool do return statusByte == 0xFFu8
	fun isSysExEvent: Bool do return statusByte == 0xF0u8 or statusByte == 0xF0u8
	fun isChannelEvent : Bool do return not isMetaEvent and not isSysExEvent
	fun isEventProgramChange: Bool do return statusByte & 0xC0u8 == 0xC0u8


	fun getBody : I
	do
		return data
	end

	redef fun to_s : String
	do
		return "Event {statusByte}"
	end

end

class SystemMessage
	super Message
	var length: Bytes
	redef type I : Bytes

	fun getBodyParsed : String
	do
		return data.hexdigest
	end


end

class  MetaMessage
	super Message
	var metaType : Byte 
	var length : Bytes

	var numerator : nullable Byte= null
	var denom : nullable Byte= null
	var tempo : nullable Int= null
	var seq : nullable Int = null

	init
	do
		if isTempo then
			tempo = ("0x" + data.hexdigest).to_i
		else if isSeq then
			seq = ("0x" + data.hexdigest).to_i
		end

	end


	redef type I : Bytes


	redef fun to_s : String
	do
		return "{statusByte} {metaType} {length.hexdigest} {data.hexdigest}"
	end

	fun isTempo: Bool
	do
		return metaType == 0x51u8
	end

	fun isEOT: Bool
	do
		return metaType == 0x2Fu8
	end

	fun isSeq: Bool
	do
		return metaType == 0x00u8
	end


end



abstract class ChannelMessage
	super Message
	var channel : Int is noinit
	var secondData : nullable Byte

	init
	do
		self.channel = statusByte.get_Channel

	end

	redef type I : Byte
	fun isController: Bool do return statusByte & 0xf0u8 == 0xB0u8



end

class ChannelVoiceMessage
	super Note	
	super ChannelMessage


	fun setStartingTime(time : Int)
	do
		self.startTime = time
	end


	init
	do
		if secondData != null and statusByte & 0xf0u8 == 0x90u8  then
			self.setNote data
			self.velocity = secondData.to_b
		end
		self.chan = self.channel
	end

	redef fun isNoteOnEvent: Bool
	do
		return statusByte & 0xf0u8 == 0x90u8 and velocity != 0x00u8 and self.note != null
	end

	redef fun isNoteOffEvent: Bool
	do
		return (statusByte & 0xf0u8 == 0x90u8 and velocity == 0x00u8) or (statusByte & 0xf0u8 == 0x80u8)
	end

	redef fun to_s: String
	do
		return super + "{data.to_s}"
	end

end

class ChannelModeMessage
	super ChannelMessage

	redef fun isNoteOffEvent:Bool
	do
		return statusByte == 0x7eu8 or statusByte == 0x7au8
	end
end