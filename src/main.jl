include("Grille.jl")
include("FillFlood.jl")

include("Dijkstra.jl")
include("heuristique.jl")

include("WA.jl")

#D(189,193)
#A(226,437)


#main((226,437),(189,193),1)


#D:(189,193) A:(226,437)

using Images,ImageView

function main()

	println("Bienvenue dans le programme de pathfind\nMettez le chemin accès du fichier")

#=

	chemin::String=demanderfichierCorrecte()

	
	(ligne,colonne)=recupererDim(chemin)

	println("mettez les coordonnées du début")

	(yD,xD)=demanderTuple((ligne,colonne))


	println("mettez les coordonnées de la fin")

	(yF,xF)=demanderTuple((ligne,colonne))
	=#

	chemin="theglaive.map"
	(yD,xD)=(189,193)
	(yF,xF)=(226,437)
	(ligne,colonne)=(512,512)
	color::Matrix{RGB{Float64}}=Matrix{RGB{Float64}}(undef,ligne,colonne)

	tab::Matrix{Case}=Matrix{Case}(undef,ligne,colonne)

	println("Mettez :\n1 pour flood fill\n2 pour dijkstra\n3 pour A*\n4 pour WA*")
	choix::Int64=demanderCo(4)


	(color,tab)=matrixCaseAndColor(recupererMatrice(chemin,(ligne,colonne)),false)

	g=Grill(tab,(yD,xD),(yF,xF),0,0,1,5,8)


	if(choix==1)
		

		

		

		che=fillflood(g)

		afficherChemin(color,che)

		color[yD,xD]=RGB(0.0,1.0,0.0)		

		color[yF,xF]=RGB(1.0,0.0,0.0)	

		imshow(color,name="Pathfind")

		return (che.longueur,che.state)

	elseif(choix==2)
		che=Dijkstra(g)

		afficherChemin(color,che)

		color[yD,xD]=RGB(0.0,1.0,0.0)		

		color[yF,xF]=RGB(1.0,0.0,0.0)	

		imshow(color,name="Pathfind")

		return (che.longueur,che.state)
	elseif(choix==3)
		che=heursitique(g)

		afficherChemin(color,che)

		color[yD,xD]=RGB(0.0,1.0,0.0)		

		color[yF,xF]=RGB(1.0,0.0,0.0)	

		imshow(color,name="Pathfind")

		return (che.longueur,che.state)

	elseif(choix==4)
		che=wa(g,100)

		afficherChemin(color,che)

		color[yD,xD]=RGB(0.0,1.0,0.0)		

		color[yF,xF]=RGB(1.0,0.0,0.0)	

		imshow(color,name="Pathfind")

		return (che.longueur,che.state)
	end



	
end



#=
Fonction demanderfichierCorrecte qui demande le chemin du fichier tant que celui-ci n'existe pas
Retourne le chemin du fichier correcte
=#

function demanderfichierCorrecte()
	chemin=""

	marche=true
	while(marche)
		marche=false
		chemin::String=readline()
		try 
			open(chemin) do f

				return chemin
		end


		catch
			marche=true
			println("Mettez un fichier correct")
			
		end


	end
	return chemin
end
#=
Fonction qui retourne un tuple en entrée par l'utilisateur où 1<=yR<=y et 1<=xR<=x
=#

function demanderTuple((y,x)::Tuple{Int64,Int64})

	println("mettez en fonction de y")

	yR::Int64=demanderCo(y)

	println("mettez en fonction de x")

	xR::Int64=demanderCo(x)

	return (yR,xR)


end
#=
Fonction qui retourne un entier en entrée par l'utilisateur où 1<=aF<=a 
=#
function demanderCo(a::Int64)
	aF=0
	
	con=true

	while(con)
		println("mettez un nombre compris entre 1 et ",a)
		aS=readline()
		if(tryparse(Int64,aS)!=nothing)
			aF=parse(Int64,aS)
			if(1<=aF<=a) 
				con=false
			end
		end
		
	end

	return aF

end


#=
Fonction recupererDim qui prend en argument le chemin d'accès d'un fichier .map et retourne un array de taille 2
Où le premier élement représente le nombres de lignes et le deuxième élement le nombre de colonnes
=#
function recupererDim(s::String)
	dim::Array{Int64}=Array{Int64}(undef,2)

	open(s) do file
		compter::Int64=1
		for i in eachline(file)
			
			if(2<=compter<=3)
				temp=1
				while(i[temp]!=' ')
					
					temp+=1

				end

				dim[compter-1]=parse(Int64,i[temp:length(i)])
				
			elseif(compter>3)
				break
			end
		

			compter+=1

		
	
		end	
	end
	return dim

end

function recupererMatrice(s::String,(ligne,colonne)::Tuple{Int64,Int64})

	tab::Matrix{Char}=Matrix{Char}(undef,ligne,colonne)
	
	compter=0
	open(s) do file
		for i in eachline(file)
			compter+=1
			println(i)
			if(compter>=5)
				for j in 1:length(i)
					tab[compter-4,j]=i[j]
				end

			end	
		end
	end
	return tab
end


function matrixCaseAndColor(tab::Matrix{Char},bloque::Bool)


	(ligne,colonne)=size(tab)

	color::Matrix{RGB{Float64}}=Matrix{RGB{Float64}}(undef,512,512)

	case::Matrix{Case}=Matrix{Case}(undef,ligne,colonne)

	for i in 1:ligne
		for j in 1:colonne
			
			if tab[i,j]=='W'
				color[i,j]=RGB(0.0,0.0,1.0)
				case[i,j]=Case(P,false,false)

				#bloque
			
			elseif tab[i,j]=='.'
				color[i,j]=RGB(1.0,1.0,1.0)
				case[i,j]=Case(N,false,false)
				#normal
				
			elseif tab[i,j]=='S'
				color[i,j]=RGB(0.52,0.80,0.92)
				case[i,j]=Case(PP,false,false)
				#pena
				
			elseif tab[i,j]=='T'
				color[i,j]=RGB(0.0,1.0,0.0)

				case[i,j]=Case(B,false,false)

				
				#bloque
				
			elseif tab[i,j]=='@'
				color[i,j]=RGB(0.0,0.0,0.0)
				case[i,j]=Case(B,false,false)
				#pena
				

			end



		end
	end

	return (color,case)

end

function afficherChemin(color::Matrix{RGB{Float64}},c::Chemin)
	
	for i in c.tab

		(y,x)=i

		color[y,x]=RGB(1.0,1.0,0.0)
	end


end


main()