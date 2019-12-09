function varargout = clothes(varargin)
% CLOTHES MATLAB code for clothes.fig
%      CLOTHES, by itself, creates a new CLOTHES or raises the existing
%      singleton*.
%
%      H = CLOTHES returns the handle to a new CLOTHES or the handle to
%      the existing singleton*.
%
%      CLOTHES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLOTHES.M with the given input arguments.
%
%      CLOTHES('Property','Value',...) creates a new CLOTHES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before clothes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to clothes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help clothes

% Last Modified by GUIDE v2.5 20-Nov-2019 09:14:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @clothes_OpeningFcn, ...
                   'gui_OutputFcn',  @clothes_OutputFcn, ...
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


% --- Executes just before clothes is made visible.
function clothes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to clothes (see VARARGIN)

% Choose default command line output for clothes
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global pic_name ori_pic trans_pic sat_ratio hue_add rect point
point = [226   604];
rect = [1   389   458   398];
sat_ratio = 1;
hue_add = 0;
pic_name = 'white1';
ori_pic = imread([pic_name,'.jpg']);
trans_pic = ori_pic;
axes(handles.ori_pic);
imshow(ori_pic);
axes(handles.trans_pic);
imshow(trans_pic);
set(handles.sat_ratio,'String','未调整');
set(handles.hue_add,'String','未调整');
set(handles.slider_sat_ratio,'value',0.2);
set(handles.slider_hue_add,'value',0.5);
set(handles.white1,'value',1);
% UIWAIT makes clothes wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = clothes_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider_sat_ratio_Callback(hObject, eventdata, handles)
% hObject    handle to slider_sat_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_pic trans_pic sat_ratio hue_add rect point
sat_ratio = roundn(5*get(handles.slider_sat_ratio,'value'),-2);
if sat_ratio == 1
    set(handles.sat_ratio,'String','未调整');
else
    text = num2str(sat_ratio);
    text = ['×',text];
    set(handles.sat_ratio,'String',text);
end
trans_pic = TransPic( ori_pic, point, rect, sat_ratio, hue_add);
axes(handles.trans_pic);
imshow(trans_pic);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_sat_ratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_sat_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_hue_add_Callback(hObject, eventdata, handles)
% hObject    handle to slider_hue_add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ori_pic trans_pic sat_ratio hue_add rect point
hue_add = roundn(-0.1+0.2*get(handles.slider_hue_add,'value'),-3);
if hue_add == 0
    set(handles.hue_add,'String','未调整');
elseif hue_add >0
    text = num2str(hue_add);
    text = ['+',text];
    set(handles.hue_add,'String',text);
elseif hue_add < 0
    set(handles.hue_add,'String',num2str(hue_add));
end
trans_pic = TransPic( ori_pic, point, rect, sat_ratio, hue_add);
axes(handles.trans_pic);
imshow(trans_pic);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_hue_add_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_hue_add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in white1.
function white1_Callback(hObject, eventdata, handles)
% hObject    handle to white1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic_name ori_pic sat_ratio hue_add rect point
point = [226   604];
rect = [1   389   458   398];
sat_ratio = 1;
hue_add = 0;
pic_name = 'white1';
ori_pic = imread([pic_name,'.jpg']);
axes(handles.ori_pic);
imshow(ori_pic);
axes(handles.trans_pic);
imshow(ori_pic);
set(handles.sat_ratio,'String','未调整');
set(handles.hue_add,'String','未调整');
set(handles.slider_sat_ratio,'value',0.2);
set(handles.slider_hue_add,'value',0.5);
% Hint: get(hObject,'Value') returns toggle state of white1


% --- Executes on button press in red1.
function red1_Callback(hObject, eventdata, handles)
% hObject    handle to red1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic_name ori_pic sat_ratio hue_add rect point
point = [184   480];
rect = [40   286   373   487];
sat_ratio = 1;
hue_add = 0;
pic_name = 'red1';
ori_pic = imread([pic_name,'.jpg']);
axes(handles.ori_pic);
imshow(ori_pic);
axes(handles.trans_pic);
imshow(ori_pic);
set(handles.sat_ratio,'String','未调整');
set(handles.hue_add,'String','未调整');
set(handles.slider_sat_ratio,'value',0.2);
set(handles.slider_hue_add,'value',0.5);
% Hint: get(hObject,'Value') returns toggle state of red1


% --- Executes on button press in orange1.
function orange1_Callback(hObject, eventdata, handles)
% hObject    handle to orange1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic_name ori_pic sat_ratio hue_add rect point
point = [107   310];
rect = [39   135   122   330];
sat_ratio = 1;
hue_add = 0;
pic_name = 'orange1';
ori_pic = imread([pic_name,'.jpg']);
axes(handles.ori_pic);
imshow(ori_pic);
axes(handles.trans_pic);
imshow(ori_pic);
set(handles.sat_ratio,'String','未调整');
set(handles.hue_add,'String','未调整');
set(handles.slider_sat_ratio,'value',0.2);
set(handles.slider_hue_add,'value',0.5);
% Hint: get(hObject,'Value') returns toggle state of orange1


% --- Executes on button press in yellow1.
function yellow1_Callback(hObject, eventdata, handles)
% hObject    handle to yellow1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic_name ori_pic sat_ratio hue_add rect point
point = [147   381];
rect = [24   190   265   430];
sat_ratio = 1;
hue_add = 0;
pic_name = 'yellow1';
ori_pic = imread([pic_name,'.jpg']);
axes(handles.ori_pic);
imshow(ori_pic);
axes(handles.trans_pic);
imshow(ori_pic);
set(handles.sat_ratio,'String','未调整');
set(handles.hue_add,'String','未调整');
set(handles.slider_sat_ratio,'value',0.2);
set(handles.slider_hue_add,'value',0.5);
% Hint: get(hObject,'Value') returns toggle state of yellow1


% --- Executes on button press in green1.
function green1_Callback(hObject, eventdata, handles)
% hObject    handle to green1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic_name ori_pic sat_ratio hue_add rect point
point = [464   812];
rect = [122 647 825 1050];
sat_ratio = 1;
hue_add = 0;
pic_name = 'green1';
ori_pic = imread([pic_name,'.jpg']);
axes(handles.ori_pic);
imshow(ori_pic);
axes(handles.trans_pic);
imshow(ori_pic);
set(handles.sat_ratio,'String','未调整');
set(handles.hue_add,'String','未调整');
set(handles.slider_sat_ratio,'value',0.2);
set(handles.slider_hue_add,'value',0.5);
% Hint: get(hObject,'Value') returns toggle state of green1


% --- Executes on button press in blue1.
function blue1_Callback(hObject, eventdata, handles)
% hObject    handle to blue1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic_name ori_pic sat_ratio hue_add rect point
point = [1135 2601];
rect = [19 1653 2148 1800];
sat_ratio = 1;
hue_add = 0;
pic_name = 'blue1';
ori_pic = imread([pic_name,'.jpg']);
axes(handles.ori_pic);
imshow(ori_pic);
axes(handles.trans_pic);
imshow(ori_pic);
set(handles.sat_ratio,'String','未调整');
set(handles.hue_add,'String','未调整');
set(handles.slider_sat_ratio,'value',0.2);
set(handles.slider_hue_add,'value',0.5);
% Hint: get(hObject,'Value') returns toggle state of blue1


% --- Executes on button press in purple1.
function purple1_Callback(hObject, eventdata, handles)
% hObject    handle to purple1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic_name ori_pic sat_ratio hue_add rect point
point = [98   243];
rect = [21   156   164   189];
sat_ratio = 1;
hue_add = 0;
pic_name = 'purple1';
ori_pic = imread([pic_name,'.jpg']);
axes(handles.ori_pic);
imshow(ori_pic);
axes(handles.trans_pic);
imshow(ori_pic);
set(handles.sat_ratio,'String','未调整');
set(handles.hue_add,'String','未调整');
set(handles.slider_sat_ratio,'value',0.2);
set(handles.slider_hue_add,'value',0.5);
% Hint: get(hObject,'Value') returns toggle state of purple1


% --- Executes on button press in pink1.
function pink1_Callback(hObject, eventdata, handles)
% hObject    handle to pink1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic_name ori_pic sat_ratio hue_add rect point
point = [167   437];
rect = [19   255   273   439];
sat_ratio = 1;
hue_add = 0;
pic_name = 'pink1';
ori_pic = imread([pic_name,'.jpg']);
axes(handles.ori_pic);
imshow(ori_pic);
axes(handles.trans_pic);
imshow(ori_pic);
set(handles.sat_ratio,'String','未调整');
set(handles.hue_add,'String','未调整');
set(handles.slider_sat_ratio,'value',0.2);
set(handles.slider_hue_add,'value',0.5);
% Hint: get(hObject,'Value') returns toggle state of pink1


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic_name trans_pic sat_ratio hue_add
str = ['./result/',pic_name,'_s',num2str(sat_ratio),'_h',num2str(hue_add),'.jpg'];
imwrite(trans_pic,str);
