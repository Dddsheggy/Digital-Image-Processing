function varargout = shootmoon(varargin)
% SHOOTMOON MATLAB code for shootmoon.fig
%      SHOOTMOON, by itself, creates a new SHOOTMOON or raises the existing
%      singleton*.
%
%      H = SHOOTMOON returns the handle to a new SHOOTMOON or the handle to
%      the existing singleton*.
%
%      SHOOTMOON('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOOTMOON.M with the given input arguments.
%
%      SHOOTMOON('Property','Value',...) creates a new SHOOTMOON or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before shootmoon_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to shootmoon_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help shootmoon

% Last Modified by GUIDE v2.5 19-Oct-2019 01:43:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @shootmoon_OpeningFcn, ...
                   'gui_OutputFcn',  @shootmoon_OutputFcn, ...
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


% --- Executes just before shootmoon is made visible.
function shootmoon_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to shootmoon (see VARARGIN)

% Choose default command line output for shootmoon
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.ISO_value,'String','');
set(handles.Shutter_value,'String','');
set(handles.Aperture_value,'String','');
img1 = imread('empty.jpg');
axes(handles.img);
imshow(img1);


% UIWAIT makes shootmoon wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = shootmoon_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ISO4000.
function ISO4000_Callback(hObject, eventdata, handles)
% hObject    handle to ISO4000 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ISO4000,'value',1)
set(handles.ISO2000,'value',0)
set(handles.ISO1000,'value',0)
set(handles.ISO_value,'String','4000');
% Hint: get(hObject,'Value') returns toggle state of ISO4000


% --- Executes on button press in ISO2000.
function ISO2000_Callback(hObject, eventdata, handles)
% hObject    handle to ISO2000 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ISO4000,'value',0)
set(handles.ISO2000,'value',1)
set(handles.ISO1000,'value',0)
set(handles.ISO_value,'String','2000');
% Hint: get(hObject,'Value') returns toggle state of ISO2000


% --- Executes on button press in ISO1000.
function ISO1000_Callback(hObject, eventdata, handles)
% hObject    handle to ISO1000 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.ISO4000,'value',0)
set(handles.ISO2000,'value',0)
set(handles.ISO1000,'value',1)
set(handles.ISO_value,'String','1000');
% Hint: get(hObject,'Value') returns toggle state of ISO1000


% --- Executes on button press in S400.
function S400_Callback(hObject, eventdata, handles)
% hObject    handle to S400 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.S400,'value',1)
set(handles.S200,'value',0)
set(handles.S100,'value',0)
set(handles.Shutter_value,'String','1/400');
% Hint: get(hObject,'Value') returns toggle state of S400


% --- Executes on button press in S200.
function S200_Callback(hObject, eventdata, handles)
% hObject    handle to S200 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.S400,'value',0)
set(handles.S200,'value',1)
set(handles.S100,'value',0)
set(handles.Shutter_value,'String','1/200');
% Hint: get(hObject,'Value') returns toggle state of S200


% --- Executes on button press in S100.
function S100_Callback(hObject, eventdata, handles)
% hObject    handle to S100 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.S400,'value',0)
set(handles.S200,'value',0)
set(handles.S100,'value',1)
set(handles.Shutter_value,'String','1/100');
% Hint: get(hObject,'Value') returns toggle state of S100


% --- Executes on button press in A6.
function A6_Callback(hObject, eventdata, handles)
% hObject    handle to A6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.A6,'value',1)
set(handles.A8,'value',0)
set(handles.A11,'value',0)
set(handles.Aperture_value,'String','6.3');
% Hint: get(hObject,'Value') returns toggle state of A6


% --- Executes on button press in A8.
function A8_Callback(hObject, eventdata, handles)
% hObject    handle to A8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.A6,'value',0)
set(handles.A8,'value',1)
set(handles.A11,'value',0)
set(handles.Aperture_value,'String','8');
% Hint: get(hObject,'Value') returns toggle state of A8


% --- Executes on button press in A11.
function A11_Callback(hObject, eventdata, handles)
% hObject    handle to A11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.A6,'value',0)
set(handles.A8,'value',0)
set(handles.A11,'value',1)
set(handles.Aperture_value,'String','11');
% Hint: get(hObject,'Value') returns toggle state of A11


% --- Executes on button press in show.
function show_Callback(hObject, eventdata, handles)
% hObject    handle to show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I1 = get(handles.ISO4000,'value');
I2 = get(handles.ISO2000,'value');
I3 = get(handles.ISO1000,'value');
if I1 == 1
    I = '1';
elseif I2 == 1
    I = '2';
elseif I3 == 1
    I = '3';
else
    I = '0';
end

S1 = get(handles.S400,'value');
S2 = get(handles.S200,'value');
S3 = get(handles.S100,'value');
if S1 == 1
    S = '1';
elseif S2 == 1
    S = '2';
elseif S3 == 1
    S = '3';
else
    S = '0';
end

A1 = get(handles.A6,'value');
A2 = get(handles.A8,'value');
A3 = get(handles.A11,'value');
if A1 == 1
    A = '1';
elseif A2 == 1
    A = '2';
elseif A3 == 1
    A = '3';
else
    A = '0';
end

show = [I, S, A];
switch show
    case '111'
        img1 = imread('4000-400-6.3.jpg');
        axes(handles.img);
        imshow(img1);
    case '112'
        img1 = imread('4000-400-8.jpg');
        axes(handles.img);
        imshow(img1);
    case '113'
        img1 = imread('4000-400-11.jpg');
        axes(handles.img);
        imshow(img1);
    case '121'
        img1 = imread('4000-200-6.3.jpg');
        axes(handles.img);
        imshow(img1);
    case '122'
        img1 = imread('4000-200-8.jpg');
        axes(handles.img);
        imshow(img1);
    case '123'
        img1 = imread('4000-200-11.jpg');
        axes(handles.img);
        imshow(img1);
    case '131'
        img1 = imread('4000-100-6.3.jpg');
        axes(handles.img);
        imshow(img1);
    case '132'
        img1 = imread('4000-100-8.jpg');
        axes(handles.img);
        imshow(img1);
    case '133'
        img1 = imread('4000-100-11.jpg');
        axes(handles.img);
        imshow(img1);
    case '211'
        img1 = imread('2000-400-6.3.jpg');
        axes(handles.img);
        imshow(img1);
    case '212'
        img1 = imread('2000-400-8.jpg');
        axes(handles.img);
        imshow(img1);
    case '213'
        img1 = imread('2000-400-11.jpg');
        axes(handles.img);
        imshow(img1);
    case '221'
        img1 = imread('2000-200-6.3.jpg');
        axes(handles.img);
        imshow(img1);
    case '222'
        img1 = imread('2000-200-8.jpg');
        axes(handles.img);
        imshow(img1);
    case '223'
        img1 = imread('2000-200-11.jpg');
        axes(handles.img);
        imshow(img1);
    case '231'
        img1 = imread('2000-100-6.3.jpg');
        axes(handles.img);
        imshow(img1);
    case '232'
        img1 = imread('2000-100-8.jpg');
        axes(handles.img);
        imshow(img1);
    case '233'
        img1 = imread('2000-100-11.jpg');
        axes(handles.img);
        imshow(img1);
    case '311'
        img1 = imread('1000-400-6.3.jpg');
        axes(handles.img);
        imshow(img1);
    case '312'
        img1 = imread('1000-400-8.jpg');
        axes(handles.img);
        imshow(img1);
    case '313'
        img1 = imread('1000-400-11.jpg');
        axes(handles.img);
        imshow(img1);
    case '321'
        img1 = imread('1000-200-6.3.jpg');
        axes(handles.img);
        imshow(img1);
    case '322'
        img1 = imread('1000-200-8.jpg');
        axes(handles.img);
        imshow(img1);
    case '323'
        img1 = imread('1000-200-11.jpg');
        axes(handles.img);
        imshow(img1);
    case '331'
        img1 = imread('1000-100-6.3.jpg');
        axes(handles.img);
        imshow(img1);
    case '332'
        img1 = imread('1000-100-8.jpg');
        axes(handles.img);
        imshow(img1);
    case '333'
        img1 = imread('1000-100-11.jpg');
        axes(handles.img);
        imshow(img1);
    otherwise
        h=warndlg('expected more arguments','warning','modal');
        img1 = imread('empty.jpg');
        axes(handles.img);
        imshow(img1);
end

set(handles.ISO4000,'value',0)
set(handles.ISO2000,'value',0)
set(handles.ISO1000,'value',0)
set(handles.S400,'value',0)
set(handles.S200,'value',0)
set(handles.S100,'value',0)
set(handles.A6,'value',0)
set(handles.A8,'value',0)
set(handles.A11,'value',0)
set(handles.ISO_value,'String','');
set(handles.Shutter_value,'String','');
set(handles.Aperture_value,'String','');