[I1, I2, I3, I4] = test_images();

u = ones(size(I1));
v = ones(size(I1))*2;

warp = warp_image(I1,u,v);
figure()
imagesc(I1)
figure()
imagesc(warp)

function warp = warp_image(I,u,v)
    %% INPUT:
    %% I: image to be warped
    %% u,v: x and y displacement
    %% OUTPUT:
    %% warp: image I deformed by u,v
        
    % initialize warp as zeros
    warp = zeros(size(I));
    % construct warp so that warp(x,y) = I(x + u, y + v)
   
%%%%%%%%%%% using loops %%%%%%%
    u = round(u);
    v = round(v);
    [I_rows I_cols] = size(warp);
    for x=1:I_cols
        for y=1:I_rows
            if (x+u(y,x) <= I_cols && y+v(y,x) <= I_rows)
                warp(y,x) = I(y+v(y,x), x+u(y,x));
            end
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%%%% Using a convolution %%%%%%    
%    a = round(u(1));
%    b = round(v(1));
%    x=2*a+1;
%    y=2*b+1;
%    k=zeros(y,x);
%    k(1,1)=1;
    
%    warp=conv2(I,k,'same');

end

