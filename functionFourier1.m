function [fitresult, gof] = functionFourier1(xSin, ySin)
%CREATEFIT(XSIN,YSIN)
%  Create a fit.
%
%  Data for 'fit1' fit:
%      X Input : xSin
%      Y Output: ySin
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 09-Jan-2018 09:45:21


%% Fit: 'fit1'.
[xData, yData] = prepareCurveData( xSin, ySin );

%w=2*pi/length(xSin);
w=1;
ptrFunc = @(a0,a1,b1,x) a0 + a1*cos(x*w) + b1*sin(x*w);

% [fitresult, gof] = fit(xData, yData, ptrFunc,'StartPoint', [0.1, 0.1, 0.1, 0.1, 0.1], ...
%     'Lower', [-Inf, -Inf, -5, -Inf], ...
%     'Robust', 'LAR' );

[fitresult, gof] = fit(xData, yData, ptrFunc);

%disp('nuevo fourier')
%coeffvalues(fitresult)
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'ySin vs. xSin', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes
xlabel xSin
ylabel ySin
grid on



