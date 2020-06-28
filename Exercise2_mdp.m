function [t,vout]=mdp(func,ti,ii,tf,h,vin,r)  % a=0, b=1, p=q=1/2;
% func is ODE function;                       % ti,tf are initial and final time;      
% ii is the initial current;                  % h is the step size;                       
% vin is the input voltahe;                   % r is the resistor;
%--------initilization--------------------------------------  
t(1)=ti;                                      % set initial value of t ti;  
li(1)=ii;                                     % set initial value of x xi;
vout(1)= vin(ti);                             % set initial valye of output voltage;
N=round((tf-ti)/h);                           % number of steps = (interval size)/(step size);
%--------calculating----------------------------------------
for i=1:N                                     % loop for N steps;
t(i+1)=t(i)+h;                                % next value of t(x);
li_pred(i+1)=li(i)+h*feval(func,t(i),li(i));  % predictor i(y) for next value of x;
li_mid(i)=0.5*(li(i)+li_pred(i+1));           % take mid value of current and predicitor i(y); 

tmid=0.5*(t(i)+t(i+1));                       % mid value of t(x);
gmid = feval(func,tmid,li_mid(i));            % mid gradient at mid t(x);
li(i+1) = li(i) + h*gmid;                     % next i(y) value evaluated;

vinn = feval(vin,t(i+1));                     % evaluate input voltage at x+1;
vout(i+1) = vinn-r*li(i+1);                   % evaluate output voltage at x+1;

end
end


