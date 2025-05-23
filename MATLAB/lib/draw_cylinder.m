function draw_cylinder(radius)
    faceAlpha = 0.3;
    h = 2;
    eul = deg2rad([0, 0, 0]);

    [sX, sY, sZ] = cylinder(radius);
    sZ = h*sZ - h/2;
    
    Rot2Des = eul2rotm(eul, "ZYX");
    
    for i = 1:size(sX, 1)
        for j = 1:size(sX, 2)
            temp = Rot2Des*[sX(i, j); sY(i, j); sZ(i, j)];
            [sX(i, j), sY(i, j), sZ(i, j)] = deal(temp(1), temp(2), temp(3));
        end
    end

    
    surf(sX, sY, sZ, "EdgeColor", "none", "FaceColor", [0, 0, 0], "FaceAlpha", faceAlpha);

    theta = linspace(0,2*pi,60);
    xC = radius * cos(theta);
    yC = radius * sin(theta);
    zC_bot = -h/2 * ones(size(theta));
    zC_top =  h/2 * ones(size(theta));
    cap_bot = Rot2Des * [xC; yC; zC_bot];
    cap_top = Rot2Des * [xC; yC; zC_top];

    patch(cap_bot(1,:), cap_bot(2,:), cap_bot(3,:), [0 0 0], 'EdgeColor','none', 'FaceAlpha',faceAlpha);
    patch(cap_top(1,:), cap_top(2,:), cap_top(3,:), [0 0 0], 'EdgeColor','none', 'FaceAlpha',faceAlpha);
end