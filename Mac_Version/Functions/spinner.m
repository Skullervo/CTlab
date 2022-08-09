function [rec,maxI,minI]=spinner(spin,spectralIm,minIntensity,maxIntensity,energyWindows,I0,bin,minE0,maxE0,ax2,ax3,ax4)
% minE0,maxE0
rec=imshow(spectralIm(:,:,spin),[minIntensity(spin) maxIntensity(spin)],'Parent',ax2, 'XData', [0 ax2.Position(3)],'YData', [0 ax2.Position(4)])
ax2.Title.String = sprintf('Spectral Reconstruction %d, Energy range: %d keV - %d keV',spin,energyWindows(spin),energyWindows(spin+1))
h=histogram(ax4, spectralIm(:,:,spin), 'FaceColor','Black','EdgeColor', 'none');
h.FaceColor = [0.50,0.62,0.67];
h.FaceAlpha = 0.4;

ax2.XLim = [0 rec.XData(2)];
ax2.YLim = [0 rec.YData(2)];
minI=h.BinLimits(1);
maxI=h.BinLimits(2);

plot(I0,'LineWidth',2, 'Parent',ax3);

%String which is displayed in text box
% stringforBox1='Min energy: %d keV,';
% stringforBox2='Max energy: %d keV.'
% stringforBox1 = sprintf(stringforBox1,minE0);
% stringforBox2 = sprintf(stringforBox2,maxE0);

%Display min and max energies of the spectrum in text box
%Plot spectrum in Spectrum figure
scaleE = minE0:1:maxE0;
%                 plot(scaleE,app.I0(app.minE0:app.maxE0), 'Parent',app.UIAxes3);
% plot(I0,'LineWidth',2, 'Parent',ax3);
%     axis([0 maxE0 0 10000])

% text(ax3,65,8e+04,stringforBox1,'Color','Black','FontSize',11);
% text(ax3,65,6e+04,stringforBox2,'Color','Black','FontSize',11);

R=rectangle('Position', [energyWindows(spin), 0, energyWindows(spin+1)-energyWindows(spin), 10000000],'FaceColor', [0, 0.5, 0.5, 0.7], 'EdgeColor', [0, 0.5, 0.5, 0.7],'LineWidth', 1.5,'Parent',ax3)



for k=1:length(energyWindows)
    
    xline(energyWindows(k),':','Parent',ax3,'Color','w')
%     xl.Color = 'w';
    
    hold on
    
end

axis([0 length(energyWindows) 0 10000])


close

end