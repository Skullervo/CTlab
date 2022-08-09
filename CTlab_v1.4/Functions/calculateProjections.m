function [p,W,I_logsum,I,mask_I, mask_water, mask_air, mask_luu] = calculateProjections(fig,minAngle,stepAngle,maxAngle,imageVolume,detectorElementsize,detectorWidth,I0,airDensity,waterDensity,iodineDensity,luuDensity,imageNoise,minE0,maxE0,time,geom, SOD, ODD,mA)
          
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                      3.Attenuation data for different energies                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% h = waitbar(0,'Please wait...');

d = uiprogressdlg(fig,'Title','Please wait',...
    'Message','Calculation in progress...','Cancelable','on');
drawnow
%Mass attenuation coefficients data of iodine, water, air & bone: NIST
%(https://www.nist.gov/pml/x-ray-mass-attenuation-coefficients)
%Import data from a spreadsheet
% vaimIlma = importfile('C:\Users\sylisiur\Desktop\virtualCTgui\vaimIlma.xlsx');
% vaimE = importfile('C:\Users\sylisiur\Desktop\virtualCTgui\vaimE.xlsx');
% vaimLuu = importfileluu('C:\Users\sylisiur\Desktop\virtualCTgui\luuVaim.xlsx');

% boneD = 1.920E+00;
% waterD = 1.000E+00;
% % iodineD = 4.930E+00;
% iodineD =1.430E+00;
% airD = 1.205E-03;

% airDensity = 0.001225;
% iodineDensity = 0.0370;
% luuDensity = 0.96;
% waterDensity = 0.5;

boneD = 0.96;
waterD = 0.5;
% iodineD = 4.930E+00;
iodineD =0.037;
airD = 0.001225;

load('vaimLuu.mat')
load('vaimIlma.mat')
load('vaimE.mat')

%convert a string to a vector containing numeric values
%for mass attenuation coefficients at different energies
E_jodi = str2double(vaimE.E_Jodi_);
u_jodi = str2double(vaimE.u_p_Jodi_);
E_vesi = str2double(vaimE.E_Vesi_);
u_vesi = str2double(vaimE.u_p_Vesi_);
E_ilma = str2double(vaimIlma.E_Jodi_);
u_ilma = str2double(vaimIlma.u_p_Jodi_);
E_luu = str2double(vaimLuu.E_Luu_);
u_luu = str2double(vaimLuu.u_p_Luu_);

% Use SplineFit to fit the attenuation curve to the data from NIST
SplineFit1 = fit(E_jodi, u_jodi, 'smoothingspline', 'SmoothingParam',1);
SplineFit2 = fit(E_vesi(1:36), u_vesi(1:36), 'smoothingspline', 'SmoothingParam', 1);
SplineFit3 = fit(E_ilma(3:40), u_ilma(3:40), 'smoothingspline', 'SmoothingParam', 1);
SplineFit4 = fit(E_luu, u_luu, 'smoothingspline', 'SmoothingParam', 1);


u_jodi_E=zeros(1,150);
u_vesi_E=zeros(1,150);
u_ilma_E=zeros(1,150);
u_luu_E=zeros(1,150);
%Attenuation coefficients for different energies:
for i=0.001:0.001:0.150
    j=round(i*1000);
    u_jodi_E(j)=SplineFit1(i)*iodineD;
end

for i=0.001:0.001:0.150
    j=round(i*1000);
    u_vesi_E(j)=SplineFit2(i)*waterD;
end

for i=0.001:0.001:0.150
    j=round(i*1000);
    u_ilma_E(j)=SplineFit3(i)*airD;
end

for i=0.001:0.001:0.150
    j=round(i*1000);
    u_luu_E(j)=SplineFit4(i)*boneD;
end

% for ii=1:length(u_vesi_E)
%     u_jodi_E(ii) = (1000*(u_jodi_E(ii)-u_vesi_E(ii))/u_vesi_E(ii));
%     u_vesi_E(ii) = (1000*(u_vesi_E(ii)-u_vesi_E(ii))/u_vesi_E(ii));
%     u_ilma_E(ii) = (1000*(u_ilma_E(ii)-u_vesi_E(ii))/u_vesi_E(ii));
%     u_luu_E(ii) = (1000*(u_luu_E(ii)-u_vesi_E(ii))/u_vesi_E(ii));
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              4.Parameters for volume & projection geometry and also for noise:                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
angles=minAngle:stepAngle:maxAngle;

%generate phantom
p = phantom(imageVolume);
%projection geometry
if (strcmp(geom,'Parallel')==1)
    proj_geom = astra_create_proj_geom('parallel', detectorElementsize, detectorWidth, angles*pi/180); 
    vol_geom = astra_create_vol_geom(imageVolume,imageVolume);%256
    W = opTomo('strip',proj_geom,vol_geom);
elseif (strcmp(geom,'Fanflat')==1)
    proj_geom = astra_create_proj_geom('fanflat', detectorElementsize, detectorWidth, angles*pi/180, SOD, ODD);
    vol_geom = astra_create_vol_geom(imageVolume,imageVolume);
    W = opTomo('cuda',proj_geom,vol_geom);
end
%volume geometry
% vol_geom = astra_create_vol_geom(imageVolume,imageVolume);
%projector
% W = opTomo('strip',proj_geom,vol_geom);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                    5.Create projection data:                                      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x=p(:);
%Forward projection
proj = W*x;
%Reshape projection data
proj = reshape(proj,W.proj_size);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                           6.Masks for different tissues and materials:                            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mask_I1 = p < 0.31 & p > 0.29;                   %Iodine mask
mask_I2 = p < 0.11 & p > 0.09;
mask_I3 = p < 0.41 & p > 0.39;
mask_I = mask_I1 + mask_I2 + mask_I3;
mask_water = p < 0.21 & p > 0.19;                  %Water mask
% mask_air = p < 0.01 & p > -0.01;                   %Air mask
mask_air = (p < -0.00);  
mask_luu = p < 1.01 & p > 0.99;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                  7.Forward project basis materials:                               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

proj_water = reshape(W*double(mask_water(:)),W.proj_size);        %Water forward projection
proj_air = reshape(W*double(mask_air(:)), W.proj_size);           %Air forward projection
proj_I = reshape(W*double(mask_I(:)), W.proj_size);               %Iodine forward projection
proj_luu = reshape(W*double(mask_luu(:)), W.proj_size);               %Iodine forward projection

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                   8.Forward projections (Beer-Lambert law) for different energies:                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Example densities for different materials (g/cm^3)
% p_air=0.001225;
% p_iodine=0.370;
% p_iodine=0.1;
% p_water=1;

% p_air=0.001225;
% p_iodine=0.0370;
% p_bone = 0.96
% p_water=0.5;

%             p_iodine=app.IodineEditField.Value;      %Iodine density
%             p_water=app.WaterEditField.Value;        %Water density
%             p_air=app.AirEditField.Value;            %Air density
noiseT='gaussian';                       %Noise type
% airDensity = 0.001225;
% iodineDensity = 0.0370;
% luuDensity = 0.96;
% waterDensity = 0.5;


I_ilma = zeros(size(proj_air,1),size(proj_air,2),maxE0);
I_jodi = zeros(size(proj_air,1),size(proj_air,2),maxE0);
I_vesi = zeros(size(proj_air,1),size(proj_air,2),maxE0);
I_luu = zeros(size(proj_air,1),size(proj_air,2),maxE0);
I = zeros(size(proj_air,1),size(proj_air,2),maxE0);

%     I_ilma = zeros(361,400,maxE0);
%     I_jodi = zeros(361,400,maxE0);
%     I_vesi = zeros(361,400,maxE0);
%     I_luu = zeros(361,400,maxE0);
    
for i=minE0:1:maxE0 %length(I0)
    %Beer-Lambert law for each energy of forward projection
%     I_ilma(:,:,i) = exp(-u_ilma_E(i)*proj_air*0.1*airDensity);
%     I_jodi(:,:,i) = exp(-u_jodi_E(i)*proj_I*0.1*iodineDensity);
%     I_vesi(:,:,i) = exp(-u_vesi_E(i)*proj_water*0.1*waterDensity);
%     I_luu(:,:,i) = exp(-u_luu_E(i)*proj_luu*0.1*luuDensity);

%     I_ilma(:,:,i) = exp(-u_ilma_E(i)*proj_air*0.1);
%     I_jodi(:,:,i) = exp(-u_jodi_E(i)*proj_I*0.1);
%     I_vesi(:,:,i) = exp(-u_vesi_E(i)*proj_water*0.1);
%     I_luu(:,:,i) = exp(-u_luu_E(i)*proj_luu*0.1);
    
    %Add noise for each forward projection
    I_ilma(:,:,i)=imnoise(exp(-u_ilma_E(i)*proj_air*0.1),noiseT,0,imageNoise);
    I_vesi(:,:,i)=imnoise(exp(-u_vesi_E(i)*proj_water*0.1),noiseT,0,imageNoise);
    I_jodi(:,:,i)=imnoise(exp(-u_jodi_E(i)*proj_I*0.1),noiseT,0,imageNoise);
    I_luu(:,:,i)=imnoise(exp(-u_luu_E(i)*proj_luu*0.1),noiseT,0,imageNoise);
    
    %Calculate forward projection which includes all materials and
    %energies
    I(:,:,i) = mA*time*I0(i)*I_ilma(:,:,i).*I_jodi(:,:,i).*I_vesi(:,:,i).*I_luu(:,:,i);
    %     waitbar(i/length(I0),h)
    % Check for Cancel button press
    if d.CancelRequested
        break
    end
%     Update progress, report current estimate
    d.Value = i/length(I0);
    d.Message = sprintf('Projections for energy %d keV processed',i);
end


% I_logsum = -log(sum(I,3)/sum(I0))/0.1;
% I_logsum_a = -log(sum(I_ilma,3)/sum(I0))/0.1;
% I_logsum_j = -log(sum(I_jodi,3)/sum(I0))/0.1;
% I_logsum_w = -log(sum(I_vesi,3)/sum(I0))/0.1;
% I_logsum_l = -log(sum(I_luu,3)/sum(I0))/0.1;

I_logsum = -log(sum(I,3)/sum(I0))/0.1;
I_logsum_a = -log(sum(I_ilma,3)/sum(I0))/0.1;
I_logsum_j = -log(sum(I_jodi,3)/sum(I0))/0.1;
I_logsum_w = -log(sum(I_vesi,3)/sum(I0))/0.1;
I_logsum_l = -log(sum(I_luu,3)/sum(I0))/0.1;

% rec1 = FBP_2D_opTomo(I_logsum_a,W);
% rec2 = FBP_2D_opTomo(I_logsum_j,W);
% rec3 = FBP_2D_opTomo(I_logsum_w,W);
% rec4 = FBP_2D_opTomo(I_logsum_l,W);
% 
% I_logsum_a = mask_air.*rec1;
% I_logsum_j = mask_I.*rec2;
% I_logsum_w = mask_water.*rec3;
% I_logsum_l = mask_luu.*rec4;

close(d)
F = findall(0,'type','figure','tag','TMWWaitbar')
% delete(h)
end