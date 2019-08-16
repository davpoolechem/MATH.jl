function fibb(i::Int64)

    fibb::Int64 = 0
    golden::Float64 = 1.61803398875
    ii = i - 1
    fibb = round((golden^ii-(1-golden)^ii)/sqrt(5))
    return fibb
end

function fibb2(i::Int64)

    fibb::Int64 = 0
    golden::Float64 = 1.61803398875
    if (i==1) fibb = 0
    if (i==2) fibb = 1
    if (i==3) fibb = 1
    if (i==4) fibb = 2
    if (i==5) fibb = 3
    if (i==6) fibb = 5
    if (i==7) fibb = 8
    if (i==8) fibb = 13
    else
        fibb = 21
        for index in 9:i fibb = round(fibb*golden) end
    end
    return fibb
end

function check(array::Array{Int64,1}, i::Int64)
    return (array[i-2]+array[i-1] == array[i])
end
