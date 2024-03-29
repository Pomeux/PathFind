include("Grille.jl")



using DataStructures




function fillflood(g::Grill)
	file=Queue{Tuple{Int64,Int64}}(g.ligne*g.colonne)

	(yD,xD)=g.debut
	(yF,xF)=g.fin
	(y,x)=(-1,-1)
	enqueue!(file,(yD,xD))


	march=true

	#matrice des distances

	
	
	distance::Matrix{Int64}=zeros(Int,g.ligne,g.colonne)
	distance[yD,xD]=1
	stat=0
	#finir ça 
	#faire de même

	#for op in 1:1
	while( y!=yF || x!=xF ) && !isempty(file)
		actuel=dequeue!(file)
		
		(y,x)=actuel


		
		v=voisin(g,(y,x))
			
	


		stat+=1

		for j in v #au max 4 iterations
				
			(vA,vB)=j
			


			if(distance[vA,vB]==0)
					
				distance[vA,vB]=(distance[y,x]+1)

				enqueue!(file,j)


					
			end

			
			
	end

			

	end

	
	#construction du chemin 
	
	march=true
	a=max(g.ligne,g.colonne)
	tab::MutableLinkedList{Tuple{Int64,Int64}}=MutableLinkedList{Tuple{Int64,Int64}}()
	push!(tab,(y,x))
	l=1
	while(y!=yD || x!=xD)


		v=voisin(g,(y,x))
		
		
		stat+=1


		for i in v #maximum 4 iteration
		
			(vA,vB)=i
			if distance[vA,vB]==(distance[y,x]-1)
				push!(tab,(vA,vB))
				l+=1
				(y,x)=(vA,vB)
				break
			end
		
			
			
		end


	end	

	return Chemin(l,tab,stat)
	
end





debut=(3,2)
fin=(1,2)
tabb=[
['p','l','l','l'],
['p','b','b','l'],
['l','l','l','l'],


]

tab::Matrix{Case}=Matrix{Case}(undef,3,4)



for i in 1:3
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

g=Grill(tab,debut,fin,0,0,0,0,0)

fillflood(g)


#problème c'est tous les même b comment les différencié? 







