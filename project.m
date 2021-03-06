function varargout = project(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @project_OpeningFcn, ...
    'gui_OutputFcn',  @project_OutputFcn, ...
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
end

% --- Executes just before project is made visible.
function project_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for project
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
end

% --- Outputs from this function are returned to the command line.
function varargout = project_OutputFcn(hObject, eventdata, handles)
% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on button press in buttonStart.
function buttonStart_Callback(hObject, eventdata, handles)
axes(handles.axes7);

[path, user_cancel]=imgetfile();
if user_cancel
    msgbox(sprintf('Error'),'Error','Error');
    return
end

img = imread(path);

[coin, area, centroi, perime, rad] = doStuff(img);
handles.coin = coin;
handles.area = area;
handles.centroi = centroi;
handles.perime = perime;
handles.rad = rad;
guidata(hObject, handles);
end

% --- Executes on button press in buttonViewCoin.
function buttonViewCoin_Callback(hObject, eventdata, handles)
axes(handles.axes9);
imshow(handles.coin);
end

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)

items = get(hObject,'String');
index_selected = get(hObject,'Value');
item_selected = items{index_selected};
get(handles.text3,'string');

switch item_selected
    case 'Area'
        set(handles.text3,'string',num2str(handles.area));
    case 'Centroid'
        set(handles.text3,'string',num2str(handles.centroi));
    case 'Perimeter'
        set(handles.text3,'string',num2str(handles.perime));
    case 'Raio'
        set(handles.text3,'string',num2str(handles.rad));
end
end

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in buttonViewHistogram.
function buttonViewHistogram_Callback(hObject, eventdata, handles)
N = 100;
coin = handles.coin;
[nlin ncol dummy] = size(coin);
npixels = nlin*ncol;
hr1 = imhist(coin(:,:,1), N)/npixels;
hg1 = imhist(coin(:,:,2), N)/npixels;
hb1 = imhist(coin(:,:,3), N)/npixels;

axes(handles.axes10);
bar(hr1);
axes(handles.axes11);
bar(hg1);
axes(handles.axes12);
bar(hb1);
end
