function plot_2d(x_wo_1,x_w_1,y_wo_1,y_w_1,x_wo_2,x_w_2,y_wo_2,y_w_2,x_wo_3,x_w_3,y_wo_3,y_w_3,t,subject) 
    figure;
    p1 = plot(t,x_wo_1); p1.Color = '#0072BD'; p1.LineStyle = '-'; hold on ; 
    p2 = plot(t,x_wo_2); p2.Color = '#0072BD'; p2.LineStyle = '-'; hold on ;  
    p3 = plot(t,x_wo_3); p3.Color = '#0072BD'; p3.LineStyle = '-'; hold on ; 
    
    
    p1 = plot(t,x_w_1); p1.Color = '#D95319'; p1.LineStyle = '-'; hold on ; 
    p2 = plot(t,x_w_2); p2.Color = '#D95319'; p2.LineStyle = '-'; hold on ;  
    p3 = plot(t,x_w_3); p3.Color = '#D95319'; p3.LineStyle = '-'; hold on ; 
    
    
    title(['Sit-to-Stand movement in x axis (Subject ',subject,')']) 
    xlabel('Time [sec]')
    ylabel('Position [cm]')
    hline = refline(0, 0);
    hline.Color = 'k';
    legend('Repetition 1 - Without SnS','Repetition 2 - Without SnS','Repetition 3 - Without SnS','Repetition 1 - with SnS','Repetition 2 - with SnS','Repetition 3 - with SnS')
    
    figure; 
    p1 = plot(t,y_wo_1); p1.Color = '#0072BD'; p1.LineStyle = '-'; hold on ;
    p2 = plot(t,y_wo_2); p2.Color = '#0072BD'; p2.LineStyle = '-'; hold on ;
    p3 = plot(t,y_wo_3); p3.Color = '#0072BD'; p3.LineStyle = '-'; hold on ;
    
    p1 = plot(t,y_w_1); p1.Color = '#D95319'; p1.LineStyle = '-'; hold on ; 
    p2 =  plot(t,y_w_2); p2.Color = '#D95319'; p2.LineStyle = '-'; hold on ;  
    p3 =  plot(t,y_w_3); p3.Color = '#D95319'; p3.LineStyle = '-'; hold on ;
    
    title(['Sit-to-Stand movement in y axis (Subject ',subject,')']) 
    xlabel('Time [sec]')
    ylabel('Position [cm]')
    hline = refline(0, 0);
    hline.Color = 'k';
    legend('Repetition 1 - Without SnS','Repetition 2- Without SnS','Repetition 3- Without SnS','Repetition 1 - with SnS','Repetition 2 - with SnS','Repetition 3 - with SnS')
end