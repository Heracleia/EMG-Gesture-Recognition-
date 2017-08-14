clear all;
close all; 
clc;
folder=uigetdir('C:\Users\kanalvxx\Desktop\HCI\EMG\EMG DATA FULL Final\EMG Study Readings');
for i=1:3
    disp(['Itteration: ',num2str(i)]);
    load([folder,'\D\D-',folder(end),'_Double_Tap_',num2str(i)]);
    load([folder,'\D\D-',folder(end),'_Finger_Spread_',num2str(i)]);
    load([folder,'\D\D-',folder(end),'_Fist_',num2str(i)]);
    load([folder,'\D\D-',folder(end),'_Half_Pinch_',num2str(i)]);
    load([folder,'\D\D-',folder(end),'_Pick_Up_Block_',num2str(i)]);
    load([folder,'\D\D-',folder(end),'_Pinch_and_Hold_',num2str(i)]);
    load([folder,'\D\D-',folder(end),'_Pointing_',num2str(i)]);
    load([folder,'\D\D-',folder(end),'_rest_',num2str(i)]);
    load([folder,'\D\D-',folder(end),'_Thumbs_Up_',num2str(i)]);
    load([folder,'\D\D-',folder(end),'_Wave_in_',num2str(i)]);
    load([folder,'\D\D-',folder(end),'_Wave_out_',num2str(i)]);

    TName{1}='Double Tap';
    TName{2}='Finger Spread';
    TName{3}='Fist';
    TName{4}='Half Pinch';
    TName{5}='Pick Up Block';
    TName{6}='Pinch And Hold';
    TName{7}='Pointing';
    TName{8}='Thumbs Up';
    TName{9}='Wave In';
    TName{10}='Wave Out';
    
    Fs=1925;
    fc1=20;fc2=500;N=4;
    filt1= fdesign.highpass('n,f3db',4,2*10*(1/Fs));H1 = design(filt1,'butter');
    filt2= fdesign.lowpass('n,f3db',4,2*500*(1/Fs));H2 = design(filt2,'butter');
    filt3 = fdesign.notch(4,50/Fs,10);H3 = design(filt3);
    
%     [b,a]=butter(N,[fc1,fc2]/(Fs/2),'bandpass');
    % figure;
%     L= length(csv_FS_temp(:,1));
    % N= length(csv_FS_temp(:,1));
     j=1;op=1;
      
    while j<30
%         rest=filtfilt(b,a,csv_rest_temp(:,j*2));
        r1=filtfilt(H1.sosMatrix, H1.ScaleValues,csv_rest_temp(:,j*2));
        r2= filtfilt(H2.sosMatrix, H2.ScaleValues,r1);
        rest= filtfilt(H3.sosMatrix, H3.ScaleValues,r2);
        L=length(rest);
        NFFTi=2^(nextpow2(L)+3);
        Y = fft(rest,NFFTi);
        Y=Y(1:NFFTi/2);
        mxi=abs(Y);
        fi=(0:NFFTi/2-1)*Fs/NFFTi; 
        for a=1:10
            switch(a)
                case 1
                    X=csv_DT_temp(:,j*2);
                case 2
                    X=csv_FS_temp(:,j*2);
                case 3
                    X=csv_fist_temp(:,j*2);
                case 4
                    X=csv_HP_temp(:,j*2);
                case 5 
                    X=csv_PUB_temp(:,j*2);
                case 6
                    X=csv_PAH_temp(:,j*2);
                case 7
                    X=csv_point_temp(:,j*2);
                case 8
                    X=csv_TU_temp(:,j*2);
                case 9
                    X=csv_WI_temp(:,j*2);
                case 10
                    X=csv_WO_temp(:,j*2);
            end
            g1=filtfilt(H1.sosMatrix, H1.ScaleValues,X);
            g2= filtfilt(H2.sosMatrix, H2.ScaleValues,g1);
            gest= filtfilt(H3.sosMatrix, H3.ScaleValues,g2);
%             gest=filtfilt(b,a,X);
            L=length(gest);
            NFFT=2^(nextpow2(L)+3);
            Y = fft(gest,NFFT);
            Y=Y(1:NFFT/2);
            mx=abs(Y);
            f=(0:NFFT/2-1)*Fs/NFFT;
            % hold on;
            figure((a*2)-1);subplot(4,2,op);
            hold on;
            plot(gest);
            plot(rest);
            title([TName{a},' ',num2str(op)]);
            figure(a*2);subplot(4,2,op);
            hold on;
            plot(f,mx)
            plot(fi,mxi,'r -.')
            title(['Single-Sided Amplitude Spectrum of S(t),',TName{a},' : ', num2str(op)])
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
            figure((a*2)-1); legend('Gesture', 'Rest');
            figure((a*2)); legend('Gesture', 'Rest');
             
             clear Y P2 P1;
        end
        
        j=j+4;op=op+1;
    end
    close all;
end
