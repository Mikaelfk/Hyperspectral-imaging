hcube = hypercube("croped.img", "croped.hdr")

% Stores the wavelengths and the datacube in variables
ListOfWavelengths = hcube.Wavelength;
datacube = hcube.DataCube;

% Make three spectrum arrays, one for each part of the image
spectrum1 = zeros(186,1);
spectrum2 = zeros(186,1);
spectrum3 = zeros(186,1);


% for loop which iterates from 1 to the number of bands in the
% hyperspectral image
for i = 1:186
   % Find the reflectance of five random pixels in the left part of the image,
   % then find the average reflactance of those five pixels
   pixel1 = datacube(250, 125, i);
   pixel2 = datacube(200, 100, i);
   pixel3 = datacube(300, 50, i);
   pixel4 = datacube(378, 144, i);
   pixel5 = datacube(80, 200, i);
   % Store the average reflectance in the spectrum1 array
   spectrum1(i,1) = (pixel1+pixel2+pixel3+pixel4+pixel5)/5;
   
   % Same as above, but with the top right part of the image
   pixel1 = datacube(100, 400, i);
   pixel2 = datacube(50, 450, i);
   pixel3 = datacube(150, 350, i);
   pixel4 = datacube(200, 300, i);
   pixel5 = datacube(100, 270, i);
   spectrum2(i,1) = (pixel1+pixel2+pixel3+pixel4+pixel5)/5;
   
   % Same as above, but with the bottom right part of the image
   pixel1 = datacube(450, 450, i);
   pixel2 = datacube(400, 400, i);
   pixel3 = datacube(350, 350, i);
   pixel4 = datacube(300, 300, i);
   pixel5 = datacube(300, 450, i);
   spectrum3(i,1) = (pixel1+pixel2+pixel3+pixel4+pixel5)/5;
end

% Make three empty 500x500 matrices.
classification1 = zeros(500);
classification2 = zeros(500);
classification3 = zeros(500);
% two foor loops, to go through each pixel in the image

thresholdangle = 0.01;

for i = 1:500
   for j = 1:500
       TargetTimesReferenceSum1 = 0;
       ReferenceSquaredSum1 = 0;
       
       TargetTimesReferenceSum2 = 0;
       ReferenceSquaredSum2 = 0;
       
       TargetTimesReferenceSum3 = 0;
       ReferenceSquaredSum3 = 0;
       
       TargetSquaredSum = 0;
       % This loop finds the values used in the SAM formula
       for k=1:186
           TargetTimesReferenceSum1 = TargetTimesReferenceSum1 + (spectrum1(k, 1) * datacube(i, j, k));
           ReferenceSquaredSum1 = ReferenceSquaredSum1 + (spectrum1(k,1)^2);
           
           TargetTimesReferenceSum2 = TargetTimesReferenceSum2 + (spectrum2(k, 1) * datacube(i, j, k));
           ReferenceSquaredSum2 = ReferenceSquaredSum2 + (spectrum2(k,1)^2);
           
           TargetTimesReferenceSum3 = TargetTimesReferenceSum3 + (spectrum3(k, 1) * datacube(i, j, k));
           ReferenceSquaredSum3 = ReferenceSquaredSum3 + (spectrum3(k,1)^2);
           
           TargetSquaredSum = TargetSquaredSum + (datacube(i,j,k)^2);
       end
       % The SAM formula returns an angle, and if the angle is less than
       % 0.07 radians (4 degrees) the current pixel is given a white color.
       % This is done for all three spectrums
       if acos(TargetTimesReferenceSum1/(TargetSquaredSum^(1/2)*ReferenceSquaredSum1^(1/2))) < thresholdangle
       classification1(i,j) = 250;
       end
       if acos(TargetTimesReferenceSum2/(TargetSquaredSum^(1/2)*ReferenceSquaredSum2^(1/2))) < thresholdangle
       classification2(i,j) = 250;
       end
       if acos(TargetTimesReferenceSum3/(TargetSquaredSum^(1/2)*ReferenceSquaredSum3^(1/2))) < thresholdangle
       classification3(i,j) = 250;
       end
   end
end
% Makes the 500x500 matrices into gray scale images.
image1 = mat2gray(classification1);
image2 = mat2gray(classification2);
image3 = mat2gray(classification3);

figure
imshow(image1)

figure
imshow(image2)

figure
imshow(image3)

figure
plot(ListOfWavelengths, spectrum1, 'b', 'LineWidth', 2)
title("Left part")
xlabel('Wavelengths') 
ylabel('Reflectance') 

figure
plot(ListOfWavelengths, spectrum2, 'b', 'LineWidth', 2)
title("Top right part")
xlabel('Wavelengths') 
ylabel('Reflectance') 

figure
plot(ListOfWavelengths, spectrum3, 'b', 'LineWidth', 2)
title("Bottom right part")
xlabel('Wavelengths') 
ylabel('Reflectance') 
