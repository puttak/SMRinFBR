% Load results
clear all
close all
load('data/pairwiseSegregated.mat')
% Create meshgrids for r and z
[R,Z] = meshgrid(r,z);
%% Temperature plot
figure(1);
filename = 'temperature';
% 3D
color = hot; % Cool (hot) colors
surf(R,Z,T) % plot
xlim([min(min(r)) max(max(r))]);
ylim([min(min(z)) max(max(z))]);
zlim([min(min(T)), max(max(T))]);
xlabel('$r\quad\left[\SI{}{\meter}\right]$');
ylabel('$z\quad\left[\SI{}{\meter}\right]$');
zlabel('$T\quad\left[\SI{}{\kelvin}\right]$');
title('Temperature in the reactor');
colormap(color(1:end-10,:));
[az,el] = view;
view(az+90,el);
set(gcf,'position',[0 0 1366/2 768/2])
cleanfigure;
matlab2tikz(['fig/' filename '.tikz'],...
            'parseStrings',false,...
            'standalone',true,...
            'extraAxisOptions',{'scaled x ticks = false', ...
            ['x tick label style={/pgf/number format/fixed,'...
             '/pgf/number format/precision=2,'...
             '/pgf/number format/zerofill=true}'],...
             'z buffer = sort'},...
            'extraCode',{'\usepackage{siunitx}'});
system(['cd fig &&'...
        'sed -i "s/white!15!black/black/g" ' filename '.tikz &&'...
        'pdflatex ' filename '.tikz && '...
        'rm ' filename '.aux ' filename '.log']);
% 2D
figure(2)
filename = [filename 'Axial'];
hold on
color = hot(5*length(r));
color = color(1:4:4*length(r),:);
legendstring = {};
for i = 1:length(r)
    plot(z,T(:,i),'Color',color(i,:),'LineWidth',1.5);
    legendstring{i} = ['$r = \SI{', num2str(r(i),'%10.2e'), '}{\meter}$'];
end
xlabel('$z\quad\left[\SI{}{\meter}\right]$');
ylabel('$T\quad\left[\SI{}{\kelvin}\right]$');
title('Temperature in the reactor')
legend(legendstring,'Location','East')
set(gcf,'position',[0 0 1366/2 768/2])
matlab2tikz(['fig/' filename '.tikz'],...
            'parseStrings',false,...
            'standalone',true,...
            'extraAxisOptions',{'scaled x ticks = false', ...
            ['x tick label style={/pgf/number format/fixed,'...
             '/pgf/number format/precision=1,'...
             '/pgf/number format/zerofill=true}'],...
            'legend style={draw=white}'},...
            'extraCode',{'\usepackage{siunitx}'});
system(['cd fig &&'...
        'sed -i "s/white!15!black/black/g" ' filename '.tikz &&'...
        'pdflatex ' filename '.tikz && '...
        'rm ' filename '.aux ' filename '.log']);
close all
%% Velocity
% 3D
figure(1);
filename = 'velocity';
color = jet; % Cool colors
surf(R,Z,uz) % plot
xlim([min(min(r)) max(max(r))]);
ylim([min(min(z)) max(max(z))]);
zlim([min(min(uz)), max(max(uz))]);
xlabel('$r\quad\left[\SI{}{\meter}\right]$');
ylabel('$z\quad\left[\SI{}{\meter}\right]$');
zlabel('$u_z\quad\left[\SI{}{\meter\per\second}\right]$');
title('Velocity in the reactor');
colormap(color);
[az,el] = view;
view(az+90,el);
set(gcf,'position',[0 0 1366/2 768/2])
cleanfigure;
matlab2tikz(['fig/' filename '.tikz'],...
            'parseStrings',false,...
            'standalone',true,...
            'extraAxisOptions',{'scaled x ticks = false', ...
            ['x tick label style={/pgf/number format/fixed,'...
             '/pgf/number format/precision=2,'...
             '/pgf/number format/zerofill=true}'],...
             'z buffer = sort'},...
            'extraCode',{'\usepackage{siunitx}'});
system(['cd fig &&'...
        'sed -i "s/white!15!black/black/g" ' filename '.tikz &&'...
        'pdflatex ' filename '.tikz && '...
        'rm ' filename '.aux ' filename '.log']);
% 2D
figure(2)
filename = [filename 'Axial'];
hold on
color = jet(length(r));
legendstring = {};
for i = 1:length(r)
    plot(z,uz(:,i),'Color',color(i,:),'LineWidth',1.5);
    legendstring{i} = ['$r = \SI{', num2str(r(i),'%10.2e'), '}{\meter}$'];
end
xlabel('$z\quad\left[\SI{}{\meter}\right]$');
ylabel('$u_z\quad\left[\SI{}{\meter\per\second}\right]$');
title('Axial velocity in the reactor')
legend(legendstring,'Location','East')
set(gcf,'position',[0 0 1366/2 768/2])
matlab2tikz(['fig/' filename '.tikz'],...
            'parseStrings',false,...
            'standalone',true,...
            'extraAxisOptions',{'scaled x ticks = false', ...
            ['x tick label style={/pgf/number format/fixed,'...
             '/pgf/number format/precision=1,'...
             '/pgf/number format/zerofill=true}'],...
            'legend style={draw=white}'},...
            'extraCode',{'\usepackage{siunitx}'});
system(['cd fig &&'...
        'sed -i "s/white!15!black/black/g" ' filename '.tikz &&'...
        'pdflatex ' filename '.tikz && '...
        'rm ' filename '.aux ' filename '.log']);
close all
%% Density
% 3D
figure(1);
filename = 'density';
surf(R,Z,rho) % plot
color = parula;
xlim([min(min(r)) max(max(r))]);
ylim([min(min(z)) max(max(z))]);
zlim([min(min(rho)), max(max(rho))]);
xlabel('$r\quad\left[\SI{}{\meter}\right]$');
ylabel('$z\quad\left[\SI{}{\meter}\right]$');
zlabel('$\rho\quad\left[\SI{}{\kilogram\per\cubic\meter}\right]$');
title('Density in the reactor');
colormap(color);
[az,el] = view;
view(az+90,el);
set(gcf,'position',[0 0 1366/2 768/2])
cleanfigure;
matlab2tikz(['fig/' filename '.tikz'],...
            'parseStrings',false,...
            'standalone',true,...
            'extraAxisOptions',{'scaled x ticks = false', ...
            ['x tick label style={/pgf/number format/fixed,'...
             '/pgf/number format/precision=2,'...
             '/pgf/number format/zerofill=true}'],...
             'z buffer = sort'},...
            'extraCode',{'\usepackage{siunitx}'});
system(['cd fig &&'...
        'sed -i "s/white!15!black/black/g" ' filename '.tikz &&'...
        'pdflatex ' filename '.tikz && '...
        'rm ' filename '.aux ' filename '.log']);
% 2D
figure(2)
filename = [filename 'Axial'];
hold on
color = flipud(parula(length(r)));
legendstring = {};
for i = 1:length(r)
    plot(z,rho(:,i),'Color',color(i,:),'LineWidth',1.5);
    legendstring{i} = ['$r = \SI{', num2str(r(i),'%10.2e'), '}{\meter}$'];
end
xlabel('$z\quad\left[\SI{}{\meter}\right]$');
ylabel('$\rho\quad\left[\SI{}{\kilogram\per\cubic\meter}\right]$');
title('Density in the reactor')
legend(legendstring)
set(gcf,'position',[0 0 1366/2 768/2])
matlab2tikz(['fig/' filename '.tikz'],...
            'parseStrings',false,...
            'standalone',true,...
            'extraAxisOptions',{'scaled x ticks = false', ...
            ['x tick label style={/pgf/number format/fixed,'...
             '/pgf/number format/precision=1,'...
             '/pgf/number format/zerofill=true}'],...
             'legend style={draw=white}'},...
            'extraCode',{'\usepackage{siunitx}'});
system(['cd fig &&'...
        'sed -i "s/white!15!black/black/g" ' filename '.tikz &&'...
        'pdflatex ' filename '.tikz && '...
        'rm ' filename '.aux ' filename '.log']);
close all
%% Pressure
figure(1)
filename = 'pressure';
plot(z,p(:,1),'k','LineWidth',1.5)
xlabel('$z\quad\left[\SI{}{\meter}\right]$');
ylabel('$p\quad\left[\SI{}{\pascal}\right]$');
title('Pressure in the reactor');
set(gcf,'position',[0 0 1366/2 768/2])
matlab2tikz(['fig/' filename '.tikz'],...
            'parseStrings',false,...
            'standalone',true,...
            'extraAxisOptions',{'scaled x ticks = false', ...
            ['x tick label style={/pgf/number format/fixed,'...
             '/pgf/number format/precision=1,'...
             '/pgf/number format/zerofill=true}'],...
             'legend style={draw=white}'},...
            'extraCode',{'\usepackage{siunitx}'});
system(['cd fig &&'...
        'sed -i "s/white!15!black/black/g" ' filename '.tikz &&'...
        'pdflatex ' filename '.tikz && '...
        'rm ' filename '.aux ' filename '.log']);
close all
%% Mass fractions
compNames = {'CH4','CO','CO2','H2','H2O','N2'};
for i = 1:length(compNames)
    % 3D
    figure(1)
    filename = [compNames{i} 'mass'];
    surf(R,Z,w{i}) % plot
    color = parula;
    xlim([min(min(r)) max(max(r))]);
    ylim([min(min(z)) max(max(z))]);
    zlim([min(min(w{i})), max(max(w{i}))]);
    xlabel('$r\quad\left[\SI{}{\meter}\right]$');
    ylabel('$z\quad\left[\SI{}{\meter}\right]$');
    zlabel(['$\omega_\ce{' compNames{i} '}$']);
    title(['Mass fraction of \ce{' compNames{i} '} in the reactor']);
    colormap(color);
    [az,el] = view;
    view(az+90,el);
    set(gcf,'position',[0 0 1366/2 768/2])
    cleanfigure;
    matlab2tikz(['fig/' filename '.tikz'],...
            'parseStrings',false,...
            'standalone',true,...
            'extraAxisOptions',{'scaled x ticks = false', ...
            ['x tick label style={/pgf/number format/fixed,'...
             '/pgf/number format/precision=2,'...
             '/pgf/number format/zerofill=true}'],...
            'scaled z ticks = false',...
            ['z tick label style={/pgf/number format/fixed,'...
             '/pgf/number format/precision=3,'...
             '/pgf/number format/zerofill=true}'],...
             'z buffer = sort'},...
            'extraCode',{'\usepackage{siunitx}',...
            '\usepackage[version=3]{mhchem}'});
    system(['cd fig &&'...
            'sed -i "s/white!15!black/black/g" ' filename '.tikz &&'...
            'pdflatex ' filename '.tikz && '...
            'rm ' filename '.aux ' filename '.log']);
	% 2D
    figure(2)
    filename = [filename 'Axial'];
    hold on
    color = flipud(parula(length(r)));
    legendstring = {};
    for j = 1:length(r)
        plot(z,w{i}(:,j),'Color',color(j,:),'LineWidth',1.5);
        legendstring{j} = ['$r = \SI{', num2str(r(j),'%10.2e'), '}{\meter}$'];
    end
    xlabel('$z\quad\left[\SI{}{\meter}\right]$');
    ylabel(['$\omega_\ce{' compNames{i} '}$']);
    title(['Mass fraction of \ce{' compNames{i} '} in the reactor']);
    legend(legendstring,'Location','EastOutside')
    set(gcf,'position',[0 0 1366/2 768/2])
    matlab2tikz(['fig/' filename '.tikz'],...
                'parseStrings',false,...
                'standalone',true,...
                'extraAxisOptions',{'scaled x ticks = false',...
                ['x tick label style={/pgf/number format/fixed,'...
                 '/pgf/number format/precision=1,'...
                 '/pgf/number format/zerofill=true}'],...
                'scaled y ticks = false',...
                ['y tick label style={/pgf/number format/fixed,'...
                 '/pgf/number format/precision=3,'...
                 '/pgf/number format/zerofill=true}'],...
                 'legend style={draw=white}'},...
                'extraCode',{'\usepackage{siunitx}',...
                '\usepackage[version=3]{mhchem}'});
    system(['cd fig &&'...
            'sed -i "s/white!15!black/black/g" ' filename '.tikz &&'...
            'pdflatex ' filename '.tikz && '...
            'rm ' filename '.aux ' filename '.log']);
    close all
end

%% Mole fractions
for i = 1:length(compNames)
    % 3D
    figure(1)
    filename = [compNames{i} 'mole'];
    surf(R,Z,x{i}) % plot
    color = parula;
    xlim([min(min(r)) max(max(r))]);
    ylim([min(min(z)) max(max(z))]);
    zlim([min(min(x{i})), max(max(x{i}))]);
    xlabel('$r\quad\left[\SI{}{\meter}\right]$');
    ylabel('$z\quad\left[\SI{}{\meter}\right]$');
    zlabel(['$x_\ce{' compNames{i} '}$']);
    title(['Mole fraction of \ce{' compNames{i} '} in the reactor']);
    colormap(color);
    [az,el] = view;
    view(az+90,el);
    set(gcf,'position',[0 0 1366/2 768/2])
    cleanfigure;
    matlab2tikz(['fig/' filename '.tikz'],...
            'parseStrings',false,...
            'standalone',true,...
            'extraAxisOptions',{'scaled x ticks = false', ...
            ['x tick label style={/pgf/number format/fixed,'...
             '/pgf/number format/precision=2,'...
             '/pgf/number format/zerofill=true}'],...
            'scaled z ticks = false',...
            ['z tick label style={/pgf/number format/fixed,'...
             '/pgf/number format/precision=3,'...
             '/pgf/number format/zerofill=true}'],...
             'z buffer = sort'},...
            'extraCode',{'\usepackage{siunitx}',...
            '\usepackage[version=3]{mhchem}'});
    system(['cd fig &&'...
            'sed -i "s/white!15!black/black/g" ' filename '.tikz &&'...
            'pdflatex ' filename '.tikz && '...
            'rm ' filename '.aux ' filename '.log']);
	% 2D
    figure(2)
    filename = [filename 'Axial'];
    hold on
    color = flipud(parula(length(r)));
    legendstring = {};
    for j = 1:length(r)
        plot(z,x{i}(:,j),'Color',color(j,:),'LineWidth',1.5);
        legendstring{j} = ['$r = \SI{', num2str(r(j),'%10.2e'), '}{\meter}$'];
    end
    xlabel('$z\quad\left[\SI{}{\meter}\right]$');
    ylabel(['$x_\ce{' compNames{i} '}$']);
    title(['Mole fraction of \ce{' compNames{i} '} in the reactor']);
    legend(legendstring,'Location','EastOutside')
    set(gcf,'position',[0 0 1366/2 768/2])
    matlab2tikz(['fig/' filename '.tikz'],...
                'parseStrings',false,...
                'standalone',true,...
                'extraAxisOptions',{'scaled x ticks = false',...
                ['x tick label style={/pgf/number format/fixed,'...
                 '/pgf/number format/precision=1,'...
                 '/pgf/number format/zerofill=true}'],...
                'scaled y ticks = false',...
                ['y tick label style={/pgf/number format/fixed,'...
                 '/pgf/number format/precision=3,'...
                 '/pgf/number format/zerofill=true}'],...
                 'legend style={draw=white}'},...
                'extraCode',{'\usepackage{siunitx}',...
                '\usepackage[version=3]{mhchem}'});
    system(['cd fig &&'...
            'sed -i "s/white!15!black/black/g" ' filename '.tikz &&'...
            'pdflatex ' filename '.tikz && '...
            'rm ' filename '.aux ' filename '.log']);
    close all
end