function X_row=extract_features(signal,time)
    sample_rate = 1/0.1; %[Hz]

    % figure()
    % plot(signal)

    num_features = 13;
    X_row=zeros(1,num_features);
    signal = (signal - min(signal)) / (max(signal) - min(signal));

    % figure()
    % plot(norm_signal)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % X_row(1)=iqr(signal); %Interquartile_range   

    p = hist(signal); p = p(p~=0); 
    X_row(1)= -sum(p.*log2(p)); % Entropy

    X_row(2)=mean(signal);

    X_row(3)=sum(diff(sign(diff(signal)))~=0);

    % [yupper,ylower]=envelope(signal);
    % X_row(3)=sum(abs(yupper))-sum(abs(ylower)); %area between upper and lower envelope

    X_row(4)=std(signal); 

    X_row(5)=mean(abs(diff(signal(sign(diff(signal))==-1)))); % the averaged trend when it gos downwards

    [hights,locs]=findpeaks(signal); 
    if isempty(hights) && isempty(locs)
        X_row(6) = 0;
        % X_row(7) = 0;
        X_row(7) = 0;
        X_row(8) = 0;
    else
        X_row(6)=mean(hights)-mean(signal); %the averaged hight of the peaks above the original trend of the signal
        % X_row(7)=sum(locs); %the locations on which the peaks are taking place along the signal
        X_row(7)=length(locs); %amount of peaks in the signal
        X_row(8)=mean(diff(locs)); %distance_between_peaks
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    velocity = abs(signal)./time';
    X_row(9)=sum(velocity); % sum of velocity
    acceleration = diff(abs(velocity)) ./ sample_rate; % acceleration signal
    X_row(10) = sum(acceleration); % sum of acceleration
    X_row(11)=max(acceleration)-min(acceleration);
    X_row(12)=max(velocity)-min(velocity);
    X_row(13)=trapz(abs(signal)); %area under the curve 
    len = length(signal);
    lenn = floor(len/5);
    % sub_signal_1 = signal(1:lenn);
    % sub_signal_2 = signal(lenn+1:2*lenn);
    % sub_signal_3 = signal(2*lenn+1:3*lenn);
    % sub_signal_4 = signal(3*lenn+1:4*lenn);
    % sub_signal_5 = signal(4*lenn+1:end);
    % X_row(14)=mean(sub_signal_1); 
    % X_row(15)=mean(sub_signal_2);
    % X_row(16)=mean(sub_signal_3);
    % X_row(17)=mean(sub_signal_4);
    % X_row(18)=mean(sub_signal_5);

    %%
    
    %X_row(1)=mean(signal);
    %X_row(2)=std(signal);
    %X_row(4)= peak2peak(signal);
    %X_row(5)=iqr(signal); %Interquartile_range
    %[pks,locs]=findpeaks(signal); 
    %X_row(6)=median(diff(locs));%distance_between_peaks
    %X_row(6)=max(cumtrapz(signal)); 
    %X_row(9)=skewness(signal);%moment
    %X_row(7)=abs(sum(signal(1:end/2))-sum(signal(end/2:end)))/length(signal);
    
    %X_row(13)=max(log10(P_signal_filt))-min(log10(P_signal_filt));%range_magnitude
    
    
end