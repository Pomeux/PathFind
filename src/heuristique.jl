include("Grille.jl")



using DataStructures

mutable struct Noeud
	gf::Tuple{Int64,Int64}
	couple::Tuple{Int64,Int64}

end

function poids(g::Grill,deuxieme::Tuple{Int64,Int64}) 

	(yF,xF)=(deuxieme[1],deuxieme[2])

	



		if(g.tab[yF,xF].etat==N)
			
			return 1
		#=elseif((g.tab[yD,xD].etat==N && g.tab[yF,xF].etat==P) || (g.tab[yD,xD].etat==P && g.tab[yF,xF].etat==N))

			
			return g.CT=#

		elseif(g.tab[yF,xF].etat==P)
			#println("b")
			return 8
		elseif(g.tab[yF,xF].etat==PP)
			#println("b")
			return 5

		end
	#=else
		#lever exception
	end=#
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

debut=(3,2)
fin=(1,2)

tabb=[
['p','l','l','l'],
['p','b','b','l'],
['l','l','l','l'],
['l','l','l','l']

]



tab::Matrix{Case}=Matrix{Case}(undef,4,4)



for i in 1:4
	for j in 1:4
		if(tabb[i][j]=='p')
			tab[i,j]=Case(P,false,false)
		elseif(tabb[i][j]=='l')
			tab[i,j]=Case(N,false,false)
		elseif(tabb[i][j]=='b')

			tab[i,j]=Case(B,false,false)
		end
	end
end

g=Grill(tab,debut,fin,0,0,1,3,5)


heursitique(g)
