
![CTlab ´logo1](https://user-images.githubusercontent.com/110446843/183570885-af213bfb-5be0-4297-a8bf-00bf1a5eb818.png)


## A Numerical Computed Tomography Simulator

The CTlab is virtually implemented medical imaging device. The CTlab simulator can be widely used in computed tomography training for all professionals who use radiation in their work. The CTlab provides fast, comprehensive, and efficient solutions for numerical CT simulations with low hardware requirements. The simulator has been developed to introduce the basic operations and workflow behind the CT imaging modality and to illustrate how the polychromatic x-ray spectrum, various imaging parameters, scan geometry and CT reconstruction algorithm affect the quality of the detected CT images.

The CTlab has been created with MATLAB's app designer feature. It offers its user the opportunity to adjust CT imaging parameters (image volume, scan angles, detector element size and detector width, noise, algorithm/geometry specific parameters), to select specific scan geometry, to observe projection data from selected imaging target with polychromatic x-ray spectrum, and to select the specific algorithm for image reconstruction (FBP, least squares, Tikhonov regularization). Key user groups for the simulator include medical physics, engineering, and radiographer students.


CTlab uses two external open source Matlab toolkits. Spektr 3.0 code is used to create a polychromatic X-ray spectrum for simulations and Astra toolbox is used to calculate reconstructions from polychromatic projection data (Not in the Mac version). The user must download both of the aforementioned Toolboxes and place them in Matlab's path in order for CTlab to work correctly. 

Since the use of Astra toolbox is not possible on Mac computers, a slightly separate version of the program has been developed for this purpose. The Mac version does not support iterative reconstruction algorithms or fanflat beam geometry in X-ray projection detection.

# Noteworthy

Since CTlab is being widely distributed for the first time, it may contain unforeseen bugs. If you wish, you can report these to the Issues channel. Thank you!
