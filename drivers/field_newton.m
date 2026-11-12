function [] = field_newton (F,J,box,resolution,simplified,addendum)
    %% FIELD_NEWTON Creates a field of points inside the box
    %   Then calculates the Newton method and plots the trajectory
arguments (Input)
    F % Functon F:R^2 -> R^2
    J % Jacobian J:R^2 -> R^2x2
    box % [-x x;-y y]
    resolution % suddivision of the box
    simplified % if true prints an arrow from x0 to x
    addendum % this string is added to the exported immage
end
    % Defaults limits
    tol   = 1e-8;
    k_max = 50;

    % Generate the grid
    [xGrid, yGrid] = meshgrid( ...
        linspace ( box(1,1), box(1,2), resolution ), ...
        linspace ( box(2,1), box(2,2), resolution ) );
    
    % Calcuate paths and plot them
    figure;
    hold on
    xlim(box(1,:).*1.2);
    ylim(box(2,:).*1.2);
    for j = 1:numel ( xGrid )
        x0 = [ xGrid(j); yGrid(j) ];
        % ignore res and err
        [x, ~, ~, k] = newton(F, J, x0, tol, k_max);

        if any ( isnan ( x ( :,k ) ) ) || norm ( x(:,k) ) > 1e6
            plot ( x0(1),x0(2), 'ro', ...
            'MarkerFaceColor', 'k', 'MarkerSize', 2 );
        end

        if simplified
            plot ( [x0(1), x(1,k)], [x0(2), x(2,k)] );
        else
            plot ( x(1,1:k), x(2,1:k) );
        end
    end
    hold off
    grid on;
    if simplified
        exportgraphics(gcf, 'osservazioni/newton_plot_simp'+ addendum +'.png', 'Resolution', 300)
    else
        exportgraphics(gcf, 'osservazioni/newton_plot'+ addendum +'.png', 'Resolution', 300)
    end
end