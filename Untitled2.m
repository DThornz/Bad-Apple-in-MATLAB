clear;clc;close all
%% Random data
x=0:.01:1;
yOriginal=x.^2;
yNoisy1_data = yOriginal + 0.1 * rand(1, length(yOriginal));
yNoisy2_data = -yOriginal + 0.1 * rand(1, length(yOriginal));
plot(x,yNoisy1_data,'.')
hold on
plot(x,yNoisy2_data,'.')
legend('Data 1','Data 2')

%% Fmincon
options = optimoptions('fmincon','Display','iter','Algorithm','interior-point','ConstraintTolerance',eps);
problem.options = options;
problem.solver = 'fmincon';
problem.objective = @(c) TestFun(c,x,yNoisy1_data, yNoisy2_data);
problem.x0 = [0.1,0.1];
[x0,fval,exitflag,output] = fmincon(problem);

%% Plot
yPred1= x0(1)*yOriginal.^2;
yPred2= x0(2)*yOriginal.^2;
plot(x,yPred1,'-')
plot(x,yPred2,'-')
