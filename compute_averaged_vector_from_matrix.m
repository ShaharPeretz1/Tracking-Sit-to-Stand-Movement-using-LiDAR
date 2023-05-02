function [mean_vec,matrix]=compute_averaged_vector_from_matrix(len_measurment,signal_position,signal_time,func)
    matrix = [];
    for num_segment=1:len_measurment
        sig = signal_position{num_segment};
        time = signal_time{num_segment};
        if func=="extract_features"
            matrix=[matrix;extract_features(sig,time)];
        elseif func=="Computational_Assumptions"
            matrix=[matrix;Computational_Assumptions(sig,time)];
        elseif func=="trapz"
            matrix=[matrix;trapz(abs(sig))];
        end
    end
    if sum(isnan(matrix),'all')~=0
        matrix = fillmissing(matrix','linear',2);%'EndValues','nearest'); 
        matrix = matrix';
    end
    norm_matrix = zeros(size(matrix));
    for i=1:size(matrix,2)
        p=prctile(matrix(:,i),[5 95]);
        if (p(2)-p(1))~=0
            norm_matrix(:,i) = (matrix(:,i)-p(1))./abs(p(2)-p(1));
        else
            norm_matrix(:,i) = 0;
        end
    end
    mean_vec = mean(norm_matrix);

    if nargout == 1
        % Only return output1
        matrix = [];
    end
end


% Y_young = [];
% len_y_young = length(aligned_young_segments.without_SnS_y);
% for num_segment=1:len_y_young
%     sig = aligned_young_segments.without_SnS_y{num_segment};
%     time = aligned_young_segments.without_SnS_y_time{num_segment};
%     Y_young=[Y_young;extract_features(sig,time)];
% end
% if sum(isnan(Y_young),'all')~=0
%     Y_young = fillmissing(Y_young','linear',2);%'EndValues','nearest'); 
%     Y_young = Y_young';
% end
% Y_young_norm = zeros(size(Y_young));
% for i=1:size(Y_young,2)
%     p=prctile(Y_young(:,i),[5 95]);
%     if (p(2)-p(1))~=0
%         Y_young_norm(:,i) = (Y_young(:,i)-p(1))./abs(p(2)-p(1));
%     else
%         Y_young_norm(:,i) = 0;
%     end
% end
% Y_young_mean = mean(Y_young_norm);