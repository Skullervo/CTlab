function answer = parameterSelection(Alg,geom)
if (strcmp(geom,'parallel')==1)
    
    if (strcmp(Alg,'Filtered backprojection (FBP)')==1)
        prompt = {'Min angle (deg.):','Step (deg.):', 'Max angle (deg.):', 'Image volume (pixels):', 'Detector width (pixels):', 'Detector element size (pixels):', 'Image Noise:', 'Scan time (sec.):', 'Tube current (mA)'};
        dlgtitle = 'Set imaging parameters';
        dims = [1 50];
        definput = {'0','1', '360', '460', '460', '1', '0.001', '1','1'};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
        
    elseif (strcmp(Alg,'Least squares')==1)
        prompt = {'Min angle (deg.):','Step (deg.):', 'Max angle (deg.):', 'Image volume (pixels):', 'Detector width (pixels):', 'Detector element size (pixels):', 'Image Noise', 'Iterations', 'Scan time (sec.):', 'Tube current (mA)'};
        dlgtitle = 'Set imaging parameters';
        dims = [1 50];
        definput = {'0','1', '360', '460', '460', '1', '0.001', '10', '1','1'};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
    
   elseif (strcmp(Alg,'Tikhonov Regularization')==1)
        prompt = {'Min angle (deg.):','Step (deg.):', 'Max angle (deg.):', 'Image volume (pixels):', 'Detector width (pixels):', 'Detector element size (pixels):', 'Image Noise', 'Scan time (sec.):', 'Regularization parameter:', 'Tube current (mA)'};
        dlgtitle = 'Set imaging parameters';
        dims = [1 50];
        definput = {'0','1', '360', '460', '460', '1', '0.001', '1','1','1'};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
        
%     elseif (strcmp(Alg,'Conjugate Gradient')==1)
%         prompt = {'Min angle (deg.):','Step (deg.):', 'Max angle (deg.):', 'Image volume (pixels):', 'Detector width (pixels):', 'Detector element size (pixels):', 'Image Noise', 'Iterations', 'Scan time (sec.):'};
%         dlgtitle = 'Set imaging parameters';
%         dims = [1 35];
%         definput = {'0','1', '360', '460', '460', '1', '0.001', '10', '1'};
%         answer = inputdlg(prompt,dlgtitle,dims,definput);
    else
        prompt = {'Min angle (deg.):','Step (deg.):', 'Max angle (deg.):', 'Image volume (pixels):', 'Detector width (pixels):', 'Detector element size (pixels):', 'Image Noise', 'Iterations','Step size:', 'Scan time (sec.):', 'Tube current (mA)'};
        dlgtitle = 'Set imaging parameters';
        dims = [1 50];
        definput = {'0','1', '360', '460', '460', '1', '0.001', '10', '1e-6','1','1'};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
    end
    
elseif (strcmp(geom,'fanflat')==1)
    
    if (strcmp(Alg,'Filtered backprojection (FBP)')==1)
        prompt = {'Min angle (deg.):','Step (deg.):', 'Max angle (deg.):', 'Image volume (pixels):', 'Detector width (pixels):', 'Detector element size (pixels):', 'source-origin-distance (SOD):', 'Origin-detector-distance(ODD):', 'Image Noise:', 'Scan time (sec.):', 'Tube current (mA)'};
        dlgtitle = 'Set imaging parameters';
        dims = [1 50];
        definput = {'0','1', '360', '460', '460', '1', '1000', '500', '0.001', '1','1'};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
        
    elseif (strcmp(Alg,'Least squares')==1)
        prompt = {'Min angle (deg.):','Step (deg.):', 'Max angle (deg.):', 'Image volume (pixels):', 'Detector width (pixels):', 'Detector element size (pixels):', 'source-origin-distance (SOD):', 'Origin-detector-distance(ODD):', 'Image Noise', 'Iterations', 'Scan time (sec.):', 'Tube current (mA)'};
        dlgtitle = 'Set imaging parameters';
        dims = [1 50];
        definput = {'0','1', '360', '460', '460', '1', '1000', '500', '0.001', '10', '1','1'};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
        
    elseif (strcmp(Alg,'Tikhonov Regularization')==1)
        prompt = {'Min angle (deg.):','Step (deg.):', 'Max angle (deg.):', 'Image volume (pixels):', 'Detector width (pixels):', 'Detector element size (pixels):', 'source-origin-distance (SOD):', 'Origin-detector-distance(ODD):', 'Image Noise', 'Scan time (sec.):', 'Regularization parameter:', 'Tube current (mA)'};
        dlgtitle = 'Set imaging parameters';
        dims = [1 50];
        definput = {'0','1', '360', '460', '460', '1', '1000', '500', '0.001', '10', '1','1','1'};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
        
%     elseif (strcmp(Alg,'Conjugate Gradient')==1)
%         prompt = {'Min angle (deg.):','Step (deg.):', 'Max angle (deg.):', 'Image volume (pixels):', 'Detector width (pixels):', 'Detector element size (pixels):', 'source-origin-distance (SOD):', 'Origin-detector-distance(ODD):', 'Image Noise', 'Iterations', 'Scan time (sec.):'};
%         dlgtitle = 'Set imaging parameters';
%         dims = [1 35];
%         definput = {'0','1', '360', '460', '460', '1', '1000', '500', '0.001', '10', '1'};
%         answer = inputdlg(prompt,dlgtitle,dims,definput);
    else
        prompt = {'Min angle (deg.):','Step (deg.):', 'Max angle (deg.):', 'Image volume (pixels):', 'Detector width (pixels):', 'Detector element size (pixels):', 'source-origin-distance (SOD):', 'Origin-detector-distance(ODD):', 'Image Noise', 'Iterations','Step size', 'Scan time (sec.):', 'Tube current (mA)'};
        dlgtitle = 'Set imaging parameters';
        dims = [1 50];
        definput = {'0','1', '360', '460', '460', '1', '1000', '500', '0.001', '10', '1e-6','1','1'};
        answer = inputdlg(prompt,dlgtitle,dims,definput);
    
    end
end

end