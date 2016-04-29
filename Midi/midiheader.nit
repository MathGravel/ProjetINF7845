module midiheader

class MidiHeader
	var chunk : String is noinit
	var chunklength : Int  is noinit
	var format : Int  is noinit
	var tracklength : Int  is noinit
	var division : Int  is noinit
	var raw : Bytes

	init
	do
		chunk = raw.slice(0,4).to_s
		chunklength = ("0x" + raw.slice(4,4).hexdigest).to_i
		format = ("0x" + raw.slice(8,2).hexdigest).to_i
		tracklength = ("0x" + raw.slice(10,2).hexdigest).to_i
		division = ("0x" + raw.slice(12,2).hexdigest).to_i


		if division < 0 then
			var fps = 	((~(division.to_b >> 8))+0x01u8) & 0xffu8
			var res =  division.to_b & 0x0fu8
			if fps == 232 then
				fps = 24.to_b
			else if fps == 231 then
				fps = 25.to_b
			else if fps == 227 then
				fps = 29.to_b
			else if fps == 226 then
				fps = 30.to_b
			else
				abort
			end

			division = fps.to_i

		end

	end

	redef fun to_s : String
	do
		var header = "Header \n{chunk}\n"
		header = header + "Length : {chunklength}\n"
		header = header + "Format : {format}\n"
		header = header + "Number of tracks : {tracklength}\n"
		header = header + "Ticks division : {division}\n"

		return header

	end

end
