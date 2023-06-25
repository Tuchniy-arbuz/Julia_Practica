___________Задание № 1 ______________
function isprime(n::IntType) where IntType <: Integer # проверка на простоту числа
    for d in 2:IntType(ceil(sqrt(n)))
        if n % d == 0
            return false
        end
    end
    return true
end

____________ Задание № 2 ______________
function eratosphenes_sieve(n::Integer)
    prime_indexes = ones(Bool, n)
    prime_indexes[begin] = false
    i = 2
    prime_indexes[i^2:i:n] .= false # - четные вычеркнуты
    i=3
    #ИНВАРИАНТ: i - простое нечетное
    while i <= n
        prime_indexes[i^2:2i:n] .= false
        # т.к. i^2 - нечетное, то шаг тут можно взять равным 2i, т.к. нечетное+нечетное=четное, а все четные уже вычеркнуты
        i+=1
        while i <= n && prime_indexes[i] == false
            i+=1
        end
        # i - очередное простое (первое не вычеркунутое)
    end
    return findall(prime_indexes)
end

____________ Задание № 3 _______________
function factorize(n::IntType) where IntType <: Integer
    list = NamedTuple{(:div, :deg), Tuple{IntType, IntType}}[]
    for p in eratosphenes_sieve(Int(ceil(n/2)))
        k = degree(n, p) # кратность делителя
        if k > 0
            push!(list, (div=p, deg=k))
        end
    end
    return list
end

function degree(n, p) # кратность делителя `p` числа `n`
    k=0
    n, r = divrem(n,p)
    while n > 0 && r == 0
        k += 1
        n, r = divrem(n,p)
    end
    return k
end

_______________ Задание № 4 ________________
function meanstd(V :: Vector)
    m, s = 0, 0
    for i in V
        m += i
        s += i*i
    end
    return s / length(V) - (m/length(V))^2
end

