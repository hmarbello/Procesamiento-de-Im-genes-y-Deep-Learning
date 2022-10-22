%% Limpiar el espacio de trabajo
close all;
clc;
clear all;
%%
nombre = '/MATLAB Drive/ClaseFviernes/Tarea1/'; %Recorre el diretorio
for k = 1:40 %recorre número de archivos guardados en el directorio
    archivo = ['Imagen' num2str(k) '.jpg']; %Obtiene el nombre de los archivos
    imagen = imread(strcat(nombre,archivo));% lee las imagenes
    a= imagen;
    I = rgb2gray(a);
    thresh = graythresh(I)
    binh = ~imbinarize(I, thresh);
    binh_fill1 =  ~imfill(binh, 'holes');
    %figure(k+5), subplot(2,2,3), imshow(binh_fill1), title('Llenado de huecos')
    binh_fill2 =  imfill(binh, 'holes');
    se4 = strel('ball', 15, 5);  %Circulo/bola de radio 15 y alto 5
    I1 = uint8(binh_fill2)*255;
    A = imopen(I1, se4);   %Apertura
    C = imclose(I1, se4);  %Cierre
    a=C;
    tamanio=size(a);
    alto=tamanio(1,1);
    ancho=tamanio(1,2);
    posAL=fix(alto/8);
    posAN=fix(ancho/8);
    plAL = a(posAL, :); %vector perfil de linea 
    plAN = a(:, posAN); %vector perfil de linea
    pposAL=0;
    pposAN=0;
    for i= 1:7
        plAL = a(pposAL+posAL, :); %vector perfil de linea 
        [L,n] = bwlabel(plAL);
        vecL(k,i) =n;
        %figure(i), plot(plAL), title('Grafica, perfil de linea');
        a(pposAL+posAL, :)= 0;  %muestra la linea en esa fila 
        %figure (8),imshow(a), title('Linea en esa fila');
        pposAL= pposAL + posAL;
        plAN = a(:, pposAN+posAN); %vector perfil de linea 
        [L,n] = bwlabel(plAN);
        vecL(k,7+i) =n;
        %figure(7+i), plot(plAN), title('Grafica, perfil de linea');
        a(:, pposAN+posAN)= 0;  %muestra la linea en esa fila 
        %figure (18),imshow(a), title('Linea en esa fila');
        pposAN= pposAN + posAN;
    end
end
%%
tablename = 'Matriz.xlsx';
writematrix(vecL(:,:), tablename)