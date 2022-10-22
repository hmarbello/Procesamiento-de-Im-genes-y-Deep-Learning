%% 
% Script para CLASIFICACION CON REDES NEURONALES ARTIFICIALES
% Electiva: Procesamiento Digital de Imágenes
% 
%% Limpiar el espacio de trabajo
close all;
clc;
clear all;
%% Configuración inicial
% addpath('###');

%% Leer datos, descriptores
matr_descrip = xlsread('Matriz.xlsx'); %Contiene descriptores en la tabla, xlsread carga sólo los valores numéricos de la primera pestaña
ss = size(matr_descrip); %tamaño de la matriz, en este caso de 36x6

j=1;
for i = 1:8:ss(1) %Cada 4 posiciones del vector se toman las 2 primeras muestras de cada clase (con esto se dejan 2 para la prueba)
    L1H(j) = matr_descrip(i,1);
    L1H(j+1) = matr_descrip(i+1,1);
    L1H(j+2) = matr_descrip(i+2,1);
    L1H(j+3) = matr_descrip(i+3,1);

    L2H(j) = matr_descrip(i,2);
    L2H(j+1) = matr_descrip(i+1,2);
    L2H(j+2) = matr_descrip(i+2,2);
    L2H(j+3) = matr_descrip(i+3,2);

    L3H(j) = matr_descrip(i,3);
    L3H(j+1) = matr_descrip(i+1,3);
    L3H(j+2) = matr_descrip(i+2,3);
    L3H(j+3) = matr_descrip(i+3,3);

    L4H(j) = matr_descrip(i,4);
    L4H(j+1) = matr_descrip(i+1,4);
    L4H(j+2) = matr_descrip(i+2,4);
    L4H(j+3) = matr_descrip(i+3,4);

    L5H(j) = matr_descrip(i,5);
    L5H(j+1) = matr_descrip(i+1,5);
    L5H(j+2) = matr_descrip(i+2,5);
    L5H(j+3) = matr_descrip(i+3,5);

    L6H(j) = matr_descrip(i,6);
    L6H(j+1) = matr_descrip(i+1,6);
    L6H(j+2) = matr_descrip(i+2,6);
    L6H(j+3) = matr_descrip(i+3,6);

    L7H(j) = matr_descrip(i,7);
    L7H(j+1) = matr_descrip(i+1,7);
    L7H(j+2) = matr_descrip(i+2,7);
    L7H(j+3) = matr_descrip(i+3,7);

    L1V(j) = matr_descrip(i,8);
    L1V(j+1) = matr_descrip(i+1,8);
    L1V(j+2) = matr_descrip(i+2,8);
    L1V(j+3) = matr_descrip(i+3,8);

    L2V(j) = matr_descrip(i,9);
    L2V(j+1) = matr_descrip(i+1,9);
    L2V(j+2) = matr_descrip(i+2,9);
    L2V(j+3) = matr_descrip(i+3,9);

    L3V(j) = matr_descrip(i,10);
    L3V(j+1) = matr_descrip(i+1,10);
    L3V(j+2) = matr_descrip(i+2,10);
    L3V(j+3) = matr_descrip(i+3,10);

    L4V(j) = matr_descrip(i,11);
    L4V(j+1) = matr_descrip(i+1,11);
    L4V(j+2) = matr_descrip(i+2,11);
    L4V(j+3) = matr_descrip(i+3,11);

    L5V(j) = matr_descrip(i,12);
    L5V(j+1) = matr_descrip(i+1,12);
    L5V(j+2) = matr_descrip(i+2,12);
    L5V(j+3) = matr_descrip(i+3,12);

    L6V(j) = matr_descrip(i,13);
    L6V(j+1) = matr_descrip(i+1,13);
    L6V(j+2) = matr_descrip(i+2,13);
    L6V(j+3) = matr_descrip(i+3,13);

    L7V(j) = matr_descrip(i,14);
    L7V(j+1) = matr_descrip(i+1,14);
    L7V(j+2) = matr_descrip(i+2,14);
    L7V(j+3) = matr_descrip(i+3,14);

    j=j+4;
end

%% Configuración y ejecución del clasificador
% 1.1 Configuración input
X = [L1H; L2H; L3H; L4H; L5H; L6H; L7H; L1V; L2V; L3V; L4V; L5V; L6V; L7V]'; %Datos de entrenamiento
%X = [area; circ]'; %Datos de entrenamiento

% 1.2 Configuración target
T = repmat([1 2 3 4 5],4,1); %Se crea una matriz con las etiquetas posibles para las muestras (2 filas, 9 columnas)
target = T(:); %Se serializa T, Vector objetivo para la clasif supervisada
%target = target';

% 2: Configuración de la red neuronal
disp('Configuring Neural Network...');
trainFcn = 'trainlm';                              % Levenberg-Marquardt
hiddenLayerSize = [5 15 10];                        %if I need more layers then I should write: [10,12,...,9]
net = fitnet(hiddenLayerSize,trainFcn);
% net.layers{1}.transferFcn='logsig';                %tansig by default, but I can put another
% net.layers{2}.transferFcn='tansig';   
% net.layers{3}.transferFcn='purelin';  
% net.trainParam.goal = 0.1;
% net.trainParam.epochs = 500;
%net = init(net);                                  %initializing the network with previous configurations
% view(net)                                          % para visualizar la red final 
[net, tr] = train(net,X',target');               %training

%% Validación del modelo sobre muestras de prueba (las que no se usaron durante el entrenamiento)
% Se toman las 2 segundas muestras de cada clase
j=1;
for i = 5:8:ss(1) %Cada 4 posiciones del vector se toman las 2 segundas muestras de cada clase
    L1H(j) = matr_descrip(i,1);
    L1H(j+1) = matr_descrip(i+1,1);
    L1H(j+2) = matr_descrip(i+2,1);
    L1H(j+3) = matr_descrip(i+3,1);

    L2H(j) = matr_descrip(i,2);
    L2H(j+1) = matr_descrip(i+1,2);
    L2H(j+2) = matr_descrip(i+2,2);
    L2H(j+3) = matr_descrip(i+3,2);

    L3H(j) = matr_descrip(i,3);
    L3H(j+1) = matr_descrip(i+1,3);
    L3H(j+2) = matr_descrip(i+2,3);
    L3H(j+3) = matr_descrip(i+3,3);

    L4H(j) = matr_descrip(i,4);
    L4H(j+1) = matr_descrip(i+1,4);
    L4H(j+2) = matr_descrip(i+2,4);
    L4H(j+3) = matr_descrip(i+3,4);

    L5H(j) = matr_descrip(i,5);
    L5H(j+1) = matr_descrip(i+1,5);
    L5H(j+2) = matr_descrip(i+2,5);
    L5H(j+3) = matr_descrip(i+3,5);

    L6H(j) = matr_descrip(i,6);
    L6H(j+1) = matr_descrip(i+1,6);
    L6H(j+2) = matr_descrip(i+2,6);
    L6H(j+3) = matr_descrip(i+3,6);

    L7H(j) = matr_descrip(i,7);
    L7H(j+1) = matr_descrip(i+1,7);
    L7H(j+2) = matr_descrip(i+2,7);
    L7H(j+3) = matr_descrip(i+3,7);

    L1V(j) = matr_descrip(i,8);
    L1V(j+1) = matr_descrip(i+1,8);
    L1V(j+2) = matr_descrip(i+2,8);
    L1V(j+3) = matr_descrip(i+3,8);

    L2V(j) = matr_descrip(i,9);
    L2V(j+1) = matr_descrip(i+1,9);
    L2V(j+2) = matr_descrip(i+2,9);
    L2V(j+3) = matr_descrip(i+3,9);

    L3V(j) = matr_descrip(i,10);
    L3V(j+1) = matr_descrip(i+1,10);
    L3V(j+2) = matr_descrip(i+2,10);
    L3V(j+3) = matr_descrip(i+3,10);

    L4V(j) = matr_descrip(i,11);
    L4V(j+1) = matr_descrip(i+1,11);
    L4V(j+2) = matr_descrip(i+2,11);
    L4V(j+3) = matr_descrip(i+3,11);

    L5V(j) = matr_descrip(i,12);
    L5V(j+1) = matr_descrip(i+1,12);
    L5V(j+2) = matr_descrip(i+2,12);
    L5V(j+3) = matr_descrip(i+3,12);

    L6V(j) = matr_descrip(i,13);
    L6V(j+1) = matr_descrip(i+1,13);
    L6V(j+2) = matr_descrip(i+2,13);
    L6V(j+3) = matr_descrip(i+3,13);

    L7V(j) = matr_descrip(i,14);
    L7V(j+1) = matr_descrip(i+1,14);
    L7V(j+2) = matr_descrip(i+2,14);
    L7V(j+3) = matr_descrip(i+3,14);

    j=j+4;
end

%X_v = [area; perim; orien; circ; ejeMen; ejeMay]'; %Datos de entrenamiento %Datos de prueba
X_v = [L1H; L2H; L3H; L4H; L5H; L6H; L7H; L1V; L2V; L3V; L4V; L5V; L6V; L7V]';

%Respuesta del clasificador
outputs = round(net(X_v'));
outputs % para presentar en pantalla un vector fila con los resultados (como responde)
target' %... y compararlo con el objetivo (como debería responder)

% Evaluación del desempeño: Es mejor si se acerca a 100
%performance = perform(net, target', outputs)
eval = sum(outputs==target')/length(target)*100 

% save ANN_model net % guardar modelo clasificador
