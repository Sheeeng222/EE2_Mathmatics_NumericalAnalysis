%RK method
function [x,vout]=mymethod(func,xi,yi,xf,h,vin,R)

x(1)=xi;
y(1)=yi;
vout(1)=feval(vin,xi);

N=round((xf-xi)/h);

for i=1:N
    x(i+1)=x(i)+h;
    grad1=feval(func,x(i),y(i));
    grad2=feval(func,x(i)+2*h/3,y(i)+grad1*2*h/3); 
    y(i+1)=y(i)+h*(grad1/4+grad2*3/4);
    vin=feval(vin,x(i));
    
    vout(i+1)=vin-R*y(i+1);
end

end