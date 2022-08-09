function [rec,minI,maxI] = Mac_iRadon(fig,text,I_logsum,I_logsum_w,mask_I,mask_water,mask_air,mask_luu,minStep,step,maxStep,detWidth,imageVolume,axis,axis2)

% h = waitbar(0,'Please wait...');
d = uiprogressdlg(fig,'Title','Please wait',...
    'Message','Calculation in progress...','Cancelable','on');
drawnow

% rec = iradon(I_logsum',min+1:step:max+1,detWidth,'linear','none');
rec = iradon(I_logsum',minStep+1:step:maxStep+1,imageVolume);
maskW = iradon(I_logsum_w',minStep+1:step:maxStep+1,imageVolume);
p=phantom(imageVolume);
Wmask = p < 0.21 & p > 0.19;
% I_w = radon(mask_water,minStep:step:maxStep,imageVolume);
% I_w = iradon(I_w,minStep:step:maxStep,imageVolume);
I_w = radon(Wmask,minStep:step:maxStep,imageVolume);
I_w = iradon(I_w,minStep:step:maxStep,imageVolume);
I_w = I_w < 2.5 & I_w > 1.5;
% imtool(I_w,[])


% rec1=mask_I.*rec;
% rec2=maskW.*rec;
% rec3=mask_water.*rec;
rec2=I_w.*rec;
% rec3=mask_air.*rec;
% rec4=mask_luu.*rec;

water=rec2(:);
water=water(water~=0);
water=abs(water);
water = mean(water);


% HU_iodine = 1000*((rec1-mean(water))/mean(water));
% HU_iodine = HU_iodine.*mask_I;
% HU_water = 1000*((rec2-mean(water))/mean(water));
% HU_water = HU_water.*mask_water;
% HU_air = 1000*((rec3-mean(water))/mean(water));
% HU_air = HU_air.*mask_air;
% HU_luu = 1000*((rec4-mean(water))/mean(water));
% HU_luu = HU_luu.*mask_luu;

% rec=HU_iodine+HU_water+HU_air+HU_luu;
% rec=1000*((rec-mean(water))/mean(water));
rec=1000*((rec-mean(water))/mean(water));

%             imshow(rec,[], 'Parent', axis);
drawnow
pause(1)
h = histogram(axis2, rec, 'FaceColor','Black','EdgeColor', 'none');
% h.EdgeColor = 'r'
h.FaceColor = [0.50,0.62,0.67];
h.FaceAlpha = 0.4;
% minI=min(h.BinEdges);
% maxI=max(h.BinEdges);
minI=h.BinLimits(1);
maxI=h.BinLimits(2);
% I = imshow(rec,[minI-minI/2 maxI+maxI/2], 'Parent', axis, ...
%     'XData', [0 axis.Position(3)], ...
%     'YData', [0 axis.Position(4)]);

% I = imshow(rec,[minI-minI/2 maxI+maxI/2], 'Parent', axis, ...
%     'XData', [0 axis.Position(3)], ...
%     'YData', [0 axis.Position(4)]);

I = imshow(rec,[-3000 3000], 'Parent', axis, ...
    'XData', [0 axis.Position(3)], ...
    'YData', [0 axis.Position(4)]);
% Set limits of axes
axis.XLim = [0 I.XData(2)];
axis.YLim = [0 I.YData(2)];
%imshow(rec,[], 'Parent', axes);
d.Value = 1;
d.Message = sprintf(text);
pause(1);
close(d);
display(minI);
display(maxI);
% F = findall(0,'type','figure','tag','TMWWaitbar')

end