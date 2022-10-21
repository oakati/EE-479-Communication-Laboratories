function [ y index ] = second_max( x )
    [ y index ] = max(x);
    x(index) = 0;
    [ y index ] = max(x);
end