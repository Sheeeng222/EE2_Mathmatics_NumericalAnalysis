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
grad2=feval(func,t(i)+2*h/3,li(i)+grad1*2*h/3); % gradient at next (t+2/3*h), p=q=2/3=0.6667;
li(i+1)=li(i)+h*(grad1*1/4+grad2*3/4);          % next i evaluated a=1/4, b=3/4;

% grad1=feval(func,t(i),li(i));                 % gradient at t;
% grad2=feval(func,t(i)+3*h/5,li(i)+grad1*3*h/5); % gradient at next (t+3/5*h), p=q=3/5=0.6;
% li(i+1)=li(i)+h*(grad1*1/6+grad2*5/6);          % next i evaluated a=1/6, b=5/6;

% grad1=feval(func,t(i),li(i));                 % gradient at t;
% grad2=feval(func,t(i)+7*h/10,li(i)+grad1*7*h/10); % gradient at next (t+7/10*h), p=q=7/10=0.7;
% li(i+1)=li(i)+h*(grad1*2/7+grad2*5/7);          % next i evaluated a=2/7, b=5/7;

% grad1=feval(func,t(i),li(i));                 % gradient at t;
% grad2=feval(func,t(i)+1*h/3,li(i)+grad1*1*h/3); % gradient at next (t+1/3*h), p=q=1/3;
% li(i+1)=li(i)+h*(grad1*(-1/2)+grad2*3/2);          % next i evaluated a=-1/2, b=3/2;

vinn=feval(vin,t(i+1));                       % evaluate input voltage at t+1;
vout(i+1)=vinn-r*li(i+1);                     % evaluate output voltage at t+1;

end
end