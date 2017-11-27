function createLList(n::Int64)
    X=rand(n)
    values = Array{KVPair}(n)
    for i in 1:n
        values[i] = KVPair(i,X[i])
    end
    L = Nullable{LList}()
    L = buildLList(values)
end

function createLList2(n::Int64)
    values = Array{KVPair}(n)
    for i in 1:n
        values[i] = KVPair(i,i)
    end
    L = Nullable{LList}()
    L = buildLList(values)
end

function printLList(list::Nullable{LList})
    if isnull(list)
        #Nullable{KVPair}
	println("")
    else
        println(get(list).data)
    	return printLList(get(list).next)
    end
end

function searchLList(list::Nullable{LList}, k::Int64)
    if isnull(list)
        Nullable{KVPair}
    elseif k == get(list).data.key
        get(list).data.value
    else 
        return searchLList(get(list).next,k)
    end
end

function createLListPartial(n::Int64)
    X=rand(n)
    Sum=zeros(n)
    values = Array{KVPair}(n)
    
    Sum[1] = X[1]
    values[1] = KVPair(1,Sum[1])
    
    for i in 2:n
        Sum[i] = X[i] + Sum[i-1]
        values[i] = KVPair(i,Sum[i])
    end
    
    L = Nullable{LList}()
    L = buildLList(values)
end

function intervalmembershipLList(list::Nullable{LList}, x::Float64)
    
    if isnull(list)
        println("x is out of range")
    elseif x < get(list).data.value
        return get(list).data.key
    else
        return intervalmembershipLList(get(list).next, x)
    end
end

function builtvalues(list::Array{}, n::Int64)
    if n == 1 
        list[1] = KVPair(1,rand(rng))
    else
        list[n] = KVPair(n,rand(rng))
        builtvalues(list, n-1)
        return list
    end 
end

function builtvalues2(list::Array{}, n::Int64)
    if n == 1 
        list[1] = KVPair(1,1)
    else
        list[n] = KVPair(n,n)
        builtvalues2(list, n-1)
        return list
    end 
end

function createFTree2(n::Int64)

values = Array{KVPair}(n)
values = builtvalues2(values,n)
T = Nullable{FTree}(FTree(KVPair(0,0.0)))
T = buildFTree(T, values)

end

function printFTree(list::Nullable{FTree})
    L = get(list).left
    R = get(list).right
    
    if isnull(L)
        println(get(list).data)
    else
        printFTree(L)
        printFTree(R)        
    end
end

function intervalmembershipFTree(list::Nullable{FTree}, x::Float64)
    L = get(list).left
    R = get(list).right
    
    if x > get(list).data.value
        println("x is out of range")
    elseif isnull(L)
        get(list).data
    elseif x < get(L).data.value        
        intervalmembershipFTree(L, x)
    else        
        x = x - get(L).data.value
        intervalmembershipFTree(R, x)
    end
end

#This is Colm's code just put into a function
function StochasticParticle(L::Float64, N::Int64, Nx::Int64, )

dx = 2.0*L/(Nx-1)
X = dx.*(-(Nx-1)/2:(Nx-1)/2)
Y =zeros(Int64,N)
D = 1.0
t=0.0
    
r = (D/2.0)/(dx*dx)
totalRate = 2.0*N*r
dt = 1.0/totalRate
T=1.0
    
# This is the main loop
while t < T
    # Pick an event
    k = rand(1:2*N)
    if k<=N
        hop = 1
        particleId = k
    else
        hop = -1
        particleId=k-N
    end
    Y[particleId]+=hop
    t+=dt
end

# Calculate the estimated density of particles
P =zeros(Float64,length(X))
for i in 1:length(Y)
    P[Y[i]+Int64((Nx-1)/2)+1]+=1/(N * dx)
end

# Calculate the theoretical density and compare
function normal(x, D, t)
    return (1.0/sqrt(2.0*pi*D*t))*exp(-x*x/(2*D*t))
end
P1 = normal.(X, D, T)

plot(X, P1, label="Analytic solution of diffusion equation")
plot!(X, P, label="Numerical estimate of particle density")
xlabel!("x")
ylabel!("Particle density, c(x,t)")
title!("Stochastic simulation of simple diffusion in 1-D")
        
end
