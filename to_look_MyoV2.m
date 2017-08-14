clear all;close all; clc;
folder= 'C:\Users\kanalvxx\Desktop\HCI\EMG\EMG DATA FULL Final\EMG Study Readings';
load([folder,'\MYO_EMG_REST.mat']);
X1=MYO_EMG_REST;
num=[X1(1,1),X1(1,1)+1,X1(1,1)+2];
j=1;tempfile=[];
rfirst={};f=1;
rsecond={};s=1;
rthird={};t=1;
for i=1:length(X1(:,1))
    if j==1
        if X1(i+1,1)== num(j)
            tempfile=[tempfile;X1(i,:)];
        else
            tempfile=[tempfile;X1(i,:)];
            rfirst{f}=tempfile;f=f+1; tempfile=[];
            j=2;
        end
    elseif j==2
        if X1(i+1,1)== num(j)
            tempfile=[tempfile;X1(i,:)];
        else
            tempfile=[tempfile;X1(i,:)];
            rsecond{s}=tempfile;s=s+1; tempfile=[];
            j=3;
        end
    else
        if i~=length(X1(:,1))
            if X1(i+1,1)== num(j)
                tempfile=[tempfile;X1(i,:)];
            else
                tempfile=[tempfile;X1(i,:)];
                rthird{t}=tempfile;t=t+1; tempfile=[];
                j=1;
            end
        else
            tempfile=[tempfile;X1(i,:)];
            rthird{t}=tempfile;t=t+1; tempfile=[];
        end
    end
end

for a=1:10;
    switch(a)
        case 1
            load([folder,'\MYO_EMG_DT.mat']);
            X1=MYO_EMG_DT;
        case 2
            load([folder,'\MYO_EMG_FS.mat']);
            X1=MYO_EMG_FS;
        case 3
            load([folder,'\MYO_EMG_FIST.mat']);
            X1=MYO_EMG_FIST;
        case 4
            load([folder,'\MYO_EMG_HP.mat']);
            X1=MYO_EMG_HP;
        case 5 
            load([folder,'\MYO_EMG_PUB.mat']);
            X1=MYO_EMG_PUB;
        case 6
            load([folder,'\MYO_EMG_PAH.mat']);
            X1=MYO_EMG_PAH;
        case 7
            load([folder,'\MYO_EMG_POINT.mat']);
            X1=MYO_EMG_POINT;
        case 8
            load([folder,'\MYO_EMG_TU.mat']);
            X1=MYO_EMG_TU;
        case 9
            load([folder,'\MYO_EMG_WI.mat']);
            X1=MYO_EMG_WI;
        case 10
            load([folder,'\MYO_EMG_WO.mat']);
            X1=MYO_EMG_WO;
    end
    
    num=[X1(1,1),X1(1,1)+1,X1(1,1)+2];
    j=1;tempfile=[];
    first={};f=1;
    second={};s=1;
    third={};t=1;
    for i=1:length(X1(:,1))
        if j==1
            if X1(i+1,1)== num(j)
                tempfile=[tempfile;X1(i,:)];
            else
                tempfile=[tempfile;X1(i,:)];
                first{f}=tempfile;f=f+1; tempfile=[];
                j=2;
            end
        elseif j==2
            if X1(i+1,1)== num(j)
                tempfile=[tempfile;X1(i,:)];
            else
                tempfile=[tempfile;X1(i,:)];
                second{s}=tempfile;s=s+1; tempfile=[];
                j=3;
            end
        else
            if i~=length(X1(:,1))
                if X1(i+1,1)== num(j)
                    tempfile=[tempfile;X1(i,:)];
                else
                    tempfile=[tempfile;X1(i,:)];
                    third{t}=tempfile;t=t+1; tempfile=[];
                    j=1;
                end
            else
                tempfile=[tempfile;X1(i,:)];
                third{t}=tempfile;t=t+1; tempfile=[];
            end
        end
    end

    Fs=200;
    for k=1:3
        switch (k)
            case 1
                AA=first;AA2=rfirst;
            case 2
                AA=second;AA2=rsecond;
            case 3
                AA=third;AA2=rthird;
        end
        for i=1:length(AA)
            temp=AA{i};temp2=AA2{i}; 

            for j=1:8
                X=temp(:,j+5);X2=temp2(:,j+5);
                Y = fft(X);
                L=length(X);
                P2 = abs(Y/L);
                P1 = P2(1:L/2+1);
                P1(2:end-1) = 2*P1(2:end-1);
                f = Fs*(0:(L/2))/L;
                
                Y = fft(X2);
                L=length(X2);
                P2i = abs(Y/L);
                P1i = P2i(1:L/2+1);
                P1i(2:end-1) = 2*P1i(2:end-1);
                fi = Fs*(0:(L/2))/L;
                
                figure((i*2)-1);subplot(2,4,j); hold on; plot(X);plot(X2); title(['Pod: ',num2str(j)]);
                figure(i*2);subplot(2,4,j);hold on;plot(f,P1);plot(fi,P1i,'r -.'); xlabel('f (Hz)');ylabel('|P1(f)|');title(['Pod: ',num2str(j)]);
            end
            figure((i*2)-1); title(['Subject: ',num2str(i)]);legend('Gesture', 'Rest');
            figure((i*2)); title(['Subject: ',num2str(i)]);legend('Gesture', 'Rest');
        end
        clear AA AA2;
        close all;
    end
%     pause();
    close all;
    clearvars -except a folder rfirst rsecond rthird; 
end