module hierachy

import mappingdistance
import cluster
import strategy

class Hierachie
	var distances : DistanceMapping 
	var clusters : Array[Cluster] 

	fun agglomerat(strategie : LinkingStrategy)
	do
		assert distances.donnees.length > 0
		var minDist : PaireCluster = distances.enlevePremier
		clusters.remove minDist.gauche
		clusters.remove minDist.droite

		var nouveauCluster : Cluster =  minDist.agglomere
		for cluster in clusters
		do
			var p1  = distances.getPaireCluster(cluster,minDist.gauche)
			var p2  = distances.getPaireCluster(cluster,minDist.droite)
			var p3 : PaireCluster = new PaireCluster(cluster,nouveauCluster)
			var dist : Array[Distance] = new Array[Distance]
			if not p1 ==  null then
				dist.add new Distance(p1.distanc)
				distances.enleve p1
			end

			if not p2 == null then
				dist.add new Distance(p2.distanc)
				distances.enleve p2
			end 

			var nouvDist : Distance = strategie.getDistance(dist)
			p3.setDistance(nouvDist.getDist)
			distances.ajouter p3

		end
		clusters.add nouveauCluster

	end

	fun finitArbre : Bool
	do
		return clusters.length == 1
	end

	fun getTete : Cluster
	do
		assert clusters.length > 0
		return clusters[0]
	end


end