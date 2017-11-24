function mergesort(A::Array{Int64,1})
    
    n=length(A)
   
    if n==1
        return A        
    else
        m=Int64(n/2)
        return mergepresorted(mergesort(A[1:m]), mergesort(A[(m+1):n])) 
    end
end

