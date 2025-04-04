clearvars; close all;

p.sigma = 10;
p.beta = 8/3;
p.rho = 28;
ts=[0 300];
s0=[1 1 1];
tic;
[sb,tb]=Lorenz63(ts,s0,p); 
toc;
sb=sb(round(size(sb,1)/2):end,:);
s0=sb(end,:); % Start comparissons once you are on the attractor


[s1,t1]=Lorenz63(ts,s0,p);
[s2,t2]=Lorenz63(ts,s0+[1e-9 0 0],p);

ti=10:0.1:40;
s1i=interp1(t1,s1,ti);
s2i=interp1(t2,s2,ti);

fh=figure(1); clf; fh.WindowState='maximized'; fh.Visible='on';
fh.Color=ones(1,3);
do3d=0;
if do3d
    plot3(sb(:,1),sb(:,2),sb(:,3),'Color',[0 0 0 0.5]); hold on;
else
    plot(sb(:,1),sb(:,3),'Color',[0.5 0.5 0.5 0.5]); hold on;
    xlabel('$x$','Interpreter','Latex','FontSize',30);
    ylabel('$z$','Interpreter','Latex','FontSize',30);
    box on;
    axis square;
    set(gca,'TickDir','out','LineWidth',2,'TickLength',[0.005, 0.01]);
    set(groot, 'defaultAxesTickLabelInterpreter','Latex');
    set(gca,'TickLabelInterpreter','latex','XTick',[],'YTick',[]);
end
for j=1:numel(ti)
    fh.WindowState='maximized';
    if do3d
        ss1=scatter3(s1i(j,1),s1i(j,2),s1i(j,3),150,'filled',...
            'MarkerEdgeColor',[0 0 0.8],'MarkerFaceAlpha',0.4);
        ss2=scatter3(s2i(j,1),s2i(j,2),s2i(j,3),150,'filled',...
            'MarkerEdgeColor',[0.8 0 0]);
    else
        ss1=scatter(s1i(j,1),s1i(j,3),250,'filled',...
            'MarkerFaceColor',[0 0 0.8],'MarkerFaceAlpha',0.4,...
            'MarkerEdgeColor',[0 0 0]);
        ss2=scatter(s2i(j,1),s2i(j,3),250,'filled',...
            'MarkerFaceColor',[0.8 0 0],'MarkerFaceAlpha',0.4,...
            'MarkerEdgeColor',[0 0 0]);
        tts=sprintf('$t=t_0+%4.2f$',ti(j)-ti(1));
        title(tts,'Interpreter','Latex','FontSize',30);
    end
    pause(0.01);
    fh.WindowState='maximized';
    frame=getframe(fh);
    im{j}=frame2im(frame);

    delete(ss1); delete(ss2);
end

fprintf('\n Making gif \n');

filename = "Attractor.gif"; % Specify the output file name
%%{
if exist(filename,'file')
    system(sprintf('rm %s',filename));
end
%}
nImages=numel(ti);
for idx = 2:nImages
    [A,map] = rgb2ind(im{idx},256);
    if idx == 2 % Skip first frame
        imwrite(A,map,filename,"gif","LoopCount",Inf,"DelayTime",0.1);
    else
        imwrite(A,map,filename,"gif","WriteMode","append","DelayTime",0.1);
    end
end


%% Time series figure.

close all; clear im;

fh=figure(1); clf; fh.WindowState='maximized'; fh.Visible='on';
fh.Color=ones(1,3);


p1=plot(ti(1),s1i(1,1),...
        'Color',[0 0 0.8 0.4],'LineWidth',2); hold on;
p2=plot(ti(1),s2i(1,1),...
        'Color',[0.8 0 0 0.4],'LineWidth',2);
xlabel('$t$','Interpreter','Latex','FontSize',30);
ylabel('$x$','Interpreter','Latex','FontSize',30);
box on;
%axis square;
set(gca,'TickDir','out','LineWidth',2,'TickLength',[0.005, 0.01]);
set(groot, 'defaultAxesTickLabelInterpreter','Latex');
set(gca,'TickLabelInterpreter','latex');%,'YTick',[]);

ylim([-20 20]);
xlim([min(ti)-10 max(ti)-10]);


for j=1:numel(ti)
    fh.WindowState='maximized';
    p1=plot(ti(1:j)-10,s1i(1:j,1),...
        'Color',[0 0 0.8 0.4],'LineWidth',3);
    p2=plot(ti(1:j)-10,s2i(1:j,1),...
        'Color',[0.8 0 0 0.4],'LineWidth',3);
    tts=sprintf('$t=t_0+%4.2f$',ti(j)-ti(1));
    title(tts,'Interpreter','Latex','FontSize',30);
    pause(0.01);
    fh.WindowState='maximized';
    frame=getframe(fh);
    im{j}=frame2im(frame);

    %delete(ss1); delete(ss2);
    delete(p1); delete(p2);
end


filename = "Butterfly.gif"; % Specify the output file name
%%{
if exist(filename,'file')
    system(sprintf('rm %s',filename));
end
%}
nImages=numel(ti);
for idx = 2:nImages
    [A,map] = rgb2ind(im{idx},256);
    if idx == 2 % Skip first frame
        imwrite(A,map,filename,"gif","LoopCount",Inf,"DelayTime",0.1);
    else
        imwrite(A,map,filename,"gif","WriteMode","append","DelayTime",0.1);
    end
end



% now make a time series next to it at the same time with purple line
% splitting up into blue and red

%plot(t1,s1(:,1),'LineWidth',2,'Color',[0 0 0.8]); hold on;
%plot(t2,s2(:,1),'LineWidth',2,'Color',[0.8 0 0]);


%ts=[0 100];
%s0=[1 1 1];