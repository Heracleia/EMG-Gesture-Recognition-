clear all;close all; clc;
folder= 'C:\Users\kanalvxx\Desktop\HCI\EMG\EMG DATA FULL Final\EMG Study Readings';
load([folder,'\MYO_EMG_REST.mat']);
KN=5;
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

for a=1:10
    
    switch(a)
        case 1
            load([folder,'\MYO_EMG_DT.mat']);
            X1=MYO_EMG_DT;k=2;
        case 2
            load([folder,'\MYO_EMG_FS.mat']);
            X1=MYO_EMG_FS;k=1;
        case 3
            load([folder,'\MYO_EMG_FIST.mat']);
            X1=MYO_EMG_FIST;k=2;
        case 4
            load([folder,'\MYO_EMG_HP.mat']);
            X1=MYO_EMG_HP;k=1;
        case 5 
            load([folder,'\MYO_EMG_PUB.mat']);
            X1=MYO_EMG_PUB;k=1;
        case 6
            load([folder,'\MYO_EMG_PAH.mat']);
            X1=MYO_EMG_PAH;k=1;
        case 7
            load([folder,'\MYO_EMG_POINT.mat']);
            X1=MYO_EMG_POINT;k=7;
        case 8
            load([folder,'\MYO_EMG_TU.mat']);
            X1=MYO_EMG_TU;k=8;
        case 9
            load([folder,'\MYO_EMG_WI.mat']);
            X1=MYO_EMG_WI;k=1;
        case 10
            load([folder,'\MYO_EMG_WO.mat']);
            X1=MYO_EMG_WO;k=1;
    end
    
%     load([folder,'\MYO_EMG_HP.mat']);
%     X1=MYO_EMG_HP;k=1;

    num=[X1(1,1),X1(1,1)+1,X1(1,1)+2];
    j=1;tempfile=[];
    firsta={};f=1;
    seconda={};s=1;
    thirda={};t=1;
    for i=1:length(X1(:,1))
        if j==1
            if X1(i+1,1)== num(j)
                tempfile=[tempfile;X1(i,:)];
            else
                tempfile=[tempfile;X1(i,:)];
                firsta{f}=tempfile;f=f+1; tempfile=[];
                j=2;
            end
        elseif j==2
            if X1(i+1,1)== num(j)
                tempfile=[tempfile;X1(i,:)];
            else
                tempfile=[tempfile;X1(i,:)];
                seconda{s}=tempfile;s=s+1; tempfile=[];
                j=3;
            end
        else
            if i~=length(X1(:,1))
                if X1(i+1,1)== num(j)
                    tempfile=[tempfile;X1(i,:)];
                else
                    tempfile=[tempfile;X1(i,:)];
                    thirda{t}=tempfile;t=t+1; tempfile=[];
                    j=1;
                end
            else
                tempfile=[tempfile;X1(i,:)];
                thirda{t}=tempfile;t=t+1; tempfile=[];
            end
        end
    end

    gest=[]; rest=[];
    for i=1: length(firsta)
        temp1=firsta{i}; temp2=seconda{i}; temp3=thirda{i};
        rtemp1=rfirst{i}; rtemp2=rsecond{i}; rtemp3=rthird{i};
        if (isempty(gest))
            m=min([length(temp1(:,1)),length(temp2(:,1)),length(temp3(:,1)),length(rtemp1(:,1)),length(rtemp2(:,1)),length(rtemp3(:,1))]);
            gest=[temp1(1:m,k+5),temp2(1:m,k+5),temp3(1:m,k+5)];
            rest=[rtemp1(1:m,k+5),rtemp2(1:m,k+5),rtemp3(1:m,k+5)];
        else
            m=min([length(gest(:,1)),length(temp1(:,1)),length(temp2(:,1)),length(temp3(:,1)),length(rtemp1(:,1)),length(rtemp2(:,1)),length(rtemp3(:,1))]);
            if m~=length(gest(:,1))
                gest=gest(1:m,:);rest=rest(1:m,:);
            end
            gest=[gest,temp1(1:m,k+5),temp2(1:m,k+5),temp3(1:m,k+5)];
            rest=[gest,rtemp1(1:m,k+5),rtemp2(1:m,k+5),rtemp3(1:m,k+5)];

        end
    end

    XAlla=[gest,rest]; YAlla=[]; for i=1:length(gest(1,:)), YAlla=[YAlla,1]; end; for i=1:length(rest(1,:)), YAlla=[YAlla, 0]; end;

    index= randperm(length(XAlla(1,:))); xall= XAlla(:,index); yall= YAlla(index);
    [kdata,kclass,drem]=Kfold(xall', yall,KN);

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
        accSa(a,i)=1-mean(abs(cl-Yt));

        K=fitcknn(X,Y);
        cl= predict(K,Xt);
        accKa(a,i)= 1-mean(abs(cl-Yt));
        clear S cl K Xt Yt;
    end
    clear XAll;
end
% load([folder,'\MYO_EMG_PUB.mat']);
% X2=MYO_EMG_PUB;
%------------------------------------------------------------------------------------------------
% num=[X1(1,1),X1(1,1)+1,X1(1,1)+2];
% j=1;tempfile=[];
% first={};f=1;
% second={};s=1;
% third={};t=1;
% for i=1:length(X1(:,1))
%     if j==1
%         if X1(i+1,1)== num(j)
%             tempfile=[tempfile;X1(i,:)];
%         else
%             tempfile=[tempfile;X1(i,:)];
%             first{f}=tempfile;f=f+1; tempfile=[];
%             j=2;
%         end
%     elseif j==2
%         if X1(i+1,1)== num(j)
%             tempfile=[tempfile;X1(i,:)];
%         else
%             tempfile=[tempfile;X1(i,:)];
%             second{s}=tempfile;s=s+1; tempfile=[];
%             j=3;
%         end
%     else
%         if i~=length(X1(:,1))
%             if X1(i+1,1)== num(j)
%                 tempfile=[tempfile;X1(i,:)];
%             else
%                 tempfile=[tempfile;X1(i,:)];
%                 third{t}=tempfile;t=t+1; tempfile=[];
%                 j=1;
%             end
%         else
%             tempfile=[tempfile;X1(i,:)];
%             third{t}=tempfile;t=t+1; tempfile=[];
%         end
%     end
% end
% 
% gestP=[]; restP=[];
% for i=1: length(first)
%     tempP1=first{i}; tempP2=second{i}; tempP3=third{i};
%     rtempP1=rfirst{i}; rtempP2=rsecond{i}; rtempP3=rthird{i};
%     if (isempty(gestP))
%         m=min([length(tempP1(:,1)),length(tempP2(:,1)),length(tempP3(:,1)),length(rtempP1(:,1)),length(rtempP2(:,1)),length(rtempP3(:,1))]);
%         gestP=[tempP1(1:m,6),tempP2(1:m,6),tempP3(1:m,6)];
%         restP=[rtempP1(1:m,6),rtempP2(1:m,6),rtempP3(1:m,6)];
%     else
%         m=min([length(gestP(:,1)),length(tempP1(:,1)),length(tempP2(:,1)),length(tempP3(:,1)),length(rtempP1(:,1)),length(rtempP2(:,1)),length(rtempP3(:,1))]);
%         if m~=length(gestP(:,1))
%             gestP=gestP(1:m,:);restP=restP(1:m,:);
%         end
%         gestP=[gestP,tempP1(1:m,6),tempP2(1:m,6),tempP3(1:m,6)];
%         restP=[gestP,rtempP1(1:m,6),rtempP2(1:m,6),rtempP3(1:m,6)];
%         
%     end
% end
% 
% XAllP=[gestP,restP]; YAllP=[]; for i=1:length(gestP(1,:)), YAllP=[YAllP,1]; end; for i=1:length(restP(1,:)), YAllP=[YAllP, 0]; end;
% 
% index= randperm(length(XAllP(1,:))); xallP= XAllP(:,index); yallP= YAllP(index);
% [kdata,kclass,drem]=Kfold(xallP', yallP,10);
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

%% ----------------------------------------------------------------------------------------------------------------

for a=1:10
    
    switch(a)
        case 1
            load([folder,'\MYO_EMG_DT.mat']);
            X1=MYO_EMG_DT;k=2;
        case 2
            load([folder,'\MYO_EMG_FS.mat']);
            X1=MYO_EMG_FS;k=1;
        case 3
            load([folder,'\MYO_EMG_FIST.mat']);
            X1=MYO_EMG_FIST;k=2;
        case 4
            load([folder,'\MYO_EMG_HP.mat']);
            X1=MYO_EMG_HP;k=1;
        case 5 
            load([folder,'\MYO_EMG_PUB.mat']);
            X1=MYO_EMG_PUB;k=1;
        case 6
            load([folder,'\MYO_EMG_PAH.mat']);
            X1=MYO_EMG_PAH;k=1;
        case 7
            load([folder,'\MYO_EMG_POINT.mat']);
            X1=MYO_EMG_POINT;k=7;
        case 8
            load([folder,'\MYO_EMG_TU.mat']);
            X1=MYO_EMG_TU;k=8;
        case 9
            load([folder,'\MYO_EMG_WI.mat']);
            X1=MYO_EMG_WI;k=1;
        case 10
            load([folder,'\MYO_EMG_WO.mat']);
            X1=MYO_EMG_WO;k=1;
    end
    
%     load([folder,'\MYO_EMG_HP.mat']);
%     X1=MYO_EMG_HP;k=1;

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

    gest=[]; rest=[];
    for i=1: length(first)
        temp1=first{i}; temp2=second{i}; temp3=third{i};
        rtemp1=rfirst{i}; rtemp2=rsecond{i}; rtemp3=rthird{i};
        gest=[gest,[max(temp1(:,k+5));min(temp1(:,k+5)); mean(abs(temp1(:,k+5))); var(temp1(:,k+5)); rms(temp1(:,k+5))],...
            [max(temp2(:,k+5));min(temp2(:,k+5)); mean(abs(temp2(:,k+5))); var(temp2(:,k+5)); rms(temp2(:,k+5))],...
            [max(temp3(:,k+5));min(temp3(:,k+5)); mean(abs(temp3(:,k+5))); var(temp3(:,k+5)); rms(temp3(:,k+5))]];
        rest=[rest,[max(rtemp1(:,k+5));min(rtemp1(:,k+5)); mean(abs(rtemp1(:,k+5))); var(rtemp1(:,k+5)); rms(rtemp1(:,k+5))],...
            [max(rtemp2(:,k+5));min(rtemp2(:,k+5)); mean(abs(rtemp2(:,k+5))); var(rtemp2(:,k+5)); rms(rtemp2(:,k+5))],...
            [max(rtemp3(:,k+5));min(rtemp3(:,k+5)); mean(abs(rtemp3(:,k+5))); var(rtemp3(:,k+5)); rms(rtemp3(:,k+5))]];
%         if (isempty(gest))
% %             m=min([length(temp1(:,1)),length(temp2(:,1)),length(temp3(:,1)),length(rtemp1(:,1)),length(rtemp2(:,1)),length(rtemp3(:,1))]);
%             gest=[[max(temp1(:,k+5));min(temp1(:,k+5)); mean(abs(temp1(:,k+5))); var(temp1(:,k+5)); rms(temp1(:,k+5))],...
%                 [max(temp2(:,k+5));min(temp2(:,k+5)); mean(abs(temp2(:,k+5))); var(temp2(:,k+5)); rms(temp2(:,k+5))],...
%                 [max(temp3(:,k+5));min(temp3(:,k+5)); mean(abs(temp3(:,k+5))); var(temp3(:,k+5)); rms(temp3(:,k+5))]];
%             rest=[[max(rtemp1(:,k+5));min(rtemp1(:,k+5)); mean(abs(rtemp1(:,k+5))); var(rtemp1(:,k+5)); rms(rtemp1(:,k+5))],...
%                 [max(rtemp2(:,k+5));min(rtemp2(:,k+5)); mean(abs(rtemp2(:,k+5))); var(rtemp2(:,k+5)); rms(rtemp2(:,k+5))],...
%                 [max(rtemp3(:,k+5));min(rtemp3(:,k+5)); mean(abs(rtemp3(:,k+5))); var(rtemp3(:,k+5)); rms(rtemp3(:,k+5))]];
%         else
% %             m=min([length(gest(:,1)),length(temp1(:,1)),length(temp2(:,1)),length(temp3(:,1)),length(rtemp1(:,1)),length(rtemp2(:,1)),length(rtemp3(:,1))]);
% %             if m~=length(gest(:,1))
% %                 gest=gest(1:m,:);rest=rest(1:m,:);
% %             end
%             gest=[gest,temp1(1:m,k+5),temp2(1:m,k+5),temp3(1:m,k+5)];
%             rest=[gest,rtemp1(1:m,k+5),rtemp2(1:m,k+5),rtemp3(1:m,k+5)];
% 
%         end
    end

    XAll=[gest,rest]; YAll=[]; for i=1:length(gest(1,:)), YAll=[YAll,1]; end; for i=1:length(rest(1,:)), YAll=[YAll, 0]; end;

    index= randperm(length(XAll(1,:))); xall= XAll(:,index); yall= YAll(index);
    [kdata,kclass,drem]=Kfold(xall', yall,KN);

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
        accS(a,i)=1-mean(abs(cl-Yt));

        K=fitcknn(X,Y);
        cl= predict(K,Xt);
        accK(a,i)= 1-mean(abs(cl-Yt));
        clear S cl K Xt Yt;
    end
    clear XAll;
end
