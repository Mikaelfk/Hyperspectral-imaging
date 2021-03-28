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
   spectrum1(i,1) = (pixel1+pixel2+pixel3+pixel4+pixel5)/5
   
   pixel1 = datacube(100, 400, i);
   pixel2 = datacube(50, 450, i);
   pixel3 = datacube(150, 350, i);
   pixel4 = datacube(200, 300, i);
   pixel5 = datacube(100, 270, i);
   spectrum2(i,1) = (pixel1+pixel2+pixel3+pixel4+pixel5)/5
   
   pixel1 = datacube(450, 450, i);
   pixel2 = datacube(400, 400, i);
   pixel3 = datacube(350, 350, i);
   pixel4 = datacube(300, 300, i);
   pixel5 = datacube(300, 450, i);
   spectrum3(i,1) = (pixel1+pixel2+pixel3+pixel4+pixel5)/5
end


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
