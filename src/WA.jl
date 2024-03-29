include("Grille.jl")



using DataStructures

mutable struct Noeud
	gf::Tuple{Int64,Int64}
	couple::Tuple{Int64,Int64}

end




function wa(g::Grill,w::Int64)

	arbre=fill(Noeud((0,0),(0,0)),g.ligne,g.colonne)

	file=PriorityQueue{Tuple{Int64,Int64},Int64,Base.Order.ForwardOrdering}(Base.Order.Forward)
	(yF,xF)=g.fin
	(y,x)=g.debut


	h=manhattan((y,x),(yF,xF))
	f=h*w
	
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


			p=poids(g,(yV,xV))

			gA=arbre[y,x].gf[1]

			h=manhattan((yV,xV),(yF,xF))


			gV=arbre[yV,xV].gf[1]

			if( (gA+p+h)<typemax(Int64))

			
					if(g.tab[yV,xV].visite==false && arbre[yV, xV].gf[1] == 0)
					gV=gA+p
					f=gV+h*w
					arbre[yV,xV]=Noeud((gV,f),(y,x))

					enqueue!(file, (yV, xV),f)
					elseif(gV>(gA+p))

					gV=gA+p
					f=gV+h*w
					arbre[yV,xV]=Noeud((gV,f),(y,x))

					file[yV, xV]=f
					end




				#=fF=gF+w*manhattan((y,x),(yF,xF))

				arbre[yV,xV]=Noeud((gF,fF),(y,x))=#

				end

			



		end
		g.tab[y,x].visite=true

		#println(file)
		#println(deque ue!(file))
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

