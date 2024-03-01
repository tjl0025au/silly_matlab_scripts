function bevly_head_function()
%% Textured 3D Bevly example

%% Options
npanels = 180;   % Number of globe panels around the equator deg/panel = 360/npanels
alpha   = 1; % globe transparency level, 1 = opaque, through 0 = invisible
GMST0 = []; 
image_file = 'http://www.eng.auburn.edu/images/programs/mech/headshots/bevly-david.jpg';
% image_file = 'http://www.eng.auburn.edu/images/programs/mech/headshots/martin-scott.jpg';
% image_file = 'http://eng.auburn.edu/images/programs/mech/headshots/chen-howard.jpg';
% Mean spherical earth
%% Create figure
space_color = 'k';
figure('Color', space_color);
hold on;
% Turn off the normal axes
set(gca, 'NextPlot','add', 'Visible','off');
axis equal;
axis auto;
% Set initial view
view(0,30);
axis vis3d;
%% Create wireframe globe
% Create a 3D meshgrid of the sphere points using the ellipsoid function
erad    = 6371008.7714; % equatorial radius (meters)
prad    = 6371008.7714; % polar radius (meters)
[x, y, z] = ellipsoid(0, 0, 0, erad, erad, prad, npanels);

cdata = imread(image_file);
pcdata = cdata(1:floor(size(cdata,1)/3*2),:,:);
ncdata = 255 - pcdata;

cdata= pcdata;
% figure(2)
for k = 1:30000
    
%     if rem(k,2) == 0
%         cdata = ncdata;
% %         cdata = -1.*cdata;
%     else
%         cdata = pcdata;
%     end
    
    globe = surf(x, y, -z, 'FaceColor', 'none', 'EdgeColor', 0.5*[1 1 1],'HandleVisibility','off');
    view(0,0);
    hgx = hgtransform;
    set(hgx,'Matrix', makehgtform('zrotate',-deg2rad(k)));
    set(globe,'Parent',hgx);
    set(globe, 'FaceColor', 'texturemap', 'CData', cdata, 'FaceAlpha', alpha, 'EdgeColor', 'none');
    axis equal;
%     imwrite(globe,'Bevly_head.gif')
%     exportgraphics(gcf,'testAnimated.gif','Append',true);
%     gif("bevly_head.gif")
%     hold on;
    pause(0.01);
end

