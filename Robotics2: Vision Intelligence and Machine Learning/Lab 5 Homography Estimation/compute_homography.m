function H = compute_homography(p1,p2)		
    % use SVD to solve for H as was done in the lecture
    % Note: p1 is a 4x2 matrix, the first column of which gives the x coordinates. 
    A = [p2(1,1) p2(1,2) 1 0 0 0 -p2(1,1)*p1(1,1) -p2(1,2)*p1(1,1) -p1(1,1);
         0 0 0 p2(1,1) p2(1,2) 1 -p2(1,1)*p1(1,2) -p2(1,2)*p1(1,2) -p1(1,2);
         p2(2,1) p2(2,2) 1 0 0 0 -p2(2,1)*p1(2,1) -p2(2,2)*p1(2,1) -p1(2,1);
         0 0 0 p2(2,1) p2(2,2) 1 -p2(2,1)*p1(2,2) -p2(2,2)*p1(2,2) -p1(2,2);
         p2(3,1) p2(3,2) 1 0 0 0 -p2(3,1)*p1(3,1) -p2(3,2)*p1(3,1) -p1(3,1);
         0 0 0 p2(3,1) p2(3,2) 1 -p2(3,1)*p1(3,2) -p2(3,2)*p1(3,2) -p1(3,2);
         p2(4,1) p2(4,2) 1 0 0 0 -p2(4,1)*p1(4,1) -p2(4,2)*p1(4,1) -p1(4,1);
         0 0 0 p2(4,1) p2(4,2) 1 -p2(4,1)*p1(4,2) -p2(4,2)*p1(4,2) -p1(4,2)];
     
    [u,d,v] = svd(A);
    X=v(:,end)/v(end,end);
    H = reshape(X,3,3)';
         
end
