function [t,vout]=mymethod(func,ti,ii,tf,h,vin,r) % a=1/4, b=3/4, p=q=2/3;
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

grad1=feval(func,t(i),li(i));                 % gradient at t;
grad2=feval(func,t(i)+2*h/3,li(i)+grad1*2*h/3); % gradient at next (t+2/3*h), p=q=2/3;
li(i+1)=li(i)+h*(grad1/4+grad2*3/4);          % next i evaluated a=1/4, b=3/4;

vinn=feval(vin,t(i+1));                       % evaluate input voltage at t+1;
vout(i+1)=vinn-r*li(i+1);                     % evaluate output voltage at t+1;

end
end