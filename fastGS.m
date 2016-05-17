function [e_hat,mi]=fastGS(mi,e_hat,angles,co)

num=find(mi(:,3)<-0.1);
pp=size(num,1);

ds = [1;1];

for i1 = 1:pp
    
    step=1;
    angle1=angles(step);
    R = rotation_matrix(angle1);
    y=R * e_hat([mi(i1,1),mi(i1,2)],:);
    
    cost1=-IKGV_estimation(y,ds,co);
    cost_opt=cost1;
    angle_opt =angle1;
    
    step=step+1;
    angle2 = angles(step);
    R = rotation_matrix(angle2);
    y=R * e_hat([mi(i1,1),mi(i1,2)],:);
    cost2=-IKGV_estimation(y,ds,co);
    step=step+1;
    dec=0;
    asc=0;
    
    while step<size(angles,2),
        
        angle3 = angles(step);
        R = rotation_matrix(angle3);
        y=R * e_hat([mi(i1,1),mi(i1,2)],:);
        
        cost3=-IKGV_estimation(y,ds,co);
        
        if (cost2 <= cost1)&&(cost3 <= cost2)
            if cost1 > cost_opt
                cost_opt=cost1;
                angle_opt =angle1;
            end
            asc=0;
            dec=dec+1;
            cost1=cost2;
            angle1=angle2;
            cost2=cost3;
            angle2=angle3;
            step=step+2^dec;
            
        elseif ((cost2 <= cost1)&&(cost3 >= cost2))||((cost1 <= cost2)&&(cost2 <= cost3))
            dec=0;
            %                         asc=asc+1;
            if cost3 > cost1
                if cost3 > cost_opt
                    cost_opt = cost3;
                    angle_opt = angle3;
                end
            else
                if cost1 > cost_opt
                    cost_opt = cost1;
                    angle_opt = angle1;
                end
            end
            cost1=cost2;
            angle1=angle2;
            cost2=cost3;
            angle2=angle3;
            step=step+3;
            
            
        elseif (cost1 <= cost2)&&(cost2 >= cost3)
            for ii=angle1:angles(2):angle3
                R = rotation_matrix(ii);
                y=R * e_hat([mi(i1,1),mi(i1,2)],:);
                cost=-IKGV_estimation(y,ds,co);
                if cost > cost_opt
                    cost_opt = cost;
                    angle_opt = ii;
                end
            end
            cost1=cost2;
            angle1=angle2;
            cost2=cost3;
            angle2=angle3;
            asc=0;
            dec=dec+1;
            step=step+2^dec;
        end
        
        %                 if abs(cost_opt)<0.1
        %                     break;
        %                 end
        
    end
    
    %update the estimated demixing matrix (W_hat), source (e_hat):
    R = rotation_matrix(angle_opt);%R optimal
    e_hat([mi(i1,1),mi(i1,2)],:) = R * e_hat([mi(i1,1),mi(i1,2)],:);
    mi(i1,3)=cost_opt;
    
end