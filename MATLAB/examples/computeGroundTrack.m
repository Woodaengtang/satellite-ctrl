function [lat, lon, heading] = computeGroundTrack(a, e, i, Omega, omega, nu, utc)
% a: semi-major axis (m), e: eccentricity, i: inclination (deg)
% Omega: Right ascension of the ascending node (deg)
% omega: argument of periapsis (deg)
% nu: true anomaly (deg)
if isempty(nu)
    nu = 0:1:359;
end

utc = utc.*ones(length(nu), 1);
p_eci = NaN(length(nu), 3);
v_eci = NaN(length(nu), 3);
for k = 1:length(nu)
    if e < 1e-6
        arglat = omega + nu(k); % for circular orbit with nonzero inclination
        if arglat > 360
            arglat = arglat - 360;
        end
        [p_eci(k, :), v_eci(k, :)] = keplerian2ijk(a, e, i, Omega, omega, nu(k), ...
            'arglat', arglat);
    else
        [p_eci(k, :), v_eci(k, :)] = keplerian2ijk(a, e, i, Omega, omega, nu(k));
    end
end
lla = eci2lla(p_eci, utc);
lat = lla(:, 1);
lon = lla(:, 2);

heading = NaN(length(nu), 1);
for k = 1:length(nu)
    [~, v_ecef] = eci2ecef(utc(k, :), p_eci(k, :), v_eci(k, :));
    [v_n, v_e] = ecef2nedv(v_ecef(1), v_ecef(2), v_ecef(3), lat(k), lon(k));
    heading(k) = atan2(v_e, v_n);
end
heading = rad2deg(heading);
end