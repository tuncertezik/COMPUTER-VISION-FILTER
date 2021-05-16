function [xout] = KalmanFilter(Data,T,X0,Y0,Q,R)

%      --------  INPUT -------------
% Data is the raw measurements obtained from a sensing device. It is a 
%       [N,2] matrix.
% T is the time interval between two measurements.
% X0, Y0 are the initial positions.
% GTData is the ground truth data of size [N,2].
%  
%  ---------   OUTPUT -------------
% xout is a filtered output data of size [N,2].
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M = [1 0 0 0; 0 0 1 0];     % Measurement equation
Phi = [1 T 0 0;0 1 0 0; 0 0 1 T; 0 0 0 1]; % State transition matrix
Stt = Q;    % Predictor covariance matrix at time t
Sttm1 = Q;  % Predictor covariance matrix at time t-1
Xtt = [X0;0;Y0;0];  % State matrix at time t
Xttm1 = [X0;0;Y0;0];    % State matrix at time t-1
I = eye(4); % Identity matrix

N = size(Data,1);
for i=1:N
    Y = Data(i,1:2)';
    K = Sttm1 * M' * (M*Sttm1*M' + R)^-1;
    Xtt = Xttm1 + K * (Y - M*Xttm1);
    Stt = (I - K*M) * Sttm1;
    Xttm1 = Phi * Xtt;
    Sttm1 = Phi*Stt*Phi' + Q;
    xout(i,1) = Xtt(1,1);
    xout(i,2) = Xtt(3,1);
end