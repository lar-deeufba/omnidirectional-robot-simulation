close all
x=TrajX;
y=TrajY;
teta=TrajTheta;

%h=x(2)-x(1) % distance between x-coordinates
h=1
n=length(x) % n points in the xy-plane

for i=1:n-2,
     p(i,i)=4;
end
for i=1:n-3,
     p(i+1,i)=1;
end
for i=1:n-3,
     p(i,i+1)=1;
end

for i=1:n-2,
    qx(i)= 6*[x(i)-2*x(i+1)+x(i+2)]/h^2 ;
    qy(i)= 6*[y(i)-2*y(i+1)+y(i+2)]/h^2 ; 
    qteta(i)= 6*[teta(i)-2*teta(i+1)+teta(i+2)]/h^2 ; 
end

ip=inv(p);
m_aux_x=ip*qx.';
m_aux_y=ip*qy.';
m_aux_teta=ip*qteta.';
mx(1)=0;
mx(n)=0;
my(1)=0;
my(n)=0;
mteta(1)=0;
mteta(n)=0;

for i=2:n-1,
    mx(i)=m_aux_x(i-1);  
    my(i)=m_aux_y(i-1);  
    mteta(i)=m_aux_teta(i-1);  
end
% solving for the ai,bi,ci,di


for i=1:n-1,
    ax(i)=(mx(i+1)-mx(i))/(6*h);
    ay(i)=(my(i+1)-my(i))/(6*h);
    ateta(i)=(mteta(i+1)-mteta(i))/(6*h);
    bx(i)=mx(i)/2;
    by(i)=my(i)/2;
    bteta(i)=mteta(i)/2;
    cx(i)=(x(i+1)-x(i))/h - [((mx(i+1)+2*mx(i))*h)/6];
    cy(i)=(y(i+1)-y(i))/h - [((my(i+1)+2*my(i))*h)/6];
    cteta(i)=(teta(i+1)-teta(i))/h - [((mteta(i+1)+2*mteta(i))*h)/6];
    dx(i)=x(i);
    dy(i)=y(i);
    dteta(i)=teta(i);
        
end

% calculating S(x)
k=.04;
np=5
inp=1/np;
ind=0;
pulo=0;

for i=1:n-1,
    %k=ts/(x(i+1)-x(i))
     for j=i-1:inp:i,  
        if pulo ~=  1
            ind=ind+1;
            sx(ind)=ax(i)*(j-(i-1))^3 + bx(i)*(j-(i-1))^2 + cx(i)*(j-(i-1)) + dx(i);
            sy(ind)=ay(i)*(j-(i-1))^3 + by(i)*(j-(i-1))^2 + cy(i)*(j-(i-1)) + dy(i);
            steta(ind)=ateta(i)*(j-(i-1))^3 + bteta(i)*(j-(i-1))^2 + cteta(i)*(j-(i-1)) + dteta(i) ;           
            
          if ind >= 2 
            derx(ind-1)=(sx(ind) - sx(ind-1))/k;
            dery(ind-1)=(sy(ind) - sy(ind-1))/k;
            w(ind-1)=(steta(ind) - steta(ind-1))/k;
            v(ind-1)= derx(ind-1)*cos(steta(ind-1)) + dery(ind-1)*sin(steta(ind-1));
            vn(ind-1)= dery(ind-1)*cos(steta(ind-1)) - derx(ind-1)*sin(steta(ind-1));
           
         end  
          
        end
        pulo=0;
     end
   %  k=k/1.5
   pulo=pulo+1;
end

figure,plot(x,y,'o',sx,sy,'-x')
figure,plot(steta*180/pi,'ko')
%figure,plot(derx,'kd')
%figure,plot(dery,'kv')
%figure,plot(w,'kx')
%figure,plot(v)
%figure,plot(vn)

%trajc1=[sx' sy' steta'];
%save trajc1.txt trajc1 -ascii 

TrajX=sx';
TrajY=sy';
TrajTheta=steta';
TrajPoints=size(TrajX(:,1),1);

% Posicao inicial do Robo
Xini=TrajX(1);
Yini=TrajY(1);
Thetaini=TrajTheta(1);


return
