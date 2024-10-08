function PlotDisplacement(FrameData,V,Sc,plotDisplacement,plotTubeThicknesses)

%Arguments are Frame(D), Displacement(U) and Scale Factor(Sc)
V = V(1:3, :);
%C=[FrameData.Coord;FrameData.Coord+Sc*V];
e=FrameData.Con(1,:);
f=FrameData.Con(2,:);

% Std Areas (in^2)
RD5x35 = .051129;
RD5x49 = .0694261;
R75x35 = .078618;
R75x49 = .1079106;
RD1x35 = .1524;     %1.3mm
RD1x49 = .1405;  %1.2mm thickness
RD1x65 = .1852;   %1.6mm thickness
RD1x83 = .2272;  %2.0mm thickness
RD1x95 = .2788;  %2.5mm thickness
RD1120 = .331752;
RD1xSD = .785398;
SQ1x35 = .1509;   %equivalent to 25.4mm OD with 1.2mm thickness
SQ1x49 = 0.1806335;
SQ1x65 = 0.2330008;


%Initializes arrays of size equal to X. Comes from 2 nodes per joint and
%1 NaN per joint
X = NaN(FrameData.m*2*1.5,6);
XT = NaN(FrameData.m*2*1.5,42);

for i=1:6
    M=[C(i,e);C(i,f); NaN(size(e))];
    %Only the non-deformed plot is displayed by thickness so only 1:3 is needed.
    if i<4
        for j=1:FrameData.m
            switch FrameData.A(j)
                case RD5x35
                    XT(3*j-2:3*j,i)=M(:,j);
                case RD5x49
                    XT(3*j-2:3*j,i+3)=M(:,j);
                case R75x35
                    XT(3*j-2:3*j,i+6)=M(:,j);
                case R75x49
                    XT(3*j-2:3*j,i+9)=M(:,j);
                case RD1x35
                    XT(3*j-2:3*j,i+12)=M(:,j);
                case SQ1x35
                    XT(3*j-2:3*j,i+15)=M(:,j);
                case RD1x49
                    XT(3*j-2:3*j,i+18)=M(:,j);
                case SQ1x49
                    XT(3*j-2:3*j,i+21)=M(:,j);
                case RD1x65
                    XT(3*j-2:3*j,i+24)=M(:,j);
                case SQ1x65
                    XT(3*j-2:3*j,i+27)=M(:,j);
                case RD1x83
                    XT(3*j-2:3*j,i+30)=M(:,j);
                case RD1x95
                    XT(3*j-2:3*j,i+33)=M(:,j);
                case RD1120
                    XT(3*j-2:3*j,i+36)=M(:,j);
                case RD1xSD
                    XT(3*j-2:3*j,i+39)=M(:,j);
            end
        end
    end
    X(:,i)=M(:);
    
    
end

if plotDisplacement
    figure('Name','Deformed vs Non-Deformed');
    h1=plot3(X(:,1),X(:,2),X(:,3),'k.--',X(:,4),X(:,5),X(:,6),'r');
    axis('equal');
    set(h1, 'LineWidth',1);
    legend('Non-Deformed', 'Deformed','Location','southeast');
    title('Deformed vs Non-Deformed');
end

if plotTubeThicknesses
    figure('Name','Tube Thickness');
    h2=plot3(XT(:,1),XT(:,2),XT(:,3),'c-.',...
    XT(:,4),XT(:,5),XT(:,6),'c',...
    XT(:,7),XT(:,8),XT(:,9),'b-.',...
    XT(:,10),XT(:,11),XT(:,12),'b',...
    XT(:,13),XT(:,14),XT(:,15),'g-.',...
    XT(:,16),XT(:,17),XT(:,18),'g',...
    XT(:,19),XT(:,20),XT(:,21),'y-.',...
    XT(:,22),XT(:,23),XT(:,24),'y',...
    XT(:,25),XT(:,26),XT(:,27),'m-.',...
    XT(:,28),XT(:,29),XT(:,30),'m',...
    XT(:,31),XT(:,32),XT(:,33),'r-.',...
    XT(:,34),XT(:,35),XT(:,36),'r',...
    XT(:,37),XT(:,38),XT(:,39),'k-.',...
    XT(:,40),XT(:,41),XT(:,42),'k');
    axis('equal');
    set(h2, 'LineWidth',2);
    title('Tube Thickness');
    legend('.5x.035','.5x.049','.75x.035','.75x.049',...
            '1x.035','SQ1x.035',...
            '1x.049',...
            'SQ1x.049','1x.065','SQ1x.065',...
            '1x.083','1x.095','1x.120',...
            '1xSolid','Location','southeast');
end
    
end