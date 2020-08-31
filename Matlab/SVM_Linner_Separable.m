clear
clc
x = [4 * rand(100, 1), 2 * rand(100, 1)];
x = cat(1, x, [5+(4) * rand(100, 1), 3+(2) * rand(100, 1)]);   
y = -ones(100, 1);
y = cat(1, y, ones(100,1));

plot(x(1:100,1),x(1:100,2),'co')
hold on
plot(x(101:200,1),x(101:200,2),'r+')
hold off

n = length(y);   % 200
f = -ones(n, 1);  
Aeq = y';
beq = 0;
lb = zeros(n, 1);
Q = (y * y') .* (x * x');
%alpha = quadprog(Q, f, A, B , Aeq, beq, lb, ub);
alpha = quadprog(Q, f, [], [], Aeq, beq, lb, []);

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
plot(x(1:100,1),x(1:100,2),'co')
hold on
plot(x(101:200,1),x(101:200,2),'r+')
hold on
z1= 0 :.1:9;
z2= (-w(1)/w(2))*z1 - b/w(2);
plot(z1,z2,'k-')

m1= 0 :.1: 9;
m2= (-w(1)/w(2))*m1 + (1- b)/w(2);
plot(m1,m2,'b.')

s1= 0 :.1: 9;
s2= (-w(1)/w(2))*s1 + (-1- b)/w(2);
plot(s1,s2,'b.')
axis([0,9,0,5])