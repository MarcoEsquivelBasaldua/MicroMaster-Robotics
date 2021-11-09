syms m r h
Idiff = sym(zeros(3));
Idiff(1,1) = -m*(3*h/4)^2;
Idiff(2,2) = Idiff(1,1);
