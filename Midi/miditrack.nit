module miditrack

import midimessage
import midievent


class Track
	super Array[MidiEvent]

	var musicins : Int is noinit
	var size : Int  is noinit
	var trackNum : Int
	var chunk : String is noinit
	var notes : Array[Note] = new Array[Note]
	var raw : Bytes

	init
	do
		chunk = raw.slice(0,4).to_s
		size = ("0x" + raw.slice(4,4).hexdigest).to_i
	end


	fun setInstrument(instrument : Int)
	do
		musicins = instrument
	end

	redef fun to_s: String
	do
		var str = "Track {trackNum} Instrument {musicins} Size {size}\n"
		for i in [0 .. self.length -1] do
			str = str + "Event {self[i]}\n"
		end
		return str
	end

end

