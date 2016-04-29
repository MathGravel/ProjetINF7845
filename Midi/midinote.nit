module midinote

class Note
	var velocity : Byte = 0x40u8
	var startTime : Int = -1
	var note :  nullable Byte = null 
	var duration : Int  = 0
	var pressure : Byte  = 0x00u8
	var noteString : String = ""
	var chan : Int is noinit

	fun setNote(b :  nullable Byte) 
	do 
		note = b
		if note != null then
			var notes = ["A","A#","B","C","C#","D","D#","E","F","F#","G","G#"]
			noteString = notes[(note.to_i + 3)%12]
		end
	end

	fun setEndTime (endTime : Int) do duration = endTime - startTime

	redef fun to_s: String
	do
		return "MidiNote number={note.to_i} start= {startTime} duration= {duration} pressure= {pressure} type= {noteString} Channel {chan} "
	end

	 fun clone : Note
	do
		var n = new Note
		n.startTime = self.startTime
		n.setNote(self.note)
		n.velocity = self.velocity
		n.duration = self.duration
		n.pressure = self.pressure
		n.chan = self.chan
		return n

	end

end
