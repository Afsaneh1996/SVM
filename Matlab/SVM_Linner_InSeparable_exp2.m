clear
clc

x = [3 1 ;3 -1; 6 -1 ;0 -1; 1 0;0 1; -1 0;6 1];
y = [1;1;1;1;-1;-1;-1;-1 ];

plot(x(1:4,1),x(1:4,2),'bo')
hold on
plot(x(5:8,1),x(5:8,2),'r+')
axis([-2,7,-4,4])
hold off

n = length(y);   % 200
f = -ones(n, 1);  
Aeq = y';
beq = 0;
lb = zeros(n, 1);
ub = 1*ones(n, 1);
Q = (y * y') .* (x * x');

alpha = quadprog(Q, f, [], [], Aeq, beq, lb, ub)

w = x' * (alpha .* y)
s = find(alpha < ub-0.0001);
%b = (1 / length(s)) * sum((y(s, : ) - (x(s, : ) * w) ))
b1 = y(s(1)) - (x(s(1,:),:)) *w;
b2 = y(s(2)) - (x(s(2,:),:))*w;
b=b1

% w.z + b = 0    w1.z1 + w2.z2 = -b    z2 = -w1/w2 - b/w2
figure
plot(x(1:4,1),x(1:4,2),'bo')
hold on
plot(x(5:8,1),x(5:8,2),'r+')
hold on

z1= -2 :.1:7;
z2= (-w(1)/w(2))*z1 - b/w(2);
plot(z1,z2,'k-')

m1= -2 :.1: 7;
m2= (-w(1)/w(2))*m1 + (1- b)/w(2);
plot(m1,m2,'k.')

s1= -2 :.1: 7;
s2= (-w(1)/w(2))*s1 + (-1- b)/w(2);
plot(s1,s2,'k.')
axis([-2,7,-4,4])