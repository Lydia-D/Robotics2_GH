% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly excecuted under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 657.643760899931410 ; 658.041141535634320 ];

%-- Principal point:
cc = [ 303.192399215135310 ; 242.555653272647110 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.256098177740337 ; 0.130887495258462 ; -0.000191176545749 ; 0.000038483795384 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 0.402433579750159 ; 0.430570164012369 ];

%-- Principal point uncertainty:
cc_error = [ 0.818610329605501 ; 0.748814446476830 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.003142113587670 ; 0.012508430224525 ; 0.000169372634872 ; 0.000167549565668 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 480;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 20;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 1.654720e+00 ; 1.651630e+00 ; -6.697971e-01 ];
Tc_1  = [ -1.778479e+02 ; -8.365802e+01 ; 8.532221e+02 ];
omc_error_1 = [ 9.548703e-04 ; 1.234585e-03 ; 1.577720e-03 ];
Tc_error_1  = [ 1.062983e+00 ; 9.798416e-01 ; 5.385209e-01 ];

%-- Image #2:
omc_2 = [ 1.848877e+00 ; 1.900269e+00 ; -3.969660e-01 ];
Tc_2  = [ -1.552066e+02 ; -1.592776e+02 ; 7.578523e+02 ];
omc_error_2 = [ 1.003409e-03 ; 1.226920e-03 ; 1.907843e-03 ];
Tc_error_2  = [ 9.491938e-01 ; 8.686565e-01 ; 5.293060e-01 ];

%-- Image #3:
omc_3 = [ 1.742277e+00 ; 2.077254e+00 ; -5.051086e-01 ];
Tc_3  = [ -1.254892e+02 ; -1.745481e+02 ; 7.757372e+02 ];
omc_error_3 = [ 9.182664e-04 ; 1.300000e-03 ; 1.972218e-03 ];
Tc_error_3  = [ 9.702941e-01 ; 8.889236e-01 ; 5.087874e-01 ];

%-- Image #4:
omc_4 = [ 1.827844e+00 ; 2.116467e+00 ; -1.102882e+00 ];
Tc_4  = [ -6.468451e+01 ; -1.547919e+02 ; 7.793401e+02 ];
omc_error_4 = [ 8.241682e-04 ; 1.346643e-03 ; 1.846859e-03 ];
Tc_error_4  = [ 9.778321e-01 ; 8.872338e-01 ; 4.098842e-01 ];

%-- Image #5:
omc_5 = [ 1.078974e+00 ; 1.922185e+00 ; -2.527138e-01 ];
Tc_5  = [ -9.248734e+01 ; -2.290794e+02 ; 7.369116e+02 ];
omc_error_5 = [ 8.051826e-04 ; 1.256029e-03 ; 1.413699e-03 ];
Tc_error_5  = [ 9.314705e-01 ; 8.466049e-01 ; 5.010231e-01 ];

%-- Image #6:
omc_6 = [ -1.701766e+00 ; -1.929498e+00 ; -7.917741e-01 ];
Tc_6  = [ -1.490441e+02 ; -7.960214e+01 ; 4.451487e+02 ];
omc_error_6 = [ 7.741343e-04 ; 1.253853e-03 ; 1.698305e-03 ];
Tc_error_6  = [ 5.582231e-01 ; 5.234354e-01 ; 4.286945e-01 ];

%-- Image #7:
omc_7 = [ 1.996394e+00 ; 1.931396e+00 ; 1.310790e+00 ];
Tc_7  = [ -8.307616e+01 ; -7.769523e+01 ; 4.404077e+02 ];
omc_error_7 = [ 1.482801e-03 ; 7.611111e-04 ; 1.780810e-03 ];
Tc_error_7  = [ 5.609048e-01 ; 5.116044e-01 ; 4.525487e-01 ];

%-- Image #8:
omc_8 = [ 1.961170e+00 ; 1.824198e+00 ; 1.326282e+00 ];
Tc_8  = [ -1.702794e+02 ; -1.035203e+02 ; 4.623205e+02 ];
omc_error_8 = [ 1.414885e-03 ; 7.761990e-04 ; 1.707652e-03 ];
Tc_error_8  = [ 6.132978e-01 ; 5.558515e-01 ; 5.098375e-01 ];

%-- Image #9:
omc_9 = [ -1.363901e+00 ; -1.980862e+00 ; 3.208860e-01 ];
Tc_9  = [ -2.107855e+00 ; -2.250933e+02 ; 7.289449e+02 ];
omc_error_9 = [ 9.645748e-04 ; 1.238801e-03 ; 1.596321e-03 ];
Tc_error_9  = [ 9.190506e-01 ; 8.338348e-01 ; 5.210346e-01 ];

%-- Image #10:
omc_10 = [ -1.513492e+00 ; -2.087101e+00 ; 1.880738e-01 ];
Tc_10  = [ -2.988524e+01 ; -3.003472e+02 ; 8.605054e+02 ];
omc_error_10 = [ 1.176238e-03 ; 1.408127e-03 ; 2.122581e-03 ];
Tc_error_10  = [ 1.104455e+00 ; 9.911865e-01 ; 6.915474e-01 ];

%-- Image #11:
omc_11 = [ -1.793139e+00 ; -2.065010e+00 ; -4.802063e-01 ];
Tc_11  = [ -1.512820e+02 ; -2.352881e+02 ; 7.050052e+02 ];
omc_error_11 = [ 1.055038e-03 ; 1.328805e-03 ; 2.283955e-03 ];
Tc_error_11  = [ 9.054157e-01 ; 8.487823e-01 ; 6.840720e-01 ];

%-- Image #12:
omc_12 = [ -1.839142e+00 ; -2.087535e+00 ; -5.158613e-01 ];
Tc_12  = [ -1.336744e+02 ; -1.771663e+02 ; 6.051959e+02 ];
omc_error_12 = [ 8.995927e-04 ; 1.277228e-03 ; 2.107483e-03 ];
Tc_error_12  = [ 7.711673e-01 ; 7.176930e-01 ; 5.719732e-01 ];

%-- Image #13:
omc_13 = [ -1.919022e+00 ; -2.116713e+00 ; -5.945150e-01 ];
Tc_13  = [ -1.328659e+02 ; -1.435033e+02 ; 5.450046e+02 ];
omc_error_13 = [ 8.392356e-04 ; 1.264306e-03 ; 2.072088e-03 ];
Tc_error_13  = [ 6.924667e-01 ; 6.424318e-01 ; 5.191272e-01 ];

%-- Image #14:
omc_14 = [ -1.954395e+00 ; -2.124760e+00 ; -5.847839e-01 ];
Tc_14  = [ -1.237533e+02 ; -1.370916e+02 ; 4.910906e+02 ];
omc_error_14 = [ 7.898423e-04 ; 1.239030e-03 ; 2.028521e-03 ];
Tc_error_14  = [ 6.248770e-01 ; 5.783289e-01 ; 4.659200e-01 ];

%-- Image #15:
omc_15 = [ -2.110704e+00 ; -2.253882e+00 ; -4.950597e-01 ];
Tc_15  = [ -1.993040e+02 ; -1.344612e+02 ; 4.752472e+02 ];
omc_error_15 = [ 9.114318e-04 ; 1.159896e-03 ; 2.210225e-03 ];
Tc_error_15  = [ 6.129619e-01 ; 5.736133e-01 ; 5.020647e-01 ];

%-- Image #16:
omc_16 = [ 1.886758e+00 ; 2.335939e+00 ; -1.729953e-01 ];
Tc_16  = [ -1.615403e+01 ; -1.702753e+02 ; 6.958201e+02 ];
omc_error_16 = [ 1.252594e-03 ; 1.323460e-03 ; 2.749250e-03 ];
Tc_error_16  = [ 8.717490e-01 ; 7.911984e-01 ; 5.946123e-01 ];

%-- Image #17:
omc_17 = [ -1.612964e+00 ; -1.953643e+00 ; -3.476711e-01 ];
Tc_17  = [ -1.353877e+02 ; -1.389062e+02 ; 4.903581e+02 ];
omc_error_17 = [ 7.804954e-04 ; 1.194035e-03 ; 1.682725e-03 ];
Tc_error_17  = [ 6.168414e-01 ; 5.736734e-01 ; 4.130599e-01 ];

%-- Image #18:
omc_18 = [ -1.341894e+00 ; -1.693367e+00 ; -2.975759e-01 ];
Tc_18  = [ -1.854450e+02 ; -1.577390e+02 ; 4.415837e+02 ];
omc_error_18 = [ 8.954374e-04 ; 1.160272e-03 ; 1.328901e-03 ];
Tc_error_18  = [ 5.609569e-01 ; 5.230889e-01 ; 4.012759e-01 ];

%-- Image #19:
omc_19 = [ -1.925896e+00 ; -1.838152e+00 ; -1.440606e+00 ];
Tc_19  = [ -1.066810e+02 ; -7.954567e+01 ; 3.343515e+02 ];
omc_error_19 = [ 7.705062e-04 ; 1.358547e-03 ; 1.721775e-03 ];
Tc_error_19  = [ 4.352701e-01 ; 3.991799e-01 ; 3.762900e-01 ];

%-- Image #20:
omc_20 = [ 1.895846e+00 ; 1.593082e+00 ; 1.471977e+00 ];
Tc_20  = [ -1.439836e+02 ; -8.800496e+01 ; 3.964140e+02 ];
omc_error_20 = [ 1.435194e-03 ; 7.937745e-04 ; 1.546537e-03 ];
Tc_error_20  = [ 5.313317e-01 ; 4.757741e-01 ; 4.552004e-01 ];

