function [aopt, fopt] = mc_lyc(cnf_file, eval_budget, boolplot)
% [aopt, fopt] = mc(cnf_file, eval_budget, boolplot)
%
% Monte Carlo MAX-3SAT solver
%
% Author: Johannes W. Kruisselbrink, Edgar Reehuis
% Last modified: September 7, 2011

	% Do you want online plotting? If not, set to false
	doplot = boolplot;

	% Load CNF file and create fitness function handle
	cnf_expr = cnf_read(cnf_file);
	fitnessfct = @(a) evaluate_sat_expr(cnf_expr, a);
	n = size(cnf_expr, 1);

	% Initialize algorithm
	aopt = rand(n,1) > 0.5;
	fopt = fitnessfct(aopt);
  evals_used = 1;

	% Statistics
  if (doplot)
	  histf = zeros(1, eval_budget);
    histf(1:evals_used) = fopt;
  end
  
  if (doplot)
    %some basic notation for the drawing
    figure 
    title('performance')
  end
	% Main Monte-Carlo loop
	while (evals_used < eval_budget)

		% Generate random bitstring
        rng('shuffle');
		a = rand(n,1) > 0.5;
    
		fa = fitnessfct(a);

		% If the new bitstring is better than the one we have, replace the old one
		if (fa >= fopt)
			aopt = a;
			fopt = fa;
		end

		% Statistics maintenance and plotting
		if (doplot)
			histf(evals_used+1) = fopt;
			%subplot(2,1,1)
% 			plot(histf(1:evals_used+1),'LineWidth',3,'Color',[1 0 0]);
			%subplot(2,1,2)
			%bar([1:n],double(aopt))
			%xlim([1 n])
% 			drawnow();
        end

    evals_used = evals_used + 1;
    end
    if(doplot) 
    plot(histf,'LineWidth',3,'Color',[1 0 0]);
    drawnow();
    set(get(gca,'YLabel'),'String','Best fitness score','FontSize',20)
    set(get(gca,'XLabel'),'String','function evaluations','FontSize',20)
    hold on
    end
    
	
end


