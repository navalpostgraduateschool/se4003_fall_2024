function figureHandle = getParentFigure(hObject)

    if ~isempty(hObject) && ~strcmp('figure', get(hObject,'type'))

    while ~isempty(hObject) && ~strcmp('figure', get(hObject,'type'))
        hObject = get(hObject,'parent');
    end
    figureHandle = hObject;
end