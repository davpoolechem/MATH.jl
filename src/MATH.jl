#=====================================================#
#== MATHEMATICS AND ARITHMETIC TEMPLATES FOR HUMANS ==#
#=====================================================#
module MATH

using LinearAlgebra

#===========================================#
#== first use case: function manipulation ==#
#===========================================#
#== general function sum ==#
macro ∑(bounds::UnitRange{Int64}, op::Function)
  return :( general_driver(+, $(esc(bounds)) , $(esc(op)) ) )
end

#== general function product ==#
macro ∏(bounds::UnitRange{Int64}, op::Function)
  return :( general_driver(*, $(esc(bounds)) , $(esc(op)) ) )
end

#== common driver ==#
function general_driver(funct::Function, bounds::UnitRange{Int64}, op::Function)
  #GC.enable(false)
  return reduce(funct, map(op, collect(bounds)))
  #GC.enable(true)
  #GC.gc()
end

#================================================#
#== second use case: array/matrix manipulation ==#
#================================================#
#== summations involving single arrays ==#
macro ∑(array)
  return :( sum_over_one( $(esc(array)) ) )
end

@inline function sum_over_one(array::T) where {T<:AbstractArray}
  return sum(array)
end

@inline function sum_over_one(range::UnitRange{T}) where {T<:Number}
  return sum(collect(range))
end

#== summations involving two arrays ==#
macro ∑(array_1, array_2)
  return :( sum_over_two( $(esc(array_1)), $(esc(array_2)) ) )
end

@inline function sum_over_two(array_1::T,
  array_2::T) where {T<:AbstractArray}

  return LinearAlgebra.dot(array_1,array_2)
end

@inline function sum_over_two(array_1::Array{T,1},
  array_2::Array{T,1}) where {T<:Number}

  return LinearAlgebra.dot(array_1,array_2)
end

@inline function sum_over_two(array_1::Array{T,2},
  array_2::Array{T,2}) where {T<:Number}

  return LinearAlgebra.dot(array_1,array_2)
end

#== quadratic transformation summation ==#
macro ∑(array_1,array_2,array_center)
  return :( quadratic_transform( $(esc(array_1)), $(esc(array_2)) ,
    $(esc(array_center)) ) )
end

@inline function quadratic_transform(array_1::Array{T},
  array_2::Array{T}, array_center::Array{T,2}) where {T<:Number}

  return transpose(array_2)*array_center*array_1
end

#== products involving single arrays ==#
macro ∏(array)
  return :( prod_over_one( $(esc(array)) ) )
end

@inline function prod_over_one(array::T) where {T<:AbstractArray}
  return prod(array)
end

@inline function prod_over_one(range::UnitRange{T}) where {T<:Number}
  return prod(collect(range))
end

export @∑
export @∏

end
