clear
clc
x = [3 1 ;3 -1; 6 1 ; 6 -1 ; 4 0; 4 2 ;4 -2;5 3;5 -3;3 3;3 -3;5 0 ; 1 0; 0 1;0 -1; -1 0; 0 2; 0 -2;-1 -3;-1 3;0 3 ;0 -3;-2 1;-2 -1];
y = -ones(12, 1);
y = cat(1, ones(12,1), y);

plot(x(1:12,1),x(1:12,2),'b*')
hold on
plot(x(13:24,1),x(13:24,2),'r*')
axis([-3,7,-4,4])
hold off

n = length(y);   % 200
f = -ones(n, 1);  
Aeq = y';
beq = 0;
lb = zeros(n, 1);
Q = (y * y') .* (x * x');

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
plot(x(1:12,1),x(1:12,2),'b*')
hold on
plot(x(13:24,1),x(13:24,2),'r*')
hold on

z1= -2 :.1:7;
z2= (-w(1)/w(2))*z1 - b/w(2);
plot(z1,z2,'k-')

m1= -2 :.1: 7;
m2= (-w(1)/w(2))*m1 + (1- b)/w(2);
plot(m1,m2,'c.')

s1= -2 :.1: 7;
s2= (-w(1)/w(2))*s1 + (-1- b)/w(2);
plot(s1,s2,'c.')
axis([-3,7,-4,4])
