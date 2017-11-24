function createLList(n::Int64)
    X=rand(n)
    values = Array{KVPair}(n)
    for i in 1:n
        values[i] = KVPair(i,X[i])
    end
    L = Nullable{LList}()
    L = buildLList(values)
end

function printLList(list::Nullable{LList})
    if isnull(list)
        println("The End")
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

function builtvalues(list::Array{}, n::Int64)
    if n == 1 
        list[1] = KVPair(1,rand(rng))
    else
        list[n] = KVPair(n,rand(rng))
        builtvalues(list, n-1)
        return list
    end 
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
        println(get(list).data)
    elseif x < get(L).data.value        
        intervalmembershipFTree(L, x)
    else        
        x = x - get(L).data.value
        intervalmembershipFTree(R, x)
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
