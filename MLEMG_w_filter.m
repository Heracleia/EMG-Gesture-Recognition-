clear all;
close all; 
clc;
folder= 'C:\Users\kanalvxx\Desktop\HCI\EMG\EMG DATA FULL Final\EMG Study Readings\Sub';
Fs=1925;
filt1= fdesign.highpass('n,f3db',4,2*10*(1/Fs));H1 = design(filt1,'butter');
filt2= fdesign.lowpass('n,f3db',4,2*500*(1/Fs));H2 = design(filt2,'butter');
filt3 = fdesign.notch(4,50/Fs,10);H3 = design(filt3);
PUB=[]; Rest=[]; HP=[]; DT=[]; FS=[]; F=[];PAH=[]; P=[];TU=[];WI=[]; WO=[]; Rest3=[]; Rest5=[]; Rest6=[]; Rest8=[];
Resto=[];PUBo=[];HPo=[]; DTo=[];FSo=[]; Fo=[];PAHo=[]; Po=[];TUo=[];WIo=[]; WOo=[];Rest3o=[]; Rest5o=[]; Rest6o=[]; Rest8o=[];
for i=1:15
    for j=1:3
        load([folder,' ',num2str(i),'\D\D-',num2str(i),'_Half_Pinch_',num2str(j)]);
        load([folder,' ',num2str(i),'\D\D-',num2str(i),'_Pick_Up_Block_',num2str(j)]);
        load([folder,' ',num2str(i),'\D\D-',num2str(i),'_rest_',num2str(j)]);
        load([folder,' ',num2str(i),'\D\D-',num2str(i),'_Double_Tap_',num2str(j)]);
        load([folder,' ',num2str(i),'\D\D-',num2str(i),'_Finger_Spread_',num2str(j)]);
        load([folder,' ',num2str(i),'\D\D-',num2str(i),'_Fist_',num2str(j)]);
        load([folder,' ',num2str(i),'\D\D-',num2str(i),'_Pinch_and_Hold_',num2str(j)]);
        load([folder,' ',num2str(i),'\D\D-',num2str(i),'_Pointing_',num2str(j)]);
        load([folder,' ',num2str(i),'\D\D-',num2str(i),'_Thumbs_Up_',num2str(j)]);
        load([folder,' ',num2str(i),'\D\D-',num2str(i),'_Wave_in_',num2str(j)]);
        load([folder,' ',num2str(i),'\D\D-',num2str(i),'_Wave_out_',num2str(j)]);
        
        k=1;
%         while k<30
            r1=filtfilt(H1.sosMatrix, H1.ScaleValues,csv_rest_temp(:,k*2));
            r2= filtfilt(H2.sosMatrix, H2.ScaleValues,r1);
            rest= filtfilt(H3.sosMatrix, H3.ScaleValues,r2);
            Rest=[Rest, rest];Resto=[Resto; [max(rest), min(rest), mean(abs(rest)), var(rest), rms(rest)]];
            clear rest;
            
            g1=filtfilt(H1.sosMatrix, H1.ScaleValues,csv_PUB_temp(:,k*2));
            g2= filtfilt(H2.sosMatrix, H2.ScaleValues,g1);
            gest= filtfilt(H3.sosMatrix, H3.ScaleValues,g2);
            PUB= [PUB,gest];PUBo=[PUBo; [max(gest), min(gest), mean(abs(gest)), var(gest), rms(gest)]];
            clear gest;
            
            g1=filtfilt(H1.sosMatrix, H1.ScaleValues,csv_HP_temp(:,k*2));
            g2= filtfilt(H2.sosMatrix, H2.ScaleValues,g1);
            gest= filtfilt(H3.sosMatrix, H3.ScaleValues,g2);
            HP=[HP,gest];HPo=[HPo; [max(gest), min(gest), mean(abs(gest)), var(gest), rms(gest)]];
            clear gest;
            
            g1=filtfilt(H1.sosMatrix, H1.ScaleValues,csv_FS_temp(:,k*2));
            g2= filtfilt(H2.sosMatrix, H2.ScaleValues,g1);
            gest= filtfilt(H3.sosMatrix, H3.ScaleValues,g2);
            FS=[FS,gest];FSo=[FSo; [max(gest), min(gest), mean(abs(gest)), var(gest), rms(gest)]];
            clear gest;
            
            g1=filtfilt(H1.sosMatrix, H1.ScaleValues,csv_PAH_temp(:,k*2));
            g2= filtfilt(H2.sosMatrix, H2.ScaleValues,g1);
            gest= filtfilt(H3.sosMatrix, H3.ScaleValues,g2);
            PAH=[PAH,gest];PAHo=[PAHo; [max(gest), min(gest), mean(abs(gest)), var(gest), rms(gest)]];
            clear gest;
            
            g1=filtfilt(H1.sosMatrix, H1.ScaleValues,csv_WO_temp(:,k*2));
            g2= filtfilt(H2.sosMatrix, H2.ScaleValues,g1);
            gest= filtfilt(H3.sosMatrix, H3.ScaleValues,g2);
            WO=[WO,gest];WOo=[WOo; [max(gest), min(gest), mean(abs(gest)), var(gest), rms(gest)]];
            clear gest;
            
            %-----------------------------------------------------------------------------------------
            k=3+6;
            g1=filtfilt(H1.sosMatrix, H1.ScaleValues,csv_DT_temp(:,k*2));
            g2= filtfilt(H2.sosMatrix, H2.ScaleValues,g1);
            gest= filtfilt(H3.sosMatrix, H3.ScaleValues,g2);
            DT=[DT,gest];DTo=[DTo; [max(gest), min(gest), mean(abs(gest)), var(gest), rms(gest)]];
            clear gest;
            
            r1=filtfilt(H1.sosMatrix, H1.ScaleValues,csv_rest_temp(:,k*2));
            r2= filtfilt(H2.sosMatrix, H2.ScaleValues,r1);
            rest= filtfilt(H3.sosMatrix, H3.ScaleValues,r2);
            Rest3=[Rest3, rest];Rest3o=[Rest3o; [max(rest), min(rest), mean(abs(rest)), var(rest), rms(rest)]];
            clear rest;
            
            %-----------------------------------------------------------------------------------------
            k=5+12;
            g1=filtfilt(H1.sosMatrix, H1.ScaleValues,csv_WI_temp(:,k*2));
            g2= filtfilt(H2.sosMatrix, H2.ScaleValues,g1);
            gest= filtfilt(H3.sosMatrix, H3.ScaleValues,g2);
            WI=[WI,gest];WIo=[WIo; [max(gest), min(gest), mean(abs(gest)), var(gest), rms(gest)]];
            clear gest;
            
            r1=filtfilt(H1.sosMatrix, H1.ScaleValues,csv_rest_temp(:,k*2));
            r2= filtfilt(H2.sosMatrix, H2.ScaleValues,r1);
            rest= filtfilt(H3.sosMatrix, H3.ScaleValues,r2);
            Rest5=[Rest5, rest];Rest5o=[Rest5o; [max(rest), min(rest), mean(abs(rest)), var(rest), rms(rest)]];
            clear rest;
            
            %-----------------------------------------------------------------------------------------
            k=6+15;
            g1=filtfilt(H1.sosMatrix, H1.ScaleValues,csv_fist_temp(:,k*2));
            g2= filtfilt(H2.sosMatrix, H2.ScaleValues,g1);
            gest= filtfilt(H3.sosMatrix, H3.ScaleValues,g2);
            F=[F,gest];Fo=[Fo; [max(gest), min(gest), mean(abs(gest)), var(gest), rms(gest)]];
            clear gest;
            
            r1=filtfilt(H1.sosMatrix, H1.ScaleValues,csv_rest_temp(:,k*2));
            r2= filtfilt(H2.sosMatrix, H2.ScaleValues,r1);
            rest= filtfilt(H3.sosMatrix, H3.ScaleValues,r2);
            Rest6=[Rest6, rest];Rest6o=[Rest6o; [max(rest), min(rest), mean(abs(rest)), var(rest), rms(rest)]];
            clear rest;
            
            %-----------------------------------------------------------------------------------------
            k=8+21;
            g1=filtfilt(H1.sosMatrix, H1.ScaleValues,csv_point_temp(:,k*2));
            g2= filtfilt(H2.sosMatrix, H2.ScaleValues,g1);
            gest= filtfilt(H3.sosMatrix, H3.ScaleValues,g2);
            P=[P,gest];Po=[Po; [max(gest), min(gest), mean(abs(gest)), var(gest), rms(gest)]];
            clear gest;
            
            g1=filtfilt(H1.sosMatrix, H1.ScaleValues,csv_TU_temp(:,k*2));
            g2= filtfilt(H2.sosMatrix, H2.ScaleValues,g1);
            gest= filtfilt(H3.sosMatrix, H3.ScaleValues,g2);
            TU=[TU,gest];TUo=[TUo; [max(gest), min(gest), mean(abs(gest)), var(gest), rms(gest)]];
            clear gest;
            
            r1=filtfilt(H1.sosMatrix, H1.ScaleValues,csv_rest_temp(:,k*2));
            r2= filtfilt(H2.sosMatrix, H2.ScaleValues,r1);
            rest= filtfilt(H3.sosMatrix, H3.ScaleValues,r2);
            Rest8=[Rest8, rest];Rest8o=[Rest8o; [max(rest), min(rest), mean(abs(rest)), var(rest), rms(rest)]];
            clear rest;
            
%             k=k+4;
%         end
    end
end

% Xtrain= [HP(:,1:35),Rest(:,1:35)]; 
% Ytrain=[];for i=1:35, Ytrain=[Ytrain 1]; end; for i=1:35,  Ytrain=[Ytrain 0]; end;
% 
% Xtest= [HP(:,36:45),Rest(:,36:45)]; 
% Ytest=[];for i=36:45, Ytest=[Ytest 1]; end; for i=36:45,  Ytest=[Ytest 0]; end;
% 
% SVM= fitcsvm(Xtrain',Ytrain);
% KNN= fitcknn(Xtrain',Ytrain);
% 
% Xtraino= [HPo(1:35,:);Resto(1:35,:)]; 
% Ytraino=[];for i=1:35, Ytraino=[Ytraino 1]; end; for i=1:35,  Ytraino=[Ytraino 0]; end;
% 
% Xtesto= [HPo(36:45,:);Resto(36:45,:)]; 
% Ytesto=[];for i=36:45, Ytesto=[Ytesto 1]; end; for i=36:45,  Ytesto=[Ytesto 0]; end;
% 
% SVMo= fitcsvm(Xtraino,Ytraino);
% KNNo= fitcknn(Xtraino,Ytraino);
% 
% [labelo,scoreo,costo]=predict(SVMo,Xtesto);
% mean(abs(labelo-Ytesto'))
% 
% [labeloK,scoreoK,costoK]=predict(KNNo,Xtesto);
% mean(abs(labeloK-Ytesto'))

%-----------------------------------------------------------------------------------------------------------------------------------
% XAll=[HP,Rest];YAll=[]; for i=1:length(HP(1,:)), YAll=[YAll,1]; end; for i=1:length(Rest(1,:)), YAll=[YAll, 0]; end;
% 
% index= randperm(length(XAll(1,:))); xall= XAll(:,index); yall= YAll(index);
% [kdata,kclass,drem]=Kfold(xall', yall,5);
% 
% for i=1: length(kclass(1,:))    
%     Xt=kdata(:,:,i);Yt=kclass(:,i);
%     X=[];Y=[];
%     for j=1:length(kclass(1,:))
%         if j~=i         
%             X= [X;kdata(:,:,j)];
%             Y= [Y;kclass(:,j)];
%         end
%     end
%     S=fitcsvm(X,Y);
%     cl= predict(S,Xt);
%     accSa(i)=1-mean(abs(cl-Yt));
%     
%     K=fitcknn(X,Y);
%     cl= predict(K,Xt);
%     accKa(i)= 1-mean(abs(cl-Yt));
%     clear S cl K Xt Yt;
% end

% ----------------------------------
% XAllo=[HPo;Resto];YAllo=[]; for i=1:length(HPo(:,1)), YAllo=[YAllo,1]; end; for i=1:length(Resto(:,1)), YAllo=[YAllo, 0]; end;
% 
% index= randperm(length(XAllo(:,1))); xallo= XAllo(index,:); yallo= YAllo(index);
% [kdata,kclass,drem]=Kfold(xallo, yallo,5);
% 
% for i=1: length(kclass(1,:))    
%     Xt=kdata(:,:,i);Yt=kclass(:,i);
%     X=[];Y=[];
%     for j=1:length(kclass(1,:))
%         if j~=i         
%             X= [X;kdata(:,:,j)];
%             Y= [Y;kclass(:,j)];
%         end
%     end
%     S=fitcsvm(X,Y);
%     cl= predict(S,Xt);
%     accS(i)=1-mean(abs(cl-Yt));
%     
%     K=fitcknn(X,Y);
%     cl= predict(K,Xt);
%     accK(i)= 1-mean(abs(cl-Yt));
%     clear S cl K Xt Yt;
% end
% 
% XAllP=[PUB,Rest];YAllP=[]; for i=1:length(PUB(1,:)), YAllP=[YAllP,1]; end; for i=1:length(Rest(1,:)), YAllP=[YAllP, 0]; end;
% 
% index= randperm(length(XAllP(1,:))); xallP= XAllP(:,index); yallP= YAllP(index);
% [kdata,kclass,drem]=Kfold(xallP', yallP,5);
% 
% for i=1: length(kclass(1,:))    
%     Xt=kdata(:,:,i);Yt=kclass(:,i);
%     X=[];Y=[];
%     for j=1:length(kclass(1,:))
%         if j~=i         
%             X= [X;kdata(:,:,j)];
%             Y= [Y;kclass(:,j)];
%         end
%     end
%     S=fitcsvm(X,Y);
%     cl= predict(S,Xt);
%     accSaP(i)=1-mean(abs(cl-Yt));
%     
%     K=fitcknn(X,Y);
%     cl= predict(K,Xt);
%     accKaP(i)= 1-mean(abs(cl-Yt));
%     clear S cl K Xt Yt;
% end
% 
% % ----------------------------------
% XAllPo=[PUBo;Resto];YAllPo=[]; for i=1:length(PUBo(:,1)), YAllPo=[YAllPo,1]; end; for i=1:length(Resto(:,1)), YAllPo=[YAllPo, 0]; end;
% 
% index= randperm(length(XAllPo(:,1))); xallPo= XAllPo(index,:); yallPo= YAllPo(index);
% [kdata,kclass,drem]=Kfold(xallPo, yallPo,5);
% 
% for i=1: length(kclass(1,:))    
%     Xt=kdata(:,:,i);Yt=kclass(:,i);
%     X=[];Y=[];
%     for j=1:length(kclass(1,:))
%         if j~=i         
%             X= [X;kdata(:,:,j)];
%             Y= [Y;kclass(:,j)];
%         end
%     end
%     S=fitcsvm(X,Y);
%     cl= predict(S,Xt);
%     accSP(i)=1-mean(abs(cl-Yt));
%     
%     K=fitcknn(X,Y);
%     cl= predict(K,Xt);
%     accKP(i)= 1-mean(abs(cl-Yt));
%     clear S cl K Xt Yt;
% end

KF=5;
XAllo=[DTo;Rest3o];YAllo=[]; for i=1:length(DTo(:,1)), YAllo=[YAllo,1]; end; for i=1:length(Rest3o(:,1)), YAllo=[YAllo, 0]; end;
index= randperm(length(XAllo(:,1))); xallo= XAllo(index,:); yallo= YAllo(index);
[kdata,kclass,drem]=Kfold(xallo, yallo,KF);
kdataA{1}=kdata; kclassA{1}=kclass;
clear kdata kclass;

XAllo=[FSo;Resto];YAllo=[]; for i=1:length(FSo(:,1)), YAllo=[YAllo,1]; end; for i=1:length(Resto(:,1)), YAllo=[YAllo, 0]; end;
index= randperm(length(XAllo(:,1))); xallo= XAllo(index,:); yallo= YAllo(index);
[kdata,kclass,drem]=Kfold(xallo, yallo,KF);
kdataA{2}=kdata; kclassA{2}=kclass;
clear kdata kclass;

XAllo=[Fo;Rest6o];YAllo=[]; for i=1:length(Fo(:,1)), YAllo=[YAllo,1]; end; for i=1:length(Rest6o(:,1)), YAllo=[YAllo, 0]; end;
index= randperm(length(XAllo(:,1))); xallo= XAllo(index,:); yallo= YAllo(index);
[kdata,kclass,drem]=Kfold(xallo, yallo,KF);
kdataA{3}=kdata; kclassA{3}=kclass;
clear kdata kclass;

XAllo=[HPo;Resto];YAllo=[]; for i=1:length(HPo(:,1)), YAllo=[YAllo,1]; end; for i=1:length(Resto(:,1)), YAllo=[YAllo, 0]; end;
index= randperm(length(XAllo(:,1))); xallo= XAllo(index,:); yallo= YAllo(index);
[kdata,kclass,drem]=Kfold(xallo, yallo,KF);
kdataA{4}=kdata; kclassA{4}=kclass;
clear kdata kclass;

XAllo=[PUBo;Resto];YAllo=[]; for i=1:length(PUBo(:,1)), YAllo=[YAllo,1]; end; for i=1:length(Resto(:,1)), YAllo=[YAllo, 0]; end;
index= randperm(length(XAllo(:,1))); xallo= XAllo(index,:); yallo= YAllo(index);
[kdata,kclass,drem]=Kfold(xallo, yallo,KF);
kdataA{5}=kdata; kclassA{5}=kclass;
clear kdata kclass;

XAllo=[PAHo;Resto];YAllo=[]; for i=1:length(PAHo(:,1)), YAllo=[YAllo,1]; end; for i=1:length(Resto(:,1)), YAllo=[YAllo, 0]; end;
index= randperm(length(XAllo(:,1))); xallo= XAllo(index,:); yallo= YAllo(index);
[kdata,kclass,drem]=Kfold(xallo, yallo,KF);
kdataA{6}=kdata; kclassA{6}=kclass;
clear kdata kclass;

XAllo=[Po;Rest8o];YAllo=[]; for i=1:length(Po(:,1)), YAllo=[YAllo,1]; end; for i=1:length(Rest8o(:,1)), YAllo=[YAllo, 0]; end;
index= randperm(length(XAllo(:,1))); xallo= XAllo(index,:); yallo= YAllo(index);
[kdata,kclass,drem]=Kfold(xallo, yallo,KF);
kdataA{7}=kdata; kclassA{7}=kclass;
clear kdata kclass;

XAllo=[TUo;Rest8o];YAllo=[]; for i=1:length(TUo(:,1)), YAllo=[YAllo,1]; end; for i=1:length(Rest8o(:,1)), YAllo=[YAllo, 0]; end;
index= randperm(length(XAllo(:,1))); xallo= XAllo(index,:); yallo= YAllo(index);
[kdata,kclass,drem]=Kfold(xallo, yallo,KF);
kdataA{8}=kdata; kclassA{8}=kclass;
clear kdata kclass;

XAllo=[WIo;Rest5o];YAllo=[]; for i=1:length(WIo(:,1)), YAllo=[YAllo,1]; end; for i=1:length(Rest5o(:,1)), YAllo=[YAllo, 0]; end;
index= randperm(length(XAllo(:,1))); xallo= XAllo(index,:); yallo= YAllo(index);
[kdata,kclass,drem]=Kfold(xallo, yallo,KF);
kdataA{9}=kdata; kclassA{9}=kclass;
clear kdata kclass;

XAllo=[WOo;Resto];YAllo=[]; for i=1:length(WOo(:,1)), YAllo=[YAllo,1]; end; for i=1:length(Resto(:,1)), YAllo=[YAllo, 0]; end;
index= randperm(length(XAllo(:,1))); xallo= XAllo(index,:); yallo= YAllo(index);
[kdata,kclass,drem]=Kfold(xallo, yallo,KF);
kdataA{10}=kdata; kclassA{10}=kclass;
clear kdata kclass;


for k=1:length(kclassA)
    kdata= kdataA{k}; kclass=kclassA{k};
    for i=1: length(kclass(1,:))    
        Xt=kdata(:,:,i);Yt=kclass(:,i);
        X=[];Y=[];
        for j=1:length(kclass(1,:))
            if j~=i         
                X= [X;kdata(:,:,j)];
                Y= [Y;kclass(:,j)];
            end
        end
        S=fitcsvm(X,Y);
        cl= predict(S,Xt);
        accS(k,i)=1-mean(abs(cl-Yt));

        K=fitcknn(X,Y);
        cl= predict(K,Xt);
        accK(k,i)= 1-mean(abs(cl-Yt));
        clear S cl K Xt Yt;
    end
end

%% --------------------------------------------------------------------------------

KF=5;
XAll=[DT,Rest3];YAll=[]; for i=1:length(DT(1,:)), YAll=[YAll,1]; end; for i=1:length(Rest3(1,:)), YAll=[YAll, 0]; end;
index= randperm(length(XAll(1,:))); xall= XAll(:,index); yall= YAll(index);
[kdata,kclass,drem]=Kfold(xall', yall,KF);
kdataAa{1}=kdata; kclassAa{1}=kclass;
clear kdata kclass;

XAll=[FS,Rest];YAll=[]; for i=1:length(FS(1,:)), YAll=[YAll,1]; end; for i=1:length(Rest(1,:)), YAll=[YAll, 0]; end;
index= randperm(length(XAll(1,:))); xall= XAll(:,index); yall= YAll(index);
[kdata,kclass,drem]=Kfold(xall', yall,KF);
kdataAa{2}=kdata; kclassAa{2}=kclass;
clear kdata kclass;

XAll=[F,Rest6];YAll=[]; for i=1:length(F(1,:)), YAll=[YAll,1]; end; for i=1:length(Rest6(1,:)), YAll=[YAll, 0]; end;
index= randperm(length(XAll(1,:))); xall= XAll(:,index); yall= YAll(index);
[kdata,kclass,drem]=Kfold(xall', yall,KF);
kdataAa{3}=kdata; kclassAa{3}=kclass;
clear kdata kclass;

XAll=[HP,Rest];YAll=[]; for i=1:length(HP(1,:)), YAll=[YAll,1]; end; for i=1:length(Rest(1,:)), YAll=[YAll, 0]; end;
index= randperm(length(XAll(1,:))); xall= XAll(:,index); yall= YAll(index);
[kdata,kclass,drem]=Kfold(xall', yall,KF);
kdataAa{4}=kdata; kclassAa{4}=kclass;
clear kdata kclass;

XAll=[PUB,Rest];YAll=[]; for i=1:length(PUB(1,:)), YAll=[YAll,1]; end; for i=1:length(Rest(1,:)), YAll=[YAll, 0]; end;
index= randperm(length(XAll(1,:))); xall= XAll(:,index); yall= YAll(index);
[kdata,kclass,drem]=Kfold(xall', yall,KF);
kdataAa{5}=kdata; kclassAa{5}=kclass;
clear kdata kclass;

XAll=[PAH,Rest];YAll=[]; for i=1:length(PAH(1,:)), YAll=[YAll,1]; end; for i=1:length(Rest(1,:)), YAll=[YAll, 0]; end;
index= randperm(length(XAll(1,:))); xall= XAll(:,index); yall= YAll(index);
[kdata,kclass,drem]=Kfold(xall', yall,KF);
kdataAa{6}=kdata; kclassAa{6}=kclass;
clear kdata kclass;

XAll=[P,Rest8];YAll=[]; for i=1:length(P(1,:)), YAll=[YAll,1]; end; for i=1:length(Rest8(1,:)), YAll=[YAll, 0]; end;
index= randperm(length(XAll(1,:))); xall= XAll(:,index); yall= YAll(index);
[kdata,kclass,drem]=Kfold(xall', yall,KF);
kdataAa{7}=kdata; kclassAa{7}=kclass;
clear kdata kclass;

XAll=[TU,Rest8];YAll=[]; for i=1:length(TU(1,:)), YAll=[YAll,1]; end; for i=1:length(Rest8(1,:)), YAll=[YAll, 0]; end;
index= randperm(length(XAll(1,:))); xall= XAll(:,index); yall= YAll(index);
[kdata,kclass,drem]=Kfold(xall', yall,KF);
kdataAa{8}=kdata; kclassAa{8}=kclass;
clear kdata kclass;

XAll=[WI,Rest5];YAll=[]; for i=1:length(WI(1,:)), YAll=[YAll,1]; end; for i=1:length(Rest5(1,:)), YAll=[YAll, 0]; end;
index= randperm(length(XAll(1,:))); xall= XAll(:,index); yall= YAll(index);
[kdata,kclass,drem]=Kfold(xall', yall,KF);
kdataAa{9}=kdata; kclassAa{9}=kclass;
clear kdata kclass;

XAll=[WO,Rest];YAll=[]; for i=1:length(WO(1,:)), YAll=[YAll,1]; end; for i=1:length(Rest(1,:)), YAll=[YAll, 0]; end;
index= randperm(length(XAll(1,:))); xall= XAll(:,index); yall= YAll(index);
[kdata,kclass,drem]=Kfold(xall', yall,KF);
kdataAa{10}=kdata; kclassAa{10}=kclass;
clear kdata kclass;


for k=1:length(kclassAa)
    kdata= kdataAa{k}; kclass=kclassAa{k};
    for i=1: length(kclass(1,:))    
        Xt=kdata(:,:,i);Yt=kclass(:,i);
        X=[];Y=[];
        for j=1:length(kclass(1,:))
            if j~=i         
                X= [X;kdata(:,:,j)];
                Y= [Y;kclass(:,j)];
            end
        end
        S=fitcsvm(X,Y);
        cl= predict(S,Xt);
        accSa(k,i)=1-mean(abs(cl-Yt));

        K=fitcknn(X,Y);
        cl= predict(K,Xt);
        accKa(k,i)= 1-mean(abs(cl-Yt));
        clear S cl K Xt Yt;
    end
end
