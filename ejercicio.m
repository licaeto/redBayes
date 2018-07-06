function[error] = ejercicio(datApr,etqApr,datTest,etqTest,gauss)
dataApr=zscore(datApr);
etiqApr = etqApr + 1;
[numVec dim] = size(dataApr);
numClas = max(etiqApr);

numGaus = gauss;
grafo = [ 0 1 1 ; 0 0 1 ; 0 0 0 ];
numNodos = length(grafo);
tallaNodos = [numClas numGaus dim];
nodosDiscretos = [1 2];
redB = mk_bnet(grafo, tallaNodos, 'discrete', nodosDiscretos);
redB.CPD{1} = tabular_CPD(redB, 1);
redB.CPD{2} = tabular_CPD(redB, 2);
redB.CPD{3} = gaussian_CPD(redB, 3, 'cov_type', 'diag');

datosApr = cell(numNodos, numVec);
datosApr(numNodos,:) = num2cell(dataApr', 1);
datosApr(1,:) = num2cell(etiqApr', 1);
motor = jtree_inf_engine(redB);
maxIter = 16;
[redB2, ll, motor2] = learn_params_em(motor, datosApr, maxIter);

dataTest = zscore(datTest);
etiqTest = etqTest + 1;

p = zeros(length(dataTest), numClas);
evidencia = cell(numNodos,1);
for i=1:length(dataTest)
    evidencia{numNodos} = dataTest(i,:)';
    [motor3, ll] = enter_evidence(motor2, evidencia);
    m = marginal_nodes(motor3, 1);
    p(i,:) = m.T';
end
n=0;
for i=1:length(dataTest)
    aux=0;
    if p(i,1)>= p(i,2)
        aux=1;
    else
        aux=2;
    end
    if aux~=etiqTest(i)
        n=n+1;
    end
end
error=n/length(dataTest);
end