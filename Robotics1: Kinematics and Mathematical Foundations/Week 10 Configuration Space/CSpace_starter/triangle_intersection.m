function flag = triangle_intersection(P1, P2)
% triangle_test : returns true if the triangles overlap and false otherwise

%%% All of your code should be between the two lines of stars.
% *******************************************************************
flag=line_intersection([P1(1,1) P1(1,2)],[P1(2,1) P1(2,2)],[P2(1,1) P2(1,2)],[P2(2,1) P2(2,2)]);

if (flag==false)
    flag=line_intersection([P1(1,1) P1(1,2)],[P1(2,1) P1(2,2)],[P2(1,1) P2(1,2)],[P2(3,1) P2(3,2)]);
end

if (flag==false)
    flag=line_intersection([P1(1,1) P1(1,2)],[P1(2,1) P1(2,2)],[P2(2,1) P2(2,2)],[P2(3,1) P2(3,2)]);
end



if (flag==false)
    flag=line_intersection([P1(1,1) P1(1,2)],[P1(3,1) P1(3,2)],[P2(1,1) P2(1,2)],[P2(2,1) P2(2,2)]);
end

if (flag==false)
    flag=line_intersection([P1(1,1) P1(1,2)],[P1(3,1) P1(3,2)],[P2(1,1) P2(1,2)],[P2(3,1) P2(3,2)]);
end
    
if (flag==false)
    flag=line_intersection([P1(1,1) P1(1,2)],[P1(3,1) P1(3,2)],[P2(2,1) P2(2,2)],[P2(3,1) P2(3,2)]);
end


if (flag==false)
    flag=line_intersection([P1(2,1) P1(2,2)],[P1(3,1) P1(3,2)],[P2(1,1) P2(1,2)],[P2(2,1) P2(2,2)]);
end 

if (flag==false)
    flag=line_intersection([P1(2,1) P1(2,2)],[P1(3,1) P1(3,2)],[P2(1,1) P2(1,2)],[P2(3,1) P2(3,2)]);
end 

if (flag==false)
    flag=line_intersection([P1(2,1) P1(2,2)],[P1(3,1) P1(3,2)],[P2(2,1) P2(2,2)],[P2(3,1) P2(3,2)]);
end 

%flag=~flag;
% *******************************************************************
end

function flag = line_intersection(p1,p2,p3,p4)
    m1=(p2(2)-p1(2))/(p2(1)-p1(1));
    m2=(p4(2)-p3(2))/(p4(1)-p3(1));

    sys=[m1 -1 p1(1)*m1;m2 -1 p3(1)*m2];
    sol=rref(sys);

    if (m2-m1~=0)
        %sol=rref(sys);
        solx=sol(1,3);
        soly=sol(2,3);
        
        if (abs(solx-p1(1))<abs(p1(1)-p2(1)) && abs(solx-p2(1))<abs(p1(1)-p2(1)))
            if (abs(soly-p1(2))<abs(p1(2)-p2(2)) && abs(soly-p2(2))<abs(p1(2)-p2(2)))
                if (abs(solx-p3(1))<abs(p3(1)-p4(1)) && abs(solx-p4(1))<abs(p3(1)-p4(1)))
                    if (abs(soly-p3(2))<abs(p3(2)-p4(2)) && abs(soly-p4(2))<abs(p3(2)-p4(2)))
                        flag=true;
                    else
                        flag=false;
                    end
                else 
                    flag=false;
                end
            else
                flag=true;
            end
        else 
            flag=false;
        end
    else 
        flag=true;
                  
    end
    
end

            
