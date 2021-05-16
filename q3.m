clear all;
clc;
x_real=csvread('x.csv');
y_real=csvread('y.csv');

x_noiz=csvread('a.csv');
y_noiz=csvread('b.csv');

 % Kalman Part ----
Q=[0.1 0 0 0; 
    0 0.2 0 0; 
    0 0 0.1 0;
    0 0 0 0.2];
R=[0.3 0; 
    0 0.3];
Data=[x_noiz' y_noiz'];
GTData=[x_real' y_real'];
x0=0.0;
y0=0.0;
dt=0.1;
[xout] = KalmanFilter(Data,dt,x0,y0,Q,R);
figure(2)
plot(x_real,y_real,'-r',xout(:,1),xout(:,2),'-b',x_noiz,y_noiz,'-g')
legend('real','noisy','Kalman filter estimation')
figure(3)
plot(x_real,y_real,'-r',xout(:,1),xout(:,2),'-b',x_noiz,y_noiz,'-g')
axis([80 100 -50 -20]);
legend('real','noisy','Kalman filter estimation')
% errors calculation
outx=xout(:,1)';
outy=xout(:,2)';
err=abs(outx-x_noiz)+abs(outy-y_noiz);
m_err=mean(err)
std_err=std(err)
rms_err=sqrt(mean(err.^2)/(length(err)+1))
