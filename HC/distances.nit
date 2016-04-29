module distances


class Distance
	
	super Comparable
	private var distan : Float
	private var poids : Float = 1.0
	
	fun setPoids(w : Float)
	do
		poids = w
	end

	fun getPoids : Float
	do
		return poids
	end

	fun getDist : Float
	do
		return distan
	end

	fun getWeightedDist : Float
	do
		return distan * poids
	end

	redef fun < (other) : Bool
	do
		if not other isa Distance then
			return false
		end

		return self.distan < other.getDist


	end

	redef fun to_s : String
	do
		return "Distance {distan} {poids}"
	end

end


