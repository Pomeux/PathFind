mutable struct Tas{T}
#tab::Vector{Tuple{Tuple{Int64,Int64},Int64}}
tab::Vector{T}
taille::Int64

end

function pere(t::Tas{T},i::Int64) where {T}
	return parse(Int64,floor(i/2))

end
function gauche(t::Tas{T},i::Int64) where {T}
	return 2*i

end
function droite(t::Tas{T},i::Int64) where {T}
	return 2*i+1

end

function entasserMax(t::Tas{T},i::Int64) where {T}
	l=gauche(t,i)
	r=droite(t,i)

	n=length(t.tab)

	if l<=taille && t.tab[l]>t.tab[i]
		max=l
	else 
		max=i
	end
	if r<=n && t.tab[r]>t.tab[max]
		max=r
	end

	if max!=i
		t.tab[i],t.tab[max]=t.tab[max],t.tab[i]
		entasserMin(t.tab,max)
	end
end

function maximum(t::Tas{T}) where {T}
	return t.tab[1]

end

function extraireMax(t::Tas{T}) where {T}
	max=maximum(t)	
	n=length(t.tab)
	t.taille=t.taille-1
	entasserMin(t,1)
	return max

end

function modifier(t::Tas{T},i::Int64,val::Tuple{Tuple{Int64,Int64},Int64}) where {T}
	t.tab[i]=val
	while(i>1 && t.tab[pere(t,i)] < t.tab[i])
		t.tab[i],t.tab[pere(t,i)]=t.tab[pere(t,i)],t.tab[i]
		i=pere(t,i)
	end
end

function inserer(t::Tas{T},val::Tuple{Tuple{Int64,Int64},Int64}) where {T}
	#(y,x)=val[1]

	t.taille=t.taille+1
	t.tab[t.taille]=typemin(Int64)

	modifier(t,t.taille,val)
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


a=[100,19,36,17,3,25,1,2,7]
taille=length(a)

tas=Tas(a,taille)
println(extraireMax(tas))
println(a)
