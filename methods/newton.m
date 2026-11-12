function [x,res,err,k] = newton (f, jac, x_0, tol, k_max)
%% NEWTON Finds the zero of a vector function
%   Detailed explanation goes here
       
    k = 1;
    res = zeros ( k_max );
    res(1) = norm ( f(x_0) );
    err = zeros ( k_max );
    err(1) = tol + 1;
    x = zeros ( length (x_0), k_max );
    x(:,1) = x_0;

    %while ( not ( ( res(k) < tol ) || ( err(k) < tol ) || ( k > k_max ) ) )
    while ( k < k_max && err(k) > tol )
        b = -f ( x(:,k) );
        A = jac ( x(:,k) );

        s = A\b;

        x(:,k+1) = x(:,k) + s;
 
        err(k+1,:) = norm ( s );
        res(k+1,:) = norm ( f(x(:,k)) );

        k = k + 1;
    end
end