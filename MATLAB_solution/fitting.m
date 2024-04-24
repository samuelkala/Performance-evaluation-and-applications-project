clear;

exec_A = readtable("TraceA-A.txt");
exec_B = readtable("TraceA-B.txt");
exec_C = readtable("TraceA-C.txt");
exec_D = readtable("TraceA-D.txt");
exec_E = readtable("TraceA-E.txt");

S_A = (exec_A.Var1);
S_B = (exec_B.Var1);
S_C = (exec_C.Var1);
S_D = (exec_D.Var1);
S_E = (exec_E.Var1);


S_A_sort = sort(S_A);
S_B_sort = sort(S_B);
S_C_sort = sort(S_C);
S_D_sort = sort(S_D);
S_E_sort = sort(S_E);

X = [S_A_sort, S_B_sort, S_C_sort, S_D_sort, S_E_sort];

t = (1 : 600) / 10;

%moments

M1 = sum(X) / size(X,1);

lambdas = 1 ./ M1;

%graphs for mle method
figure;
plot(S_A_sort, (1 : 50000) / 50000, "+", t, exp_cdf(t, lambdas(1,1)), "-");
legend("sample", "exp");
title('CDF server A');

figure;
plot(S_B_sort, (1 : 50000) / 50000, "+", t, exp_cdf(t, lambdas(1,2)), "-");
legend("sample", "exp");
title('CDF server B');

figure;
plot(S_C_sort, (1 : 50000) / 50000, "+", t, exp_cdf(t, lambdas(1,3)), "-");
legend("sample", "exp");
title('CDF server C');

figure;
plot(S_D_sort, (1 : 50000) / 50000, "+", t, exp_cdf(t, lambdas(1,4)), "-");
legend("sample", "exp");
title('CDF server D');

figure;
plot(S_E_sort, (1 : 50000) / 50000, "+", t, exp_cdf(t, lambdas(1,5)), "-");
legend("sample", "exp");
title('CDF server E');


function F = exp_cdf(t, lambda)
    F = 1 - exp(-lambda.*t);
end



