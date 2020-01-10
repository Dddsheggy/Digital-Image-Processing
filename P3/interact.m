function varargout = interact(varargin)
% INTERACT MATLAB code for interact.fig
%      INTERACT, by itself, creates a new INTERACT or raises the existing
%      singleton*.
%
%      H = INTERACT returns the handle to a new INTERACT or the handle to
%      the existing singleton*.
%
%      INTERACT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERACT.M with the given input arguments.
%
%      INTERACT('Property','Value',...) creates a new INTERACT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interact_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interact_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interact

% Last Modified by GUIDE v2.5 11-Dec-2019 10:05:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interact_OpeningFcn, ...
                   'gui_OutputFcn',  @interact_OutputFcn, ...
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


% --- Executes just before interact is made visible.
function interact_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interact (see VARARGIN)

% Choose default command line output for interact
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interact wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global op_pic final_pic changed k m i fnew bnew
op_pic=imread('1.jpg');
empty = imread('empty.jpg');
final_pic=empty;
k=1000;
m=10;
i=5;
axes(handles.op_pic);
imshow(op_pic);
axes(handles.final_pic);
imshow(final_pic);
axes(handles.slic_pic);
imshow(empty);
axes(handles.axes5);
imshow('info.jpg');
changed=1;
fnew=1;
bnew=1;
set(handles.uibuttongroup6,'Visible','off');
set(handles.pr,'Visible','off');


% --- Outputs from this function are returned to the command line.
function varargout = interact_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in tag.
function tag_Callback(hObject, eventdata, handles)
% hObject    handle to tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op_pic p1 h1 fnew foregroundInd
axes(handles.op_pic);
imshow(op_pic)
if fnew
    p1=ginput();
    p1(:,:)=round(p1(:,:));
    fnew=0;
    h1=impoly(gca,p1,'Closed',false);
else
    h1=impoly(gca,p1,'Closed',false);
    tmp_p=ginput();
    sp1=size(p1,1);
    stmp=size(tmp_p,1);
    p1(sp1+1:sp1+stmp,:)=tmp_p(:,:);
    p1(:,:)=round(p1(:,:));
    h1=impoly(gca,p1,'Closed',false);
end
foresub=getPosition(h1);
foregroundInd=sub2ind(size(op_pic),foresub(:,2),foresub(:,1));


% --- Executes on button press in back_tag.
function back_tag_Callback(hObject, eventdata, handles)
% hObject    handle to back_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op_pic p2 h2 bnew backgroundInd
axes(handles.op_pic);
imshow(op_pic)
if bnew
    p2=ginput();
    p2(:,:)=round(p2(:,:));
    bnew=0;
    h2=impoly(gca,p2,'Closed',false);
else
    h2=impoly(gca,p2,'Closed',false);
    tmp_p=ginput();
    sp1=size(p2,1);
    stmp=size(tmp_p,1);
    p2(sp1+1:sp1+stmp,:)=tmp_p(:,:);
    p2(:,:)=round(p2(:,:));
    h2=impoly(gca,p2,'Closed',false);
end
backsub=getPosition(h2);
backgroundInd=sub2ind(size(op_pic),backsub(:,2),backsub(:,1));

% --- Executes on button press in generate.
function generate_Callback(hObject, eventdata, handles)
% hObject    handle to generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global changed op_pic final_pic slic_pic k m i  foregroundInd backgroundInd info info1 info2 L1 L2 pr_pic pr_info
if changed==1
    [slic_pic,info,L1,L2,info1,info2]=slic(op_pic,k,m,2,i);
    pr_pic=slic_pic;
    pr_info=info;
    BW = boundarymask(pr_pic);
    axes(handles.slic_pic);
    imshow(imoverlay(op_pic,BW,'cyan'),'InitialMagnification',67);
    hold on
    plot(pr_info(2,:),pr_info(1,:),'*r')
    hold off
    changed=0;
    set(handles.uibuttongroup6,'Visible','on');
    set(handles.slic_and_center,'value',1);
    set(handles.pr,'Visible','on');
    set(handles.final,'value',1);
    str=['迭代次数 = ',num2str(i)];
    set(handles.final,'String',str);
    if(i==10)
        str1='迭代次数 = 5';
        set(handles.pr1,'String',str1);
        str2='迭代次数 = 2';
        set(handles.pr2,'String',str2);
    elseif(i==5)
        str1='迭代次数 = 3';
        set(handles.pr1,'String',str1);
        str2='迭代次数 = 1';
        set(handles.pr2,'String',str2);
    else
        str1='迭代次数 = 15';
        set(handles.pr1,'String',str1);
        str2='迭代次数 = 5';
        set(handles.pr2,'String',str2);
    end
end
pic=lazysnapping(op_pic,slic_pic,foregroundInd,backgroundInd);
final_pic = op_pic;
final_pic(repmat(~pic,[1 1 3])) = 0;
axes(handles.final_pic);
imshow(final_pic);

% --- Executes on button press in getback.
function getback_Callback(hObject, eventdata, handles)
% hObject    handle to getback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA) 
global op_pic final_pic fnew bnew
empty = imread('empty.jpg');
final_pic=empty;
axes(handles.op_pic);
imshow(op_pic);
axes(handles.final_pic);
imshow(final_pic);
fnew=1;
bnew=1;

% --- Executes on button press in choose_1.
function choose_1_Callback(hObject, eventdata, handles)
% hObject    handle to choose_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of choose_1
global op_pic final_pic changed fnew bnew
op_pic=imread('1.jpg');
empty = imread('empty.jpg');
final_pic=empty;
axes(handles.op_pic);
imshow(op_pic);
axes(handles.final_pic);
imshow(final_pic);
changed=1;
fnew=1;
bnew=1;
set(handles.slic_and_center,'value',1);
set(handles.uibuttongroup6,'Visible','off');
set(handles.pr,'Visible','off');
 axes(handles.slic_pic);
 imshow('empty.jpg');



% --- Executes on button press in choose_2.
function choose_2_Callback(hObject, eventdata, handles)
% hObject    handle to choose_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of choose_2
global op_pic final_pic changed fnew bnew
op_pic=imread('2.jpg');
empty = imread('empty.jpg');
final_pic=empty;
axes(handles.op_pic);
imshow(op_pic);
axes(handles.final_pic);
imshow(final_pic);
changed=1;
fnew=1;
bnew=1;
set(handles.slic_and_center,'value',1);
set(handles.uibuttongroup6,'Visible','off');
set(handles.pr,'Visible','off');
 axes(handles.slic_pic);
 imshow('empty.jpg');

function choose_3_Callback(hObject, eventdata, handles)
% hObject    handle to choose_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of choose_3
global op_pic final_pic changed fnew bnew
op_pic=imread('3.jpg');
empty = imread('empty.jpg');
final_pic=empty;
axes(handles.op_pic);
imshow(op_pic);
axes(handles.final_pic);
imshow(final_pic);
changed=1;
fnew=1;
bnew=1;
set(handles.slic_and_center,'value',1);
set(handles.uibuttongroup6,'Visible','off');
set(handles.pr,'Visible','off');
 axes(handles.slic_pic);
 imshow('empty.jpg');


% --- Executes on button press in k_1000.
function k_1000_Callback(hObject, eventdata, handles)
% hObject    handle to k_1000 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of k_1000
global k changed  
k=1000;
changed=1;
set(handles.slic_and_center,'value',1);
set(handles.uibuttongroup6,'Visible','off');
set(handles.pr,'Visible','off');
axes(handles.slic_pic);
imshow('empty.jpg');


% --- Executes on button press in k_3000.
function k_3000_Callback(hObject, eventdata, handles)
% hObject    handle to k_3000 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of k_3000
global k changed 
k=3000;
changed=1;
set(handles.slic_and_center,'value',1);
set(handles.uibuttongroup6,'Visible','off');
set(handles.pr,'Visible','off');
axes(handles.slic_pic);
imshow('empty.jpg');


% --- Executes on button press in k_6000.
function k_6000_Callback(hObject, eventdata, handles)
% hObject    handle to k_6000 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of k_6000
global k changed 
k=6000;
changed=1;
set(handles.slic_and_center,'value',1);
set(handles.uibuttongroup6,'Visible','off');
set(handles.pr,'Visible','off');
axes(handles.slic_pic);
imshow('empty.jpg');



% --- Executes on button press in m_10.
function m_10_Callback(hObject, eventdata, handles)
% hObject    handle to m_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of m_10
global m changed 
m=10;
changed=1;
set(handles.slic_and_center,'value',1);
set(handles.uibuttongroup6,'Visible','off');
set(handles.pr,'Visible','off');
axes(handles.slic_pic);
imshow('empty.jpg');


function m_20_Callback(hObject, eventdata, handles)
% hObject    handle to m_20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of m_20
global m changed
m=20;
changed=1;
set(handles.slic_and_center,'value',1);
set(handles.uibuttongroup6,'Visible','off');
set(handles.pr,'Visible','off');
 axes(handles.slic_pic);
 imshow('empty.jpg');


% --- Executes on button press in m_30.
function m_30_Callback(hObject, eventdata, handles)
% hObject    handle to m_30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of m_30
global m changed
m=30;
changed=1;
set(handles.slic_and_center,'value',1);
set(handles.uibuttongroup6,'Visible','off');
set(handles.pr,'Visible','off');
 axes(handles.slic_pic);
 imshow('empty.jpg');


% --- Executes on button press in i_5.
function i_5_Callback(hObject, eventdata, handles)
% hObject    handle to i_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of i_5
global i changed
i=5;
changed=1;
set(handles.slic_and_center,'value',1);
set(handles.uibuttongroup6,'Visible','off');
set(handles.pr,'Visible','off');
 axes(handles.slic_pic);
 imshow('empty.jpg');


% --- Executes on button press in i_10.
function i_10_Callback(hObject, eventdata, handles)
% hObject    handle to i_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of i_10
global i changed
i=10;
changed=1;
set(handles.slic_and_center,'value',1);
set(handles.uibuttongroup6,'Visible','off');
set(handles.pr,'Visible','off');
 axes(handles.slic_pic);
 imshow('empty.jpg');


% --- Executes on button press in i_20.
function i_20_Callback(hObject, eventdata, handles)
% hObject    handle to i_20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of i_20
global i changed
i=20;
changed=1;
set(handles.slic_and_center,'value',1);
set(handles.uibuttongroup6,'Visible','off');
set(handles.pr,'Visible','off'); 
 axes(handles.slic_pic);
 imshow('empty.jpg');


% --- Executes on button press in slic_and_center.
function slic_and_center_Callback(hObject, eventdata, handles)
% hObject    handle to slic_and_center (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pr_pic pr_info op_pic
 BW = boundarymask(pr_pic);
 axes(handles.slic_pic);
 imshow(imoverlay(op_pic,BW,'cyan'),'InitialMagnification',67);
 hold on
 plot(pr_info(2,:),pr_info(1,:),'*r')
 hold off
% Hint: get(hObject,'Value') returns toggle state of slic_and_center


% --- Executes on button press in slic_only.
function slic_only_Callback(hObject, eventdata, handles)
% hObject    handle to slic_only (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op_pic pr_pic
 BW = boundarymask(pr_pic);
 axes(handles.slic_pic);
 imshow(imoverlay(op_pic,BW,'cyan'),'InitialMagnification',67);
% Hint: get(hObject,'Value') returns toggle state of slic_only


% --- Executes on button press in final.
function final_Callback(hObject, eventdata, handles)
% hObject    handle to final (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pr_pic pr_info slic_pic info op_pic
pr_pic=slic_pic;
pr_info=info;
tmp=get(handles.slic_only,'value');
if tmp==1
    BW = boundarymask(pr_pic);
    axes(handles.slic_pic);
     imshow(imoverlay(op_pic,BW,'cyan'),'InitialMagnification',67);
else
    BW = boundarymask(pr_pic);
    axes(handles.slic_pic);
     imshow(imoverlay(op_pic,BW,'cyan'),'InitialMagnification',67);
    hold on
    plot(pr_info(2,:),pr_info(1,:),'*r')
    hold off
end
% Hint: get(hObject,'Value') returns toggle state of final


% --- Executes on button press in pr1.
function pr1_Callback(hObject, eventdata, handles)
% hObject    handle to pr1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pr_pic pr_info L2 info2 op_pic
pr_pic=L2;
pr_info=info2;
tmp=get(handles.slic_only,'value');
if tmp==1
    BW = boundarymask(pr_pic);
    axes(handles.slic_pic);
     imshow(imoverlay(op_pic,BW,'cyan'),'InitialMagnification',67);
else
    BW = boundarymask(pr_pic);
    axes(handles.slic_pic);
     imshow(imoverlay(op_pic,BW,'cyan'),'InitialMagnification',67);
    hold on
    plot(pr_info(2,:),pr_info(1,:),'*r')
    hold off
end
% Hint: get(hObject,'Value') returns toggle state of pr1


% --- Executes on button press in pr2.
function pr2_Callback(hObject, eventdata, handles)
% hObject    handle to pr2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pr_pic pr_info L1 info1 op_pic
pr_pic=L1;
pr_info=info1;
tmp=get(handles.slic_only,'value');
if tmp==1
    BW = boundarymask(pr_pic);
    axes(handles.slic_pic);
     imshow(imoverlay(op_pic,BW,'cyan'),'InitialMagnification',67);
else
    BW = boundarymask(pr_pic);
    axes(handles.slic_pic);
     imshow(imoverlay(op_pic,BW,'cyan'),'InitialMagnification',67);
    hold on
    plot(pr_info(2,:),pr_info(1,:),'*r')
    hold off
end
% Hint: get(hObject,'Value') returns toggle state of pr2
