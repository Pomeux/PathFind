#include("Grille.jl")

using DataStructures

mutable struct Node
	g::Int64
	couple::Tuple{Int64,Int64}
end

function heursitique(g::grill)

	arbre=fill(Node(0,(0,0)),g.ligne,g.colonne)
	file=PriorityQueue{Tuple{Int64,Int64},Int64,Base.Order.ForwardOrdering}(Base.Order.Forward)
	(yF,xF)=g.fin
	(y,x)=g.debut
	bloque=Case(B,false)



	h=manhattan((y,x),(yF,xF))
	f=h
	
	enqueue!(file, (y,x)=>f)

	voi=voisin(g,(y,x))

	g.tab[y][x]=bloque



	while !isempty(file) && (x!=xF || y!=yF)
	#for m in 1:7	
		actuel=dequeue_pair!(file)
		
		
		(y,x)=actuel[1]
		d=actuel[2]

	
		voi=voisin(g,(y,x))
	

		
		
	
		g.tab[y][x]=bloque

		for i in voi 

			(yV,xV)=i
			g.tab[yV][xV]=bloque
			h=manhattan((yV,xV),(yF,xF))
			arbre[yV,xV]=Node((arbre[y,x].g+1),(y,x))
			f=h+arbre[yV,xV].g

			enqueue!(file, (yV,xV)=>f)


		end
	
	end
	
	chemin::MutableLinkedList{Tuple{Int64,Int64}}=MutableLinkedList{Tuple{Int64,Int64}}() #modifier mettre linked

	while(x!=0 && y!=0)
		push!(chemin,(y,x))
		(y,x)=arbre[y,x].couple

	end
	
	return chemin 
end

function manhattan((yD,xD),(yF,xF)::Tuple{Int64,Int64})

	return abs(xF-xD)+abs(yF-yD)
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


tab=[
[b,b,b,b],
[b,a,a,b],
[b,b,b,b],
[b,b,b,b]

]


debut=(3,2)
fin=(1,2)

debut=(1,1)
fin=(2,2)


g=grill(tab,debut,fin,0,0)
#println(voisin(g,(1,1)))
heursitique(g)

#On calcule manhattan 
#on regarde pour chaque voisin ce que ça fait: f minimum 
#

=#
