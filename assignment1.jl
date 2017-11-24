function Float_exercise(a1,a2,t,N)
    
    temp = zeros(N)

    if t==1
        a = convert(Array{Float32,1},temp)
        b = Float32(8)/Float32(9)
        c = Float32(2)
    elseif t==2
        a = convert(Array{Float64,1},temp)
        b = Float64(8)/Float64(9)
        c = Float64(2)
    else t==3
        a = convert(Array{BigFloat,1},temp)
        b = BigFloat(8)/BigFloat(9)	
        c = BigFloat(2)
    end
     
    a[1]=a1
    a[2]=a2

    for i=2:(N-1)
        a[i+1]=c*a[i] - b*a[i-1]
    end
    
    return a
    
end
