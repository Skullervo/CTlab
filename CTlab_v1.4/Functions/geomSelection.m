function opt=geomSelection
hfig=figure('Name','Reconstruction geometry','NumberTitle','off','CloseRequestFcn',@close_req_fun,'menu','none'); %'Color',[0.25,0.44,0.68]
% opt_list={'Filtered backprojection (FBP)','Least squares','Tikhonov Regularization','Gradient Descent', 'Tikhonov Gradient Descent', 'Conjugate Gradient', 'Preconditioned Conjugate Gradient', 'Biconjugate Gradient',...
%     'Iterative Soft Thresholding Algo (ISTA)', 'Iterative Soft Thresholding Algo (ISTA) + discrete cosine transform', 'Total Variation minimization'};
opt_list={'parallel','fanflat'};
defaultans='parallel';
%set defaults
% str1=defaultans;
% str2=defaultans;
% opt=opt_list{1};
%create GUI
set(hfig,'menu','none')
% field1=uicontrol('Style', 'Edit', 'String', str1, ...
%     'Parent',hfig,'Units','Normalized', ...
%     'Position', [.1, .75, .8, .15]);
% field2=uicontrol('Style', 'Edit', 'String', str2, ...
%     'Parent',hfig,'Units','Normalized', ...
%     'Position', [.1, .55, .8, .15]);

% p=phantom(256,256);
% 
% imshow(p,'XData', [100 200], 'YData', [100 200]))


dropdown=uicontrol('Style', 'popupmenu', 'String', opt_list, ...
    'Parent',hfig,'Units','Normalized', ...
    'Position', [.1, .35, .8, .15]);
uicontrol('Style', 'pushbutton', 'String', 'OK', ...
    'Parent',hfig,'Units','Normalized', ...
    'Position', [.1 .1 .35 .2],...
    'Callback','close(gcbf)');
cancel=uicontrol('Style', 'pushbutton', 'String', 'cancel', ...
    'Parent',hfig,'Units','Normalized', ...
    'Position', [.55 .1 .35 .2],...
    'Tag','0','Callback',@cancelfun); %, 'BackgroundColor',[0.76,0.89,1.00]
%wait for figure being closed (with OK button or window close)
uiwait(hfig)
%figure is now closing
if strcmp(cancel.Tag,'0')%not canceled, get actual inputs
    %     str1=field1.String;
    %     str2=field2.String;
    opt=opt_list{dropdown.Value};
elseif strcmp(cancel.Tag,'1')
    opt=cancel.Tag
end
% a=isempty(opt)
% display(a)
%actually close the figure
delete(hfig)
end
function cancelfun(h,~)
set(h,'Tag','1')
uiresume
end
function close_req_fun(~,~)
uiresume
end