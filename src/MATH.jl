import LinearAlgebra

#=====================================================#
#== MATHEMATICS AND ARITHMETIC TEMPLATES FOR HUMANS ==#
#=====================================================#
module MATH
    using LinearAlgebra

    #===========================================#
    #== first use case: function manipulation ==#
    #===========================================#
    #== general function sum ==#
    function ∑(bounds::UnitRange{Int64}, op::Function)
        return general_driver(+,bounds,op)
    end

    #== general function product ==#
    function ∏(bounds::UnitRange{Int64}, op::Function)
        return general_driver(*,bounds,op)
    end

    #== common driver ==#
    function general_driver(funct::Function, bounds::UnitRange{Int64}, op::Function)
        GC.enable(false)
        return reduce(funct, map(op, collect(bounds)))
        GC.enable(true)
        GC.gc()
    end

    #================================================#
    #== second use case: array/matrix manipulation ==#
    #================================================#
    #== summations involving single arrays ==#
    function ∑(array::Array{Float64}) return sum(array) end
    function ∑(array::Array{Int64}) return sum(array) end
    function ∑(range::UnitRange{Int64}) return sum(collect(range)) end

    #== summations involving multiple arrays ==#
    function ∑(array_1::Array{Float64},array_2::Array{Float64})
        return LinearAlgebra.dot(array_1,array_2)
    end

    #== products involving single arrays ==#
    function ∏(array::Array{Float64}) return prod(array) end
    function ∏(array::Array{Int64}) return prod(array) end
    function ∏(range::UnitRange{Int64}) return prod(collect(range)) end
end
