function exp_table(cnf_file,eval_budget)
%function exp(cnf_file,eval_budget,boolplot)
%Li Yicheng 2015/10/17


boolplot = false;
disp('Monte-Carlo Search')
for i = 1:20
    [bitstring, fopt] = Yicheng_Li_mc(cnf_file, eval_budget);
    f_candidate(i) = fopt;
end
% disp('20 candidates')
% f_candidate
disp('avarage')
mean(f_candidate)
disp('standard deviation')
std(f_candidate)


disp('GA Search')
for i = 1:20
    [bitstring, fopt] = Yicheng_Li_ga(cnf_file, eval_budget);
    f_candidate(i) = fopt;
end
% disp('20 candidates')
% f_candidate
disp('avarage')
mean(f_candidate)
disp('standard deviation')
std(f_candidate)







