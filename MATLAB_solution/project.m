clear;

exec_A = readtable("TraceA-A.txt");
exec_B = readtable("TraceA-B.txt");
exec_C = readtable("TraceA-C.txt");
exec_D = readtable("TraceA-D.txt");
exec_E = readtable("TraceA-E.txt");

S_A = (exec_A.Var1) / 1000;
S_B = (exec_B.Var1) / 1000;
S_C = (exec_C.Var1) / 1000;
S_D = (exec_D.Var1) / 1000;
S_E = (exec_E.Var1) / 1000;

X = [S_A, S_B, S_C, S_D, S_E];

%moments
M1 = sum(X) / size(X,1);

lambdas = 1 ./ M1;

%number of cores
N = 4;

l1 = lambdas(1,1);
l2 = lambdas(1,2) * N;
l3 = lambdas(1,3) * 0.1;
l4 = lambdas(1,4);
m1 = lambdas(1,5) * N * 0.2;
m2 = lambdas(1,3) * 0.9;
m3 = lambdas(1,5) * N * 0.8;

%infinitesimal generator
Q = [-l1,  l1  ,  0  ,  0, 0;
      0 , -l2,   l2  , 0, 0;
        0 ,   m2  ,-m2-l3, l3, 0;
         0 ,  0  , 0  ,-l4, l4;
         m1, m3, 0, 0, -m1-m3];

%transition reward matrix for throughput of the system
X = [0, 0, 0, 0, 0;
     0, 0, 0, 0, 0;
     0, 0, 0, 0, 0;
     0, 0, 0, 0, 0;
     1, 0, 0, 0, 0;];

P = [0 1 0 0 0; 0 0 1 0 0; 0 0.9 0 0.1 0; 0 0 0 0 1; 0 0.8 0 0 0];

l = [1 0 0 0 0];

Q1 = Q;

Q1(:,1) = ones(5,1);

p0 = [1, 0, 0, 0, 0];

u = [1, 0, 0, 0, 0];

%visits
v = l / (eye(5) - P);

%steady state probabilities
pi = u / Q1;


avg_throughput_steady = avg_transition(pi, Q, X);

fprintf('X = %f\n', avg_throughput_steady);
fprintf('visits: ');
fprintf('%f ', v);

function F = avg_transition(p, Q, T)
    cum = 0;
    throughput = 0;
    for i = 1 : size(Q,1)
        for j = 1 : size(Q,2)
            if i ~= j
                cum = cum + (Q(i,j) * T(i,j));
            end
        end
        throughput = throughput + (p(1,i) * cum);
        cum = 0;
    end
    F = throughput;
end


