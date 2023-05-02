mainpath = pwd;
mainpath = strcat(mainpath,['\LiDAR calibration results']);
LiDAR_results = dir(fullfile(mainpath, "*LiDAR.csv"));
machine_results = dir(fullfile(mainpath, "*machine.csv"));
times_mat_Li = {};
positions_mat_Li = {};
velocities_mat_Li = {};
velocity_calc_mat_Li = {};
for file=1:length(LiDAR_results)
    curr_LiDAR_data = readtable([mainpath,'\',LiDAR_results(file).name]);
    time_Li = curr_LiDAR_data.time;
    times_mat_Li{1,file} = time_Li - time_Li(1);
    position_Li = curr_LiDAR_data.position;
    positions_mat_Li{1,file} = position_Li - position_Li(1);
    velocities_mat_Li{1,file} = curr_LiDAR_data.velocity;
    velocity_calc_mat_Li{1,file} = position_Li(2:end).*10./time_Li(2:end);
end

times_mat_ma = {};
positions_mat_ma = {};
velocity_calc_mat_ma = {};
position_errors = {};
velocity_errors = {};
T = [];
for file=1:length(machine_results)
    curr_machine_data = readtable([mainpath,'\',machine_results(file).name]);
    time_ma = curr_machine_data.Time;
    times_mat_ma{1,file} = time_ma - time_ma(1);
    position_ma = curr_machine_data.Displacement;
    positions_mat_ma{1,file} = position_ma.*0.1 - position_ma(1)*0.1; % from mm to cm
    velocity_calc_mat_ma{1,file} = position_ma(2:end)./time_ma(2:end);
    
    p = polyfit(times_mat_ma{file},positions_mat_ma{file},1);
%     % fill nans:
%     velocity_calc_mat_ma{1,file} = fillmissing(velocity_calc_mat_ma{1,file},'linear',2,'EndValues','nearest');
%     velocity_calc_mat_Li{1,file} = fillmissing(velocity_calc_mat_Li{1,file},'linear',2,'EndValues','nearest');

    diff_Li = median(diff(times_mat_Li{1,file}));
    diff_ma = median(diff(times_mat_ma{1,file}));
    sample = diff_Li/diff_ma;
    positions_mat_ma{1,file} = downsample(positions_mat_ma{1,file},floor(sample*10));
    add = abs(size(positions_mat_Li{file},1)-size(positions_mat_ma{file},1));
    y = polyval(p,times_mat_Li{file});

%     % errors calculations:
%     position_errors{1,file} = (abs(positions_mat_Li{file} - y).*100)./y; % relative error [%] in position (LiDAR compared to machine)
%     velocity_errors{1,file} = (abs(velocity_calc_mat_Li{file} - y./times_mat_Li{file})*100)./(y./times_mat_Li{file}); % relative error [%] in velocity (LiDAR compared to machine)
%     mean_pos_relative_err = mean(position_errors{file});
%     STD_pos_err = std(position_errors{file});
%     mean_vel_relative_err = mean(velocity_errors{file});
%     STD_vel_err = std(velocity_errors{file});
%     rmse_pos = sqrt(mean((positions_mat_Li{file} - y).^2));
%     rmse_vel = sqrt(mean((velocity_calc_mat_Li{file} - y).^2));
%     T = [T;table(mean_pos_relative_err,STD_pos_err,rmse_pos,mean_vel_relative_err,STD_vel_err,rmse_vel)];


    positions_Li = positions_mat_Li{file}(2:end);
    y_new = y(2:end);
    velocity_calc_Li = velocity_calc_mat_Li{file}(1:end);
    time_Li = times_mat_Li{file}(2:end);

    if file == 1 || file == 2
        x_value = 570;
    else
        x_value = 380;
    end

    indx = find(times_mat_Li{file}>=x_value);
    time = time_Li(1:indx(1));
    position = positions_Li(1:indx(1));
    y = y_new(1:indx(1));

    % errors calculations:
    position_errors{1,file} = (abs(position - y).*100)./y; % relative error [%] in position (LiDAR compared to machine)
    velocity_errors{1,file} = (abs(position./time - y./time)*100)./(y./time); % relative error [%] in velocity (LiDAR compared to machine)
    mean_pos_relative_err = mean(position_errors{file});
    STD_pos_err = std(position_errors{file});
    mean_vel_relative_err = mean(velocity_errors{file});
    STD_vel_err = std(velocity_errors{file});
    rmse_pos = sqrt(mean((position - y).^2));
    rmse_vel = sqrt(mean((velocity_calc_Li(1:indx(1)) - y./time).^2));
    T = [T;table(mean_pos_relative_err,STD_pos_err,rmse_pos,mean_vel_relative_err,STD_vel_err,rmse_vel)];

    figure(file)
    hold on
    plot(time,position)
    plot(time,y)
    legend('LiDAR','Machine (gold standard)')
    xlabel('Time [sec]')
    ylabel('Position [mm]')
    xlim([0 600])
    ylim([-10 100])
    title('Position [cm] vs. Time [mm] using LiDAR and Instron testing machine')
    hold off
end

