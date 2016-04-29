module cluster

import distances

class Cluster

	var nom : String
	var parent : Cluster is noinit
	var enfants : Array[Cluster] = new Array[Cluster]
	var dist : Distance = new Distance(0.0)

	fun getDistancePoids : Float
	do
		return dist.getPoids
	end

	fun getDistanceVal : Float
	do
		return dist.getDist
	end


	fun ajouterEnfant(enfant : Cluster)
	do
		enfants.add enfant
	end

	fun contient(enfant : Cluster) : Bool
	do
		return enfants.has(enfant)
	end

	redef fun to_s : String
	do
		return "Cluster {nom} {dist}"
	end

	redef fun hash : Int
	do
		return nom.hash		
	end

	fun estFeuille : Bool do 
		return enfants.length == 0 
	end

	fun compterFeuilles : Int
	do
		if estFeuille then return 1

		var comp : Int = 0
		for enfant in enfants
		do
			comp = comp + enfant.compterFeuilles
		end
		return comp
	end

	fun distanceTotale: Float
	do
		var distance : Float = dist.getDist
		if enfants.length > 0 then
			distance = distance + enfants[0].getDistanceVal
		end

		return distance
	end

end

class PaireCluster
	
	super Comparable
	var gauche : Cluster
	var droite : Cluster
	var distanc : Float = 0.0


	fun setDistance(dist : Float)
	do
		distanc = dist
	end

	redef fun < (other) : Bool
	do
		if other isa PaireCluster then
			return distanc < other.distanc
		end
		return false
	end

	fun agglomere : Cluster
	do
		var newCluster : Cluster = new Cluster("{gauche.nom} {droite.nom}")
		newCluster.dist = new Distance(distanc)
		newCluster.ajouterEnfant(gauche)
		newCluster.ajouterEnfant(droite)
		gauche.parent = newCluster
		droite.parent = newCluster
		newCluster.dist.setPoids(gauche.getDistancePoids + droite.getDistancePoids)
		return newCluster
	end

	redef fun to_s : String
	do
		return "PaireCluster {gauche} {droite} {distanc}"
	end


end