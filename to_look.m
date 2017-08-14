clear all;
close all; 
clc;
folder=uigetdir('C:\Users\kanalvxx\Desktop\HCI\EMG\EMG DATA FULL Final\EMG Study Readings');
for i=1:3
    disp(['Itteration: ',num2str(i)]);
    if folder(end-1) == '1'
        ind= folder(end-1:end);
    else
        ind= folder(end);
    end
    load([folder,'\D\D-',ind,'_Double_Tap_',num2str(i)]);
    load([folder,'\D\D-',ind,'_Finger_Spread_',num2str(i)]);
    load([folder,'\D\D-',ind,'_Fist_',num2str(i)]);
    load([folder,'\D\D-',ind,'_Half_Pinch_',num2str(i)]);
    load([folder,'\D\D-',ind,'_Pick_Up_Block_',num2str(i)]);
    load([folder,'\D\D-',ind,'_Pinch_and_Hold_',num2str(i)]);
    load([folder,'\D\D-',ind,'_Pointing_',num2str(i)]);
    load([folder,'\D\D-',ind,'_rest_',num2str(i)]);
    load([folder,'\D\D-',ind,'_Thumbs_Up_',num2str(i)]);
    load([folder,'\D\D-',ind,'_Wave_in_',num2str(i)]);
    load([folder,'\D\D-',ind,'_Wave_out_',num2str(i)]);

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
    % figure;
%     L= length(csv_FS_temp(:,1));
    % N= length(csv_FS_temp(:,1));
     j=1;op=1;
      
    while j<30
        L=length(csv_rest_temp(:,j*2));
        NFFTi=2^(nextpow2(L)+3);
        Y = fft(csv_rest_temp(:,j*2),NFFTi);
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
            L=length(X);
            NFFT=2^(nextpow2(L)+3);
            Y = fft(X,NFFT);
            Y=Y(1:NFFT/2);
            mx=abs(Y);
            f=(0:NFFT/2-1)*Fs/NFFT;
            % hold on;
            figure((a*2)-1);subplot(4,2,op);
            hold on;
            plot(X);
            plot(csv_rest_temp(:,j*2));
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
