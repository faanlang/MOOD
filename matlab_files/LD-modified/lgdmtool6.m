function varargout = lgdmtool6(varargin)
% LGDMTOOL6 M-file for lgdmtool6.fig
%      LGDMTOOL6, by itself, creates a new LGDMTOOL5 or raises the existing
%      singleton*.
%
%      H = LGDMTOOL6 returns the handle to a new LGDMTOOL5 or the handle to
%      the existing singleton*.
%
%      LGDMTOOL6('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LGDMTOOL5.M with the given input arguments.
%
%      LGDMTOOL6('Property','Value',...) creates a new LGDMTOOL5 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lgdmtool4_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lgdmtool6_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lgdmtool6

% Last Modified by GUIDE v2.5 18-Apr-2009 16:07:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lgdmtool6_OpeningFcn, ...
                   'gui_OutputFcn',  @lgdmtool6_OutputFcn, ...
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

%% 
% --- Executes just before lgdmtool6 is made visible.
function lgdmtool6_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lgdmtool6 (see VARARGIN)

% Choose default command line output for lgdmtool6
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lgdmtool6 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%%   
% --- Outputs from this function are returned to the command line.
function varargout = lgdmtool6_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%   
% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)

v=get(hObject,'Value');
set(handles.edit1,'String',num2str(v));
evalin('base',['layeraxis6(lg,[' num2str(v) ' ' get(handles.edit4,'String') '])'])

%%   
% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Max',10);

%%   
function edit1_Callback(hObject, eventdata, handles)

v=str2double(get(hObject,'String'));
set(handles.slider1,'Value',v);
evalin('base',['layeraxis6(lg,[' num2str(v) ' ' get(handles.edit4,'String') '])'])

%%   
% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','0')

%%   
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

evalin('base',['lg=buildlgstruct6(' get(handles.edit16,'String') ',' get(handles.edit17,'String') ',' get(handles.edit25,'String') ')']);
ll=evalin('base','lg');
set(handles.edit3,'String',num2str(ll.numind));
set(handles.edit7,'String',num2str(ll.nobj));
set(handles.edit8,'String',num2str(ll.npar));
set(handles.edit4,'String',num2str(max(ll.slayer)));
evalin('base','lg.selpoint=[];');
set(handles.edit21,'String','');
set(handles.edit22,'String','');
set(handles.edit24,'String','[1,inf]');

%%   
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

evalin('base','lg=layergraph6(lg)')
ll=evalin('base','lg');
set(handles.slider2,'Max',100,'Min',0); % rango maximos 
rlactual=get(ll.axis(1),'Ylim'); % lee el rango de capas actual
set(handles.slider2,'Value',rlactual(2));
set(handles.edit4,'String',num2str(rlactual(2)));
set(handles.slider1,'Max',100,'Min',0); % rango maximos 
set(handles.slider1,'Value',rlactual(1));
set(handles.edit1,'String',num2str(rlactual(1)));
evalin('base','lg.selpoint=[];');
set(handles.edit21,'String','');
set(handles.edit22,'String','');
set(handles.edit24,'String','[1,inf]');

%%   
function edit3_Callback(hObject, eventdata, handles)



%%   
% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%   
% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)

v=get(hObject,'Value');
set(handles.edit4,'String',num2str(v));
evalin('base',['layeraxis6(lg,[' get(handles.edit1,'String') ' ' num2str(v) '])'])

%%   
% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value',10);

%%   
function edit4_Callback(hObject, eventdata, handles)

v=str2double(get(hObject,'String'));
set(handles.slider2,'Value',v);
evalin('base',['layeraxis6(lg,[' get(handles.edit1,'String') ' ' num2str(v) '])'])

%%   
% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','1')

%%   
% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)

%%   
% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%%   
function edit5_Callback(hObject, eventdata, handles)

%%   
% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%   
% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)

%%   
% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%%   
function edit6_Callback(hObject, eventdata, handles)

%%   
% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%   
function edit7_Callback(hObject, eventdata, handles)

%%   
% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%   
function edit8_Callback(hObject, eventdata, handles)

%%   
% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%   
function edit9_Callback(hObject, eventdata, handles)

set(handles.edit10,'String','0'); %pone a cero el display parametros
v=str2double(get(hObject,'String')); %lee el display objetivo
ll=evalin('base','lg');
rango=[ll.minps(v) ll.maxps(v)];% lee el rango maximo del eje del parametro
rangoactual=get(ll.axis(ll.nobj+v),'XLim');% lee el rango actual del parametro
set(handles.edit13,'String',num2str(rango(2))); % actualiza el max en el display
set(handles.slider6,'Max',rango(2),'Min',rango(1)); % actualiza el max en el deslizante
set(handles.slider6,'Value',rangoactual(2));
set(handles.edit12,'String',num2str(rango(1))); % actualiza el min en el display
set(handles.slider5,'Max',rango(2),'Min',rango(1));% actualiza el min en el deslizante
set(handles.slider5,'Value',rangoactual(1)); 

%%   
% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%   
function edit10_Callback(hObject, eventdata, handles)

set(handles.edit9,'String','0'); %pone a cero el display parametros
v=str2double(get(hObject,'String')); %lee el display objetivo
ll=evalin('base','lg');
rango=[ll.minpf(v) ll.maxpf(v)];% lee el rango maximo del eje del objetivo
rangoactual=get(ll.axis(v),'XLim');% lee el rango actual del eje del objetivo
set(handles.edit13,'String',num2str(rango(2))); % actualiza el max en el display
set(handles.slider6,'Max',rango(2),'Min',rango(1)); % actualiza el max en el deslizante
set(handles.slider6,'Value',rangoactual(2));
set(handles.edit12,'String',num2str(rango(1))); % actualiza el min en el display
set(handles.slider5,'Max',rango(2),'Min',rango(1));% actualiza el min en el deslizante
set(handles.slider5,'Value',rangoactual(1)); 

%%   
% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%   
% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)

v=get(hObject,'Value');
set(handles.edit12,'String',num2str(v));
ob=get(handles.edit10,'String'); % lee el display de obj axis
pr=get(handles.edit9,'String'); % lee el display de par axis
if ob~='0'
    evalin('base',['objaxis6(lg,' ob ',[' num2str(v) ' ' get(handles.edit13,'String') '])']) 
end
if pr~='0'
    evalin('base',['paraxis6(lg,' pr ',[' num2str(v) ' ' get(handles.edit13,'String') '])']) 
end

%%   
% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%%   
function edit12_Callback(hObject, eventdata, handles)

v=get(hObject,'String');
set(handles.slider5,'Value',str2double(v)); % actualiza el deslizante
ob=get(handles.edit10,'String'); % lee el display de obj axis
pr=get(handles.edit9,'String'); % lee el display de par axis
if ob~='0'
    evalin('base',['objaxis5(lg,' ob ',[' v ' ' get(handles.edit13,'String') '])']) 
end
if pr~='0'
    evalin('base',['paraxis5(lg,' pr ',[' v ' ' get(handles.edit13,'String') '])'])
end

%%   
% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','0')

%%   
% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)

v=get(hObject,'Value');
set(handles.edit13,'String',num2str(v));
ob=get(handles.edit10,'String'); % lee el display de obj axis
pr=get(handles.edit9,'String'); % lee el display de par axis
if ob~='0'
    evalin('base',['objaxis6(lg,' ob ',[' get(handles.edit12,'String') ' ' num2str(v) '])']) 
end
if pr~='0'
    evalin('base',['paraxis6(lg,' pr ',[' get(handles.edit12,'String') ' ' num2str(v) '])'])
end

%%   
% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value',1)

%%   
function edit13_Callback(hObject, eventdata, handles)

v=get(hObject,'String');
set(handles.slider6,'Value',str2double(v)); % actualiza el deslizante
ob=get(handles.edit10,'String'); % lee el display de obj axis
pr=get(handles.edit9,'String'); % lee el display de par axis
if ob~='0'
    evalin('base',['objaxis6(lg,' ob ',[' get(handles.edit12,'String') ' ' v '])']) 
end
if pr~='0'
    evalin('base',['paraxis6(lg,' pr ',[' get(handles.edit12,'String') ' ' v '])'])
end
%%   
% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','1')

%%   
function edit16_Callback(hObject, eventdata, handles)

%%   
% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','ParetoFront');

%%   
function edit17_Callback(hObject, eventdata, handles)


%%   
% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','ParetoSet');


%%
function edit18_Callback(hObject, eventdata, handles)

%% 
% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','0')

%% 
% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)

l=get(handles.edit18,'String');
if str2double(l) ~= 0
    evalin('base',['lg=removeextreme6(lg,' l ');']);
    evalin('base','lg=layergraph6(lg);');
    nind=evalin('base','lg.numind');
    set(handles.edit3,'String',num2str(nind));
    set(handles.edit18,'String','0');
    evalin('base','lg.selpoint=[];');
    set(handles.edit21,'String','');
    set(handles.edit22,'String','');
    set(handles.edit24,'String','[1,inf]');
end

%%
function edit19_Callback(hObject, eventdata, handles)

%%
% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','pref');

%%
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)

pref=get(handles.edit19,'String');
evalin('base',['lg=classbypreference6(lg,' pref ');']);
evalin('base','lg=layergraph6(lg);');
evalin('base','lg.selpoint=[];');
set(handles.edit21,'String','');
set(handles.edit22,'String','');
set(handles.edit24,'String','[1,inf]');


%%
% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)

ll=evalin('base','lg');
button=get(handles.radiobutton1,'Value');
if button==1
    evalin('base','[c,lg]=paretopoint6(lg,lg.figuras(1))');
else
    evalin('base','[c,lg]=paretopoint6(lg,lg.figuras(2))');
end
c=evalin('base','c');
set(handles.edit21,'String',num2str(ll.spf(c,:)));
set(handles.edit22,'String',num2str(ll.sps(c,:)));

%%
function edit21_Callback(hObject, eventdata, handles)

%%
% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','')

%%
function edit22_Callback(hObject, eventdata, handles)

%%
% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','')



%%
% --- Executes during object creation, after setting all properties.
function pushbutton7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%%
% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1

%%
% --- Executes during object creation, after setting all properties.
function radiobutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


%%
function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double

%%
% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','[1,inf]');

%%
% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pref=get(handles.edit24,'String');
evalin('base',['lg=classbycondition6(lg,' pref ');']);
evalin('base','lg=layergraph6(lg);');
evalin('base','lg.selpoint=[];');
set(handles.edit21,'String','');
set(handles.edit22,'String','');

%%
function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','2')

%% Update Control
% 30/01/2012 ... Initial Release
% 16/10/2012 ... First Test Release
% 13/12/2012 ... Matlab Central Release
