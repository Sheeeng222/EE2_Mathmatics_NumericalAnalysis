% 4th order RK method

function [x,vout]=mymethod(func1,func2,xi,yi,xf,h,R)

x(1)=xi;
y(1)=yi;
vout(1)=feval(func2,xi);

N=round((xf-xi)/h);

for i=1:N
    x(i+1)=x(i)+h;
    grad1=feval(func1,x(i),y(i));
    grad2=feval(func1,x(i)+3*h/4,y(i)+grad1*3*h/4); 
    y(i+1)=y(i)+h*(grad1/3+grad2*3/4);
    vin=feval(func2,x(i));
    
    vout(i+1)=vin-R*y(i+1);
end

end


