function fib(n)
    num1 = num2 = 1
    while n > 0
        num2, num1 = num2 + num1, num2
        n -= 1
    end
    return num1
end
