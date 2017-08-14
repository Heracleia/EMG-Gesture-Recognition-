clear all;
close all; 
clc;
folder=uigetdir('C:\Users\kanalvxx\Desktop\HCI\EMG\EMG DATA FULL Final\EMG Study Readings');
for i=1:3
    load([folder,'\M\M-',folder(end),'_Double_Tap_',num2str(i),'_EMG.mat']);
    load([folder,'\M\M-',folder(end),'_Finger_Spread_',num2str(i),'_EMG.mat']);
    load([folder,'\M\M-',folder(end),'_Fist_',num2str(i),'_EMG.mat']);
    load([folder,'\M\M-',folder(end),'_Half_Pinch_',num2str(i),'_EMG.mat']);
    load([folder,'\M\M-',folder(end),'_Pick_Up_Block_',num2str(i),'_EMG.mat']);
    load([folder,'\M\M-',folder(end),'_Pinch_and_Hold_',num2str(i),'_EMG.mat']);
    load([folder,'\M\M-',folder(end),'_Pointing_',num2str(i),'_EMG.mat']);
    load([folder,'\M\M-',folder(end),'_rest_',num2str(i),'_EMG.mat']);
    load([folder,'\M\M-',folder(end),'_Thumbs_Up_',num2str(i),'_EMG.mat']);
    load([folder,'\M\M-',folder(end),'_Wave_in_',num2str(i),'_EMG.mat']);
    load([folder,'\M\M-',folder(end),'_Wave_out_',num2str(i),'_EMG.mat']);

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
    %L= length(csv_FS_temp_one(:,1));
    % N= length(csv_FS_temp(:,1));
     j=1;op=1;
%      len= max();
    while j<30
        Y = fft(csv_rest_temp_one(:,j*2));
        L=length(csv_rest_temp_one(:,j*2));
            P2i = abs(Y/L);
            P1i = P2i(1:L/2+1);
            P1i(2:end-1) = 2*P1i(2:end-1);
            fi = Fs*(0:(L/2))/L;
        for a=1:10
            switch(a)
                case 1
                    X=csv_DT_temp_one(:,j*2);
                case 2
                    X=csv_FS_temp_one(:,j*2);
                case 3
                    X=csv_fist_temp_one(:,j*2);
                case 4
                    X=csv_HP_temp_one(:,j*2);
                case 5 
                    X=csv_PUB_temp_one(:,j*2);
                case 6
                    X=csv_PAH_temp_one(:,j*2);
                case 7
                    X=csv_point_temp_one(:,j*2);
                case 8
                    X=csv_TU_temp_one(:,j*2);
                case 9
                    X=csv_WI_temp_one(:,j*2);
                case 10
                    X=csv_WO_temp_one(:,j*2);
            end
            Y = fft(X);
            L=length(X);
            P2 = abs(Y/L);
            P1 = P2(1:L/2+1);
            P1(2:end-1) = 2*P1(2:end-1);
            f = Fs*(0:(L/2))/L;
            % hold on;
            figure((a*2)-1);subplot(4,2,op);
            hold on;
            plot(X);
            plot(csv_rest_temp_one(:,j*2));
            title([TName{a},' ',num2str(op)]);
            figure(a*2);subplot(4,2,op);
            hold on;
            plot(f,P1)
            plot(fi,P1i,'r -.')
            title(['Single-Sided Amplitude Spectrum of S(t),',TName{a},' : ', num2str(op)])
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
             
             clear Y P2 P1;
        end
        j=j+4;op=op+1;
    end
end
