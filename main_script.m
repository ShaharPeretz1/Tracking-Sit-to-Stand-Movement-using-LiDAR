close all; clear all;
%% Load data
% for the young recordings we took only the recordings in which the
% subjects' age were below 60: once when they shifted their legs forward in order to
% demonstrate instability movement (with and without the SnS device) and in a regular legs position

% for the old recordings we took only the recordings in which the
% subjects' ages were above 60 and they conducted an original sit to stand
% movement (with and without the SnS device = pillow)

mainpath = pwd;
mainpath_old = strcat(mainpath,'\old_examinees');
mainpath_young = strcat(mainpath,'\young_examinees');

% for proof 3:
back_withoutSNS_old = dir(fullfile(mainpath_old, "*1.csv"));
front_withoutSNS_old = dir(fullfile(mainpath_old, "*A.csv"));

back_withoutSNS_footshift_young = dir(fullfile(mainpath_young, "*1+.csv"));
front_withoutSNS_footshift_young = dir(fullfile(mainpath_young, "*A+.csv"));

back_withoutSNS_young = dir(fullfile(mainpath_young, "*1.csv"));
front_withoutSNS_young = dir(fullfile(mainpath_young, "*A.csv"));

% for proof 7:
back_withSNS_old = dir(fullfile(mainpath_old, "*2.csv"));
front_withSNS_old = dir(fullfile(mainpath_old, "*B.csv"));

back_withSNS_footshift_young = dir(fullfile(mainpath_young, "*2+.csv"));
front_withSNS_footshift_young = dir(fullfile(mainpath_young, "*B+.csv"));

times_mat = {};
positions_mat = {};
velocities_mat = {};
velocity_calc_mat = {};
%% sort the data according to the examinee's number
% Extract the numbers from each file name

%%%%%%%%%%%%%%%%%%%%%% without SnS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fileNumbers_back_old_without = cellfun(@(x) str2double(x(1:2)), {back_withoutSNS_old.name});
fileNumbers_back_young_footshift_without = cellfun(@(x) str2double(x(1:2)), {back_withoutSNS_footshift_young.name});
fileNumbers_front_old_without = cellfun(@(x) str2double(x(1:2)), {front_withoutSNS_old.name});
fileNumbers_front_young_footshift_without = cellfun(@(x) str2double(x(1:2)), {front_withoutSNS_footshift_young.name});
fileNumbers_back_young_without = cellfun(@(x) str2double(x(1:2)), {back_withoutSNS_young.name});
fileNumbers_front_young_without = cellfun(@(x) str2double(x(1:2)), {front_withoutSNS_young.name});

% Sort the files according to their numbers
[~, sortedIndices_back_old_without] = sort(fileNumbers_back_old_without);
[~, sortedIndices_back_young_footshift_without] = sort(fileNumbers_back_young_footshift_without);
[~, sortedIndices_front_old_without] = sort(fileNumbers_front_old_without);
[~, sortedIndices_front_young_footshift_without] = sort(fileNumbers_front_young_footshift_without);
[~, sortedIndices_back_young_without] = sort(fileNumbers_back_young_without);
[~, sortedIndices_front_young_without] = sort(fileNumbers_front_young_without);

sortedFiles_back_old_without = back_withoutSNS_old(sortedIndices_back_old_without);
sortedFiles_back_young_footshift_without = back_withoutSNS_footshift_young(sortedIndices_back_young_footshift_without);
sortedFiles_front_old_without = front_withoutSNS_old(sortedIndices_front_old_without);
sortedFiles_front_young_footshift_without = front_withoutSNS_footshift_young(sortedIndices_front_young_footshift_without);
sortedFiles_back_young_without = back_withoutSNS_young(sortedIndices_back_young_without);
sortedFiles_front_young_without = front_withoutSNS_young(sortedIndices_front_young_without);

%%%%%%%%%%%%%%%%%%%%%%% with SnS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fileNumbers_back_old_with = cellfun(@(x) str2double(x(1:2)), {back_withSNS_old.name});
fileNumbers_back_young_footshift_with = cellfun(@(x) str2double(x(1:2)), {back_withSNS_footshift_young.name});
fileNumbers_front_old_with = cellfun(@(x) str2double(x(1:2)), {front_withSNS_old.name});
fileNumbers_front_young_footshift_with = cellfun(@(x) str2double(x(1:2)), {front_withSNS_footshift_young.name});

% Sort the files according to their numbers
[~, sortedIndices_back_old_with] = sort(fileNumbers_back_old_with);
[~, sortedIndices_back_young_footshift_with] = sort(fileNumbers_back_young_footshift_with);
[~, sortedIndices_front_old_with] = sort(fileNumbers_front_old_with);
[~, sortedIndices_front_young_footshift_with] = sort(fileNumbers_front_young_footshift_with);

sortedFiles_back_old_with = back_withSNS_old(sortedIndices_back_old_with);
sortedFiles_back_young_footshift_with = back_withSNS_footshift_young(sortedIndices_back_young_footshift_with);
sortedFiles_front_old_with = front_withSNS_old(sortedIndices_front_old_with);
sortedFiles_front_young_footshift_with = front_withSNS_footshift_young(sortedIndices_front_young_footshift_with);

%% read tables of signals
old_vec_num_sections_without_SnS_x = [];
old_vec_num_sections_without_SnS_y = [];
old_vec_num_sections_with_SnS_x = [];
old_vec_num_sections_with_SnS_y = [];

len_old = length(sortedFiles_front_old_without);
for file_old=1:len_old
    old_without_SnS_x = readtable([mainpath_old,'\',sortedFiles_front_old_without(file_old).name]);
    old_without_SnS_y = readtable([mainpath_old,'\',sortedFiles_back_old_without(file_old).name]);
    old_with_SnS_x = readtable([mainpath_old,'\',sortedFiles_front_old_with(file_old).name]);
    old_with_SnS_y = readtable([mainpath_old,'\',sortedFiles_back_old_with(file_old).name]);

    time_old_without_SnS_x = old_without_SnS_x.time - old_without_SnS_x.time(1);
    time_old_without_SnS_x = linspace(time_old_without_SnS_x(1),time_old_without_SnS_x(end),length(time_old_without_SnS_x));
    time_old_without_SnS_y = old_without_SnS_y.time - old_without_SnS_y.time(1);
    time_old_without_SnS_y = linspace(time_old_without_SnS_y(1),time_old_without_SnS_y(end),length(time_old_without_SnS_y));
    time_old_with_SnS_x = old_with_SnS_x.time - old_with_SnS_x.time(1);
    time_old_with_SnS_x = linspace(time_old_with_SnS_x(1),time_old_with_SnS_x(end),length(time_old_with_SnS_x));
    time_old_with_SnS_y = old_with_SnS_y.time - old_with_SnS_y.time(1);
    time_old_with_SnS_y = linspace(time_old_with_SnS_y(1),time_old_with_SnS_y(end),length(time_old_with_SnS_y));
    
    [labelVals_without_SnS_x,labelLocs_without_SnS_x,num_sectionss_without_SnS_x] = findSTS(old_without_SnS_x.position',time_old_without_SnS_x');
    [labelVals_without_SnS_y,labelLocs_without_SnS_y,num_sectionss_without_SnS_y] = findSTS(old_without_SnS_y.position',time_old_without_SnS_y');
    [labelVals_with_SnS_x,labelLocs_with_SnS_x,num_sectionss_with_SnS_x] = findSTS(old_with_SnS_x.position',time_old_with_SnS_x');
    [labelVals_with_SnS_y,labelLocs_with_SnS_y,num_sectionss_with_SnS_y] = findSTS(old_with_SnS_y.position',time_old_with_SnS_y');
    
    
    old_vec_num_sections_without_SnS_x = [old_vec_num_sections_without_SnS_x;num_sectionss_without_SnS_x];
    old_vec_num_sections_without_SnS_y = [old_vec_num_sections_without_SnS_y;num_sectionss_without_SnS_y];
    old_vec_num_sections_with_SnS_x = [old_vec_num_sections_with_SnS_x;num_sectionss_with_SnS_x];
    old_vec_num_sections_with_SnS_y = [old_vec_num_sections_with_SnS_y;num_sectionss_with_SnS_y];

    % manual fixing:
    if file_old==1
        labelLocs_with_SnS_x = [281,331;509,563;722,772];
        time = time_old_with_SnS_x;
        raw_signal = old_with_SnS_x.position;
        STS_up_locs = labelLocs_with_SnS_x;
        STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up']) 

    elseif file_old==2
        labelLocs_without_SnS_x(end,:) = [];
        labelLocs_without_SnS_x(2:3,:) = [250,284;433,468];
        time = time_old_without_SnS_x;
        raw_signal = old_without_SnS_x.position;
        STS_up_locs = labelLocs_without_SnS_x;
        STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up'])  

        labelLocs_with_SnS_x = [250,284;422,466;617,668];
        time = time_old_with_SnS_x;
        raw_signal = old_with_SnS_x.position;
        STS_up_locs = labelLocs_with_SnS_x;
        STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up']) 

     elseif file_old==3
        labelLocs_without_SnS_x(3:end,:) = [];
        labelLocs_without_SnS_x(3,:) =[441,463];
        time = time_old_without_SnS_x;
        raw_signal = old_without_SnS_x.position;
        STS_up_locs = labelLocs_without_SnS_x;
        STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up']) 

    elseif file_old==7
        labelLocs_without_SnS_y = [110,140;281,322;480,520];
        time = time_old_without_SnS_y;
        raw_signal = old_without_SnS_y.position;
        STS_up_locs = labelLocs_without_SnS_y;
        STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up']) 

    elseif file_old==8
        labelLocs_with_SnS_y = [226,259;384,420;613,654];
        time = time_old_with_SnS_y;
        raw_signal = old_with_SnS_y.position;
        STS_up_locs = labelLocs_with_SnS_y;
        STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up'])   

        labelLocs_without_SnS_x = [65,94;217,254;402,447];
        time = time_old_without_SnS_x;
        raw_signal = old_without_SnS_x.position;
        STS_up_locs = labelLocs_without_SnS_x;
        STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up']) 

        labelLocs_with_SnS_x = [209,270;375,434;602,673];
        time = time_old_with_SnS_x;
        raw_signal = old_with_SnS_x.position;
        STS_up_locs = labelLocs_with_SnS_x;
        STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up'])       

    elseif file_old==10
        labelLocs_with_SnS_x(2:3,:) = [428,474;622,679];
        time = time_old_with_SnS_x;
        raw_signal = old_with_SnS_x.position;
        STS_up_locs = labelLocs_with_SnS_x;
        STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up'])   
    end

    % old_without_SnS_x.position = detrend(old_without_SnS_x.position);
    % old_without_SnS_y.position = detrend(old_without_SnS_y.position);
    % old_with_SnS_x.position = detrend(old_with_SnS_x.position);
    % old_with_SnS_y.position = detrend(old_with_SnS_y.position);
    
    for i=1:size(labelLocs_without_SnS_x,1)
        old_segments.without_SnS_x{file_old,i} = old_without_SnS_x.position(labelLocs_without_SnS_x(i,1):labelLocs_without_SnS_x(i,2));
        old_segments.without_SnS_x_time{file_old,i} = time_old_without_SnS_x(labelLocs_without_SnS_x(i,1):labelLocs_without_SnS_x(i,2));
        % figure()
        % Y = max(old_segments.without_SnS_x{file_old,i})-old_segments.without_SnS_x{file_old,i};
        % plot(old_segments.without_SnS_x_time{file_old,i},old_segments.without_SnS_x{file_old,i})
        % xlabel("time [sec]")
        % ylabel("Position [cm]")
        % title("Sit to Stand movement (x axis) of an old subject without assistance")
    end
    

    for i=1:size(labelLocs_without_SnS_y,1)
        old_segments.without_SnS_y{file_old,i} = old_without_SnS_y.position(labelLocs_without_SnS_y(i,1):labelLocs_without_SnS_y(i,2));
        old_segments.without_SnS_y_time{file_old,i} = time_old_without_SnS_y(labelLocs_without_SnS_y(i,1):labelLocs_without_SnS_y(i,2));
        % figure()
        % Y = max(old_segments.without_SnS_y{file_old,i})-old_segments.without_SnS_y{file_old,i};
        % plot(old_segments.without_SnS_y_time{file_old,i},Y)
        % xlabel("time [sec]")
        % ylabel("Position [cm]")
        % title("Sit to Stand movement (y axis) of an old subject without assistance")
    end

    for i=1:size(labelLocs_with_SnS_x,1)
        old_segments.with_SnS_x{file_old,i} = old_with_SnS_x.position(labelLocs_with_SnS_x(i,1):labelLocs_with_SnS_x(i,2));
        old_segments.with_SnS_x_time{file_old,i} = time_old_with_SnS_x(labelLocs_with_SnS_x(i,1):labelLocs_with_SnS_x(i,2));
        % figure()
        % Y = max(old_segments.with_SnS_x{file_old,i})-old_segments.with_SnS_x{file_old,i};
        % plot(old_segments.with_SnS_x_time{file_old,i},old_segments.with_SnS_x{file_old,i})
        % xlabel("time [sec]")
        % ylabel("Position [cm]")
        % title("Sit to Stand movement (x axis) of an old subject with SitnStand assistance")
    end

    for i=1:size(labelLocs_with_SnS_y,1)
        old_segments.with_SnS_y{file_old,i} = old_with_SnS_y.position(labelLocs_with_SnS_y(i,1):labelLocs_with_SnS_y(i,2));
        old_segments.with_SnS_y_time{file_old,i} = time_old_with_SnS_y(labelLocs_with_SnS_y(i,1):labelLocs_with_SnS_y(i,2));
        % figure()
        % Y = max(old_segments.with_SnS_y{file_old,i})-old_segments.with_SnS_y{file_old,i};
        % plot(old_segments.with_SnS_y_time{file_old,i},Y)
        % xlabel("time [sec]")
        % ylabel("Position [cm]")
        % title("Sit to Stand movement (y axis) of an old subject with SitnStand assistance")
    end
end

old_segments.without_SnS_x = old_segments.without_SnS_x(:,1:3);
old_segments.without_SnS_y = old_segments.without_SnS_y(:,1:3);
old_segments.with_SnS_x = old_segments.with_SnS_x(:,1:3);
old_segments.with_SnS_y = old_segments.with_SnS_y(:,1:3);
old_segments.without_SnS_x_time = old_segments.without_SnS_x_time(:,1:3);
old_segments.without_SnS_y_time = old_segments.without_SnS_y_time(:,1:3);
old_segments.with_SnS_x_time = old_segments.with_SnS_x_time(:,1:3);
old_segments.with_SnS_y_time = old_segments.with_SnS_y_time(:,1:3);

len_young_footshift = length(sortedFiles_front_young_footshift_without);
for file_young_footshift=1:len_young_footshift
    without_SnS_x_footshift = readtable([mainpath_young,'\',sortedFiles_front_young_footshift_without(file_young_footshift).name]);
    without_SnS_y_footshift = readtable([mainpath_young,'\',sortedFiles_back_young_footshift_without(file_young_footshift).name]);
    with_SnS_x_footshift = readtable([mainpath_young,'\',sortedFiles_front_young_footshift_with(file_young_footshift).name]);
    with_SnS_y_footshift = readtable([mainpath_young,'\',sortedFiles_back_young_footshift_with(file_young_footshift).name]);
    
    time_without_SnS_x_footshift = without_SnS_x_footshift.time - without_SnS_x_footshift.time(1);
    time_without_SnS_x_footshift = linspace(time_without_SnS_x_footshift(1),time_without_SnS_x_footshift(end),length(time_without_SnS_x_footshift));
    time_without_SnS_y_footshift = without_SnS_y_footshift.time - without_SnS_y_footshift.time(1);
    time_without_SnS_y_footshift = linspace(time_without_SnS_y_footshift(1),time_without_SnS_y_footshift(end),length(time_without_SnS_y_footshift));
    time_with_SnS_x_footshift = with_SnS_x_footshift.time - with_SnS_x_footshift.time(1);
    time_with_SnS_x_footshift = linspace(time_with_SnS_x_footshift(1),time_with_SnS_x_footshift(end),length(time_with_SnS_x_footshift));
    time_with_SnS_y_footshift = with_SnS_y_footshift.time - with_SnS_y_footshift.time(1);
    time_with_SnS_y_footshift = linspace(time_with_SnS_y_footshift(1),time_with_SnS_y_footshift(end),length(time_with_SnS_y_footshift));

    [labelVals_without_SnS_x_footshift,labelLocs_without_SnS_x_footshift] = findSTS(without_SnS_x_footshift.position',time_without_SnS_x_footshift');
    [labelVals_without_SnS_y_footshift,labelLocs_without_SnS_y_footshift] = findSTS(without_SnS_y_footshift.position',time_without_SnS_y_footshift');
    [labelVals_with_SnS_x_footshift,labelLocs_with_SnS_x_footshift] = findSTS(with_SnS_x_footshift.position',time_with_SnS_x_footshift');
    [labelVals_with_SnS_y_footshift,labelLocs_with_SnS_y_footshift] = findSTS(with_SnS_y_footshift.position',time_with_SnS_y_footshift');
    
    % manual fixing:
    if file_young_footshift==2
        labelLocs_without_SnS_x_footshift = [71,103;220,250;390,418];
        time = time_without_SnS_x_footshift;
        raw_signal = without_SnS_x_footshift.position;
        STS_up_locs = labelLocs_without_SnS_x_footshift;
        STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up'])
    elseif file_young_footshift==4
        labelLocs_with_SnS_x_footshift = [71,103;235,266];
        % time = time_with_SnS_x_footshift;
        % raw_signal = with_SnS_x_footshift.position;
        % STS_up_locs = labelLocs_with_SnS_x_footshift;
        % STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up'])
    elseif file_young_footshift==6
        labelLocs_without_SnS_x_footshift = [60,100;200,240;360,400];
        % time = time_without_SnS_x_footshift;
        % raw_signal = without_SnS_x_footshift.position;
        % STS_up_locs = labelLocs_without_SnS_x_footshift;
        % STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up'])

        labelLocs_without_SnS_y_footshift(3,:) = [368,385];
        labelLocs_without_SnS_y_footshift(4,:) = [];
        % time = time_without_SnS_y_footshift;
        % raw_signal = without_SnS_y_footshift.position;
        % STS_up_locs = labelLocs_without_SnS_y_footshift;
        % STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up'])

        labelLocs_with_SnS_x_footshift = [240,290;410,460;610,660];
        % time = time_with_SnS_x_footshift;
        % raw_signal = with_SnS_x_footshift.position;
        % STS_up_locs = labelLocs_with_SnS_x_footshift;
        % STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up'])
       
        labelLocs_with_SnS_y_footshift = [240,290;410,460;610,660];
        % time = time_with_SnS_y_footshift;
        % raw_signal = with_SnS_y_footshift.position;
        % STS_up_locs = labelLocs_with_SnS_y_footshift;
        % STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up'])

    elseif file_young_footshift==7
        labelLocs_without_SnS_y_footshift(end,:) = [450,490];
        % time = time_without_SnS_y_footshift;
        % raw_signal = without_SnS_y_footshift.position;
        % STS_up_locs = labelLocs_without_SnS_y_footshift;
        % STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up'])  

        labelLocs_with_SnS_y_footshift = [232,276;410,460;606,653];
        % time = time_with_SnS_y_footshift;
        % raw_signal = with_SnS_y_footshift.position;
        % STS_up_locs = labelLocs_with_SnS_y_footshift;
        % STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up'])

    end
    without_SnS_x_footshift.position = detrend(without_SnS_x_footshift.position);
    without_SnS_y_footshift.position = detrend(without_SnS_y_footshift.position);
    with_SnS_x_footshift.position = detrend(with_SnS_x_footshift.position);
    with_SnS_y_footshift.position = detrend(with_SnS_y_footshift.position);

    for i=1:size(labelLocs_without_SnS_x_footshift,1)
        young_footshift_segments.without_SnS_x{file_young_footshift,i} = without_SnS_x_footshift.position(labelLocs_without_SnS_x_footshift(i,1):labelLocs_without_SnS_x_footshift(i,2));
        young_footshift_segments.without_SnS_x_time{file_young_footshift,i} = time_without_SnS_x_footshift(labelLocs_without_SnS_x_footshift(i,1):labelLocs_without_SnS_x_footshift(i,2));
        % figure()
        % Y = max(young_footshift_segments.without_SnS_x{file_young_footshift,i})-young_footshift_segments.without_SnS_x{file_young_footshift,i};
        % plot(young_footshift_segments.without_SnS_x_time{file_young_footshift,i},Y)
        % xlabel("time [sec]")
        % ylabel("Position [cm]")
        % title("Sit to Stand movement (x axis) of a young subject shifted leg position without assistance")
    end

    for i=1:size(labelLocs_without_SnS_y_footshift,1)
        young_footshift_segments.without_SnS_y{file_young_footshift,i} = without_SnS_y_footshift.position(labelLocs_without_SnS_y_footshift(i,1):labelLocs_without_SnS_y_footshift(i,2));
        young_footshift_segments.without_SnS_y_time{file_young_footshift,i} = time_without_SnS_y_footshift(labelLocs_without_SnS_y_footshift(i,1):labelLocs_without_SnS_y_footshift(i,2));
        % figure()
        % Y = max(young_footshift_segments.without_SnS_y{file_young_footshift,i})-young_footshift_segments.without_SnS_y{file_young_footshift,i};
        % plot(young_footshift_segments.without_SnS_y_time{file_young_footshift,i},Y)
        % xlabel("time [sec]")
        % ylabel("Position [cm]")
        % title("Sit to Stand movement (y axis) of a young subject shifted leg position without assistance")
    end


    for i=1:size(labelLocs_with_SnS_x_footshift,1)
        young_footshift_segments.with_SnS_x{file_young_footshift,i} = with_SnS_x_footshift.position(labelLocs_with_SnS_x_footshift(i,1):labelLocs_with_SnS_x_footshift(i,2));
        young_footshift_segments.with_SnS_x_time{file_young_footshift,i} = time_with_SnS_x_footshift(labelLocs_with_SnS_x_footshift(i,1):labelLocs_with_SnS_x_footshift(i,2));
        % figure()
        % Y = max(young_footshift_segments.with_SnS_x{file_young_footshift,i})-young_footshift_segments.with_SnS_x{file_young_footshift,i};
        % plot(young_footshift_segments.with_SnS_x_time{file_young_footshift,i},Y)
        % xlabel("time [sec]")
        % ylabel("Position [cm]")
        % title("Sit to Stand movement (x axis) of a young subject shifted leg position with SitnStand assistnace")
    end

    for i=1:size(labelLocs_with_SnS_y_footshift,1)
        young_footshift_segments.with_SnS_y{file_young_footshift,i} = with_SnS_y_footshift.position(labelLocs_with_SnS_y_footshift(i,1):labelLocs_with_SnS_y_footshift(i,2));
        young_footshift_segments.with_SnS_y_time{file_young_footshift,i} = time_with_SnS_y_footshift(labelLocs_with_SnS_y_footshift(i,1):labelLocs_with_SnS_y_footshift(i,2));
        % figure()
        % Y = max(young_footshift_segments.with_SnS_y{file_young_footshift,i})-young_footshift_segments.with_SnS_y{file_young_footshift,i};
        % plot(young_footshift_segments.with_SnS_y_time{file_young_footshift,i},Y)
        % xlabel("time [sec]")
        % ylabel("Position [cm]")
        % title("Sit to Stand movement (y axis) of a young subject shifted leg position with SitnStand assistance")
    end

    
end
%%
len_young = length(sortedFiles_front_young_without);
for file_young=1:len_young
    without_SnS_x_young = readtable([mainpath_young,'\',sortedFiles_front_young_without(file_young).name]);
    without_SnS_y_young = readtable([mainpath_young,'\',sortedFiles_back_young_without(file_young).name]);

    time_without_SnS_x_young = without_SnS_x_young.time - without_SnS_x_young.time(1);
    time_without_SnS_x_young = linspace(time_without_SnS_x_young(1),time_without_SnS_x_young(end),length(time_without_SnS_x_young));
    time_without_SnS_y_young = without_SnS_y_young.time - without_SnS_y_young.time(1);
    time_without_SnS_y_young = linspace(time_without_SnS_y_young(1),time_without_SnS_y_young(end),length(time_without_SnS_y_young));
    
    [labelVals_without_SnS_x_young,labelLocs_without_SnS_x_young] = findSTS(without_SnS_x_young.position',time_without_SnS_x_young');
    [labelVals_without_SnS_y_young,labelLocs_without_SnS_y_young] = findSTS(without_SnS_y_young.position',time_without_SnS_y_young');

    % manual fixing:
    if file_young==5
        labelLocs_without_SnS_y_young(2:3,:) = [200,234;340,362];
        time = time_without_SnS_y_young;
        raw_signal = without_SnS_y_young.position;
        STS_up_locs = labelLocs_without_SnS_y_young;
        STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up'])
    elseif file_young==13
        labelLocs_without_SnS_y_young(end,:) = [];
        time = time_without_SnS_y_young;
        raw_signal = without_SnS_y_young.position;
        STS_up_locs = labelLocs_without_SnS_y_young;
        STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up'])
    elseif file_young==14
        labelLocs_without_SnS_y_young(end,:) = [379,410];
        time = time_without_SnS_y_young;
        raw_signal = without_SnS_y_young.position;
        STS_up_locs = labelLocs_without_SnS_y_young;
        STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up'])
    elseif file_young==15
        labelLocs_without_SnS_y_young = [74,97;230,264;347,361];
        time = time_without_SnS_y_young;
        raw_signal = without_SnS_y_young.position;
        STS_up_locs = labelLocs_without_SnS_y_young;
        STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up'])
    elseif file_young==17
        labelLocs_without_SnS_y_young(2:3,:) = [262,295;417,453];
        time = time_without_SnS_y_young;
        raw_signal = without_SnS_y_young.position;
        STS_up_locs = labelLocs_without_SnS_y_young;
        STS_up = repmat("STS_up",size(STS_up_locs,1),1);
        % figure()
        % plot(time,raw_signal)
        % xline([time(STS_up_locs(:,1)),time(STS_up_locs(:,2))],'-r',[STS_up',STS_up'])
    end

    without_SnS_x_young.position = detrend(without_SnS_x_young.position);
    without_SnS_y_young.position = detrend(without_SnS_y_young.position);

    for i=1:size(labelLocs_without_SnS_x_young,1)
        young_segments.without_SnS_x{file_young,i} = without_SnS_x_young.position(labelLocs_without_SnS_x_young(i,1):labelLocs_without_SnS_x_young(i,2));
        young_segments.without_SnS_x_time{file_young,i} = time_without_SnS_x_young(labelLocs_without_SnS_x_young(i,1):labelLocs_without_SnS_x_young(i,2));
    end

    for i=1:size(labelLocs_without_SnS_y_young,1)
        young_segments.without_SnS_y{file_young,i} = without_SnS_y_young.position(labelLocs_without_SnS_y_young(i,1):labelLocs_without_SnS_y_young(i,2));
        young_segments.without_SnS_y_time{file_young,i} = time_without_SnS_y_young(labelLocs_without_SnS_y_young(i,1):labelLocs_without_SnS_y_young(i,2));
    end
end

%% create feature matrices
aligned_old_segments.without_SnS_x = old_segments.without_SnS_x(~cellfun('isempty', old_segments.without_SnS_x));
aligned_old_segments.without_SnS_y = old_segments.without_SnS_y(~cellfun('isempty', old_segments.without_SnS_y));
aligned_old_segments.with_SnS_x = old_segments.with_SnS_x(~cellfun('isempty', old_segments.with_SnS_x));
aligned_old_segments.with_SnS_y = old_segments.with_SnS_y(~cellfun('isempty', old_segments.with_SnS_y));
aligned_old_segments.without_SnS_x_time = old_segments.without_SnS_x_time(~cellfun('isempty', old_segments.without_SnS_x_time));
aligned_old_segments.without_SnS_y_time = old_segments.without_SnS_y_time(~cellfun('isempty', old_segments.without_SnS_y_time));
aligned_old_segments.with_SnS_x_time = old_segments.with_SnS_x_time(~cellfun('isempty', old_segments.with_SnS_x_time));
aligned_old_segments.with_SnS_y_time = old_segments.with_SnS_y_time(~cellfun('isempty', old_segments.with_SnS_y_time));

aligned_young_footshift_segments.without_SnS_x = young_footshift_segments.without_SnS_x(~cellfun('isempty', young_footshift_segments.without_SnS_x));
aligned_young_footshift_segments.without_SnS_y = young_footshift_segments.without_SnS_y(~cellfun('isempty', young_footshift_segments.without_SnS_y));
aligned_young_segments.without_SnS_x = young_segments.without_SnS_x(~cellfun('isempty', young_segments.without_SnS_x));
aligned_young_segments.without_SnS_y = young_segments.without_SnS_y(~cellfun('isempty', young_segments.without_SnS_y));
aligned_young_footshift_segments.with_SnS_x = young_footshift_segments.with_SnS_x(~cellfun('isempty', young_footshift_segments.with_SnS_x));
aligned_young_footshift_segments.with_SnS_y = young_footshift_segments.with_SnS_y(~cellfun('isempty', young_footshift_segments.with_SnS_y));
aligned_young_footshift_segments.without_SnS_x_time = young_footshift_segments.without_SnS_x_time(~cellfun('isempty', young_footshift_segments.without_SnS_x_time));
aligned_young_footshift_segments.without_SnS_y_time = young_footshift_segments.without_SnS_y_time(~cellfun('isempty', young_footshift_segments.without_SnS_y_time));
aligned_young_segments.without_SnS_x_time = young_segments.without_SnS_x_time(~cellfun('isempty', young_segments.without_SnS_x_time));
aligned_young_segments.without_SnS_y_time = young_segments.without_SnS_y_time(~cellfun('isempty', young_segments.without_SnS_y_time));
aligned_young_footshift_segments.with_SnS_x_time = young_footshift_segments.with_SnS_x_time(~cellfun('isempty', young_footshift_segments.with_SnS_x_time));
aligned_young_footshift_segments.with_SnS_y_time = young_footshift_segments.with_SnS_y_time(~cellfun('isempty', young_footshift_segments.with_SnS_y_time));

%%
% x:
len_x_old = length(aligned_old_segments.without_SnS_x);
[X_old_mean]=compute_averaged_vector_from_matrix(len_x_old,aligned_old_segments.without_SnS_x,aligned_old_segments.without_SnS_x_time,"extract_features");

len_x_young_footshift = length(aligned_young_footshift_segments.without_SnS_x);
[X_young_footshift_mean]=compute_averaged_vector_from_matrix(len_x_young_footshift,aligned_young_footshift_segments.without_SnS_x,aligned_young_footshift_segments.without_SnS_x_time,"extract_features");

len_x_young = length(aligned_young_segments.without_SnS_x);
[X_young_mean]=compute_averaged_vector_from_matrix(len_x_young,aligned_young_segments.without_SnS_x,aligned_young_segments.without_SnS_x_time,"extract_features");


% y:
len_y_old = length(aligned_old_segments.without_SnS_y);
[Y_old_mean]=compute_averaged_vector_from_matrix(len_y_old,aligned_old_segments.without_SnS_y,aligned_old_segments.without_SnS_y_time,"extract_features");

len_y_young_footshift = length(aligned_young_footshift_segments.without_SnS_y);
[Y_young_footshift_mean]=compute_averaged_vector_from_matrix(len_y_young_footshift,aligned_young_footshift_segments.without_SnS_y,aligned_young_footshift_segments.without_SnS_y_time,"extract_features");

len_y_young = length(aligned_young_segments.without_SnS_y);
[Y_young_mean]=compute_averaged_vector_from_matrix(len_y_young,aligned_young_segments.without_SnS_y,aligned_young_segments.without_SnS_y_time,"extract_features");

%% Calculte models correlations
% we want to prove that the correlation between the models of young people
% with their legs position shifted and the old people without assistance is
% high (i.e > 0.8)
old_young_x_corr = corr2(X_old_mean,X_young_footshift_mean);
old_young_y_corr = corr2(Y_old_mean,Y_young_footshift_mean);

[rho_old_young_x_corr,pval_old_young_x_corr] = corr(X_old_mean',X_young_footshift_mean',"type",'Spearman');
[rho_old_young_y_corr,pval_old_young_y_corr] = corr(Y_old_mean',Y_young_footshift_mean',"type",'Spearman');


% we want to prove that the correlation between the models of young people
% with their legs position shifted and the young people with their legs in
% the original position is low (i.e < 0.5)
young_young_x_corr = corr2(X_young_mean,X_young_footshift_mean);
young_young_y_corr = corr2(Y_young_mean,Y_young_footshift_mean);

[rho_young_young_x_corr,pval_young_young_x_corr] = corr(X_young_mean',X_young_footshift_mean',"type",'Spearman');
[rho_young_young_y_corr,pval_young_young_y_corr] = corr(Y_young_mean',Y_young_footshift_mean',"type",'Spearman');


% t-test - evaluate whether the results are signifficantly equal
% according to P value
[h_old_young_x,p_old_young_x] = kstest2(X_old_mean,X_young_footshift_mean); % p_##_x is the p-value from the t-test on the difference between the results of equation 1.
[h_old_young_y,p__old_young_y] = kstest2(Y_old_mean,Y_young_footshift_mean);
[h_young_young_x,p_young_young_x] = kstest2(X_young_mean,X_young_footshift_mean);
[h_young_young_y,p_young_young_y] = kstest2(Y_young_mean,Y_young_footshift_mean);
%% Calculate the Computational Assumptions of the models
% we want to prove that the Computational Assumptions of the model of young people
% with their legs position shifted is higher then the Computational Assumptions of the model of young people with their legs in
% the original position (i.e. CA_ratio_X & CA_ratio_Y > 0.5)

len_CA_x_young_footshift = length(aligned_young_footshift_segments.without_SnS_x);
[CA_X_young_footshift_mean,CA_X_young_footshift_matrix]=compute_averaged_vector_from_matrix(len_CA_x_young_footshift,aligned_young_footshift_segments.without_SnS_x,aligned_young_footshift_segments.without_SnS_x_time,"Computational_Assumptions");

len_CA_x_young = length(aligned_young_segments.without_SnS_x);
[CA_X_young_mean,CA_X_young_matrix]=compute_averaged_vector_from_matrix(len_CA_x_young,aligned_young_segments.without_SnS_x,aligned_young_segments.without_SnS_x_time,"Computational_Assumptions");

len_CA_y_young_footshift = length(aligned_young_footshift_segments.without_SnS_y);
[CA_Y_young_footshift_mean,CA_Y_young_footshift_matrix]=compute_averaged_vector_from_matrix(len_CA_y_young_footshift,aligned_young_footshift_segments.without_SnS_y,aligned_young_footshift_segments.without_SnS_y_time,"Computational_Assumptions");

len_CA_y_young = length(aligned_young_segments.without_SnS_y);
[CA_Y_young_mean,CA_Y_young_matrix]=compute_averaged_vector_from_matrix(len_CA_y_young,aligned_young_segments.without_SnS_y,aligned_young_segments.without_SnS_y_time,"Computational_Assumptions");

CA_ratio_X = [];
CA_ratio_Y = [];
for col=1:size(CA_Y_young_matrix,2)
    CA_ratio_X = [CA_ratio_X;sum(CA_X_young_footshift_matrix(:,col) > CA_X_young_matrix(:,col)','all')/(length(CA_X_young_footshift_matrix(:,col))*length(CA_X_young_matrix(:,col)))];
    CA_ratio_Y = [CA_ratio_Y;sum(CA_Y_young_footshift_matrix(:,col) > CA_Y_young_matrix(:,col)','all')/(length(CA_Y_young_footshift_matrix(:,col))*length(CA_Y_young_matrix(:,col)))];
end

eva_ratio_X = sum(CA_ratio_X>0.5)/length(CA_ratio_X);
eva_ratio_Y = sum(CA_ratio_Y>0.5)/length(CA_ratio_Y);

% t-test - evaluate whether the results are signifficantly different
% according to P value
[h_CA_X_young,p_CA_X_young] = ttest2(CA_X_young_footshift_mean,CA_X_young_mean,'Tail','right'); % p_##_x is the p-value from the t-test on the difference between the results of equation 1.
[h_CA_Y_young,p_CA_Y_young] = ttest2(CA_Y_young_footshift_mean,CA_Y_young_mean,'Tail','right');

%% Calculate the difference between the Computational Assumptions of the models
% we want to prove that the difference between the AUC of the model of young people
% with their legs position shifted minus the AUC of the model of young people with their legs in
% the original position is equal to the difference between the AUC of the
% model of old people without assistance minus the AUC of the model of old people used the SnS 

len_x_old_without_SnS = length(aligned_old_segments.without_SnS_x);
[X_old_without_SnS_mean,X_old_without_SnS_matrix]=compute_averaged_vector_from_matrix(len_x_old_without_SnS,aligned_old_segments.without_SnS_x,aligned_old_segments.without_SnS_x_time,"trapz");

len_x_old_with_SnS = length(aligned_old_segments.with_SnS_x);
[X_old_with_SnS_mean,X_old_with_SnS_matrix]=compute_averaged_vector_from_matrix(len_x_old_with_SnS,aligned_old_segments.with_SnS_x,aligned_old_segments.with_SnS_x_time,"trapz");

diff_x_old = abs(X_old_without_SnS_mean - X_old_with_SnS_mean)/max(X_old_without_SnS_mean,X_old_with_SnS_mean);

len_x_young_footshift = length(aligned_young_footshift_segments.without_SnS_x);
[X_young_footshift_mean,X_young_footshift_matrix]=compute_averaged_vector_from_matrix(len_x_young_footshift,aligned_young_footshift_segments.without_SnS_x,aligned_young_footshift_segments.without_SnS_x_time,"trapz");

len_x_young = length(aligned_young_segments.without_SnS_x);
[X_young_mean,X_young_matrix]=compute_averaged_vector_from_matrix(len_x_young,aligned_young_segments.without_SnS_x,aligned_young_segments.without_SnS_x_time,"trapz");

diff_x_young = abs(X_young_footshift_mean - X_young_mean)/max(X_young_footshift_mean,X_young_mean);

% y:
len_y_old_without_SnS = length(aligned_old_segments.without_SnS_y);
[Y_old_without_SnS_mean,Y_old_without_SnS_matrix]=compute_averaged_vector_from_matrix(len_y_old_without_SnS,aligned_old_segments.without_SnS_y,aligned_old_segments.without_SnS_y_time,"trapz");

len_y_old_with_SnS = length(aligned_old_segments.with_SnS_y);
[Y_old_with_SnS_mean,Y_old_with_SnS_matrix]=compute_averaged_vector_from_matrix(len_y_old_with_SnS,aligned_old_segments.with_SnS_y,aligned_old_segments.with_SnS_y_time,"trapz");

diff_y_old = abs(Y_old_without_SnS_mean - Y_old_with_SnS_mean)/max(Y_old_without_SnS_mean,Y_old_with_SnS_mean);

len_y_young_footshift = length(aligned_young_footshift_segments.without_SnS_y);
[Y_young_footshift_mean,Y_young_footshift_matrix]=compute_averaged_vector_from_matrix(len_y_young_footshift,aligned_young_footshift_segments.without_SnS_y,aligned_young_footshift_segments.without_SnS_y_time,"trapz");

len_y_young = length(aligned_young_segments.without_SnS_y);
[Y_young_mean,Y_young_matrix]=compute_averaged_vector_from_matrix(len_y_young,aligned_young_segments.without_SnS_y,aligned_young_segments.without_SnS_y_time,"trapz");

diff_y_young = abs(Y_young_footshift_mean - Y_young_mean)/max(Y_young_footshift_mean,Y_young_mean);

% t-test - evaluate whether the results are signifficantly different
% according to P value
[h_X_old,p_X_old] = ttest2(X_old_without_SnS_matrix,X_old_with_SnS_matrix,'Tail','both'); % p_##_x is the p-value from the t-test on the difference between the results of equation 1.
[h_X_young,p_X_young] = ttest2(X_young_footshift_matrix,X_young_matrix,'Tail','both');
[h_Y_old,p_Y_old] = ttest2(Y_old_without_SnS_matrix,Y_old_with_SnS_matrix,'Tail','both'); % p_##_x is the p-value from the t-test on the difference between the results of equation 1.
[h_Y_young,p_Y_young] = ttest2(Y_young_footshift_matrix,Y_young_matrix,'Tail','both');
%% Compute Computational Assumptions per person (old only)
old_vec_num_sections_without_SnS_x = 3*ones(10,1);
old_vec_num_sections_with_SnS_x = 3*ones(10,1);
old_vec_num_sections_without_SnS_y = 3*ones(10,1);
old_vec_num_sections_with_SnS_y = 3*ones(10,1);

CoM_initial_distance_from_wall = zeros(length(old_vec_num_sections_without_SnS_x),1)-99;
for old_examinee=1:length(old_vec_num_sections_without_SnS_x)
    CoM_initial_distance_from_wall(old_examinee) = old_segments.without_SnS_x{old_examinee,1}(1);
end

BoS_old_table = readtable('BoS_old_examinees');
origin_BoS = CoM_initial_distance_from_wall-BoS_old_table.Var2;
matrix = repmat(origin_BoS', 3, 1); % create matrix with each digit repeated 3 times (becuse each examinee had 3 repeatitions of STS
BoS = matrix(:)'; % concatenate rows and transpose into row vector
BoS = num2cell(BoS);

len_x_old_without_SnS = length(aligned_old_segments.without_SnS_x);
[X_old_without_SnS_mean,X_old_without_SnS_matrix]=compute_measurments_per_person(len_x_old_without_SnS,aligned_old_segments.without_SnS_x,aligned_old_segments.without_SnS_x_time,old_vec_num_sections_without_SnS_x,BoS);

len_x_old_with_SnS = length(aligned_old_segments.with_SnS_x);
[X_old_with_SnS_mean,X_old_with_SnS_matrix]=compute_measurments_per_person(len_x_old_with_SnS,aligned_old_segments.with_SnS_x,aligned_old_segments.with_SnS_x_time,old_vec_num_sections_with_SnS_x,BoS);

pval_per_person_x = zeros(size(X_old_with_SnS_mean,1),size(X_old_with_SnS_matrix,2))-99;
difference_per_person_x = zeros(size(X_old_with_SnS_mean,1),size(X_old_with_SnS_matrix,2))-99;
j1 =0;
for i=1:size(X_old_with_SnS_mean,1)
    j2=old_vec_num_sections_without_SnS_x(i);
    if i==1
        for calc=1:size(X_old_without_SnS_matrix,2)  
            [~,pval_person] = ttest2(X_old_with_SnS_matrix(1:j2,calc),X_old_without_SnS_matrix(1:j2,calc),'Tail','both');
            pval_per_person_x(i,calc) = pval_person;
            difference_per_person_x(i,calc) = (X_old_with_SnS_mean(i,calc)-X_old_without_SnS_mean(i,calc))*100/abs(X_old_with_SnS_mean(i,calc));
        end
    else
        j1=j1+old_vec_num_sections_without_SnS_x(i-1);
        for calc=1:size(X_old_without_SnS_matrix,2)  
            [~,pval_person] = ttest2(X_old_with_SnS_matrix(j1+1:j1+j2,calc),X_old_without_SnS_matrix(j1+1:j1+j2,calc),'Tail','both');
            pval_per_person_x(i,calc) = pval_person;
            difference_per_person_x(i,calc) = (X_old_with_SnS_mean(i,calc)-X_old_without_SnS_mean(i,calc))*100/abs(X_old_with_SnS_mean(i,calc));
        end
    end
end


len_y_old_without_SnS = length(aligned_old_segments.without_SnS_y);
[Y_old_without_SnS_mean,Y_old_without_SnS_matrix]=compute_measurments_per_person(len_y_old_without_SnS,aligned_old_segments.without_SnS_y,aligned_old_segments.without_SnS_y_time,old_vec_num_sections_without_SnS_y,BoS);

len_y_old_with_SnS = length(aligned_old_segments.with_SnS_y);
[Y_old_with_SnS_mean,Y_old_with_SnS_matrix]=compute_measurments_per_person(len_y_old_with_SnS,aligned_old_segments.with_SnS_y,aligned_old_segments.with_SnS_y_time,old_vec_num_sections_with_SnS_y,BoS);

pval_per_person_y = zeros(size(Y_old_with_SnS_mean,1),size(Y_old_with_SnS_matrix,2))-99;
difference_per_person_y = zeros(size(Y_old_with_SnS_mean,1),size(Y_old_with_SnS_matrix,2))-99;
j1 =0;
for i=1:size(Y_old_with_SnS_mean,1)
    j2=old_vec_num_sections_without_SnS_y(i);
    if i==1
        for calc=1:size(Y_old_without_SnS_matrix,2)  
            [~,pval_person] = ttest2(Y_old_with_SnS_matrix(1:j2,calc),Y_old_without_SnS_matrix(1:j2,calc),'Tail','both');
            pval_per_person_y(i,calc) = pval_person;
            difference_per_person_y(i,calc) = (Y_old_with_SnS_mean(i,calc)-Y_old_without_SnS_mean(i,calc))*100/abs(Y_old_with_SnS_mean(i,calc));
        end

    else
        j1=j1+old_vec_num_sections_without_SnS_y(i-1);
        for calc=1:size(Y_old_without_SnS_matrix,2)  
            [~,pval_person] = ttest2(Y_old_with_SnS_matrix(j1+1:j1+j2,calc),Y_old_without_SnS_matrix(j1+1:j1+j2,calc),'Tail','both');
            pval_per_person_y(i,calc) = pval_person;
            difference_per_person_y(i,calc) = (Y_old_with_SnS_mean(i,calc)-Y_old_without_SnS_mean(i,calc))*100/abs(Y_old_with_SnS_mean(i,calc));
        end
    end
end

% Print the results:
success_rate_x = sum(pval_per_person_x<=0.05)*100/size(X_old_with_SnS_mean,1);
sprintf(['Precentage of Pval<=0.05 in x axis\nfor Computation Assumptions 1: %0.0f %%'  ...
    '\nfor Computation Assumptions 2: %0.0f %%' ...
    '\nfor Computation Assumptions 3: %0.0f %%' ...
    '\nfor Computation Assumptions 4: %0.0f %%'],success_rate_x(1),success_rate_x(2),success_rate_x(3),success_rate_x(4))
% error_rate_x = sum(difference_per_person_x<=5)*100/size(X_old_with_SnS_mean,1);
% sprintf(['Precentage of error rate <=5%% in x axis\nfor Computation Assumptions 1: %0.0f %%'  ...
%     '\nfor Computation Assumptions 2: %0.0f %%' ...
%     '\nfor Computation Assumptions 3: %0.0f %%' ...
%     '\nfor Computation Assumptions 4: %0.0f %%'],error_rate_x(1),error_rate_x(2),error_rate_x(3),error_rate_x(4))
mean_diff_x = mean(difference_per_person_x);
sprintf(['Average difference in x axis\nfor Computation Assumptions 1: %0.0f %%'  ...
    '\nfor Computation Assumptions 2: %0.0f %%' ...
    '\nfor Computation Assumptions 3: %0.0f %%' ...
    '\nfor Computation Assumptions 4: %0.0f %%'],mean_diff_x(1),mean_diff_x(2),mean_diff_x(3),mean_diff_x(4))
success_rate_y = sum(pval_per_person_y<=0.05)*100/size(Y_old_with_SnS_mean,1);
sprintf(['Precentage of Pval<=0.05 in y axis\nfor Computation Assumptions 1: %0.0f %%'  ...
    '\nfor Computation Assumptions 2: %0.0f %%' ...
    '\nfor Computation Assumptions 3: %0.0f %%'],success_rate_y(1),success_rate_y(2),success_rate_y(3))
% error_rate_y = sum(difference_per_person_y<=5)*100/size(Y_old_with_SnS_mean,1);
% sprintf(['Precentage of error rate <=5%% in x axis\nfor Computation Assumptions 1: %0.0f %%'  ...
%     '\nfor Computation Assumptions 2: %0.0f %%' ...
%     '\nfor Computation Assumptions 3: %0.0f %%'],error_rate_y(1),error_rate_y(2),error_rate_y(3))
mean_diff_y = mean(difference_per_person_y);
sprintf(['Average difference in y axis\nfor Computation Assumptions 1: %0.0f %%'  ...
    '\nfor Computation Assumptions 2: %0.0f %%' ...
    '\nfor Computation Assumptions 3: %0.0f %%'],mean_diff_y(1),mean_diff_y(2),mean_diff_y(3))
