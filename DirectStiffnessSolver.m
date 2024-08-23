% Back-end displacement solver. Need to understand before competition.

function [Q,V,R]=DirectStiffnessSolver(struct)
global endval;
MIN = 10000;
for t = 1:1:endval+1
    FrameData = struct(t);
m=FrameData.m;
n=FrameData.n;
Ni=zeros(12,12,m);
S=zeros(6*n);
Pf=S(:,1);
Q=zeros(12,m);
Qfi=Q;
Ei=Q;
for i=1:m
    H=FrameData.Con(:,i);
    C=FrameData.Coord(:,H(2))-FrameData.Coord(:,H(1));
    e=[6*H(1)-5:6*H(1),6*H(2)-5:6*H(2)];
    c=FrameData.be(i);
    [a,b,L]=cart2sph(C(1),C(3),C(2));
    ca=cos(a);
    sa=sin(a);
    cb=cos(b);
    sb=sin(b);
    cc=cos(c);
    sc=sin(c);
    r=[1 0 0;0 cc sc;0 -sc cc]*[cb sb 0;-sb cb 0;0 0 1]*[ca 0 sa;0 1 0;-sa 0 ca];
    T=kron(eye(4),r);
    co=2*L*[6/L 3 2*L L];
    x=FrameData.A(i)*L^2;y=FrameData.Iy(i)*co;
    z=FrameData.Iz(i)*co;
    g=FrameData.G(i)*FrameData.J(i)*L^2/FrameData.E(i);
    K1=diag([x,z(1),y(1)]);
    K2=[0 0 0;0 0 z(2);0 -y(2) 0];
    K3=diag([g,y(3),z(3)]);
    K4=diag([-g,y(4),z(4)]);
    K=FrameData.E(i)/L^3*[K1 K2 -K1 K2;K2' K3 -K2' K4;-K1 -K2 K1 -K2;K2' K4 -K2' K3];
    w=FrameData.w(:,i)';
    Qf=-L^2/12*[6*w/L 0 -w(3) w(2) 6*w/L 0 w(3) -w(2)]';
    Qfs=K*T*FrameData.St(e)';
    A=diag([0 -0.5 -0.5]);
    B(2,3)=1.5/L;
    B(3,2)=-1.5/L;
    W=diag([1,0,0]);
    Z=zeros(3);
    M=eye(12);
    p=4:6;
    q=10:12;
    switch 2*H(3)+H(4)
        case 0;B=2*B/3;M(:,[p,q])=[-B -B;W Z;B B;Z W];case 1;M(:,p)=[-B;W;B;A];case 2;M(:,q)=[-B;A;B;W];
    end
    K=M*K;Ni(:,:,i)=K*T;S(e,e)=S(e,e)+T'*Ni(:,:,i);Qfi(:,i)=M*Qf;Pf(e)=Pf(e)+T'*M*(Qf+Qfs);Ei(:,i)=e;
end
V=1-(FrameData.Re|FrameData.St);f=find(V);V(f)=S(f,f)\(FrameData.Load(f)-Pf(f));R=reshape(S*V(:)+Pf,6,n);R(f)=0;V=V+FrameData.St;
for i=1:m
    Q(:,i)=Ni(:,:,i)*V(Ei(:,i))+Qfi(:,i);
end
%disp(V);
%disp(R);
deflect(t) = sqrt(V(1,14)^2 + V(2,14)^2 + V(3,14)^2);
if deflect(t)<MIN
    MIN = deflect(t);
    var = t;
end
end
p1 = [-188.47 530.83 313.97];
p2 = [-211.01 654.65 -181.998];
b = (p2-p1)/norm(p2-p1);
var
point = p1+ var*b
x = 0:1:endval;
plot(x,deflect)
