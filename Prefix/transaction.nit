module transaction

import cartesian

class Transactions
	super Array[Transaction]
	var indices : Array[Int] = new Array[Int]

	redef fun clear
	do
		super
		indices.clear
	end


	fun addItem ( tr : Transaction, indice : Int)
	do
		self.push(tr)
		indices.push(indice)
	end	

	fun getItem(index : Int) : Pair[Transaction,Int]
	do
		return new Pair[Transaction,Int](self[index],indices[index])
	end
	


end

#class TransactionInt
#	super Transaction
#	redef type ITEM : Int
#end

class TransactionFloat
	super Transaction
	redef type ITEM: Float
end

class Transaction
	super Base

	var id : Int
	var table : Array[ITEM] = new Array[ITEM]
	fun getId : Int
	do
		return id
	end

	fun add(item : ITEM)
	do
		table.add item
	end

	fun length: Int
	do
		return table.length
	end

	fun get(index : Int) : ITEM
	do
		return table[index]
	end

	fun [](index : Int) : ITEM
	do
		return table[index]	
	end

	fun remove(index : Int)
	do
		table.remove(index)
	end

	fun clear
	do
		table.clear
	end

	redef fun to_s: String
	do
		var str = "Id {id} ("
		for i in table
		do
			str = str + "i "
		end
		str = str + ")"
		return str
	end

end

class Base
	type ITEM : Object
end