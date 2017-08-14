function [kdata,kclass,drem]=Kfold(data,class,k)
    if k>1
        %% ------ To Make Number of Data In All Sets Equal --------%
        if mod(length(data(:,1)),k)~=0
            torem= randperm(length(data(:,1)),mod(length(data(:,1)),k));
            for i=1:length(torem)
                drem(i,:)=data(i,:);
            end
            data(torem,:)=[];
        else
            drem=NaN(1);
        end
        %% ------ To Divide the Data into Sets ------%
        numb=(length(data(:,1))/k);
        for i=1:k
            div=randperm(length(data(:,1)),numb);
            kdata(:,:,i)= data(div,:);
            kclass(:,i)= class(div);
            data(div,:)=[];class(div)=[];
        end
    elseif k==1
        %% -------- To Handle 1 Fold -------%
        drem=NaN(1);
        for start=1:length(data(:,1))
            poss=1;
            for i=1:length(data(:,1))
                if i~=start
                    kdata(poss,:,start)=data(i,:);
                    kclass(poss,:,start)=class(i);
                    poss=poss+1;
                end
            end
        end
    else
        %% ------ To Handle Wrong Input -----%
        error('K has to be 1 or Greater');
    end
end