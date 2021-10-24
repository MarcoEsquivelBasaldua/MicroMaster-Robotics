% get images
buildingDir = fullfile(toolboxdir('vision'), 'visiondata', 'building');
buildingScene = imageDatastore(buildingDir);
I1 = rgb2gray(readimage(buildingScene, 1));
I2 = rgb2gray(readimage(buildingScene, 2));

% get points
points1 = detectHarrisFeatures(I1);
points2 = detectHarrisFeatures(I2);

% get features
[features1, points1] = extractFeatures(I1, points1);
[features2, points2] = extractFeatures(I2, points2);

loc1 = points1.Location;
loc2 = points2.Location;

[match,match_fwd,match_bkwd] = match_features(double(features1.Features),double(features2.Features));

figure()
plot_corr(I1,I2,loc1(match_fwd(:,1),:),loc2(match_fwd(:,2),:));

figure()
plot_corr(I1,I2,loc1(match_bkwd(:,1),:),loc2(match_bkwd(:,2),:));

figure()
plot_corr(I1,I2,loc1(match(:,1),:),loc2(match(:,2),:));

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
    [fwd_rows fwd_cols] = size(match_fwd);
    [bkwd_rows bkwd_cols] = size(match_bkwd);
    
    r=1;
    for i=1:fwd_rows
        for j=1:bkwd_rows
            if match_fwd(i,1)==match_bkwd(j,1) && match_fwd(i,2)==match_bkwd(j,2)
                match(r,:)=match_fwd(i,:);
                r=r+1;
                break;
            end
        end
    end
   
end

