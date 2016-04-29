module clusteralgorithm

import cluster
import mappingdistance
import distances
import strategy
import hierachy


class ClusteringAlgorithm
	var strategie : LinkingStrategy
	var distances : Array[Array[Float]]
	var noms : Array[String]
	var clusters : Array[Cluster] = new Array[Cluster]
	var mapping : DistanceMapping = new DistanceMapping
	var hier : Hierachie is noinit

	init
	do
		for dist in distances
		do
			assert dist.length == distances.length
			assert dist.length == noms.length
		end

		for nom in noms
		do
			clusters.add new Cluster(nom)
		end

		for i in [0 .. clusters.length]
		do
			for j in [i + 1 .. clusters.length]
			do
				var paire = new PaireCluster(clusters[i],clusters[j])
				paire.setDistance(distances[i][j])
				mapping.ajouter paire
			end
		end

		hier = new Hierachie(self.mapping,self.clusters)
		while not hier.finitArbre
		do
			hier.agglomerat(strategie)
		end
	end


	fun getCluster : Cluster
	do
		return hier.getTete
	end

end

