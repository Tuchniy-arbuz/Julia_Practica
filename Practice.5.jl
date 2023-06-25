using BenchmarkTools

____________ Задание №1 _________

function Insert_sort!(array::AbstractVector{T})::AbstractVector{T} where T <: Number
    n = 1

    while n < length(array) 
        n += 1
        i = n
        while i > 1 && array[i-1] > array[i]
            array[i], array[i-1] = array[i-1], array[i]
            i -= 1
        end
    end
    return array
end

Insert_sort(array::AbstractVector)::AbstractVector = Insert_sort!(copy(array))

____________ Задание № 3 ___________

function com!(arr, i, g)
    if i < 0 || g < 0 
        return;
    end
    if arr[i] > arr[g]
        arr[i], arr[g] = arr[g], arr[i]
        com!(arr, i, 2i - g)
    end
end

function Shell_sort!(arr)
    len = length(arr)   
    step = div(len, 2)          

    while step >= 1
        for i in 1:len - step       
            com!(arr,i,i + step)
        end
        step = div(step, 2)
    end
    return arr
end

arr = [1, 1, 5, 4, 3, 2, 7, 2, 8, 9]    
print(Shell_sort!(arr))

___________ Задание №4 ____________

function merge_sort(arr)
    if length(arr) ≤ 1
        return arr
    end

    middle = div(length(arr), 2)
    left = merge_sort(arr[1:middle])
    right = merge_sort(arr[middle+1:end])

    return merge(left, right)
end

function merge(left, right)
    result = similar(left, length(left) + length(right))
    i, j, k = 1, 1, 1

    while i ≤ length(left) && j ≤ length(right)
        if left[i] ≤ right[j]
            result[k] = left[i]
            i += 1
        else
            result[k] = right[j]
            j += 1
        end
        k += 1
    end

    while i ≤ length(left)
        result[k] = left[i]
        i += 1
        k += 1
    end

    while j ≤ length(right)
        result[k] = right[j]
        j += 1
        k += 1
    end

    return result
end

arr = [5, 2, 9, 1, 7, 6]
sorted_arr = merge_sort(arr)
println(sorted_arr)  # Выведет [1, 2, 5, 6, 7, 9]

___________ Задание №5 __________

function quick_sort(arr)
    if length(arr) <= 1
        return arr
    end

    pivot = arr[rand(1:length(arr))]
    lesser = [x for x in arr if x < pivot]
    equal = [x for x in arr if x == pivot]
    greater = [x for x in arr if x > pivot]

    return vcat(quick_sort(lesser), equal, quick_sort(greater))
end

arr = [5, 2, 9, 1, 7]
sorted_arr = quick_sort(arr)
println(sorted_arr)

___________ Задание №7 ____________

function Counting_sort(arr)
    min_value = minimum(arr)
    max_value = maximum(arr)
    count = zeros(Int, max_value - min_value + 1)
    
    for val in arr
        count[val - min_value + 1] += 1
    end
    
    sorted_arr = []
    for (val, freq) in enumerate(count)
        push!(sorted_arr, fill(val + min_value - 1, freq))
    end
    
    return vcat(sorted_arr...)
end

arr = [5, 2, 9, 5, 2, 3]
sorted_arr = Counting_sort(arr)
println(sorted_arr)

