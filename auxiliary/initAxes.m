% optionalProps is an optional structure that, when included will apply
% the key value pairs provided.  
function axesH = initAxes(axesH, x_limits, y_limits, optionalProps)
    if ~nargin || isempty(axesH)
        axesH = gca;
    end

    limits = [-100,100];
    
    if nargin<=1
        x_limits = limits;
        y_limits = limits;
    elseif nargin==2
        y_limits = x_limits;
    end
        
    xlim(axesH, x_limits);
    ylim(axesH, y_limits);
    
    
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

    if nargin>3
        try
            set(axesH, optionalProps);
        catch me
        end
    end
    
end
