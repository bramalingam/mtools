function varargout = batchChooser(varargin)
% BATCHCHOOSER M-file for batchChooser.fig
%      BATCHCHOOSER, by itself, creates a new BATCHCHOOSER or raises the existing
%      singleton*.
%
%      H = BATCHCHOOSER returns the handle to a new BATCHCHOOSER or the handle to
%      the existing singleton*.
%
%      BATCHCHOOSER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BATCHCHOOSER.M with the given input arguments.
%
%      BATCHCHOOSER('Property','Value',...) creates a new BATCHCHOOSER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before batchChooser_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to batchChooser_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help batchChooser

% Last Modified by GUIDE v2.5 10-Feb-2010 16:54:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @batchChooser_OpeningFcn, ...
                   'gui_OutputFcn',  @batchChooser_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before batchChooser is made visible.
function batchChooser_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to batchChooser (see VARARGIN)

% Choose default command line output for batchChooser
handles.output = hObject;
handles.parentHandles = varargin{1};
filePath = getappdata(handles.parentHandles.labelMaker, 'filePath');
setappdata(handles.batchChooser, 'filePath', filePath);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes batchChooser wait for user response (see UIRESUME)
uiwait(handles.batchChooser);


% --- Outputs from this function are returned to the command line.
function varargout = batchChooser_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;



function conditionText_Callback(hObject, eventdata, handles)
% hObject    handle to conditionText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of conditionText as text
%        str2double(get(hObject,'String')) returns contents of conditionText as a double


% --- Executes during object creation, after setting all properties.
function conditionText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to conditionText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in addLabelsButton.
function addLabelsButton_Callback(hObject, eventdata, handles)
% hObject    handle to addLabelsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

conditions = getappdata(handles.batchChooser, 'conditions');
conditionsPaths = getappdata(handles.batchChooser, 'conditionsPaths');
conditionsFiles = getappdata(handles.batchChooser, 'conditionsFiles');
filePath = getappdata(handles.batchChooser, 'filePath');
conditionText = get(handles.conditionText, 'String');

if isempty(conditionText)
    uicontrol(handles.conditionText);
    return;
end
[fileNames filePath] = uigetfile('*.mat', ['Choose label files for ', conditionText], 'MultiSelect', 'on', filePath);

conditions{end+1} = conditionText;
conditionsPaths{end+1} = filePath;
if iscell(fileNames)
    conditionsFiles{end+1} = fileNames;
else
    if fileNames == 0
        return;
    end
    conditionsFiles{end+1} = {fileNames};
end
set(handles.conditionsList, 'String', conditions);
setappdata(handles.batchChooser, 'conditions', conditions);
set(handles.removeButton, 'Enable', 'on');
set(handles.analyseButton, 'Enable', 'on');
set(handles.conditionText, 'String', '');
uicontrol(handles.conditionText);
setappdata(handles.batchChooser, 'conditionsPaths', conditionsPaths);
setappdata(handles.batchChooser, 'conditionsFiles', conditionsFiles);
setappdata(handles.batchChooser, 'filePath', filePath);


    


% --- Executes on selection change in conditionsList.
function conditionsList_Callback(hObject, eventdata, handles)
% hObject    handle to conditionsList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns conditionsList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from conditionsList


% --- Executes during object creation, after setting all properties.
function conditionsList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to conditionsList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in analyseButton.
function analyseButton_Callback(hObject, eventdata, handles)
% hObject    handle to analyseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

conditions = getappdata(handles.batchChooser, 'conditions');
conditionsPaths = getappdata(handles.batchChooser, 'conditionsPaths');
conditionsFiles = getappdata(handles.batchChooser, 'conditionsFiles');
filePath = getappdata(handles.batchChooser, 'filePath');

setappdata(handles.parentHandles.labelMaker, 'conditions', conditions);
setappdata(handles.parentHandles.labelMaker, 'conditionsPaths', conditionsPaths);
setappdata(handles.parentHandles.labelMaker, 'conditionsFiles', conditionsFiles);
setappdata(handles.parentHandles.labelMaker, 'filePath', filePath);
if get(handles.individualFilesCheck, 'Value') == 1
    setappdata(handles.parentHandles.labelMaker, 'analyseIndividualFiles', 1);
else
    setappdata(handles.parentHandles.labelMaker, 'analyseIndividualFiles', 0);
end
close(handles.batchChooser);


% --- Executes on button press in removeButton.
function removeButton_Callback(hObject, eventdata, handles)
% hObject    handle to removeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selectedIdx = get(handles.conditionsList, 'Value');
currentConditions = get(handles.conditionsList, 'String');
currentFiles = getappdata(handles.batchChooser, 'conditionsFiles');
currentPaths = getappdata(handles.batchChooser, 'conditionsPaths');
numConditions = length(currentConditions);
if selectedIdx ~= numConditions
    for thisCondition = selectedIdx:numConditions-1
        currentConditions{thisCondition} = currentConditions{thisCondition+1};
        currentFiles{thisCondition} = currentFiles{thisCondition+1};
        currentPaths{thisCondition} = currentPaths{thisCondition+1};
    end
    for thisCondition = 1:numConditions-1
        editedConditions{thisCondition} = currentConditions{thisCondition};
        editedFiles{thisCondition} = currentFiles{thisCondition};
        editedPaths{thisCondition} = currentPaths{thisCondition};
    end
    setappdata(handles.batchChooser, 'conditions', editedConditions);
    setappdata(handles.batchChooser, 'conditionsFiles', editedFiles);
    setappdata(handles.batchChooser, 'conditionsPaths', editedPaths);
else
    for thisCondition = 1:numConditions-1
        editedConditions{thisCondition} = currentConditions{thisCondition};
        editedFiles{thisCondition} = currentFiles{thisCondition};
        editedPaths{thisCondition} = currentPaths{thisCondition};
    end
end

if numConditions == 1
    set(handles.conditionsList, 'Value', 1);
    editedConditions{1} = '';
    editedFiles{1} = '';
    editedPaths{1} = '';
    set(handles.conditionsList, 'String', editedConditions);
    handles.conditionsFiles = editedFiles;
    handles.conditionsPaths = editedPaths;
    rmappdata(handles.batchChooser, 'conditions');
    rmappdata(handles.batchChooser, 'conditionsFiles');
    rmappdata(handles.batchChooser, 'conditionsPaths');
    return
end
if numConditions == 0
    return;
end

set(handles.conditionsList, 'String', editedConditions);
set(handles.conditionsList, 'Value', numConditions-1);
setappdata(handles.batchChooser, 'conditions', editedConditions);
setappdata(handles.batchChooser, 'conditionsFiles', editedFiles);
setappdata(handles.batchChooser, 'conditionsPaths', editedPaths);


guidata(hObject, handles);


% --- Executes on button press in individualFilesCheck.
function individualFilesCheck_Callback(hObject, eventdata, handles)
% hObject    handle to individualFilesCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of individualFilesCheck


