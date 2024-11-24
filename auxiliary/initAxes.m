function axesH = initAxes(axesH)
    if ~nargin || isempty(axesH)
        axesH = gca;
    end
    
    % Access the UIAxes component and update its properties
    axesH.XLabel.String = '';  % Remove X label
    axesH.YLabel.String = '';  % Remove Y label
    
    % Remove ticks and tick labels
    xticks(axesH, []);
    yticks(axesH, []);
    
    % Set the background color to black
    axesH.Color = 'black';  % Set the background color of the axes to black
    
    % Add a black border
    axesH.Box = 'on';  % Turn on the box (border)
    axesH.XColor = 'black';  % Set the color of the X axis line (black)
    axesH.YColor = 'black';  % Set the color of the Y axis line (black)
    axesH.LineWidth = 2;  % Optional: make the border thicker
end
