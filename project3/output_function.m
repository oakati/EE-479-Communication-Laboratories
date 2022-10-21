function [received_seq,memory] = output_function(received_seq,...
    power_vector,memory,dtmf_map,frequencies)
[v1 i1] = first_max(power_vector); % v1:1st max value i1:its index
[v2 i2] = second_max(power_vector); % v2:2nd max value i2:its index
f1 = frequencies(i1); %1st detected frequency
f2 = frequencies(i2);%2nd detected frequency
for i = 1:length(dtmf_map)
    if (dtmf_map{i,2} == f1 & dtmf_map{i,3} == f2) | (dtmf_map{i,2} == f2 & dtmf_map{i,3} == f1)
        if (v1 > 200 & v2 > 200) & memory < 200 %
            received_seq = strcat(received_seq,dtmf_map{i,1});
            display(received_seq);
            break;
        end
    end
end
memory = v1; % this is the previous state to prevent displaying
%the same symbol again and again while holding the button

end
