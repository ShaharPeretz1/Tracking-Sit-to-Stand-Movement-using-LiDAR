function X_row=Computational_Assumptions(signal,time,varargin)
    num_features = 6;
    % Check if the last input argument is provided
    if ~isempty(varargin)
        BoS = varargin{1};
    else
        % If input3 is not provided, use a default value
        BoS = 0;
    end
    sample_rate = 1/0.1; %[Hz]
    % figure()
    % plot(signal)
    
    X_row=zeros(1,num_features);
    velocity = signal./time';
    % velocity = (max(signal)-min(signal))./time';
    % velocity = (0.95*max(signal)-0.25*max(signal))./time';
    X_row(1)=mean(abs(velocity)); % average of velocity
    % X_row(1)= mean(abs(diff(signal))./ sample_rate); % average of velocity
    acceleration = diff(velocity) ./ (1/sample_rate); % acceleration signal
    X_row(2) = mean(abs(acceleration)); % average of acceleration
    % X_row(2) = mean(abs(diff(diff(signal)))./ sample_rate); % average of acceleration
    X_row(3)=trapz(abs(signal)); %area under the curve 
    negative_vec = (signal-BoS)<0;
    if ~all(negative_vec==0)
        time_negative = time(negative_vec);
        X_row(4)=time_negative(end)-time_negative(1); % measure how long the CoM-BoS was negative [sec]
    else
        X_row(4) = 0;
    end
    X_row(5) = max(time)-min(time);
    X_row(6) = max(signal)-min(signal);
    % X_row(5)=mean(abs(diff(signal(sign(diff(signal))==-1)))); % the averaged trend when it gos downwards
    % [hights,locs]=findpeaks(signal); 
    % if isempty(hights) && isempty(locs)
    %     X_row(6) = 0;
    %     % X_row(7) = 0;
    %     X_row(7) = 0;
    %     X_row(8) = 0;
    % else
    %     X_row(6)=mean(hights)-mean(signal); %the averaged hight of the peaks above the original trend of the signal
    %     % X_row(7)=sum(locs); %the locations on which the peaks are taking place along the signal
    %     X_row(7)=length(locs); %amount of peaks in the signal
    %     X_row(8)=mean(diff(locs)); %distance_between_peaks
    % end

    % X_row(4)=max(acceleration)-min(acceleration);
    % X_row(5)=max(velocity)-min(velocity);

    % X_row(1)=trapz(abs(signal)); 
    % X_row(2)=min(abs(diff(abs(signal)))); 
    % X_row(3)=min(abs(diff(abs(signal),2)));
    % X_row(4)=trapz(abs(time)); 
    % X_row(5)=min(abs(diff(abs(time)))); 
    % X_row(6)=min(abs(diff(abs(time)))); 

end