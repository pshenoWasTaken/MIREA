function f(x)
    if x == 1 || x == 2
        return 1
    else 
        return f(x-2)+f(x-1)
    end
end