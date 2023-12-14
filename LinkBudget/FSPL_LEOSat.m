%% LEO Satellite FSPL Calculator
%% Assumes a non-stationary, constant altitude satellite orbits around the spherical earth
%% Assumes the loss is due to free-space propagation, and there is no other loss
%% Shows the required isoflux ground station antenna pattern
%% v0: Turker, 2023.12.15, GNU Octave, version 7.3.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
clc

%% Inputs
R_earth=6371*1e3 %radius of earth, m
H_gs=900 %altitude of ground station, m
H_sat=400*1e3 %altitude of satellite orbit, m
freq=435*1e6 %frequency of operation, Hz
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Elevation angle calculation for horizon
figure;
imshow('FSPL_LEOSat.png') ;

theta=acosd(R_earth/(R_earth+H_gs)); %gs elevation angle to horizon, degrees
phi=acosd(R_earth/(R_earth+H_sat)); %sat elevation angle to horizon, degrees

arcangle=theta+phi; %visible satellite elevation angle in one direction wrt center of earth, degrees

%% Coordinates of the arc that represents the earth
anglestep=0.5; %sampling interval of the earth plot, degrees
eartharcanglelim=((-arcangle-10):anglestep:(arcangle+10))+90; %angle samples of the earth plot, degrees
arcx=R_earth*cosd(eartharcanglelim); %x positions of the earth plot, m
arcy=R_earth*sind(eartharcanglelim); %y positions of the earth plot, m

%% Coordinates of the point that represents the ground station
gs_x=0; %ground station x position, m
gs_y=R_earth+H_gs; %ground station y position, m

%% Coordinates of the points that represents the satellite orbit
sat_x=(R_earth+H_sat)*sind(arcangle); %satellite orbit horizon x position, m
sat_y=(R_earth+H_sat)*cosd(arcangle); %satellite orbit horizon y position, m

satxpoints=(R_earth+H_sat)*cosd(eartharcanglelim); %all satellite orbit x positions, m
satypoints=(R_earth+H_sat)*sind(eartharcanglelim); %all satellite orbit y positions, m

satxpointsvis=(R_earth+H_sat)*sind(-arcangle:anglestep:arcangle); %visible satellite orbit x positions, m
satypointsvis=(R_earth+H_sat)*cosd(-arcangle:anglestep:arcangle); %visible satellite orbit y positions, m

%% Satellite orbit and visibility plot
figure;
subplot(2,2,[1,2])
scatter(gs_x,gs_y,'*','linewidth',7)
axis equal
hold on
plot([-2*sat_x+gs_x gs_x 2*sat_x-gs_x],[2*sat_y-gs_y gs_y 2*sat_y-gs_y],'r')
plot(satxpoints,satypoints,'linestyle','--','color','g')
plot(satxpointsvis,satypointsvis,'g')
area(arcx,arcy,'FaceColor','k')
lgd=legend('Ground Station','Horizon Line Between Ground Station and Satellite',...
'Non-Visible Portion of Satellite Orbit','Visible Portion of Satellite Orbit',...
'location','south');
set (lgd, "fontsize", 12);
xlim([-3*1e6,3*1e6]);
ylim([5.5*1e6 7*1e6]);
xticks([]);
yticks([]);
box on
title({'Satellite Visibility',['Satellite Altitude=',num2str(H_sat/1000),'km'],['Ground Station Altitude=',num2str(H_gs),'m']})

%% Elevation angle of the satellite in its visible orbit wrt ground station, degrees
eleanglewrtstation=rad2deg(atan2((satypointsvis-R_earth-H_gs),satxpointsvis));
% Set the elevation angles from -90 to 270
eleanglewrtstation((eleanglewrtstation<-90)&(eleanglewrtstation>=-180))=eleanglewrtstation((eleanglewrtstation<-90)&(eleanglewrtstation>=-180))+360;
eleanglewrtstation((eleanglewrtstation<=360)&(eleanglewrtstation>270))=eleanglewrtstation((eleanglewrtstation<=360)&(eleanglewrtstation>270))-360;

%% Free space path loss calculation between the satellite and ground station when the satellite is visible
fsplvisdb=20*log10(4*pi*sqrt(satxpointsvis.^2+(satypointsvis-gs_y).^2)*freq/3e8);%fspl, dB

%% FSPL vs elevation angle & distance vs elevation angle plots
subplot(2,2,3)
[hAx,hLine1,hLine2]=plotyy (eleanglewrtstation,(1e-3)*sqrt(satxpointsvis.^2+(satypointsvis-gs_y).^2),eleanglewrtstation,fsplvisdb);
xlabel('Elevation Angle, ^\circ');
ylabel (hAx(1), 'Distance, km');
ylabel (hAx(2), 'FSPL, dB');
xlim([0 90]);
grid on;
set(hAx,'Xtick', 0:15:180);
set(hAx,'Xdir', 'reverse');
title({'Distance vs Elevation Angle','Free Space Path Loss vs Elevation Angle','90^\circ: Zenith, 0^\circ: Horizon'});

%% Required normalized isoflux ground station antenna pattern plot
subplot(2,2,4)
polar(deg2rad(eleanglewrtstation), fsplvisdb-min(fsplvisdb));
title({'Normalized Isoflux Antenna Pattern, dB',' ',' '});
set (gca, "rtick", 0:2.5:(2.5*ceil((max(fsplvisdb-min(fsplvisdb)))/2.5)),"ttick", 0:30:180);
axis equal;
%hold on
ylim([-5 (2.5*ceil((max(fsplvisdb-min(fsplvisdb)))/2.5))]);
%negarcangle=180:1:360;
%area((2.5*ceil((max(fsplvisdb-min(fsplvisdb)))/2.5))*cosd(negarcangle),(2.5*ceil((max(fsplvisdb-min(fsplvisdb)))/2.5))*sind(negarcangle),'FaceColor','k')

%%%%%%%%%%%%%%%%%%%%%

%% 3D plots
%Angular and cartesian positions of the satellite when it is visible
phisat=(0:anglestep:(360-0*anglestep)).';
thetasat=90+(-arcangle:anglestep:arcangle).';
phisat_rep=repmat(phisat.',length(thetasat),1);
thetasat_rep=repmat(thetasat,1,length(phisat));
[sat3d_x,sat3d_y,sat3d_z]=sph2cart(deg2rad(phisat_rep),deg2rad(thetasat_rep),ones(size(phisat_rep))*(H_sat+R_earth));

%Angular and cartesian positions of the earth to plot in 3D coordinate system
phiearth=(0:5:(360)).';
thetaearth=(-90:5:90).';
phiearth_rep=repmat(phiearth.',length(thetaearth),1);
thetaearth_rep=repmat(thetaearth,1,length(phiearth));
[earth3d_x,earth3d_y,earth3d_z]=sph2cart(deg2rad(phiearth_rep),deg2rad(thetaearth_rep),ones(size(phiearth_rep))*(R_earth));

%Distance between the ground station and the satellite
gs_to_sat_3ddist_km=sqrt(sat3d_x.^2+sat3d_y.^2+(sat3d_z-R_earth-H_gs).^2)/1e3;

%Free space path loss calculation between the satellite and ground station when the satellite is visible
gs_to_sat_3dfspl_db=20*log10(4*pi*gs_to_sat_3ddist_km*1000*freq/3e8);

%Required normalized isoflux ground station antenna pattern
reqdirectivity_db=gs_to_sat_3dfspl_db-min(gs_to_sat_3dfspl_db);

figure;
surf(sat3d_x,sat3d_y,sat3d_z,gs_to_sat_3ddist_km);
shading interp;
hold on;
surf(earth3d_x,earth3d_y,earth3d_z,zeros(size(earth3d_x)));
axis equal;
cb=colorbar;
title(cb,'km')
colormap jet;
caxis([min(min(gs_to_sat_3ddist_km)) max(max(gs_to_sat_3ddist_km))]);
view(45,30);
title('Distance Between Ground Station and Satellite, km');

figure;
subplot(2,2,[1,3])
surf(sat3d_x,sat3d_y,sat3d_z,gs_to_sat_3dfspl_db);
shading interp;
axis equal;
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
view(0,90);
title({'Free Space Path Loss, dB','Normalized Isoflux Antenna Pattern, dB'});
colormap jet
axis off

subplot(2,2,2)
axis off
cb2=colorbar('location','southoutside');
title(cb2,'Normalized Isoflux Antenna Pattern, dB')
caxis([min(min(reqdirectivity_db)) max(max(reqdirectivity_db))]);

subplot(2,2,4)
axis off
cb1=colorbar('location','northoutside');
title(cb1,'Free Space Path Loss, dB')
caxis([min(min(gs_to_sat_3dfspl_db)) max(max(gs_to_sat_3dfspl_db))]);
