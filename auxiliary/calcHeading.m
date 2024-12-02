function heading_deg = calcHeading(start_pos, end_pos)
    % Calculate the differences in x and y
    dx_dy = end_pos - start_pos;
    dx = dx_dy(1);
    dy = dx_dy(2);
    heading_deg = atan2d(dy, dx);

    % Ensure the heading is in the range [0, 360) degrees
    if heading_deg < 0
        heading_deg = heading_deg + 360;
    end
end