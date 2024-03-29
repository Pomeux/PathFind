
#On utilise DataStructures qui est dans la libraire standard



using DataStructures



mutable struct Chemin
	longueur::Int64
	tab::MutableLinkedList{Tuple{Int64,Int64}}
	state::Int64
end

@enum Etat B=0 N=1 P=2 PP=3
mutable struct Case
	etat::Etat
	chemin::Bool #enleve
	visite::Bool

end

struct Grill
	tab::Matrix{Case}
	debut::Tuple{Int64,Int64}
	fin::Tuple{Int64,Int64}

	ligne::Int64
	colonne::Int64

	CN::Int64 #cout entre 2 noeud normal
	CT::Int64 #cout entre 1 normal<->1 pena
	CP::Int64 #cout entre 2<-> pena


	function Grill(tab::Matrix{Case},debut::Tuple{Int64,Int64},fin::Tuple{Int64,Int64},ligne::Int64,colonne::Int64,CN::Int64,CT::Int64,CP::Int64)
		
		ligne=size(tab,1)
		colonne=size(tab,2)
		if(1>debut[2] || debut[2] >colonne || 1>debut[1] || debut[1] >ligne ||1>fin[2] || fin[2]>colonne || 1>fin[1] || fin[1] >ligne )

		end
		g=new(tab,debut,fin,ligne,colonne,CN,CT,CP)
		return g
	end

end




function voisin(g::Grill,co::Tuple{Int64,Int64})

		(y,x)=co

		voisin::Vector{Tuple{Int64,Int64}}=Vector{Tuple{Int64,Int64}}(undef,0)

		
		if(1<=y<=g.ligne && 1<=x<=g.colonne)
	
			if (y<=(g.ligne-1)  && g.tab[y+1,x].etat!=B && g.tab[y+1,x].visite!=true)
				
				push!(voisin,((y+1),x))
			end
		
			if (2<=x  && g.tab[y,x-1].etat!=B && g.tab[y,x-1].visite!=true)
			
				push!(voisin,(y,(x-1)))
			end
					if (x<=(g.colonne-1)  && g.tab[y,x+1].etat!=B && g.tab[y,x+1].visite!=true)
				
				push!(voisin,(y,(x+1)))
			end 

			if(2<=y && g.tab[y-1,x].etat!=B && g.tab[y-1,x].visite!=true ) 
				
				push!(voisin,((y-1),x))
			end

			

		

		end
		return voisin
	end



