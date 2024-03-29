include("Grille.jl")

#	

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

			if( file[yV,xV]>d+poids(g,(yV,xV))) #changer après
				
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







