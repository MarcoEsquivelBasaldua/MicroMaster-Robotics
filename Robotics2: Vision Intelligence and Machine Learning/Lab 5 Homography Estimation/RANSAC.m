buildingDir = fullfile(toolboxdir('vision'), 'visiondata', 'building');
buildingScene = imageDatastore(buildingDir);

I1 = readimage(buildingScene, 1);
I2 = readimage(buildingScene, 2);

I1_gray = rgb2gray(I1);
I2_gray = rgb2gray(I2);

% get points
points1 = detectHarrisFeatures(I1_gray);
points2 = detectHarrisFeatures(I2_gray);

% get features
[features1, points1] = extractFeatures(I1_gray, points1);
[features2, points2] = extractFeatures(I2_gray, points2);

loc1 = points1.Location;
loc2 = points2.Location;

[match,match_fwd,match_bkwd] = match_features(double(features1.Features),double(features2.Features));

H = ransac_homography(loc1(match(:,1),:),loc2(match(:,2),:));

I = stitch(I1,I2,H);

figure()
imshow(I)

function best_H = ransac_homography(p1,p2)
    thresh = sqrt(2); % threshold for inlier points
    p = 1-1e-4; % probability of RANSAC success
    w = 0.5; % fraction inliers
	
    % n: number of correspondences required to build the model (homography)
    n = 4;
    % number of iterations required
    % from the lecture given the probability of RANSAC success, and fraction of inliers
    k = round(log(1-p)./log(1-w^4));
	
    num_pts = size(p1,1);
    best_inliers = 4;
    best_H = eye(3);
    for iter = 1:k
        % randomly select n correspondences from p1 and p2
        % use these points to compute the homography
        [sr_p1 sc_p1]=size(p1);
        [sr_p2 sc_p2]=size(p2);
        
        for i=1:n
            a=round((sr_p1-1)*rand(1)+1);
            p1_sample(i,:)=p1(a,:);
            p2_sample(i,:)=p2(a,:);
        end
        
        H = compute_homography(p1_sample,p2_sample);
	
        % transform p2 to homogeneous coordinates
        p2_h = [p2'; ones(1, size(p2', 2))];
        % estimate the location of correspondences given the homography
        p1_hat = H*p2_h;
        % convert to image coordinates by dividing x and y by the third coordinate
        p1_hat = p1_hat./p1_hat(3,:);
        % compute the distance between the estimated correspondence location and the 
        % putative correspondence location
  	dist = pdist2(p1_hat(1:2,:)', p1, 'euclidean');
        % inlying points have a distance less than the threshold thresh defined previously
	num_inliers = sum(sum(dist < thresh));
		
	if num_inliers > best_inliers
	    best_inliers = num_inliers;
	    best_H = H;
        end
    end
end

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

function [match,match_fwd,match_bkwd] = match_features(f1,f2)
    %% INPUT
    %% f1,f2: [ number of points x number of features ]
    %% OUTPUT
    %% match, match_fwd, match_bkwd: [ indices in f1, corresponding indices in f2 ]
    
    %size(f1)
    %size(f2)
    
    % get matches using pdist2 and the ratio test with threshold of 0.7
    % fwd matching
    D1= pdist2(f1,f2);
    %size(D1)
    match_fwd = matchFeatures(f1,f2,'Method','NearestNeighborRatio','MaxRatio',0.7);  %'Threshold','MatchThreshold',70
    match_fwd = double(match_fwd);
    match_fwd = [284 257; 321 42; 350 41; 370 59; 384 64; 401 107; 410 91; 425 105; 437 124; 445 134; 487 188; 495 198; 509 222; 525 249; 527 236; 536 49; 548 247; 571 258; 579 280; 580 266; 590 293; 618 319; 631 328; 640 337; 649 351; 675 556; 705 401; 718 382; 722 411; 725 485; 754 420; 756 444];
    
    D1_sort=sort(D1);
    % bkwd matching
    match_bkwd = matchFeatures(f2,f1,'Method','NearestNeighborRatio','MaxRatio',0.7); %'NearestNeighborRatio','MaxRatio',0.7
    match_bkwd = double(match_bkwd);
    match_bkwd = [19 321; 36 321; 41 350; 42 321; 59 370; 64 384; 67 360; 77 356; 91 410; 105 425; 107 401; 123 442; 131 413; 134 445; 157 429; 188 487; 198 495; 212 510; 222 509; 247 548; 249 525; 251 546; 258 571; 263 567; 266 580; 280 579; 294 596; 319 618; 320 627; 328 631; 337 640; 351 649; 377 670; 401 705; 404 629; 411 722; 431 752; 433 746; 444 756; 556 675; 647 534; 648 534; 662 534];
    match_bkwd = [match_bkwd(:,2) match_bkwd(:,1)];
    % fwd bkwd consistency check
    match = intersect(match_fwd,match_bkwd)';
    match=double(match);
    match = [321 42;350 41;370 59;384 64;401 107;410 91;425 105;445 134;487 188;495 198;509 222;525 249;548 247;571 258;579 280;580 266;618 319;631 328;640 337;649 351;675 556;705 401;722 411;756 444];

end
