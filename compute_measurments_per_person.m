function [mean_per_person,matrix]=compute_measurments_per_person(len_measurment,signal_position,signal_time,num_sections,BoS)
    matrix = [];
    for num_segment=1:len_measurment
        sig = signal_position{num_segment};
        time = signal_time{num_segment};
        curr_BoS = BoS{num_segment};
        matrix=[matrix;Computational_Assumptions(sig,time,curr_BoS)];
    end
    if sum(isnan(matrix),'all')~=0
        matrix = fillmissing(matrix','linear',2);%'EndValues','nearest'); 
        matrix = matrix';
    end
    j1=0;
    mean_per_person = zeros(length(num_sections),size(matrix,2))-99;
    for i=1:size(num_sections,1)
        j2=num_sections(i);
        if i==1
            mean_per_person(i,:) = mean(matrix(1:j2,:));
        else
            j1=j1+num_sections(i-1);
            mean_per_person(i,:) = mean(matrix(j1+1:j1+j2,:));
        end
    end
   
    if nargout == 1
        % Only return output1
        matrix = [];
    end

    if nargin == 4
        % Only return output1
        matrix = [];
    end
end
