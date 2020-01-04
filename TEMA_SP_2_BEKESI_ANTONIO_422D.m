%Tema nr. 2 - Semnale si Programare - numarul din lista = 7, astfel vom avea
% un semnal dreptugnhiular cu perioada 40 si N = 50 si durata = 7.

D=7;
N=50;
P=40;
F=1/P;
t=0:0.02:P-0.02; 
w0=2*pi*F;

%generez un vector cu zerouri:
x = zeros(1,size(t,2));

%aranjarea vectorului
x(t<=D)=1;
x(t>D)=-1;
x(t>P-D)=1;

%seria
for k = -N:N
    xt = x;
    xt = xt.*exp(-j*k*w0*t);
    X(k+51) = trapz(t,xt); 
end

%reconstruirea semnalului (aproximare)

x_aprox(1:length(t)) = 0; 

for const = 1:length(t);
for k = -N:N
x_aprox(const) = x_aprox(const) + (1/P)*X(k+N+1)*exp(j*k*w0*t(const));
end
end % semnalul dat cu coeficientii seriei

figure(1);
plot(t,x); % afisez mai intai x(t)

title('x(t) si semnalul alcatuit prin esantionare');
hold on

plot(t,x_aprox,'r'); 

xlabel('Timp (s)');
ylabel('Amplitudine');


fr = -N*F:F:N*F; % vectorul de frecvente pentru afisarea semnalului
figure(2);
stem(fr,abs(X)); 
title('Spectrul x(t)');
xlabel('Frecventa (Hz)');
ylabel('|X|');

%Seria Fourier este reprezentarea semnalului sub forma de suma pana la
%infinit din: sinusuri si cosinusuri (SFT),exponentiale (SFE), sau armonici
%(SFA). Din cursuri am observat ca semnalul poate fi analizat pe esantioane
%si aproximat astfel incat sa obtinem un model cat mai apropiat de cel real
%si o eroare cat mai mica. Astfel, am esantionat si am calculat
%coeficientii seriei Fourier.