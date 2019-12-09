function varargout = filters(varargin)
% FILTERS MATLAB code for filters.fig
%      FILTERS, by itself, creates a new FILTERS or raises the existing
%      singleton*.
%
%      H = FILTERS returns the handle to a new FILTERS or the handle to
%      the existing singleton*.
%
%      FILTERS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FILTERS.M with the given input arguments.
%
%      FILTERS('Property','Value',...) creates a new FILTERS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before filters_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to filters_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help filters

% Last Modified by GUIDE v2.5 10-Nov-2019 08:48:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @filters_OpeningFcn, ...
                   'gui_OutputFcn',  @filters_OutputFcn, ...
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


% --- Executes just before filters is made visible.
function filters_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to filters (see VARARGIN)

% Choose default command line output for filters
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes filters wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global rect ori_pic genre ISO m SW CW
rect = [83 141 37 37];
SW = 15;
CW = 3;
set(handles.m,'Visible','on');
set(handles.sliderm,'Visible','on');
set(handles.SW,'Visible','off');
set(handles.sliderSW,'Visible','off');
set(handles.CW,'Visible','off');
set(handles.sliderCW,'Visible','off');
m = 3;
genre = 'indoors_';
ISO = 'ISOl_';
ori_pic = imread([genre,ISO,'.jpg']);
axes(handles.ori_pic);
imshow(ori_pic);
noise = imcrop(ori_pic,rect);
axes(handles.noise_pdf);
imhist(noise);
empty = imread('empty.png');
axes(handles.fil_pic);
imshow(empty);

% --- Outputs from this function are returned to the command line.
function varargout = filters_OutputFcn(hObject, eventdata, handles) 
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
global ori_pic m SW CW
ori_pic = im2double(ori_pic);
t1 = get(handles.mean,'value');
t2 = get(handles.nonlocalmean,'value');
t3 = get(handles.median,'value');
t4 = get(handles.max,'value');
t5 = get(handles.min,'value');
if t1 == 1
    h_arithmetic = ones(m,m) / (m*m);
    fil_pic = imfilter(ori_pic,h_arithmetic);
elseif t2 == 1
    fil_pic = imnlmfilt(ori_pic, 'SearchWindowSize', SW, 'ComparisonWindowSize', CW);
elseif t3 ==1
    fun = @(x) median(x(:));
    fil_pic = nlfilter(ori_pic,[m m],fun);
elseif t4 ==1
    fun = @(x) max(x(:));
    fil_pic = nlfilter(ori_pic,[m m],fun);
elseif t5 ==1
    fun = @(x) min(x(:));
    fil_pic = nlfilter(ori_pic,[m m],fun);
end
axes(handles.fil_pic);
imshow(fil_pic);


% --- Executes on button press in ISOm.
function ISOm_Callback(hObject, eventdata, handles)
% hObject    handle to ISOm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ISOm
global ori_pic genre ISO rect
ISO = 'ISOm_';
ori_pic = imread([genre,ISO,'.jpg']);
t1 = get(handles.indoors,'value');
t2 = get(handles.outdoors,'value');
t3 = get(handles.people,'value');
if t1 == 1
    rect = [187 66 72 43];
elseif t2 == 1
    rect = [201 49 34 10];
elseif t3 == 1
    rect = [172.0497   79.3851   33.6535   16.3636];
end
axes(handles.ori_pic);
imshow(ori_pic);
noise = imcrop(ori_pic,rect);
axes(handles.noise_pdf);
imhist(noise); 


% --- Executes on button press in indoors.
function indoors_Callback(hObject, eventdata, handles)
% hObject    handle to indoors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of indoors
global ori_pic genre ISO rect
genre = 'indoors_';
ori_pic = imread([genre,ISO,'.jpg']);
t1 = get(handles.ISOl,'value');
t2 = get(handles.ISOm,'value');
t3 = get(handles.ISOh,'value');
if t1 == 1
    rect = [83 141 37 37];
elseif t2 == 1
    rect = [187 66 72 43];
elseif t3 == 1
    rect = [171.7410   89.5738   28.0961   15.7461];
end
axes(handles.ori_pic);
imshow(ori_pic);
noise = imcrop(ori_pic,rect);
axes(handles.noise_pdf);
imhist(noise); 


% --- Executes on button press in outdoors.
function outdoors_Callback(hObject, eventdata, handles)
% hObject    handle to outdoors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of outdoors
global ori_pic genre ISO rect
genre = 'outdoors_';
ori_pic = imread([genre,ISO,'.jpg']);
t1 = get(handles.ISOl,'value');
t2 = get(handles.ISOm,'value');
t3 = get(handles.ISOh,'value');
if t1 == 1
    rect = [137.1612  103.7762   28.7136   46.0034];
elseif t2 == 1
    rect = [201 49 34 10];
elseif t3 == 1
    rect = [168.9623   34.9254   23.1561    8.6449];
end
axes(handles.ori_pic);
imshow(ori_pic);
noise = imcrop(ori_pic,rect);
axes(handles.noise_pdf);
imhist(noise);

% --- Executes on button press in people.
function people_Callback(hObject, eventdata, handles)
% hObject    handle to people (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of people
global ori_pic genre ISO
genre = 'people_';
ori_pic = imread([genre,ISO,'.jpg']);
t1 = get(handles.ISOl,'value');
t2 = get(handles.ISOm,'value');
t3 = get(handles.ISOh,'value');
if t1 == 1
    rect = [131.2950   81.5463   15.4374   14.8199];
elseif t2 == 1
    rect = [172.0497   79.3851   33.6535   16.3636];
elseif t3 == 1
    rect = [163.4048   71.9751   30.2573   14.2024];
end
axes(handles.ori_pic);
imshow(ori_pic);
noise = imcrop(ori_pic,rect);
axes(handles.noise_pdf);
imhist(noise);

% --- Executes on button press in ISOl.
function ISOl_Callback(hObject, eventdata, handles)
% hObject    handle to ISOl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ISOl
global ori_pic genre ISO
ISO = 'ISOl_';
ori_pic = imread([genre,ISO,'.jpg']);
t1 = get(handles.indoors,'value');
t2 = get(handles.outdoors,'value');
t3 = get(handles.people,'value');
if t1 == 1
    rect = [83 141 37 37];
elseif t2 == 1
    rect = [137.1612  103.7762   28.7136   46.0034];
elseif t3 == 1
    rect = [131.2950   81.5463   15.4374   14.8199];
end
axes(handles.ori_pic);
imshow(ori_pic);
noise = imcrop(ori_pic,rect);
axes(handles.noise_pdf);
imhist(noise); 


% --- Executes on button press in ISOh.
function ISOh_Callback(hObject, eventdata, handles)
% hObject    handle to ISOh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ISOh
global ori_pic genre ISO
ISO = 'ISOh_';
ori_pic = imread([genre,ISO,'.jpg']);
t1 = get(handles.indoors,'value');
t2 = get(handles.outdoors,'value');
t3 = get(handles.people,'value');
if t1 == 1
    rect = [171.7410   89.5738   28.0961   15.7461];
elseif t2 == 1
    rect = [168.9623   34.9254   23.1561    8.6449];
elseif t3 == 1
    rect = [163.4048   71.9751   30.2573   14.2024];
end
axes(handles.ori_pic);
imshow(ori_pic);
noise = imcrop(ori_pic,rect);
axes(handles.noise_pdf);
imhist(noise);


% --- Executes on button press in mean.
function mean_Callback(hObject, eventdata, handles)
% hObject    handle to mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m
m = 3;
set(handles.sliderm,'value',0);
set(handles.m,'String','W = 3');
set(handles.m,'Visible','on');
set(handles.sliderm,'Visible','on');
set(handles.SW,'Visible','off');
set(handles.sliderSW,'Visible','off');
set(handles.CW,'Visible','off');
set(handles.sliderCW,'Visible','off');
% Hint: get(hObject,'Value') returns toggle state of mean


% --- Executes on button press in nonlocalmean.
function nonlocalmean_Callback(hObject, eventdata, handles)
% hObject    handle to nonlocalmean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SW CW
SW = 15;
CW = 3;
set(handles.sliderSW,'value',0);
set(handles.sliderCW,'value',0);
set(handles.SW,'String','SW = 15');
set(handles.CW,'String','CW = 3');
set(handles.m,'Visible','off');
set(handles.sliderm,'Visible','off');
set(handles.SW,'Visible','on');
set(handles.sliderSW,'Visible','on');
set(handles.CW,'Visible','on');
set(handles.sliderCW,'Visible','on');
% Hint: get(hObject,'Value') returns toggle state of nonlocalmean


% --- Executes on slider movement.
function sliderm_Callback(hObject, eventdata, handles)
% hObject    handle to sliderm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m
m = 3 + floor(7 * get(hObject, 'value'));
str = ['W=',num2str(m)];
set(handles.m,'String',str);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderSW_Callback(hObject, eventdata, handles)
% hObject    handle to sliderSW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SW
SW = 15+2 * floor(10 * get(hObject, 'value'));
str = ['SW=',num2str(SW)];
set(handles.SW,'String',str);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderSW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderSW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderCW_Callback(hObject, eventdata, handles)
% hObject    handle to sliderCW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CW
CW = 3 + 2 * floor(7 * get(hObject, 'value'));
str = ['CW=',num2str(CW)];
set(handles.CW,'String',str);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function sliderCW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderCW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in median.
function median_Callback(hObject, eventdata, handles)
% hObject    handle to median (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of median
global m
m = 3;
set(handles.sliderm,'value',0);
set(handles.m,'String','W = 3');
set(handles.m,'Visible','on');
set(handles.sliderm,'Visible','on');
set(handles.SW,'Visible','off');
set(handles.sliderSW,'Visible','off');
set(handles.CW,'Visible','off');
set(handles.sliderCW,'Visible','off');


% --- Executes on button press in max.
function max_Callback(hObject, eventdata, handles)
% hObject    handle to max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m
m = 3;
set(handles.sliderm,'value',0);
set(handles.m,'String','W = 3');
set(handles.m,'Visible','on');
set(handles.sliderm,'Visible','on');
set(handles.SW,'Visible','off');
set(handles.sliderSW,'Visible','off');
set(handles.CW,'Visible','off');
set(handles.sliderCW,'Visible','off');
% Hint: get(hObject,'Value') returns toggle state of max


% --- Executes on button press in min.
function min_Callback(hObject, eventdata, handles)
% hObject    handle to min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global m
m = 3;
set(handles.sliderm,'value',0);
set(handles.m,'String','W = 3');
set(handles.m,'Visible','on');
set(handles.sliderm,'Visible','on');
set(handles.SW,'Visible','off');
set(handles.sliderSW,'Visible','off');
set(handles.CW,'Visible','off');
set(handles.sliderCW,'Visible','off');
% Hint: get(hObject,'Value') returns toggle state of min
