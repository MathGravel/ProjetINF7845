module mappingdistance


import distances
import cluster
import trees

class Element
	super Comparable
	var paire : PaireCluster
	var enlever : Bool = false
	var nom : String is noinit

	init
	do
		if paire.gauche.nom < paire.droite.nom then
			nom = "{paire.gauche.nom} ### {paire.droite.nom}"
		else
			nom = "{paire.droite.nom} ### {paire.gauche.nom}"
		end		
	end

	redef fun <(other) : Bool
	do
		if other isa Element then
			return paire < other.paire 
		else
			return false
		end
	end

	redef fun to_s : String
	do
		return nom
	end
end


class DistanceMapping
	var donnees : MinHeap[Element] = new MinHeap[Element].default
	var map : BinTreeMap[String,Element] = new BinTreeMap[String,Element]

	fun getElems : Array[PaireCluster]
	do
		var liste : Array[PaireCluster] = new Array[PaireCluster]
		for elem in map.values
		do
			liste.add elem.paire
		end
		return liste
	end

	fun getPaireCluster(ca : Cluster, cb : Cluster) : nullable PaireCluster
	do
		var nom = ""
		if ca.nom < cb.nom then
			nom = "{ca.nom} ### {cb.nom}"
		else
			nom = "{cb.nom} ### {ca.nom}"
		end	
		var i = map.get_or_null(nom)
		if i == null then return null
		return i.paire
	end

	fun enlevePremier : PaireCluster
	do
		assert donnees.length > 0
		var it : Element = donnees.take
		while it.enlever
		do
			it = donnees.take
		end
		map.delete it.nom

		return it.paire

	end

	fun enleve(cp : PaireCluster) : Bool
	do 
		if map.keys.length == 0 then
			return false
		end
		var nom = ""
		if cp.gauche.nom < cp.droite.nom then
			nom = "{cp.gauche.nom} ### {cp.droite.nom}"
		else
			nom = "{cp.droite.nom} ### {cp.gauche.nom}"
		end	

		var it = map.delete(nom)
		it.enlever = true
		return true

	end

	fun ajouter(cp : PaireCluster)
	do
		var el : Element = new Element(cp)
		map[el.nom] = el
		donnees.add el

	end


end