#
# sqrtiteration.m
#
# (c) 2020 Prof Dr Andreas Müller, Hochschule Rapperswil
#

x0 = 0
N = 30

function y = f(x)
	y = sqrt(x+2);
endfunction

results = zeros(N, 4);
results(1,3) = 2;

for i = (2:N)
	results(i,1) = i-1;
	results(i,2) = f(results(i-1,2));
	results(i,3) = 2 - results(i,2);
	results(i,4) = results(i-1,3) / results(i,3);
endfor

format long
results

fn = fopen("sqrtiteration.tex", "w");
fprintf(fn, "%%\n");
fprintf(fn, "%% sqrtiteration.tex -- generated by sqrtiteration.m\n");
fprintf(fn, "%%\n");
fprintf(fn, "%% (c) 2020 Prof Dr Andreas Müller Hochschule Rapperswil\n");
fprintf(fn, "%%\n");
fprintf(fn, "\\begin{tabular}{|>{$}r<{$}|>{$}r<{$}|>{$}r<{$}|>{$}r<{$}|}\n");
fprintf(fn, "\\hline\n");
fprintf(fn, "   k & x_k                           & \\delta_k = 2-x_k     & \\delta_k / \\delta_{k-1} \\\\\n");
fprintf(fn, "\\hline\n");
fprintf(fn, " %2d &           %20.16f & %20.16f &        \\\\\n", 0, 0, 2);
for k = (2:N)
	s = sprintf("%18.16f", results(k, 2));
	stellen = round(log10(results(k, 3)))
	if (stellen < -15) 
		stellen = -16;
	endif
	if (stellen < 0)
		S = ["\\underline{" substr(s, 1, 2-stellen) "}" ];
		if (stellen > -16)
			S = [S substr(s, 3-stellen)];
		endif
		s = S;
	else
		s = [ "            " s ];
	endif
	q = "";
	if (k < 29)
		q = sprintf("%6.4f", results(k,4));
	else
		q = "      ";
	endif
	fprintf(fn," %2d & %s & %20.16f & %s \\\\\n", k, s, results(k, 3), q);
endfor
fprintf(fn, "\\hline\n");
fprintf(fn, "\\end{tabular}\n");

fclose(fn);