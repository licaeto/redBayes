addpath('M:\ETSINF\apr\p2\BNT');
addpath(genpathKPM('M:\ETSINF\apr\p2\BNT'));

N=5; P=1; F=2; C=3; X=4; D=5;
grafo=zeros(N,N);
grafo([P F],C)=1;
grafo(C,[X D])=1;
nodosDiscretos=1:N;
tallaNodos=[2 2 2 3 2];
redB=mk_bnet(grafo,tallaNodos,'discrete',nodosDiscretos);

redB.CPD{P}=tabular_CPD(redB,P,[0.1 0.9]);
redB.CPD{F}=tabular_CPD(redB,F,[0.3 0.7]);
redB.CPD{C}=tabular_CPD(redB,C,[0.08 0.03 0.05 0.001 0.92 0.97 0.95 0.999]);
redB.CPD{X}=tabular_CPD(redB,X,[0.7 0.1 0.2 0.1 0.1 0.8]);
redB.CPD{D}=tabular_CPD(redB,D,[0.65 0.3 0.35 0.7]);

