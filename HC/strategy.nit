module strategy

import distances

redef class Float

	fun is_Correct : Bool
	do
		return self > 0.0
	end

end

interface LinkingStrategy
	fun getDistance(distValues : Array[Distance]) : Distance is abstract
end

class SingleLinkingStrategy
	super LinkingStrategy

	redef fun getDistance(distValues : Array[Distance]) : Distance
	do
		var d : Float = -1.0
		for dist in distValues
		do
			if dist.getDist.is_Correct and (dist.getDist < d or d == -1.0) then
				d = dist.getDist
			end
		end

		return new Distance(d)

	end
end

class CompleteLinkingStrategy
	super LinkingStrategy

	redef fun getDistance(distValues : Array[Distance]) : Distance
	do
		var d : Float = -1.0
		for dist in distValues
		do
			if dist.getDist.is_Correct and (dist.getDist > d or d == -1.0) then
				d = dist.getDist
			end
		end

		return new Distance(d)
	end
end

class WeightLinkingStrategy
	super LinkingStrategy

	redef fun getDistance(distValues : Array[Distance]) : Distance
	do
		var d : Float = 0.0
		var w : Float = 0.0
		for dist in distValues
		do
			w = w + dist.getPoids
			d = d + dist.getWeightedDist
		end

		var dis = new Distance(d/w)
		dis.setPoids(w)

		return dis
	end
end