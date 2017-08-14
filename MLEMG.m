clear all;
close all; 
clc;
folder= 'C:\Users\kanalvxx\Desktop\HCI\EMG\EMG DATA FULL Final\EMG Study Readings\Sub';
PUB=[]; Rest=[]; HP=[]; DT=[];
Resto=[];PUBo=[];HPo=[]; DTo=[];
for i=1:15
    for j=1:3
        load([folder,' ',num2str(i),'\D\D-',num2str(i),'_Half_Pinch_',num2str(j)]);
        load([folder,' ',num2str(i),'\D\D-',num2str(i),'_Pick_Up_Block_',num2str(j)]);
        load([folder,' ',num2str(i),'\D\D-',num2str(i),'_rest_',num2str(j)]);
        load([folder,' ',num2str(i),'\D\D-',num2str(i),'_Double_Tap_',num2str(j)]);
        k=1;
%         while k<30

            X=csv_rest_temp(:,1*2);Rest=[Rest, X]; Resto=[Resto; [max(X), min(X), mean(abs(X)), var(X), rms(X)]];
            X=csv_PUB_temp(:,1*2);PUB= [PUB, X];PUBo=[PUBo; [max(X), min(X), mean(abs(X)), var(X), rms(X)]];
            X=csv_HP_temp(:,1*2);HP=[HP,X];HPo=[HPo; [max(X), min(X), mean(X), var(abs(X)), rms(X)]];
            
            X=csv_DT_temp(:,9*2);DT=[DT,X];DTo=[DTo; [max(X), min(X), mean(X), var(abs(X)), rms(X)]];
%             k=k+4;
%         end
    end
end

% Xtrain= [HP(:,1:300),Rest(:,1:300)]; 
% Ytrain=[];for i=1:300, Ytrain=[Ytrain 1]; end; for i=1:300,  Ytrain=[Ytrain 0]; end;
% 
% Xtest= [HP(:,301:360),Rest(:,301:360)]; 
% Ytest=[];for i=301:360, Ytest=[Ytest 1]; end; for i=301:360,  Ytest=[Ytest 0]; end;
% 
% XAll=[HP,Rest];YAll=[]; for i=1:length(HP(1,:)), YAll=[YAll,1]; end; for i=1:length(Rest(1,:)), YAll=[YAll, 0]; end;
% 
% SVM= fitcsvm(Xtrain',Ytrain);
% KNN= fitcknn(Xtrain',Ytrain);
% 
% SVMAll= fitcsvm(XAll',YAll);
% 
% Xtrain= [HP(:,1:35),Rest(:,1:35)]; 
% Ytrain=[];for i=1:35, Ytrain=[Ytrain 1]; end; for i=1:35,  Ytrain=[Ytrain 0]; end;
% 
% Xtest= [HP(:,36:45),Rest(:,36:45)]; 
% Ytest=[];for i=36:45, Ytest=[Ytest 1]; end; for i=36:45,  Ytest=[Ytest 0]; end;
% 
% XtrainP= [PUB(2000:end,1:35),Rest(2000:end,1:35)]; 
% YtrainP=[];for i=1:35, YtrainP=[YtrainP 1]; end; for i=1:35,  YtrainP=[YtrainP 0]; end;
% 
% XtestP= [PUB(2000:end,36:45),Rest(2000:end,36:45)]; 
% YtestP=[];for i=36:45, YtestP=[YtestP 1]; end; for i=36:45,  YtestP=[YtestP 0]; end;
% 
% SVMP= fitcsvm(XtrainP',YtrainP);
% KNNP= fitcknn(XtrainP',YtrainP);
% 
% [labelP,scoreP,costP]=predict(SVMP,XtestP');
% mean(abs(labelP-YtestP'))
% 
% [labelPK,scorePK,costPK]=predict(KNNP,XtestP');
% mean(abs(labelPK-YtestP'))
% 
% 
% XtrainDT= [DT(:,1:35),Rest(:,1:35)]; 
% YtrainDT=[];for i=1:35, YtrainDT=[YtrainDT 1]; end; for i=1:35,  YtrainDT=[YtrainDT 0]; end;
% 
% XtestDT= [DT(:,36:45),Rest(:,36:45)]; 
% YtestDT=[];for i=36:45, YtestDT=[YtestDT 1]; end; for i=36:45,  YtestDT=[YtestDT 0]; end;
% 
% 
% SVMDT= fitcsvm(XtrainDT',YtrainDT);
% KNNDT= fitcknn(XtrainDT',YtrainDT);
% 
% [labelDT,scoreDT,costDT]=predict(SVMDT,XtestDT');
% mean(abs(labelDT-YtestDT'))
% 
% [labelDTK,scoreDTK,costDTK]=predict(KNNDT,XtestDT');
% mean(abs(labelDTK-YtestDT'))
% 
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
% 
% [labelo,scoreo,costo]=predict(SVMo,Xtesto);
% mean(abs(labelo-Ytesto'))
% 
% [labeloK,scoreoK,costoK]=predict(KNNo,Xtesto);
% mean(abs(labeloK-Ytesto'))
% 
% 
% 
% x = XAll;
% t = YAll;
% trainFcn = 'trainscg';
% hiddenLayerSize = 10;
% net = fitnet(hiddenLayerSize,trainFcn);
% net.divideParam.trainRatio = 70/100;
% net.divideParam.valRatio = 15/100;
% net.divideParam.testRatio = 15/100;
% [net,tr] = train(net,x,t);
% y=net(Xtest);
% e=gsubtract(Ytest,y);
% performance=perform(net,Ytest,y);

XAll=[HP,Rest];YAll=[]; for i=1:length(HP(1,:)), YAll=[YAll,1]; end; for i=1:length(Rest(1,:)), YAll=[YAll, 0]; end;

index= randperm(length(XAll(1,:))); xall= XAll(:,index); yall= YAll(index);
[kdata,kclass,drem]=Kfold(xall', yall,10);

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
    accSa(i)=1-mean(abs(cl-Yt));
    
    K=fitcknn(X,Y);
    cl= predict(K,Xt);
    accKa(i)= 1-mean(abs(cl-Yt));
    clear S cl K Xt Yt;
end

% ----------------------------------
XAllo=[HPo;Resto];YAllo=[]; for i=1:length(HPo(:,1)), YAllo=[YAllo,1]; end; for i=1:length(Resto(:,1)), YAllo=[YAllo, 0]; end;

index= randperm(length(XAllo(:,1))); xallo= XAllo(index,:); yallo= YAllo(index);
[kdata,kclass,drem]=Kfold(xallo, yallo,10);

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
    accS(i)=1-mean(abs(cl-Yt));
    
    K=fitcknn(X,Y);
    cl= predict(K,Xt);
    accK(i)= 1-mean(abs(cl-Yt));
    clear S cl K Xt Yt;
end

