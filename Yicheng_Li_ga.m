function [parent, f_parent] = Yicheng_Li_ga(cnf_file, eval_budget)
%function [aopt, fopt] = simple_ga (cnf_file,eval_budget,boolplot)
%input: cnf_file enter : filepath
%input: eval_budget : evaluate times
%input: boolplot : false or true , determine plot or not
%output: aopt : the best individual pattern after the evaluation
%output: fopt : the highest score after the evaluation
%Li Yicheng 2015/10/15
%reference: workshop first assignment

    %plot or not
    boolplot= true;
    
    %get the size of binary string and the fittness function
	cnf_expr = cnf_read(cnf_file);
	fitnessfct = @(a) evaluate_sat_expr(cnf_expr, a);
	n = size(cnf_expr, 1);
    
    %mutation rate
    p=1/n;  
    
    %generate initial solution
    parent = rand (n,1) > 0.5;
    f_parent = fitnessfct(parent);
    hist_f(1) = f_parent;
    
    %start evaluation
    for i = 2:eval_budget
        bits = (rand(n,1) < p); %using mutation rate to choose bits to mutate
        offspring = mod (parent + bits,2);
        f_offspring = fitnessfct(offspring);
        
        if ( f_offspring >= f_parent )
            parent = offspring;
            f_parent = f_offspring;
        end
        
        hist_f(i) = f_parent;
        
        if(boolplot)
            plot(hist_f,'LineWidth',3,'Color',[0 0 0.7])
            drawnow()
        end
    end
    if (boolplot)
    legend ('GA');
    end
    
    
    

