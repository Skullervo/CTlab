function [rec, recoText, minI, maxI] = reconstructionSelection(fig, valAlg, I_logsum,mask_I,mask_water,mask_air,mask_luu,W,imageVolume,alpha,lambda,iterations,ax,ax2)

if (strcmp(valAlg,'Filtered backprojection (FBP)')==1)
    alg='Filtered backprojection (FBP) reconstruction';
    ax.Title.String = sprintf('Filtered backprojection (FBP) reconstruction')
    recoText = 'Filtered backprojection (FBP)'
    recotext='Filtered backprojection (FBP) calculated'
    [rec,minI,maxI,h] = filteredBackprojection2(fig,recotext,I_logsum,mask_I,mask_water,mask_air,mask_luu,W,ax,ax2)
    %     sliderLims = [limMin limMax]
    
    
elseif (strcmp(valAlg,'Least squares')==1)
    ax.Title.String = sprintf('Least squares reconstruction')
    recoText = 'Least Squares'
    %     [rec,minI,maxI,h] = least_squares(fig,W, mask_I,mask_water,mask_air,mask_luu, iterations, ax, ax2)
    [rec,minI,maxI,h] = least_squares(fig,W, I_logsum, mask_I,mask_water,mask_air,mask_luu, iterations, ax, ax2)

    
% elseif (strcmp(valAlg,'Gradient Descent')==1)
%     ax.Title.String = sprintf('Gradient Descent reconstruction')
%     recoText = 'Gradient Descent'
%     [rec,minI,maxI,h] = gradientDescent(fig,I_logsum,I_logsum_a,I_logsum_j,I_logsum_w,I_logsum_l, iterations, alpha, imageVolume, W, ax, ax2)

    
elseif (strcmp(valAlg,'Tikhonov Regularization')==1)
    ax.Title.String = sprintf('Tikhonov Regularization reconstruction')
    recoText = 'Tikhonov Regularization'
    %     [rec,minI,maxI,h] = tikhonovReg(fig,W,imageVolume,I_logsum,I_logsum_a,I_logsum_j,I_logsum_w,I_logsum_l,alpha,ax,ax2)
    [rec,minI,maxI,h] = tikhonovReg(fig,W,imageVolume,I_logsum,mask_I,mask_water,mask_air,mask_luu,alpha,ax,ax2)

    
% elseif (strcmp(valAlg,'Tikhonov Gradient Descent')==1)
%     ax.Title.String = sprintf('Tikhonov Gradient Descent reconstruction')
%     recoText = 'Tikhonov Gradient Descent'
%     [rec,minI,maxI,h] = tikhonovGradDec(fig, iterations, imageVolume, alpha, W, I_logsum, ax, ax2)

% elseif (strcmp(valAlg,'Conjugate Gradient')==1)
%     ax.Title.String = sprintf('Conjugate Gradient reconstruction')
%     recoText = 'Conjugate Gradient'
%     [rec,minI,maxI,h] = conjugateGrad(fig, iterations, W, imageVolume, I_logsum, ax, ax2)
    

    
% elseif (strcmp(valAlg,'Preconditioned Conjugate Gradient')==1)
%     recoText = 'Preconditioned Conjugate Gradient'
%     [rec,minI,maxI,h] = precondConjugateGrad(iterations, W, I_logsum, imageVolume, ax, ax2)
% 
%     
% elseif (strcmp(valAlg,'Biconjugate Gradient')==1)
%     recoText = 'Biconjugate Gradient'
%     [rec,minI,maxI,h] = biconjugateGrad(iterations, W, I_logsum, imageVolume, ax, ax2)
% 
%     
% elseif (strcmp(valAlg,'Iterative Soft Thresholding Algo (ISTA)')==1)
%     recoText = 'Iterative Soft Thresholding Algo (ISTA)'
%     [rec,minI,maxI,h] = ista(iterations, lambda, alpha, I_logsum, ax, ax2)
% 
%     
% elseif (strcmp(valAlg,'Iterative Soft Thresholding Algo (ISTA) + discrete cosine transform'))
%     recoText = 'Iterative Soft Thresholding Algo (ISTA) + discrete cosine transform'
%     
% elseif (strcmp(valAlg,'Total Variation minimization'))

    
else isequal(valAlg,0)
    disp('Ready')
    recoText = 'Reconstruction algorithm selection cancelled'

end