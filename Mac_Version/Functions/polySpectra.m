function [I0, E0, minE0, maxE0,kVp,mA,aluminiumFilter,copperFilter] = polySpectra(ax,name1,name2)
%Reads a previously defined X-ray spectrum text file and visualizes it on the program screen

%Open datafile
load(name2)
% f = fopen(name2);

%Read formatted data from text file
% str = textscan(f,'%d %f','Delimiter',' ');
% 
% for i = 1:length(str{1,1})
%     T = str{1,1};
%     TT = str{1,2};
%     T(T==0) = [] ;
%     TT(isnan(TT)) = [] ;
%     str{1,1} = T;
%     str{1,2} = TT;
% end
info{1,1}=spectra{151,2};

for ii=1:4
    info{1,ii} = spectra{150+ii,2}
end

info=string(info);

% for ii=150:1:1
%     info(ii,:)=[]
% end
% 
% info=cell(1,4);
% % str1=textscan(f,'%s');
% 
% for ii=151:154
%     info{ii} = spectra{ii,2};
% end


% fclose(f);

%Choose second column of the str and generate for that I0 vector
I0 = spectra;
I0(154,:)=[];
I0(153,:)=[];
I0(152,:)=[];
I0(151,:)=[];
I0=I0(:,2);
I0 = cell2mat(I0);

%Eliminate NaN values from vector
I0(isnan(I0)) = [];
% I0(I0==0)= [];
I0 = round(I0,1);

%Energies in keV
E0=1:1:length(I0);
E0=E0';

%Eliminate zero values from vector
E0=E0(I0~=0);

%Max/Min value of energy in the spectrum
maxE0 = max(E0);
minE0 = min(E0);

%Strings which are displayed in text box
stringforBox1='Min energy: %d keV';
stringforBox2='Max energy: %d keV';
stringforbox3 ='Peak kilovoltage: %d kV';
stringforBox1 = sprintf(stringforBox1,minE0);
stringforBox2 = sprintf(stringforBox2,maxE0);

kVp=str2num(info(1));
stringforBox3 = sprintf(stringforbox3,kVp);
mA=str2num(info(2));
aluminiumFilter = str2num(info(3));
copperFilter = str2num(info(4));

%Plot spectrum in Spectrum figure
plot(I0,'LineWidth',2, 'Parent',ax);

limY = max(I0);
ax.YLim = [0 limY];

%Display min and max energies of the spectrum in text box
text(ax,70,limY-limY/10,stringforBox1,'Color','w','FontSize',11);
text(ax,70,limY-2*limY/10,stringforBox2,'Color','w','FontSize',11);
% text(ax,65,limY-3*limY/10,stringforBox3,'Color','w','FontSize',11);

ax.XTickMode = 'auto';
ax.YTickMode = 'auto';

end
