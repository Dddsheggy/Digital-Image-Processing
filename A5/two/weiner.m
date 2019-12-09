function varargout = weiner(varargin)
% WEINER MATLAB code for weiner.fig
%      WEINER, by itself, creates a new WEINER or raises the existing
%      singleton*.
%
%      H = WEINER returns the handle to a new WEINER or the handle to
%      the existing singleton*.
%
%      WEINER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WEINER.M with the given input arguments.
%
%      WEINER('Property','Value',...) creates a new WEINER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before weiner_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to weiner_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help weiner

% Last Modified by GUIDE v2.5 10-Nov-2019 07:35:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @weiner_OpeningFcn, ...
                   'gui_OutputFcn',  @weiner_OutputFcn, ...
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


% --- Executes just before weiner is made visible.
function weiner_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to weiner (see VARARGIN)

% Choose default command line output for weiner
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes weiner wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global ori_pic type level LEN noise_var disk
set(handles.disk,'visible','on');
set(handles.sliderdisk,'visible','on');
set(handles.LEN,'visible','off');
set(handles.slider_LEN,'visible','off');
set(handles.noise_var,'visible','on');
set(handles.slider_noise_var,'visible','on');
disk = 3;
LEN = 2;
noise_var = 0.001;
type = 'outfocus_';
level = 'l_';
ori_pic = imread([type,level,'.jpg']);
axes(handles.ori_pic);
imshow(ori_pic);
empty = imread('empty.png');
axes(handles.fil_pic);
imshow(empty);

% --- Outputs from this function are returned to the command line.
function varargout = weiner_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in show_fil_pic.
function show_fil_pic_Callback(hObject, eventdata, handles)
% hObject    handle to show_fil_pic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_pic LEN noise_var disk
ori_pic = im2double(ori_pic);
t1 = get(handles.lose_focus,'value');
if t1 == 1
    PSF = fspecial('disk',disk);
else
    THETA = 0;
    PSF = fspecial('motion', LEN, THETA);
end
noise_mean = 0;
estimated_nsr = noise_var / var(ori_pic(:));
fil_pic = deconvwnr(ori_pic, PSF, estimated_nsr);
axes(handles.fil_pic);
imshow(fil_pic);


% --- Executes on button press in lose_focus.
function lose_focus_Callback(hObject, eventdata, handles)
% hObject    handle to lose_focus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lose_focus
global ori_pic type level
set(handles.disk,'visible','on');
set(handles.sliderdisk,'visible','on');
set(handles.LEN,'visible','off');
set(handles.slider_LEN,'visible','off');
set(handles.noise_var,'visible','on');
set(handles.slider_noise_var,'visible','on');
type = 'outfocus_';
ori_pic = imread([type,level,'.jpg']);
axes(handles.ori_pic);
imshow(ori_pic);


% --- Executes on button press in camera_move.
function camera_move_Callback(hObject, eventdata, handles)
% hObject    handle to camera_move (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of camera_move
global ori_pic type level
set(handles.disk,'visible','off');
set(handles.sliderdisk,'visible','off');
set(handles.LEN,'visible','on');
set(handles.slider_LEN,'visible','on');
set(handles.noise_var,'visible','on');
set(handles.slider_noise_var,'visible','on');
type = 'cmove_';
ori_pic = imread([type,level,'.jpg']);
axes(handles.ori_pic);
imshow(ori_pic);


% --- Executes on button press in object_move.
function object_move_Callback(hObject, eventdata, handles)
% hObject    handle to object_move (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of object_move
global ori_pic type level
set(handles.disk,'visible','off');
set(handles.sliderdisk,'visible','off');
set(handles.LEN,'visible','on');
set(handles.slider_LEN,'visible','on');
set(handles.noise_var,'visible','on');
set(handles.slider_noise_var,'visible','on');
type = 'omove_';
ori_pic = imread([type,level,'.jpg']);
axes(handles.ori_pic);
imshow(ori_pic);


% --- Executes on button press in blurl.
function blurl_Callback(hObject, eventdata, handles)
% hObject    handle to blurl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of blurl
global ori_pic type level
level = 'l_';
ori_pic = imread([type,level,'.jpg']);
axes(handles.ori_pic);
imshow(ori_pic);


% --- Executes on button press in blurm.
function blurm_Callback(hObject, eventdata, handles)
% hObject    handle to blurm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of blurm
global ori_pic type level
level = 'm_';
ori_pic = imread([type,level,'.jpg']);
axes(handles.ori_pic);
imshow(ori_pic);


% --- Executes on button press in blurh.
function blurh_Callback(hObject, eventdata, handles)
% hObject    handle to blurh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of blurh
global ori_pic type level
level = 'h_';
ori_pic = imread([type,level,'.jpg']);
axes(handles.ori_pic);
imshow(ori_pic);


% --- Executes on slider movement.
function slider_noise_var_Callback(hObject, eventdata, handles)
% hObject    handle to slider_noise_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global noise_var
noise_var = 0.001+0.019 * get(hObject, 'value');
noise_var = roundn(noise_var,-3);
str = ['noise_var ',num2str(noise_var)];
set(handles.noise_var,'String',str);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_noise_var_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_noise_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_LEN_Callback(hObject, eventdata, handles)
% hObject    handle to slider_LEN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global LEN
LEN = 2+floor(48 * get(hObject, 'value'));
str = ['LEN ',num2str(LEN)];
set(handles.LEN,'String',str);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_LEN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_LEN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderdisk_Callback(hObject, eventdata, handles)
% hObject    handle to sliderdisk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global disk
disk = 3+floor(12 * get(hObject, 'value'));
str = ['disk ',num2str(disk)];
set(handles.disk,'String',str);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderdisk_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderdisk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
