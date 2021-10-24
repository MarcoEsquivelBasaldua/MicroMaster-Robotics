function Ic = ImageCarving(N)

% N: number of vertical seams you have to remove


% read image
I = im2double(imread('waterfall.png'));

% get grayscale image
Ig0 = rgb2gray(im2double(I));

% colored image 
Ic = I; 


for iIter = 1:N

    Ig = rgb2gray(Ic);
    Gx = imfilter(Ig,.5*[-1 0 1],'replicate');
    Gy = imfilter(Ig,.5*[-1 0 1]','replicate');
    E = abs(Gx) +  abs(Gy); % energy
    
    [nrows ncols]=size(Ig);
    
    M = zeros(size(Ig)); % cumulative energy
    P = zeros(size(Ig)); % Path Matrix
    
    % your CODE starts here
    M(1,:)=E(1,:);
    
    for i=2:nrows
        for j=1:ncols
            if j==1
                [mini pos]=min(M(i-1,j:j+1));    %[mini pos]=min(E(i-1,j),E(i-1,j+1));
                M(i,j)=E(i,j)+mini;
                if pos==1
                    P(i,j)=0;
                else
                    P(i,j)=1;
                end
                
            elseif j==ncols
                [mini pos]=min(M(i-1,j-1:j));    %[mini pos]=min(E(i-1,j-1),E(i-1,j));
                M(i,j)=E(i,j)+mini;
                if pos==1
                    P(i,j)=-1;
                else
                    P(i,j)=0;
                end
                
            else
                [mini pos]=min(M(i-1,j-1:j+1)); %[mini pos]=min(E(i-1,j-1),E(i-1,j),E(i-1,j+1));
                M(i,j)=E(i,j)+mini;
                if pos==1
                    P(i,j)=-1;
                elseif pos==2
                    P(i,j)=0;
                else
                    P(i,j)=1;
                end
            end 
        end
    end
    
    [last_min current_col]=min(M(nrows,:));
    
    for k=nrows:-1:1
        Ic(k,current_col:ncols-1,1:3)=Ic(k,current_col+1:ncols,1:3);
        
            %Ic(k,current_col+1:ncols,1:3)=Ic(k,current_col:ncols-1,1:3);
        %Ic(k,current_col:ncols-1,2)=Ic(k,current_col+1:ncols,2);
        %Ic(k,current_col:ncols-1,3)=Ic(k,current_col+1:ncols,3);
        current_col=current_col+P(k,current_col);
    end
    
    Ic=Ic(1:nrows,1:ncols-1,1:3);
    


    % your CODE ends here


end

%Ic=Ic(1:nrows,1:ncols-N,1:3);

figure(1),imshow(I);
figure(2),imshow(Ic);


end


