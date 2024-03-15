#On utilise DataStructures qui est dans la libraire standard

@enum Etat B=0 N=1 P=2
mutable struct Case
	etat::Etat
	chemin::Bool

end

struct grill
	tab::Vector{Vector{Case}}
	debut::Tuple{Int64,Int64}
	fin::Tuple{Int64,Int64}

	ligne::Int64
	colonne::Int64

	function grill(tab::Vector{Vector{Case}},debut::Tuple{Int64,Int64},fin::Tuple{Int64,Int64},ligne::Int64,colonne::Int64)
		
		ligne=length(tab)
		colonne=length(tab[1])
		if(1>debut[2] || debut[2] >colonne || 1>debut[1] || debut[1] >ligne ||1>fin[2] || fin[2]>colonne || 1>fin[1] || fin[1] >ligne )

		end
		g=new(tab,debut,fin,ligne,colonne)
		return g
	end

end




function voisin(g::grill,co::Tuple{Int64,Int64})

		(y,x)=co

		voisin::Vector{Tuple{Int64,Int64}}=Vector{Tuple{Int64,Int64}}(undef,0)

		
		if(1<=y<=g.ligne && 1<=x<=g.colonne) 
			if (2<=x  && g.tab[y][x-1].etat!=B)
			
				push!(voisin,(y,(x-1)))
			end
			if(2<=y && g.tab[y-1][x].etat!=B) 
				
				push!(voisin,((y-1),x))
			end

			if (y<=(g.ligne-1)  && g.tab[y+1][x].etat!=B)
				
				push!(voisin,((y+1),x))
			end

		
			if (x<=(g.colonne-1)  && g.tab[y][x+1].etat!=B)
				
				push!(voisin,(y,(x+1)))
			end
		end
		return voisin
	end

function toString(g::grill)
	s=""
	(yD,xD)=g.debut
	(yF,xF)=g.fin

	for i in 1:g.ligne
		for j in 1:g.colonne
			if(yD==i && xD==j)					
				s*="D"
			elseif(yF==i && xF==j)
				s*="F"
			elseif g.tab[i][j].etat !=B
				if g.tab[i][j].chemin==true
					s*="C"

				elseif g.tab[i][j].etat==N
					s*="_"
				else
					s*="P"
				end
			else
				s*="B"
			end
		end
		s*="\n"
	end
	return s
end

