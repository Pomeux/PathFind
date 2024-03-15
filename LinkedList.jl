#pas finis sert aussi de file 

mutable struct noeud{T}
    val::T
    prec::Union{Nothing,noeud{T}}
    suiv::Union{Nothing,noeud{T}}
end

mutable struct list{T}
    tete::Union{Nothing,noeud{T}}
    queue::Union{Nothing,noeud{T}}
    longueur::Int
end




function retirer!(l::list{T}) where {T}
    l.longueur-=1

    n=l.tete

    l.tete=n.suiv
    n.suiv=nothing

    return n.val
end

function ajouter!(l::list{T}, val::T) where {T}

    l.longueur+=1
    if(l.tete==nothing && l.queue==nothing)
        a=noeud{T}(val,nothing,nothing)

        l.tete=a
        l.queue=a
    else
        b=noeud{T}(val,l.queue,nothing)
        l.queue.suiv=b

        l.queue=b

    end

end

function reverser(l::list{T}) where {T}

    n::Union{Nothing,noeud{T}}=l.queue

    a::Union{Nothing,noeud{T}}=l.tete
    l.tete=l.queue
    l.queue=a


    while(n!=nothing)
        a=n.prec
        n.prec=n.suiv
        n.suiv=a

        n=n.suiv
    end
   #throw si vide 

end


#=
a=list{Int64}(nothing,nothing,0)
ajouter!(a,1)
ajouter!(a,2)
ajouter!(a,3)



show(a)

println("")
#println(retirer!(a))

reverser(a)

show(a)






=#





    