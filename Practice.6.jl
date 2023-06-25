
__________ Задание №1 ___________

# Определение типа Vector2D
struct Vector2D
    x::Float64
    y::Float64
end

# Определение функций для типа Vector2D
function length(v::Vector2D)
    return sqrt(v.x^2 + v.y^2)
end

function dot(v1::Vector2D, v2::Vector2D)
    return v1.x*v2.x + v1.y*v2.y
end

function normalize(v::Vector2D)
    len = length(v)
    return Vector2D(v.x/len, v.y/len)
end

function cross(v1::Vector2D, v2::Vector2D)
    return v1.x*v2.y - v1.y*v2.x
end

# Определение типа Segment2D
struct Segment2D
    start::Vector2D
    finish::Vector2D
end

# Определение функции для типа Segment2D
function length(s::Segment2D)
    return length(s.finish - s.start)
end

___________ Задание № 2 ___________

function check_points_side(point1, point2, line_segment)
    # Получение координат точек
    x1, y1 = point1
    x2, y2 = point2

    # Получение координат точек прямой
    x3, y3 = line_segment[1]
    x4, y4 = line_segment[2]

    # Вычисление значений для определения стороны
    side1 = (x2 - x1) * (y3 - y1) - (x3 - x1) * (y2 - y1)
    side2 = (x2 - x1) * (y4 - y1) - (x4 - x1) * (y2 - y1)

    # Проверка, лежат ли точки по одну сторону от прямой
    if (side1 >= 0 && side2 >= 0) || (side1 < 0 && side2 < 0)
        return true  # Точки лежат по одну сторону от прямой
    else
        return false  # Точки лежат по разные стороны от прямой
    end
end

______________ Задание № 3 ______________

function check_points_side(F, point1, point2)
    # Вычисляем значение функции F для точек
    value1 = F(point1[1], point1[2])
    value2 = F(point2[1], point2[2])
    
    # Проверяем, лежат ли точки по одну сторону от кривой
    if sign(value1) == sign(value2)
        return true  # Точки лежат по одну сторону от кривой
    else
        return false  # Точки лежат по разные стороны от кривой
    end
end

______________ Задание № 4 ________________

function intersect_segments(s1::Segment2D, s2::Segment2D)
    x1, y1 = s1.start.x, s1.start.y
    x2, y2 = s1.stop.x, s1.stop.y
    x3, y3 = s2.start.x, s2.start.y
    x4, y4 = s2.stop.x, s2.stop.y
    A1 = (y2 - y1) / (x2 - x1)
    A2 = (y4 - y3) / (x4 - x3)
    b1 = y1 - A1*x1
    b2 = y3 - A3*x3

    if A1 == A2
        return false
    else
        x_intersect = (b1 - b2) / (A2 - A1)
        if x_intersect < max(min(x1, x2), min(x3, x4)) || x_intersect > min(max(x1, x2), (x3, x4))
            return false
        else
            return true
        end
    end
end

_______________ Задание № 5 __________________

function pointInsidePolygon(polygon::Array{Tuple{Float64, Float64}, 1}, point::Tuple{Float64, Float64})
    num_vertices = length(polygon)
    c = false
    i = 1
    j = num_vertices

    for i = 1:num_vertices
        if (((polygon[i][2] > point[2]) != (polygon[j][2] > point[2])) &&
            (point[1] < (polygon[j][1] - polygon[i][1]) * (point[2] - polygon[i][2]) / (polygon[j][2] - polygon[i][2]) + polygon[i][1]))
            c = !c
        end
        j = i
    end

    return c
end

______________ Задание № 7 ______________

struct Point
    x::Float64
    y::Float64
end

function is_convex_polygon(points::Vector{Point})
    num_points = length(points)
    
    if num_points < 3
        return false  # Многоугольник должен иметь минимум 3 вершины
    end
    
    prev_cross_product = 0.0
    current_cross_product = 0.0
    
    for i in 1:num_points
        prev_point = points[mod1(i-1, num_points)]
        current_point = points[i]
        next_point = points[mod1(i+1, num_points)]
        
        # Вычисляем векторы между точками
        vec1 = Point(prev_point.x - current_point.x, prev_point.y - current_point.y)
        vec2 = Point(next_point.x - current_point.x, next_point.y - current_point.y)
        
        # Вычисляем векторное произведение
        cross_product = vec1.x * vec2.y - vec1.y * vec2.x
        
        if cross_product != 0.0
            if cross_product * prev_cross_product < 0.0
                return false  # Знаки векторных произведений различны, многоугольник невыпуклый
            elseif prev_cross_product == 0.0
                current_cross_product = cross_product
            end
        end
        
        prev_cross_product = cross_product
    end
    
    # Если не было изменений знака векторного произведения, многоугольник выпуклый
    return true
end
