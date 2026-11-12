function [] = driver_newton(F,J,x0)
    %% DRIVER_NEWTON Executes the Newton Method and NewtonMod
    %   Graphs the results for error and residue
    %   Note that The dimensions of F and x0 must be the same and J must be
    %   the Jacobian of F
    arguments (Input)
        F % The function
        J % The Jacobian of the Funtion F
        x0 % The start Vector of iteration
    end

    tol   = 1e-8;
    k_max = 50;

    [x, res, err, k] = newton(F, J, x0, tol, k_max);    
    [xm, resm, errm, km] = newtonMod(F, J, x0, tol, k_max);
   
    figure;
    semilogy ( 1:k, res(1:k), '-' );
    hold on;
    semilogy ( 1:k, err(1:k), '-' );
    hold on;
    semilogy ( 1:km, resm(1:km), '-' );
    hold on;
    semilogy ( 1:km, errm(1:km), '-' );
    legend('Newton residual', 'Newton error', ...
           'Modified residual', 'Modified error');
    xlabel('Iteration');
    ylabel('Norm');
    grid on;
end
