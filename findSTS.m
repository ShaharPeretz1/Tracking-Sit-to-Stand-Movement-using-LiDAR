function [labelVals,labelLocs,num_sections] = findSTS(raw_signal,time)
  
    labelVals = cell(3,1); 
    labelLocs = cell(3,1); % [indeces]

    window = 5;
    %% low pass filter
    filtered_signal = smoothdata(raw_signal,30,"gaussian");
%% 
    % calculate the first derivetive of the signal to extract the locations
    % where the signal decreases and where it increases
    diff_sig = movmedian(diff(filtered_signal),window);
    up_locs = find(diff_sig<0);
    down_locs = find(diff_sig>0);

    idx_up=diff(up_locs);
    gaps_up=unique([find(idx_up>1)' ;numel(up_locs)]);
    ii1=[1 ;gaps_up(1:end-1)+1];
    out_up=arrayfun(@(x,y) up_locs(x:y),ii1,gaps_up,'un',0);
    
    idx_down=diff(down_locs);
    gaps_down=unique([find(idx_down>1)' ;numel(down_locs)]);
    ii2=[1 ;gaps_down(1:end-1)+1];
    out_down=arrayfun(@(x,y) down_locs(x:y),ii2,gaps_down,'un',0);

    STS_up_loc = [];
    STS_up_locs = []; % a matrix that saves the locations where the subject went up (sit to stand). 
                     % Each row is a different sit-to-stand movement 
                     % The first instant is the begining of the movement and the second instant is where the movement ended.
    STS_down_loc = []; % same idea only here we ware tracking where the subject went down (stand to sit)
    [yupper,ylower]=envelope(raw_signal);
    limit = 17; %mean(yupper) - mean(ylower)- 0.2*mean(mean(yupper),mean(ylower));
    for i=1:length(out_up)
        % take out all elements which their distance in y axis is lower
        % then the limit and their length is below 0.2
        if filtered_signal(out_up{i}(1))-filtered_signal(out_up{i}(end))>=limit && time(out_up{i}(end))-time(out_up{i}(1))>=0.2
            STS_up_loc = [STS_up_loc;out_up{i}(1),out_up{i}(end)];
        end
    end
    for i=1:length(out_down)
        if filtered_signal(out_down{i}(1))-filtered_signal(out_down{i}(end))>=limit && time(out_down{i}(end))-time(out_down{i}(1))>=0.2
            STS_down_loc = [STS_down_loc;out_down{i}(1),out_down{i}(end)];
        end
    end
    

    STS_up = repmat("STS_up",size(STS_up_loc,1),1);

%     figure()
%     plot(time,filtered_signal)
%     xline([time(STS_up_loc(:,1))',time(STS_up_loc(:,2))'],'-r',[STS_up',STS_up'])
%     
    range = 15;
    for row=1:length(STS_up_loc(:,1))
        % take out all elements that the median of the values in the range before them are not higher then the values in the range after them
        % and if two adjusent elements are closer then 5 sec to each other
        if row~=length(STS_up_loc(:,1)) 
            if STS_up_loc(row,1)-range>0 && STS_up_loc(row,2)+range<length(filtered_signal) && time(STS_up_loc(row+1,1))-time(STS_up_loc(row,2))>5
                if median(filtered_signal(STS_up_loc(row,1)-range:STS_up_loc(row,1)))>median(filtered_signal(STS_up_loc(row,2):STS_up_loc(row,2)+range))
                    STS_up_locs = [STS_up_locs;STS_up_loc(row,1)-range,STS_up_loc(row,2)+range];
                end
            else
                STS_up_locs = [STS_up_locs;STS_up_loc(row,1),STS_up_loc(row,2)];
            end
        elseif row==length(STS_up_loc(:,1)) && length(STS_up_loc(:,1))>1
            if STS_up_loc(row,1)-range>0 && STS_up_loc(row,2)+range<length(filtered_signal) && time(STS_up_loc(row,1))-time(STS_up_loc(row-1,2))>5
                if median(filtered_signal(STS_up_loc(row,1)-range:STS_up_loc(row,1)))>median(filtered_signal(STS_up_loc(row,2):STS_up_loc(row,2)+range))
                    STS_up_locs = [STS_up_locs;STS_up_loc(row,1)-range,STS_up_loc(row,2)+range];
                end
            end
        else 
            if STS_up_loc(row,1)-range>0 && STS_up_loc(row,2)+range<length(filtered_signal)
                if median(filtered_signal(STS_up_loc(row,1)-range:STS_up_loc(row,1)))>median(filtered_signal(STS_up_loc(row,2):STS_up_loc(row,2)+range))
                    STS_up_locs = [STS_up_locs;STS_up_loc(row,1)-range,STS_up_loc(row,2)+range];
                end
            end
        end
    end


    for row=2:length(STS_up_locs(:,1))
        if STS_up_locs(row,1)-STS_up_locs(row-1,2)<100
            if STS_up_locs(row,2)-STS_up_locs(row-1,1)<200
                STS_up_locs(row,:) = [STS_up_locs(row-1,1),STS_up_locs(row,2)];
                STS_up_locs(row-1,:) = [0, 0];
            else
                STS_up_locs(row-1,:) = [0, 0];
            end
        end
    end
    STS_up_locs(all(STS_up_locs==0,2),:) = [];

    STS_up = repmat("STS_up",size(STS_up_locs,1),1);
    STS_down = repmat("STS_down",size(STS_down_loc,1),1);
    
    % figure()
    % plot(time,raw_signal)
    % xline([time(STS_up_locs(:,1))',time(STS_up_locs(:,2))'],'-r',[STS_up',STS_up'])


    labelLocs = [STS_up_locs;STS_down_loc];
    labelVals = [STS_up;STS_down];
    num_sections = size(labelLocs,1);
end

