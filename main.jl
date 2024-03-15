include("Grille.jl")
include("FillFlood.jl")

include("Dijkstra.jl")
include("heuristique.jl")

#D(189,193)
#A(226,437)

#main((226,437),(189,193),1)


#D:(189,193) A:(226,437)
function main((yD,xD),(yF,xF),choix)

	println("Mettez le chemin  accès de l'image au format .map")

	#tab::Vector{Vector{Case}}=
	c=0
	s=""
	ligne=0
	colonne=0
	open("theglaive.map") do file
		
		for i in eachline(file)
			c+=1
			if(2<=c<=3)
			s=s*i
			if(c==3)
			
				a=8
				b=""
				
				while(tryparse(Int64,s[8:a])!==nothing)
					#println(s[8:a])
					b=s[8:a]
					a=a+1
				end

				
				ligne=parse(Int64,b)
				colonne=parse(Int64,s[17:length(s)])
				break
			end
		
		end
	end
	
end	

c=0
tab::Vector{Vector{Case}}=Vector{Vector{Case}}(undef,ligne)

for i in 1:ligne
	tab[i]=Vector{Case}(undef,colonne)
end

bloque=Case(B,false)
normal=Case(N,false)
penalite=Case(P,false)
open("theglaive.map") do file
	cc=0
	for i in eachline(file)

		c+=1
		if(c>=5)
			cc+=1
			
			
			for b in 1:length(i)
				if i[b]=='.'
					
					tab[cc][b]=normal
				elseif i[b]=='@'
					tab[cc][b]=bloque
				elseif i[b]=='T' || i[b]=='W' || i[b]=='S'
					tab[cc][b]=penalite
				else
			
					tab[cc][b]=normal
				end

			end
			
		end
		
	end
	#println(tab)


	debut=(yD,xD)
	fin=(yF,xF)

	g=grill(tab,debut,fin,0,0)


#.=normal @=bloque T=penalite
	if(choix==1)
		t=fillflood(g)
		println(length(t))
		println(t)
	elseif(choix==2)
		t=Dijkstra(g)
		println(length(t))
		println(t)
	elseif(choix==3)
		t=heursitique(g)
		println(length(t))
		println(t)
	end


end


	
end