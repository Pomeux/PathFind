#include("Grille.jl")

#Dijkstra.jl

#Si poids négatif on peut utiliser Algorithme de Bellmon-Ford pour éviter les boucles
#Pour implementer l'arbre on le représente sous forme de tableau. Pour éviter de refaire des allocutions on lui donne en taille le nombre de sommet 
#Pour prendre le minimum on utilise une file de priorité 

using DataStructures



function Dijkstra(g::grill)

	(y,x)=g.debut

	(yF,xF)=g.fin


	

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


	bloque=Case(B,false)


	while !isempty(file) && (y,x)!=(yF,xF) #pas oubliez d'arretez quand atteint 

		a=dequeue_pair!(file)


	
		(y,x)=a[1]
		d=a[2]
		
		voi=voisin(g,(y,x))
		
		g.tab[y][x]=bloque

		for i in voi #max 4 iterations
			(yV,xV)=i

			if(file[yV,xV]>d+poids(g,(y,x),(yV,xV),1,3,5)) #changer après

				arbre[yV,xV]=(y,x)	
				file[(yV,xV)]=d+poids(g,(y,x),(yV,xV),1,3,5)
				
			end


		end
	end
#	println(arbre)

	chemin::MutableLinkedList{Tuple{Int64,Int64}}=MutableLinkedList{Tuple{Int64,Int64}}() #modifier mettre linked
	while(x!=0 && y!=0)
		push!(chemin,(y,x))
		(y,x)=arbre[y,x]

	end

	return chemin 
	

end
#ajouter exception si pas voisins, mettre CN,CT,CP dans la grille et faire exception dans la grille 
function poids(g::grill,premier,deuxieme::Tuple{Int64,Int64},CN,CT,CP::Int64) 

	(yD,xD)=(premier[1],premier[2])
	(yF,xF)=(deuxieme[1],deuxieme[2])

	#println(g.tab[yD][xD].etat)



		if(g.tab[yD][xD].etat==N && g.tab[yF][FD].etat==N)
			
			return 1
		elseif((g.tab[yD][xD].etat==N && g.tab[yF][xF].etat==P) || (g.tab[yD][xD].etat==P && g.tab[yF][xF].etat==N))

			
			return 3
		elseif(g.tab[yD][xD].etat==P && g.tab[yF][xF].etat==P)
			#println("b")
			return 5

		else
		
			return 1
		end

		return 1
	#=else
		#lever exception
	end=#
end
#=
a=Case(B,false)
b=Case(N,false)
c=Case(N,true)
d=Case(P,false)
	
tab=[
[b,b,b,b,b,b,b,b,b,b,b],
[b,a,b,b,b,b,a,a,a,b,b],
[b,b,b,b,b,b,b,b,a,b,b],
[b,b,b,b,b,b,b,b,b,b,b],
[b,b,b,b,b,b,b,b,b,b,b],
[b,b,b,a,b,b,b,a,b,b,b],
[b,b,b,a,b,b,b,b,b,b,b],
[b,b,b,a,b,b,b,b,b,b,b],
[b,b,b,b,b,b,b,b,b,b,b],
[b,b,b,b,b,b,b,b,b,b,b],
[b,b,b,b,b,b,b,b,b,b,b],
]



debut=(6,6)
fin=(4,4)

debut=(3,2)
fin=(1,2)
tab=[
[b,b,b,b],
[b,a,a,b],
[b,b,b,b],
[b,b,b,b]

]
g=grill(tab,debut,fin,0,0)




#poids(g,(1,1),(2,2),1,2,3)

Dijkstra(g)

=#




