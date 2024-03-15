include("Grille.jl")



using DataStructures




function fillflood(g::grill)
	file=Queue{Tuple{Int64,Int64}}(g.colonne*g.ligne)

	(yD,xD)=g.debut
	(yF,xF)=g.fin
	(y,x)=(-1,-1)
	enqueue!(file,(yD,xD))

	march=true


	#matrice des distances



	distance::Matrix{Int64}=zeros(Int,g.colonne,g.ligne)
	distance[yD,xD]=1
	
	while march 
		actuel=dequeue!(file)
		
		(y,x)=actuel

		if(y==yF && x==xF)
			#println(x," ",y)
			march=false
		else
			v=voisin(g,(y,x))
			
			n=length(v)


		
			for j in 1:n #au max 4 iterations
				
				(vA,vB)=v[j]
				s=(vA,vB)



				if(distance[vA,vB]==0)
					
					distance[vA,vB]=(distance[y,x]+1)
					#println(vA," ",vB," ",distance[vA,vB])
					enqueue!(file,v[j])
					
				end
			end
			
		end

			

	end

	#construction du chemin 

	march=true
	a=max(g.ligne,g.colonne)
	tab::Vector{Tuple{Int64,Int64}}=Vector{Tuple{Int64,Int64}}(undef,0) #modifier mettre linked
	push!(tab,(y,x))

	while(march)

		if((y,x)==(yD,xD))
			march=false
		end

		v=voisin(g,(y,x))
		n=length(v)
		i=1



		while i<=n #maximum 4 iteration
		
			(vA,vB)=v[i]
			if distance[vA,vB]==(distance[y,x]-1)
				push!(tab,(vA,vB))

				(y,x)=(vA,vB)
				break
			end
		
			i+=1
			
		end


	end	

	tab=reverse(tab)

	return tab

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


g=grill(tab,debut,fin,0,0)

fillflood(g)


#problème c'est tous les même b comment les différencié? 
=#






