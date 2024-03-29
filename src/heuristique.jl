include("Grille.jl")



using DataStructures

mutable struct Noeud
	gf::Tuple{Int64,Int64}
	couple::Tuple{Int64,Int64}

end


function heursitique(g::Grill)

	arbre=fill(Noeud((0,0),(0,0)),g.ligne,g.colonne)

	file=PriorityQueue{Tuple{Int64,Int64},Int64,Base.Order.ForwardOrdering}(Base.Order.Forward)
	(yF,xF)=g.fin
	(y,x)=g.debut


	h=manhattan((y,x),(yF,xF))
	f=h
	
	enqueue!(file, (y,x)=>f)



	stat=0
	gg=0

	#for op in 1:1
	while !isempty(file) && (x!=xF || y!=yF)
		stat+=1
		actuel=dequeue!(file)

		(y,x)=actuel

		voi=voisin(g,(y,x))
		
		for i in voi
			(yV,xV)=i

			
			gg=(arbre[y,x].gf[1]+poids(g,(yV,xV)))
			h=manhattan((yV,xV),(yF,xF))
			
			f=h+gg
			#println("h ",h,"gg ",gg," f ",f," ",i)
				
			if (arbre[yV, xV].gf[1] == 0 || f < arbre[yV, xV].gf[1])
    			arbre[yV, xV] = Noeud((gg, f), (y, x))


    			enqueue!(file, (yV, xV),f)
			end

		end
		g.tab[y,x].visite=true

		#println(file)
		#println(dequeue!(file))
	end


	
	cheminTab::MutableLinkedList{Tuple{Int64,Int64}}=MutableLinkedList{Tuple{Int64,Int64}}() #modifier mettre linked
	l=0
	
	while(x!=0 && y!=0)
		push!(cheminTab,(y,x))
		(y,x)=arbre[y,x].couple
		l+=1
		stat+=1

	end
	
	return Chemin(l,cheminTab ,stat)
	
end

function manhattan((yD,xD),(yF,xF)::Tuple{Int64,Int64})

	return abs(xF-xD)+abs(yF-yD)
end

