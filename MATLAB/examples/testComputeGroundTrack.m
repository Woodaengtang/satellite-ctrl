clear
clc
close all

addpath(genpath('../../utils/ground-track/'))

gif_names = ["Semi_major_axis.gif";...
             "Semi_major_axis_gt.gif";...
             "Eccentricity.gif";...
             "Eccentricity_gt.gif";...
             "Inclination.gif";...
             "Inclination_gt.gif";...
             "RAAN.gif";...
             "RAAN_gt.gif";...
             "AOP.gif";...
             "AOP_gt.gif"];
gif_name = "Inclination_gt.gif";
omega = 0;
Omega = 0;
final_omega = 360;

target = 0.5:1:179.5;

gifFig = figure();
gifPause = 0.001;
%%
for k = 1:length(target)
    a = 6711*1e3; % (m)
    e = 0.34;
    i = 46.1320; % (deg)
    Omega = 0;
    omega = 0;
    utc = [2024, 6, 1, 06, 22, 57];

    [lat, lon, heading] = computeGroundTrack(a, e, target(k), Omega, omega, [], utc);
    [maxLat, maxInd] = max(lat);
    [minLat, minInd] = min(lat);
    % plotGroundTrackEarth(a, e, i, Omega, target(k), [], utc);
    ground_track(lat, lon);
    hold off;
    pause(gifPause);

    frame = getframe(gifFig);
    img = frame2im(frame);
    [imind, cm] = rgb2ind(img, 1024);
    % imind = double(imind);
    if k == 1
        imwrite(imind,cm,gif_name,"gif","Loopcount", 1,"DelayTime",1/30);
    else
        imwrite(imind,cm,gif_name,"gif","WriteMode","append","DelayTime",1/30);
    end

end

% for k = 1:length(target_a) 
%     a = 6711*1e3; % (m)
%     e = 0;
%     i = 46.1320; % (deg)
%     Omega = 0;
%     omega = 0;
%     utc = [2024, 6, 1, 06, 22, 57];
% 
%     [lat, lon, heading] = computeGroundTrack(a, e, i, Omega, omega, [], utc);
%     [maxLat, maxInd] = max(lat);
%     [minLat, minInd] = min(lat);
%     plotGroundTrackEarth(a, e, target(end+1-k), Omega, omega, [], utc);
%     ground_track(lat, lon);
%     hold off;
%     pause(gifPause);
% 
%     frame = getframe(gifFig);
%     img = frame2im(frame);
%     [imind, cm] = rgb2ind(img, 256);
%     imind = double(imind);
%     if k == 1
%         imwrite(imind,cm,gif_name,"gif","Loopcount", 1,"DelayTime",1/30);
%     else
%         imwrite(imind,cm,gif_name,"gif","WriteMode","append","DelayTime",1/30);
%     end
% 
% end