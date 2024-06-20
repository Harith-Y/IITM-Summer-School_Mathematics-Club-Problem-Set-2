%%

clearvars;
clc;

integrand     = @(x) x.^2;
lower_limit   = 0;
upper_limit   = 2;
no_of_div     = 10;

x             = linspace(lower_limit, upper_limit, no_of_div+1);
y             = integrand(x);
splineCoeffs  = spline(x, y);

integralValue = 0;
for i             = 1:no_of_div
    xi            = x(i);
    xi1           = x(i+1);
    
    c             = splineCoeffs.coefs(i, :);
    F             = @(x) (c(1)/4)*(x-xi).^4 + (c(2)/3)*(x-xi).^3 + (c(3)/2)*(x-xi).^2 + c(4)*(x-xi);
    
    integralValue = integralValue + (F(xi1) - F(xi));
end

disp(['The approximate integral of the function is: ', num2str(integralValue)]);

%%

%Testing how close the approximation is to the exact value
clearvars;
clc;

integrand     = @(x) x.^2;
lower_limit   = 0;
upper_limit   = 2;
exactIntegral = integral(integrand, lower_limit, upper_limit);

disp(['The exact integral of the function is: ', num2str(exactIntegral)]);

%%