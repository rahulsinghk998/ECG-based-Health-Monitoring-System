clear all;

volt=csvread('TEK0000.csv',126,4,[126,4,2125,4]);
Fs=250;
L=2000;


NFFT =2^(nextpow2(L)); % Next power of 2 from length of y

fft_volt = fft(volt,NFFT);
f = (Fs/2)*linspace(0,1,NFFT/2+1);
hold on;
plot(f,2*abs(fft_volt(1:NFFT/2+1)))
delF=Fs/NFFT;
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

low_lim=find(f>0.67,1);
up_lim=find(f<2,1,'last');
abs_fft_volt=abs(fft_volt); 
[amp,argmax]=max(abs_fft_volt(low_lim:up_lim));
m=low_lim+argmax-1;
f1=f(m);%Fundamental frequency as obtained from Coarse search
HR_coarseSearch=f1*60

%Fine search begins

e=[0 0 0];
p=0.5;
Q=3;
z=-1;
flag=0;
for i=2:Q
    Aplus=0;
    Aminus=0;
    for k=1:L
    
    Aplus=Aplus+(volt(k)*exp(-1i*2*pi*k*((m+(p-e(i-1)))/L)));
    Aminus=Aminus+(volt(k)*exp(-1i*2*pi*k*((m-(p-e(i-1)))/L)));
    
    end
        
    Aplusabs=abs(Aplus)
    Aminusabs=abs(Aminus)
    
    if (abs(Aplusabs-Aminusabs))<1
        
            flag = 1;
            if Aplusabs>Aminusabs 
            z=1;
            end
            
            delta=p-e(i-1);
            diff_amp=amp-min(Aplusabs,Aminusabs);
            delta_dash=(delta/diff_amp)*((abs(Aplusabs-Aminusabs))/2);
            
            HeartRate=((m-1)+(z*(delta_dash)))*delF*60
            %break;
        
    end
    
    e(i)=e(i-1)+((0.5-e(i-1))*abs((Aplusabs-Aminusabs)/(Aplusabs+Aminusabs)));
    %e(i)=e(i-1)+((0.5-e(i-1))*real((Aplus+Aminus)/(Aplus-Aminus)));
    
end

%if(flag==0)
    
 if(Aplusabs>Aminusabs) 
 z=1;
 end

HeartRate=((m-1)+(z*(p-e(Q))))*delF*60

%end


