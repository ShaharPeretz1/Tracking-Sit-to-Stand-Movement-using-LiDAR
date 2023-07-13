function [T_anova] = statistical_calculation(X_wo_1,X_w_1,Y_wo_1,Y_w_1,X_wo_2,X_w_2,Y_wo_2,Y_w_2,X_wo_3,X_w_3,Y_wo_3,Y_w_3,subject)
    %% reordering the data
    X_wo_1= X_wo_1-X_wo_1(end);X_wo_2= X_wo_2-X_wo_2(end); X_wo_3= X_wo_3-X_wo_3(end); 
    X_w_1= X_w_1-X_w_1(end);X_w_2= X_w_2-X_w_2(end);X_w_3= X_w_3-X_w_3(end);
    Y_wo_1= Y_wo_1-Y_wo_1(end);Y_wo_2= Y_wo_2-Y_wo_2(end);Y_wo_3= Y_wo_3-Y_wo_3(end);
    Y_w_1= Y_w_1-Y_w_1(end);Y_w_2= Y_w_2-Y_w_2(end);Y_w_3= Y_w_3-Y_w_3(end);
    
    len_X_WO_1 = length(X_wo_1); len_X_WO_2 = length(X_wo_2); len_X_WO_3 = length(X_wo_3);
    len_X_W_1 = length(X_w_1); len_X_W_2 = length(X_w_2); len_X_W_3 = length(X_w_3);
    len_Y_WO_1 = length(Y_wo_1); len_Y_WO_2 = length(Y_wo_2); len_Y_WO_3 = length(Y_wo_3);
    len_Y_W_1 = length(Y_w_1); len_Y_W_2 = length(Y_w_2); len_Y_W_3 = length(Y_w_3);
    
    len_vec = [len_X_WO_1,len_X_WO_2,len_X_WO_3,len_X_W_1,len_X_W_2,len_X_W_3,len_Y_WO_1,len_Y_WO_2,len_Y_WO_3,len_Y_W_1,len_Y_W_2,len_Y_W_3];
    max_len = max(len_vec);
    NaN_vec = NaN(1,max_len);
    
    x_wo_1 = NaN_vec; x_wo_2 = NaN_vec; x_wo_3 = NaN_vec; 
    x_w_1 = NaN_vec; x_w_2 = NaN_vec;  x_w_3 = NaN_vec; 
    y_wo_1 = NaN_vec; y_wo_2 = NaN_vec; y_wo_3 = NaN_vec; 
    y_w_1 = NaN_vec; y_w_2 = NaN_vec;  y_w_3 = NaN_vec;
    
    t = 0:0.1:(max_len-1)*0.1;
    x_wo_1(1:length(X_wo_1)) = X_wo_1(:); x_wo_2(1:length(X_wo_2)) =X_wo_2(:); x_wo_3(1:length(X_wo_3))= X_wo_3(:); 
    x_w_1(1:length(X_w_1)) = X_w_1(:); x_w_2(1:length(X_w_2))=X_w_2(:); x_w_3(1:length(X_w_3)) =X_w_3(:) ; 
    y_wo_1(1:length(Y_wo_1)) =Y_wo_1(:) ; y_wo_2(1:length(Y_wo_2)) =Y_wo_2(:); y_wo_3(1:length(Y_wo_3)) = Y_wo_3(:); 
    y_w_1(1:length(Y_w_1)) = Y_w_1(:);  y_w_2(1:length(Y_w_2)) = Y_w_2(:); y_w_3(1:length(Y_w_3))=Y_w_3(:);
    
    plot_2d(x_wo_1,x_w_1,y_wo_1,y_w_1,x_wo_2,x_w_2,y_wo_2,y_w_2,x_wo_3,x_w_3,y_wo_3,y_w_3,t,subject)
    groups = {'Without SnS','Without SnS','Without SnS','With SnS','With SnS','With SnS'};
    %% Calculating computational assumptions

    % Poisition
    %Poisition_x
    set1_data_position_x_wo = [x_wo_1',x_wo_2',x_wo_3'];
    set2_data_position_x_w = [x_w_1',x_w_2',x_w_3'];
    p_value_position_anova_x = anova1([set1_data_position_x_wo, set2_data_position_x_w], groups,'off');
    %Poisition_y
    set1_data_position_y_wo = [y_wo_1',y_wo_2',y_wo_3']; 
    set2_data_position_y_w = [y_w_1',y_w_2',y_w_3']; 
    p_value_position_anova_y = anova1([set1_data_position_y_wo, set2_data_position_y_w], groups,'off');

    % VELOCITY
    %VELOCITY_X
    vel_x_wo_1 = diff(X_wo_1)./0.1 ; vel_x_wo_2 = diff(X_wo_2)./0.1 ; vel_x_wo_3 = diff(X_wo_3)./0.1;
    vel_x_w_1 = diff(X_w_1)./0.1 ; vel_x_w_2 = diff(X_w_2)./0.1 ; vel_x_w_3 = diff(X_w_3)./0.1;
    set1_data_vel_x_wo = [vel_x_wo_1,vel_x_wo_2,vel_x_wo_3];
    set2_data_vel_x_w = [vel_x_w_1,vel_x_w_2,vel_x_w_3];
    p_value_vel_anova_x = anova1([set1_data_vel_x_wo, set2_data_vel_x_w], groups,'off');
    %VELOCITY_y
    vel_y_wo_1 = diff(Y_wo_1)./0.1 ; vel_y_wo_2 = diff(Y_wo_2)./0.1 ; vel_y_wo_3 = diff(Y_wo_3)./0.1;
    vel_y_w_1 = diff(Y_w_1)./0.1 ; vel_y_w_2 = diff(Y_w_2)./0.1 ; vel_y_w_3 = diff(Y_w_3)./0.1;
    set1_data_vel_y_wo = [vel_y_wo_1,vel_y_wo_2,vel_y_wo_3];
    set2_data_vel_y_w = [vel_y_w_1,vel_y_w_2,vel_y_w_3];
    p_value_vel_anova_y = anova1([set1_data_vel_y_wo, set2_data_vel_y_w], groups,'off');

    % ACCELERATION
    %ACCELERATION_X
    accel_x_wo_1 = diff(diff(X_wo_1)./0.1)./0.1 ; accel_x_wo_2 = diff(diff(X_wo_2)./0.1)./0.1 ; accel_x_wo_3 = diff(diff(X_wo_3)./0.1)./0.1;
    accel_x_w_1 = diff(diff(X_w_1)./0.1)./0.1 ; accel_x_w_2 = diff(diff(X_w_2)./0.1)./0.1 ; accel_x_w_3 = diff(diff(X_w_3)./0.1)./0.1;
    set1_data_accel_x_wo = [accel_x_wo_1,accel_x_wo_2,accel_x_wo_3];
    set2_data_accel_x_w = [accel_x_w_1,accel_x_w_2,accel_x_w_3];
    p_value_accel_anova_x = anova1([set1_data_accel_x_wo, set2_data_accel_x_w], groups,'off');
    %ACCELERATION_y
    accel_y_wo_1 = diff(diff(Y_wo_1)./0.1)./0.1 ; accel_y_wo_2 = diff(diff(Y_wo_2)./0.1)./0.1 ; accel_y_wo_3 = diff(diff(Y_wo_3)./0.1)./0.1;
    accel_y_w_1 = diff(diff(Y_w_1)./0.1)./0.1 ; accel_y_w_2 = diff(diff(Y_w_2)./0.1)./0.1 ; accel_y_w_3 = diff(diff(Y_w_3)./0.1)./0.1;
    set1_data_accel_y_wo = [accel_y_wo_1,accel_y_wo_2,accel_y_wo_3];
    set2_data_accel_y_w = [accel_y_w_1,accel_y_w_2,accel_y_w_3];
    p_value_accel_anova_y = anova1([set1_data_accel_y_wo, set2_data_accel_y_w], groups,'off');

    %% results 
    T_anova = table(p_value_position_anova_x,p_value_position_anova_y, p_value_vel_anova_x,p_value_vel_anova_y,p_value_accel_anova_x,p_value_accel_anova_y);
    filename = 'SnS_Results_vell_accel_anova.xlsx';
    writetable(T_anova,filename,'Sheet',1);
end