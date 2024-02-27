clear;
clc;
close all;
app=NaN(1);
format shortG

folder1='C:\Local Matlab Data';  %%%%%%%Change this to where you put this matlab file
cd(folder1)
addpath(folder1)
pause(0.1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Get Terrain Profile

tic;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Test to Check ITM/Terrain 
NET.addAssembly(fullfile('C:\USGS', 'SEADLib.dll')); %%%%%%Where the SEADLib.dll is located
itmp=ITMAcs.ITMP2P;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Transmitter
TxLat = 34.147;
TxLon = -117.63;
TxHtm = 30 ;  %%%%%meters

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Receiver
RxLat =  35.427;
RxLon = -116.89;
RxHtm =  73;  %%%%%%%%meters


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Terrain Profile 
USGS3Secp = TerrainPcs.USGS;
CoordTx = TerrainPcs.Geolocation(TxLat,TxLon);
CoordRx = TerrainPcs.Geolocation(RxLat,RxLon);
USGS3Secp.TerrainDataPath=  "C:\USGS";
Elev=double(USGS3Secp.GetPathElevation(CoordTx,CoordRx,90,true));  %%%%%%%%%This is the "z" equivalent

%%%%%%%Need to then get the distance array --> track2 or just calculate the
%%%%%%%distance and divide by the number of element in Elev
temp_dist_km=deg2km(distance(TxLat,TxLon,RxLat,RxLon));
guess_num_steps=temp_dist_km*1000/90;
length(Elev)
r=linspace(0,temp_dist_km*1000,length(Elev));  %%%%%%%%X distance is in meters

close all;
figure;
hold on;
plot(r/1000,Elev,'-k')
xlabel('Distance [km]')
ylabel('Elevation [m]')
title('Terrain Profile')
grid on;
filename1=strcat('Example_Terrain_Profile.png');
%saveas(gcf,char(filename1))
















'Done'
