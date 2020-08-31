clear
clc
x1 = [4 * rand(50, 1), 2 * rand(50, 1)];
x2 = [4 * rand(40, 1), 2 * rand(40, 1)];
x3 = [4 * rand(10, 1), 2 * rand(10, 1)];
x = cat(1, x1,[5+(4) * rand(10, 1), 3+(2) * rand(10, 1)],x2,[5+(4) * rand(50, 1), 3+(2) * rand(50, 1)],x3 ,[5+(4) * rand(40, 1), 3+(2) * rand(40, 1)]);   
y1 = -ones(50, 1);
y2 = -ones(40, 1);
y3 = -ones(10, 1);
y = cat(1, y1, ones(10,1), y2,ones(50,1),y3,ones(40,1));

plot(x(1:100,1),x(1:100,2),'bo')
hold on
plot(x(101:200,1),x(101:200,2),'r+')
axis([-1,10,-1,6])
hold off

n = length(y);   % 200
f = -ones(n, 1);  
Aeq = y';
beq = 0;
lb = zeros(n, 1);
ub = 10*ones(n, 1);  % ub=0.01
Q = (y * y') .* (x * x');

alpha = quadprog(Q, f, [], [], Aeq, beq, lb, ub);

for i=1:n
    if alpha(i) < 0.0005
        alpha(i) = 0;
    end
end
w = x' * (alpha .* y)
s = find(alpha ~= 0);
b = (1 / length(s)) * sum((y(s, : ) - (x(s, : ) * w) ))

% w.z + b = 0    w1.z1 + w2.z2 = -b    z2 = -w1/w2 - b/w2
figure
plot(x(1:100,1),x(1:100,2),'bo')
hold on
plot(x(101:200,1),x(101:200,2),'r+')
hold on
z1= -1 :.1:9.5;
z2= (-w(1)/w(2))*z1 - b/w(2);
plot(z1,z2,'k-')

m1= -1 :.1: 9.3;
m2= (-w(1)/w(2))*m1 + (1- b)/w(2);
plot(m1,m2,'c.')

s1= -1 :.1: 9.3;
s2= (-w(1)/w(2))*s1 + (-1- b)/w(2);
plot(s1,s2,'c.')
axis([-1,10,-1,6])