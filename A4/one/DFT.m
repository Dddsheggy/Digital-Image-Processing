function varargout = DFT(varargin)
% DFT MATLAB code for DFT.fig
%      DFT, by itself, creates a new DFT or raises the existing
%      singleton*.
%
%      H = DFT returns the handle to a new DFT or the handle to
%      the existing singleton*.
%
%      DFT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DFT.M with the given input arguments.
%
%      DFT('Property','Value',...) creates a new DFT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DFT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DFT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DFT

% Last Modified by GUIDE v2.5 31-Oct-2019 11:33:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DFT_OpeningFcn, ...
                   'gui_OutputFcn',  @DFT_OutputFcn, ...
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


% --- Executes just before DFT is made visible.
function DFT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DFT (see VARARGIN)

% Choose default command line output for DFT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DFT wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global m i center_x center_y rec_or_im;
m = 256;
i = complex(0, 1);
rec_or_im = 2;
set(handles.long_edge,'String','不可选');
set(handles.slide_long_edge,'Enable','off');
set(handles.ratio,'String','不可选');
set(handles.slide_ratio,'Enable','off');
set(handles.rotate,'String','不可选');
set(handles.slide_rotate,'Enable','off');
set(handles.tan,'String','不可选');
set(handles.slide_tan,'Enable','off');
set(handles.fre,'String','不可选');
set(handles.slide_fre,'Enable','off');
set(handles.phase,'String','不可选');
set(handles.slide_phase,'Enable','off');
set(handles.sigma,'String','不可选');
set(handles.slide_sigma,'Enable','off');
impulse_fun = zeros(m, m);
center_x = 1;
center_y = 1;
impulse_fun(center_x, center_y) = 1;
axes(handles.original);
imshow(impulse_fun);
impulse_DFT = my_DFT(impulse_fun, m);
center_DFT = fftshift(impulse_DFT);
axes(handles.abs);
imshow(abs(center_DFT));
axes(handles.angle);
imshow(angle(center_DFT));
axes(handles.surf_original);
surf(impulse_fun);
axis([1 256 1 256 0 1]);
shading interp;
axes(handles.surf_abs);
surf(abs(center_DFT));
axis([1 256 1 256 0 2]);
shading interp;
axes(handles.surf_angle);
surf(angle(center_DFT));
shading interp;
% --- Outputs from this function are returned to the command line.
function varargout = DFT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slide_center_x_Callback(hObject, eventdata, handles)
% hObject    handle to slide_center_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global m center_x center_y rec_or_im long_edge ratio rotate;
center_x = 50+floor(150 * get(hObject, 'value'));
set(handles.center_x,'String', num2str(center_x));
if(rec_or_im == 1)
    rec_or_im = 1;
    rec_fun = zeros(m, m);
    short_edge = long_edge * ratio;
    rec_fun(center_x - long_edge:center_x + long_edge, center_y - short_edge:center_y + short_edge) = 1;
    rec_fun = imrotate(rec_fun,rotate,'bilinear','crop');
    axes(handles.original);
    imshow(rec_fun);
    rec_DFT = my_DFT(rec_fun, m);
    center_DFT = fftshift(rec_DFT);
    axes(handles.abs);
    imshow(abs(center_DFT));
    axes(handles.angle);
    imshow(angle(center_DFT));
    axes(handles.surf_original);
    surf(rec_fun);
    shading interp;
    axes(handles.surf_abs);
    surf(abs(center_DFT));
    shading interp;
    axes(handles.surf_angle);
    surf(angle(center_DFT));
    shading interp;
else
    impulse_fun = zeros(m, m);
    impulse_fun(center_x, center_y) = 1;
    axes(handles.original);
    imshow(impulse_fun);
    impulse_DFT = my_DFT(impulse_fun, m);
    center_DFT = fftshift(impulse_DFT);
    axes(handles.abs);
    imshow(abs(center_DFT));
    axes(handles.angle);
    imshow(angle(center_DFT));
    axes(handles.surf_original);
    surf(impulse_fun);
    axis([1 256 1 256 0 1]);
    shading interp;
    axes(handles.surf_abs);
    surf(abs(center_DFT));
    axis([1 256 1 256 0 2]);
    shading interp;
    axes(handles.surf_angle);
    surf(angle(center_DFT));
    shading interp;
end


% --- Executes during object creation, after setting all properties.
function slide_center_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slide_center_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slide_center_y_Callback(hObject, eventdata, handles)
% hObject    handle to slide_center_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global m center_x center_y rec_or_im long_edge ratio rotate;
center_y = 50+floor(150 * get(hObject, 'value'));
set(handles.center_y,'String', num2str(center_y));
if(rec_or_im == 1)
    rec_or_im = 1;
    rec_fun = zeros(m, m);
    short_edge = long_edge * ratio;
    rec_fun(center_x - long_edge:center_x + long_edge, center_y - short_edge:center_y + short_edge) = 1;
    rec_fun = imrotate(rec_fun,rotate,'bilinear','crop');
    axes(handles.original);
    imshow(rec_fun);
    rec_DFT = my_DFT(rec_fun, m);
    center_DFT = fftshift(rec_DFT);
    axes(handles.abs);
    imshow(abs(center_DFT));
    axes(handles.angle);
    imshow(angle(center_DFT));
    axes(handles.surf_original);
    surf(rec_fun);
    shading interp;
    axes(handles.surf_abs);
    surf(abs(center_DFT));
    shading interp;
    axes(handles.surf_angle);
    surf(angle(center_DFT));
    shading interp;
else
    impulse_fun = zeros(m, m);
    impulse_fun(center_x, center_y) = 1;
    axes(handles.original);
    imshow(impulse_fun);
    impulse_DFT = my_DFT(impulse_fun, m);
    center_DFT = fftshift(impulse_DFT);
    axes(handles.abs);
    imshow(abs(center_DFT));
    axes(handles.angle);
    imshow(angle(center_DFT));
    axes(handles.surf_original);
    surf(impulse_fun);
    axis([1 256 1 256 0 1]);
    shading interp;
    axes(handles.surf_abs);
    surf(abs(center_DFT));
    axis([1 256 1 256 0 2]);
    shading interp;
    axes(handles.surf_angle);
    surf(angle(center_DFT));
    shading interp;
end


% --- Executes during object creation, after setting all properties.
function slide_center_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slide_center_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slide_long_edge_Callback(hObject, eventdata, handles)
% hObject    handle to slide_long_edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global m center_x center_y long_edge ratio rotate;
A = [m - center_x m - center_y center_x center_y];
max_edge = min(A) - 30;
long_edge = 10+floor(max_edge * get(hObject, 'value'));
set(handles.long_edge,'String', num2str(long_edge));
rec_fun = zeros(m, m);
short_edge = long_edge * ratio;
rec_fun(center_x - long_edge:center_x + long_edge, center_y - short_edge:center_y + short_edge) = 1;
rec_fun = imrotate(rec_fun,rotate,'bilinear','crop');
axes(handles.original);
imshow(rec_fun);
rec_DFT = my_DFT(rec_fun, m);
center_DFT = fftshift(rec_DFT);
axes(handles.abs);
imshow(abs(center_DFT));
axes(handles.angle);
imshow(angle(center_DFT));
axes(handles.surf_original);
surf(rec_fun);
shading interp;
axes(handles.surf_abs);
surf(abs(center_DFT));
shading interp;
axes(handles.surf_angle);
surf(angle(center_DFT));
shading interp;



% --- Executes during object creation, after setting all properties.
function slide_long_edge_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slide_long_edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slide_ratio_Callback(hObject, eventdata, handles)
% hObject    handle to slide_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global m center_x center_y long_edge ratio rotate;
ratio = 0.3+get(hObject, 'value')/2.5;
set(handles.ratio,'String', num2str(ratio));
rec_fun = zeros(m, m);
short_edge = long_edge * ratio;
rec_fun(center_x - long_edge:center_x + long_edge, center_y - short_edge:center_y + short_edge) = 1;
rec_fun = imrotate(rec_fun,rotate,'bilinear','crop');
axes(handles.original);
imshow(rec_fun);
rec_DFT = my_DFT(rec_fun, m);
center_DFT = fftshift(rec_DFT);
axes(handles.abs);
imshow(abs(center_DFT));
axes(handles.angle);
imshow(angle(center_DFT));
axes(handles.surf_original);
surf(rec_fun);
shading interp;
axes(handles.surf_abs);
surf(abs(center_DFT));
shading interp;
axes(handles.surf_angle);
surf(angle(center_DFT));
shading interp;


% --- Executes during object creation, after setting all properties.
function slide_ratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slide_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slide_rotate_Callback(hObject, eventdata, handles)
% hObject    handle to slide_rotate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global m center_x center_y long_edge ratio rotate;
rotate = 360 * get(hObject, 'value');
set(handles.rotate,'String', num2str(rotate));
rec_fun = zeros(m, m);
short_edge = long_edge * ratio;
rec_fun(center_x - long_edge:center_x + long_edge, center_y - short_edge:center_y + short_edge) = 1;
rec_fun = imrotate(rec_fun,rotate,'bilinear','crop');
axes(handles.original);
imshow(rec_fun);
rec_DFT = my_DFT(rec_fun, m);
center_DFT = fftshift(rec_DFT);
axes(handles.abs);
imshow(abs(center_DFT));
axes(handles.angle);
imshow(angle(center_DFT));
axes(handles.surf_original);
surf(rec_fun);
shading interp;
axes(handles.surf_abs);
surf(abs(center_DFT));
shading interp;
axes(handles.surf_angle);
surf(angle(center_DFT));
shading interp;



% --- Executes during object creation, after setting all properties.
function slide_rotate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slide_rotate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slide_tan_Callback(hObject, eventdata, handles)
% hObject    handle to slide_tan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global m tan fre phase;
tan = pi * get(hObject, 'value');
set(handles.tan,'String', [num2str(get(hObject, 'value')),'π']);
[X, Y] = meshgrid(1:m);
sin_fun = cos(2*pi*fre*(cos(tan)*X+sin(tan)*Y) + phase);
axes(handles.original);
imshow(sin_fun);
sin_DFT = my_DFT(sin_fun, m);
center_DFT = fftshift(sin_DFT);
axes(handles.abs);
imshow(abs(center_DFT));
axes(handles.angle);
imshow(angle(center_DFT));
axes(handles.surf_original);
surf(sin_fun);
shading interp;
axes(handles.surf_abs);
surf(abs(center_DFT));
shading interp;
axes(handles.surf_angle);
surf(angle(center_DFT));
shading interp;


% --- Executes during object creation, after setting all properties.
function slide_tan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slide_tan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slide_fre_Callback(hObject, eventdata, handles)
% hObject    handle to slide_fre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global m tan fre phase;
fre = 0.3 * get(hObject, 'value');
set(handles.fre,'String', num2str(fre));
[X, Y] = meshgrid(1:m);
sin_fun = cos(2*pi*fre*(cos(tan)*X+sin(tan)*Y) + phase);
axes(handles.original);
imshow(sin_fun);
sin_DFT = my_DFT(sin_fun, m);
center_DFT = fftshift(sin_DFT);
axes(handles.abs);
imshow(abs(center_DFT));
axes(handles.angle);
imshow(angle(center_DFT));
axes(handles.surf_original);
surf(sin_fun);
shading interp;
axes(handles.surf_abs);
surf(abs(center_DFT));
shading interp;
axes(handles.surf_angle);
surf(angle(center_DFT));
shading interp;


% --- Executes during object creation, after setting all properties.
function slide_fre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slide_fre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slide_phase_Callback(hObject, eventdata, handles)
% hObject    handle to slide_phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global m tan fre phase;
phase = pi * get(hObject, 'value');
set(handles.phase,'String', [num2str(get(hObject, 'value')),'π']);
[X, Y] = meshgrid(1:m);
sin_fun = cos(2*pi*fre*(cos(tan)*X+sin(tan)*Y) + phase);
axes(handles.original);
imshow(sin_fun);
sin_DFT = my_DFT(sin_fun, m);
center_DFT = fftshift(sin_DFT);
axes(handles.abs);
imshow(abs(center_DFT));
axes(handles.angle);
imshow(angle(center_DFT));
axes(handles.surf_original);
surf(sin_fun);
shading interp;
axes(handles.surf_abs);
surf(abs(center_DFT));
shading interp;
axes(handles.surf_angle);
surf(angle(center_DFT));
shading interp;


% --- Executes during object creation, after setting all properties.
function slide_phase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slide_phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slide_sigma_Callback(hObject, eventdata, handles)
% hObject    handle to slide_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global m sigma_sqr;
sigma_sqr = max(1,floor(1000 * get(hObject, 'value')));
set(handles.sigma,'String', num2str(sigma_sqr));
gauss_fun = zeros(m, m);
center = m/2;
for s=1:m
    for t=1:m
        gauss_fun(s,t) = exp(-((s-1-center)^2+(t-1-center)^2) / (2*sigma_sqr));
    end
end
gauss_fun = gauss_fun ./ (2*pi*sigma_sqr);
axes(handles.original);
imshow(gauss_fun,[]);
gauss_DFT = my_DFT(gauss_fun,m);
center_DFT = fftshift(gauss_DFT);
axes(handles.abs);
imshow(abs(center_DFT));
axes(handles.angle);
imshow(angle(center_DFT));
axes(handles.surf_original);
surf(gauss_fun);
shading interp;
axes(handles.surf_abs);
surf(abs(center_DFT));
shading interp;
axes(handles.surf_angle);
surf(angle(center_DFT));
shading interp;


% --- Executes during object creation, after setting all properties.
function slide_sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slide_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in choose_impulse.
function choose_impulse_Callback(hObject, eventdata, handles)
% hObject    handle to choose_impulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of choose_impulse
global m i center_x center_y rec_or_im;
impulse_fun = zeros(m, m);
center_x = 1;
center_y = 1;
rec_or_im = 2;
set(handles.center_x,'String','1');
set(handles.center_y,'String','1');
set(handles.slide_center_x,'Enable','on');
set(handles.slide_center_y,'Enable','on');
set(handles.slide_center_x,'value',0);
set(handles.slide_center_y,'value',0);
set(handles.long_edge,'String','不可选');
set(handles.slide_long_edge,'Enable','off');
set(handles.ratio,'String','不可选');
set(handles.slide_ratio,'Enable','off');
set(handles.rotate,'String','不可选');
set(handles.slide_rotate,'Enable','off');
set(handles.tan,'String','不可选');
set(handles.slide_tan,'Enable','off');
set(handles.fre,'String','不可选');
set(handles.slide_fre,'Enable','off');
set(handles.phase,'String','不可选');
set(handles.slide_phase,'Enable','off');
set(handles.sigma,'String','不可选');
set(handles.slide_sigma,'Enable','off');
impulse_fun(center_x, center_y) = 1;
axes(handles.original);
imshow(impulse_fun);
impulse_DFT = my_DFT(impulse_fun, m);
center_DFT = fftshift(impulse_DFT);
axes(handles.abs);
imshow(abs(center_DFT));
axes(handles.angle);
imshow(angle(center_DFT));
axes(handles.surf_original);
surf(impulse_fun);
axis([1 256 1 256 0 1]);
shading interp;
axes(handles.surf_abs);
surf(abs(center_DFT));
axis([1 256 1 256 0 2]);
shading interp;
axes(handles.surf_angle);
surf(angle(center_DFT));
shading interp;



% --- Executes on button press in choose_sin.
function choose_sin_Callback(hObject, eventdata, handles)
% hObject    handle to choose_sin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of choose_sin
global m tan fre phase;
tan = 0;
fre = 0;
phase = 0;
set(handles.center_x,'String','不可选');
set(handles.center_y,'String','不可选');
set(handles.slide_center_x,'Enable','off');
set(handles.slide_center_y,'Enable','off');
set(handles.long_edge,'String','不可选');
set(handles.slide_long_edge,'Enable','off');
set(handles.ratio,'String','不可选');
set(handles.slide_ratio,'Enable','off');
set(handles.rotate,'String','不可选');
set(handles.slide_rotate,'Enable','off');
set(handles.tan,'String','0π');
set(handles.slide_tan,'Enable','on');
set(handles.slide_tan,'value',0);
set(handles.fre,'String','0');
set(handles.slide_fre,'Enable','on');
set(handles.slide_fre,'value',0);
set(handles.phase,'String','0');
set(handles.slide_phase,'Enable','on');
set(handles.slide_phase,'value',0);
set(handles.sigma,'String','不可选');
set(handles.slide_sigma,'Enable','off');
[X, Y] = meshgrid(1:m);
sin_fun = cos(2*pi*fre*(cos(tan)*X+sin(tan)*Y)+phase);
axes(handles.original);
imshow(sin_fun);
sin_DFT = my_DFT(sin_fun, m);
center_DFT = fftshift(sin_DFT);
axes(handles.abs);
imshow(abs(center_DFT));
axes(handles.angle);
imshow(angle(center_DFT));
axes(handles.surf_original);
surf(sin_fun);
shading interp;
axes(handles.surf_abs);
surf(abs(center_DFT));
shading interp;
axes(handles.surf_angle);
surf(angle(center_DFT));
shading interp;


% --- Executes on button press in choose_rec.
function choose_rec_Callback(hObject, eventdata, handles)
% hObject    handle to choose_rec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of choose_rec
global m center_x center_y long_edge ratio rotate rec_or_im;
set(handles.center_x,'String','50');
set(handles.center_y,'String','50');
set(handles.slide_center_x,'Enable','on');
set(handles.slide_center_y,'Enable','on');
set(handles.slide_center_x,'value',0);
set(handles.slide_center_y,'value',0);
set(handles.long_edge,'String','10');
set(handles.slide_long_edge,'Enable','on');
set(handles.slide_long_edge,'value',0);
set(handles.ratio,'String','0.3');
set(handles.slide_ratio,'Enable','on');
set(handles.slide_ratio,'value',0);
set(handles.rotate,'String','0');
set(handles.slide_rotate,'Enable','on');
set(handles.slide_rotate,'value',0);
set(handles.tan,'String','不可选');
set(handles.slide_tan,'Enable','off');
set(handles.fre,'String','不可选');
set(handles.slide_fre,'Enable','off');
set(handles.phase,'String','不可选');
set(handles.slide_phase,'Enable','off');
set(handles.sigma,'String','不可选');
set(handles.slide_sigma,'Enable','off');
center_x = 50;
center_y = 50;
long_edge = 10;
ratio = 0.3;
rotate = 0;
rec_or_im = 1;
rec_fun = zeros(m, m);
short_edge = long_edge * ratio;
rec_fun(center_x - long_edge:center_x + long_edge, center_y - short_edge:center_y + short_edge) = 1;
axes(handles.original);
imshow(rec_fun);
rec_DFT = my_DFT(rec_fun, m);
center_DFT = fftshift(rec_DFT);
axes(handles.abs);
imshow(abs(center_DFT));
axes(handles.angle);
imshow(angle(center_DFT));
axes(handles.surf_original);
surf(rec_fun);
shading interp;
axes(handles.surf_abs);
surf(abs(center_DFT));
shading interp;
axes(handles.surf_angle);
surf(angle(center_DFT));
shading interp;


% --- Executes on button press in choose_gauss.
function choose_gauss_Callback(hObject, eventdata, handles)
% hObject    handle to choose_gauss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of choose_gauss
global m sigma_sqr;
set(handles.center_x,'String','128');
set(handles.center_y,'String','128');
set(handles.slide_center_x,'Enable','off');
set(handles.slide_center_y,'Enable','off');
set(handles.slide_center_x,'value',0);
set(handles.slide_center_y,'value',0);
set(handles.long_edge,'String','不可选');
set(handles.slide_long_edge,'Enable','off');
set(handles.ratio,'String','不可选');
set(handles.slide_ratio,'Enable','off');
set(handles.rotate,'String','不可选');
set(handles.slide_rotate,'Enable','off');
set(handles.tan,'String','不可选');
set(handles.slide_tan,'Enable','off');
set(handles.fre,'String','不可选');
set(handles.slide_fre,'Enable','off');
set(handles.phase,'String','不可选');
set(handles.slide_phase,'Enable','off');
set(handles.sigma,'String','1');
set(handles.slide_sigma,'Enable','on');
set(handles.slide_sigma, 'value',0);
sigma_sqr = 1;
gauss_fun = zeros(m, m);
center = m/2;
for s=1:m
    for t=1:m
        gauss_fun(s,t) = exp(-((s-1-center)^2+(t-1-center)^2) / (2*sigma_sqr));
    end
end
gauss_fun = gauss_fun ./ (2*pi*sigma_sqr);
axes(handles.original);
imshow(gauss_fun, []);
gauss_DFT = my_DFT(gauss_fun, m);
center_DFT = fftshift(gauss_DFT);
axes(handles.abs);
imshow(abs(center_DFT));
axes(handles.angle);
imshow(angle(center_DFT));
axes(handles.surf_original);
surf(gauss_fun);
shading interp;
axes(handles.surf_abs);
surf(abs(center_DFT));
shading interp;
axes(handles.surf_angle);
surf(angle(center_DFT));
shading interp;