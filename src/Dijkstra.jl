include("Grille.jl")

#Dijkstra.jl

#Si poids négatif on peut utiliser Algorithme de Bellmon-Ford pour éviter les boucles
#Pour implementer l'arbre on le représente sous forme de tableau. Pour éviter de refaire des allocutions on lui donne en taille le nombre de sommet 
#Pour prendre le minimum on utilise une file de priorité 

using DataStructures



function Dijkstra(g::Grill)

	(y,x)=g.debut

	(yF,xF)=g.fin


	stat=0	

	arbre::Matrix{Tuple{Int64,Int64}}=fill((0,0),g.ligne,g.colonne)

	file=PriorityQueue{Tuple{Int64,Int64},Int64,Base.Order.ForwardOrdering}(Base.Order.Forward)
	enqueue!(file, (y,x)=>0)
	

	for i in 1:g.ligne
		for j in 1:g.colonne
			
			if i!=y || j!=x
				
				enqueue!(file, (i,j)=>typemax(Int64))
			end
		end
	end


	

	while !isempty(file) && ( y!=yF || x!=xF) #pas oubliez d'arretez quand atteint 
		
		a=dequeue_pair!(file)
	
		(y,x)=a[1]
		d=a[2]
			
		voi=voisin(g,(y,x))
	
		voi=reverse(voi)
	
		
		stat+=1
		for i in voi #max 4 iterations
			(yV,xV)=i

			if( file[yV,xV]>d+poids(g,(y,x),(yV,xV))) #changer après
				
				arbre[yV,xV]=(y,x)	
				
				file[(yV,xV)]=d+poids(g,(y,x),(yV,xV))
				
			end


		end
		g.tab[y,x].visite=true
	end

	cheminTab::MutableLinkedList{Tuple{Int64,Int64}}=MutableLinkedList{Tuple{Int64,Int64}}() #modifier mettre linked
	l=0
	while(x!=0 && y!=0)
		push!(cheminTab,(y,x))
		(y,x)=arbre[y,x]
		l+=1

	end


	return Chemin(l,cheminTab,stat) 
	

end
#ajouter exception si pas voisins, mettre CN,CT,CP dans la grille et faire exception dans la grille 
function poids(g::Grill,premier,deuxieme::Tuple{Int64,Int64}) 

	(yD,xD)=(premier[1],premier[2])
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



#=
debut=(3,2)
fin=(1,2)

tabb=[
['p','l','l','l'],
['p','b','b','l'],
['l','l','l','l'],


]
=#
#=
debut=(1,1)
fin=(3,3)

tabb=[
['l','l','l'],
['l','l','l'],
['l','l','l'],


]


tab::Matrix{Case}=Matrix{Case}(undef,3,3)



for i in 1:3
	for j in 1:3
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


	
Dijkstra(g)

=#





