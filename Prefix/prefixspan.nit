module prefixspan

import cartesian
import transaction


redef class Pair[E : nullable Object,F : nullable Object]
	super Cloneable

	redef fun clone
	do
		return new Pair[E,F](self.e,self.f)
	end
end

class PrefixSpan
	super Base
	var fileloc : String	
	var minSup : Int
	var maxSup : Int
	var patterns : Array[Pair[Array[ITEM],Int]] = new Array[Pair[Array[ITEM],Int]]
	var file : FileReader is noinit
	var db : Transactions = new Transactions
	var curPattern : Array[ITEM] is noinit

	init
	do
		self.file= new FileReader.open(self.fileloc)
		var i : Int = 0
		var line : String		
		while not file.eof
		do
			line = file.read_line
			if line.length > 0 then
				var elems : Array[String] = line.split(' ')
				print elems
				if elems.length > 1 then
					var tr : Transaction
					tr = new Transaction(i)
					i = i + 1
					for elem in elems
					do
						print "elem {elem.is_num}"
						if elem.is_num then
							tr.add elem.to_i
						else
							tr.add elem
						end
					end
					db.addItem(tr,0)
				end

			end

		end
		curPattern = new Array[ITEM]
		self.project(db)

	end

	private fun project(values : Transactions)
	do
		if values.length < minSup then return
		print values
		var p = new Pair[Array[ITEM],Int](curPattern.clone,values.length)
		patterns.add p.clone
		if maxSup > 0 and maxSup == curPattern.length then return

		var mapping : Map[ITEM,Int] = new ArrayMap[ITEM,Int]
		for i  in [0.. values.length-1]
		do
			var trans : Transaction = values.getItem(i).e
			for j in [values.getItem(i).f .. trans.length -1]
			do
				if mapping.has_key(trans.get(j)) then
					mapping[trans[j]] = mapping[trans[j]] +1
				else 
					mapping[trans[j]] = 0
				end
			end

		end
		var newSet : Transactions = new Transactions
		#print mapping.keys
		for itr in mapping.keys
		do
			for ii in [0..values.length-1]
			do
				var trans : Transaction = values.getItem(ii).e
				for jj in [values.getItem(ii).f .. trans.length -1]
				do
					if trans[jj] == itr then
						newSet.addItem(trans,jj+1)
						break
					end
				end
			end
			curPattern.add itr
			project(newSet)
			curPattern.pop
			newSet.clear
		end


	end

	redef fun to_s : String
	do 
		var str = ""
		for i in patterns
		do
			str = str + "("
			for j in i.e
			do
				str = str + "{j} "
			end
			str = str + ") : {i.f}\n"
		end
		return str

	end

end

class PrefixSpanInt
	super PrefixSpan
	redef type ITEM: Int
end

class PrefixSpanString
	super PrefixSpan
	redef type ITEM: String

end

if args.is_empty or args.length < 4 then
	print "Usage: ./prefixspan file dataType(Int = 1,String = 2) minSupport=1 maxSupport=0"
	exit(1)
end
var midi : PrefixSpan

if not args[1].is_int and not args[2].is_int or not args[3].is_int then
	print "Erreur, minSupport et maxSupport doivent être un chiffre"
	abort
end

if args[1].to_i == 1 then
	 midi = new PrefixSpanInt(args[0],args[2].to_i,args[3].to_i)
else if args[1].to_i == 2 then
	 midi = new PrefixSpanString(args[0],args[2].to_i,args[3].to_i) 
else
	 print "Erreur, ce type n'est pas utilisable."
	 abort
end
print midi.to_s