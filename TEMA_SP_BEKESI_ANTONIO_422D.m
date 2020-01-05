N = 50; % Numarul de coeficienti
D = 8; % Durata de crestere
P = 40; % Perioada
F=1/P; % Frecventa 
w0=2*pi/P; % Pulsatia
r=0.02; % Rezolutia
t=0:r:P-r; % Vectorul timp pentru o perioada

%Constructia unei perioade
x = zeros(1,size(t,2)); % Initializarea lui x cu zerouri
for i=0 : 1 : D/r
   x(i+1) = 1 - 1/8*i*r ;
end

m=0
for i=(P-D)/r : 1 : P/r    
    x(i) = 1/8 * m * r;
    m=m+1;
end

%Reprezentarea unei perioade 
figure(1), plot(t,x)

t_4p = 0:r:4*P-r; % Vectorul timp pentru 4 perioade
x_4p = repmat(x,1,4); % Replicarea matricii pentru generarea a 4 perioade ale semnalului

%Reprezentarea a 4 perioade ale semnalului
figure(2),plot(t_4p,x_4p)
grid on

% Determinarea coeficientilor fourier
for k = -N:N
    a = x;
    a = a.*exp(-j*k*w0*t);
    X(k+51) = trapz(t,a); % Calcularea integralei cu metoda trapezului
end

x_refacut(1:length(t)) = 0; % Initializarea semnalului reconstruit cu N puncte

%Reconstructia lui x(t) folosind N coeficienti
for i = 1:length(t);
for k = -N:N
x_refacut(i) = x_refacut(i) + (1/P)*X(k+N+1)*exp(j*k*w0*t(i));
end
end

figure(3);
plot(t_4p,x_4p); % Afisarea lui x(t) - 4 perioade
title('x(t) cu linie solida si reconstructia folosind N=50 coeficienti(linie punctata)');
hold on
x_refacut_4p = repmat(x_refacut,1,4); % Replicarea matricii pentru generarea a 4 perioade
plot(t_4p,x_refacut_4p,'--'); % Afisarea lui x refacut
xlabel('Timp [s]');
ylabel('Amplitudine [V]');

f = -N*F:F:N*F; % Vectorul de frecvente

figure(4), stem(f,abs(X)), title('Spectrul lui x(t)'), xlabel('Frecventa [Hz]'), ylabel('|X|');

%Seriile Fourier sunt o unealta matematica folosita pentru a analiza
%Functiile periodice descompunandu-le intr-o suma ponderata de functii sinusoidale
%Fiecare functie sinusoidala are un coeficient(pondere)
%Reprezentarea spectrala ne arata frecventele si ponderile sinusoidelor prin care poate
%fi aproximat semnalul.
%Semnalul reconstruit pe baza coeficientilor Fourier devine din ce in ce mai
%apropiat de semnalul original, cu cat sunt luati in considerare mai multi
%termeni ai dezvoltarii