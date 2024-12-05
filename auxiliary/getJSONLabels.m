function topLevelLabels = getJSONLabels(filename)
% READJSONTOPLEVELLABELS Reads a JSON file and returns the top-level labels as a cell array.
%   topLevelLabels = READJSONTOPLEVELLABELS(filename) reads the JSON file
%   specified by the input 'filename', decodes it, and extracts the names
%   of the top-level fields in the JSON structure.

    % Validate the input filename
    if ~isfile(filename)
        error('The file "%s" does not exist. Please provide a valid filename.', filename);
    end

    % Step 1: Read the JSON file as text
    jsonText = fileread(filename);

    % Step 2: Decode the JSON text into a MATLAB structure
    dataStruct = jsondecode(jsonText);

    % Step 3: Retrieve the field names of the top-level structure
    topLevelLabels = fieldnames(dataStruct);

    % Step 4: Display the field names (optional, for user feedback)
    disp('Top-level labels:');
    disp(topLevelLabels);
end
