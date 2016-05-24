
diffs = zeros(28,1);

x = zeros(28,1);

for b = 3:30;
    x(b-2) = b;
end
    
    
    

for i = 3:30
    Jzzz = ones(i,i,i);
    for h = 1:i;
        for j = 1:i;
            for k = 1:i;
                if h == j || h == k || j == k
                    Jzzz(i,j,k) = 0;
                end
            end
        end
    end
    [hs, Jzz, pens, diff] = threeToTwo(Jzzz, i);
    diffs(i-2) = diff;
end

length(x)
length(diffs)

plotfit = fit(x, diffs, 'poly2')
plot(plotfit, x, diffs)

