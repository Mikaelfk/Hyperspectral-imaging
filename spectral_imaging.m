hcube = hypercube("croped.img", "croped.hdr")
ListOfWavelengths = hcube.Wavelength;

datacube = hcube.DataCube;

spectrum1 = zeros(186,1);
spectrum2 = zeros(186,1);
spectrum3 = zeros(186,1);



for i = 1:186
   pixel1 = datacube(250, 125, i);
   pixel2 = datacube(200, 100, i);
   pixel3 = datacube(300, 50, i);
   pixel4 = datacube(400, 200, i);
   pixel5 = datacube(100, 230, i);
   spectrum1(i,1) = (pixel1+pixel2+pixel3+pixel4+pixel5)/5;
   
   pixel1 = datacube(100, 400, i);
   pixel2 = datacube(50, 450, i);
   pixel3 = datacube(150, 350, i);
   pixel4 = datacube(200, 300, i);
   pixel5 = datacube(100, 270, i);
   spectrum2(i,1) = (pixel1+pixel2+pixel3+pixel4+pixel5)/5;
   
   pixel1 = datacube(450, 450, i);
   pixel2 = datacube(400, 400, i);
   pixel3 = datacube(350, 350, i);
   pixel4 = datacube(300, 300, i);
   pixel5 = datacube(300, 450, i);
   spectrum3(i,1) = (pixel1+pixel2+pixel3+pixel4+pixel5)/5;
end

classification1 = zeros(500);
classification2 = zeros(500);
classification3 = zeros(500);
for i = 1:500
   for j = 1:500      
       TargetTimesReferenceSum1 = 0;
       TargetSquaredSum1 = 0;
       
       TargetTimesReferenceSum2 = 0;
       TargetSquaredSum2 = 0;
       
       TargetTimesReferenceSum3 = 0;
       TargetSquaredSum3 = 0;
       
       ReferenceSquaredSum = 0;
       for k=1:186
           TargetTimesReferenceSum1 = TargetTimesReferenceSum1 + (spectrum1(k, 1) * datacube(i, j, k));
           TargetSquaredSum1 = TargetSquaredSum1 + (spectrum1(k,1)^2);
           
           TargetTimesReferenceSum2 = TargetTimesReferenceSum2 + (spectrum2(k, 1) * datacube(i, j, k));
           TargetSquaredSum2 = TargetSquaredSum2 + (spectrum2(k,1)^2);
           
           TargetTimesReferenceSum3 = TargetTimesReferenceSum3 + (spectrum3(k, 1) * datacube(i, j, k));
           TargetSquaredSum3 = TargetSquaredSum3 + (spectrum3(k,1)^2);
           
           ReferenceSquaredSum = ReferenceSquaredSum + (datacube(i,j,k)^2);
       end
       if acos(TargetTimesReferenceSum1/(TargetSquaredSum1^(1/2)*ReferenceSquaredSum^(1/2))) < 0.07
       classification1(i,j) = 250;
       end
       if acos(TargetTimesReferenceSum2/(TargetSquaredSum2^(1/2)*ReferenceSquaredSum^(1/2))) < 0.07
       classification2(i,j) = 250;
       end
       if acos(TargetTimesReferenceSum3/(TargetSquaredSum3^(1/2)*ReferenceSquaredSum^(1/2))) < 0.07
       classification3(i,j) = 250;
       end
   end
end
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
