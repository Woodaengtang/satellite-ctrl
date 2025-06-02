function plotGroundTrackEarth(a, e, i, Omega, omega, nu, utc)
color = [0.2, 0.2, 0.2];
lineWidth = 1.5;

R_0 = 6378145; % radius of Earth (m)

if isempty(nu)
    nu = 0:1:359;
end

utc = utc.*ones(length(nu), 1);
p_eci = NaN(length(nu), 3);

for k = 1:length(nu)
    if e < 1e-6
        arglat = omega + nu(k); % for circular orbit with nonzero inclination
        p_eci(k, :) = keplerian2ijk(a, e, i, Omega, omega, nu(k), ...
            'arglat', arglat);
    else
        p_eci(k, :) = keplerian2ijk(a, e, i, Omega, omega, nu(k));
    end
end
lla = eci2lla(p_eci, utc);
lla(:, 3) = 0.001*R_0;
p_gt_eci = lla2eci(lla, utc);

[X_e, Y_e, Z_e] = sphere();
X_e = R_0*X_e; % (km)
Y_e = R_0*Y_e; % (km)
Z_e = R_0*Z_e; % (km)

% figure()
fac = 2*1e3;
surf(X_e/fac, Y_e/fac, Z_e/fac, 'HandleVisibility', 'off', 'FaceAlpha', 0.3, "EdgeColor", "none")
hold on
MissionOrbit = plot3(p_eci(:, 1)/1e3, p_eci(:, 2)/1e3, p_eci(:, 3)/1e3, ...
    'Color', color, 'LineStyle', '-', 'LineWidth', lineWidth, ...
    'DisplayName', "Mission orbit");
GroundTrack = plot3(p_gt_eci(:, 1)/fac, p_gt_eci(:, 2)/fac, p_gt_eci(:, 3)/fac, ...
    'Color', color, 'LineStyle', '--', 'LineWidth', lineWidth, ...
    'DisplayName', "Ground track");
daspect([1 1 1])
xlabel("X (km)")
ylabel("Y (km)")
zlabel("Z (km)")
% lgd = legend([MissionOrbit, GroundTrack], {"Mission Orbit", "Ground Track"});
grid on;
% az = -7.1243;
% el = 23.8360;
% view([az, el]);
view([25, 25]);
end