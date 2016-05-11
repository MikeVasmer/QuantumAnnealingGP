function [ q ] = order_parameter( spins1, spins2 )
%ORDER_PARAMETER calculates spin overlap or order between two spin
%configurations

q = 0;

for i = 1:length(spins1)
    
    q = q + spins1(i)*spins2(i);

end

q = q / length(spins1);
