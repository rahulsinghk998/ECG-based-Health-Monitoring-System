k=[];
j=1;
load DataPlot.txt;
p=DataPlot(:,1);
for i=1:length(p)
    if ((p(i)>p(i-1)) && (p(i)>p(i+1))) then
        k(j)=p(i);
    end
    i=i+1;
    j=j+1;
end
plot(j,k);


        
% outputmean  = tsmovavg(p,'s',30,2);
% outputstdev = movingstd(p,30,'backward');
% 
% deviations = zeros(length(p));
% 
% signals = [];
% 
% for i=1:length(p)
% 
%    if (p(i) - outputmean(i) >= 1.5*max(deviations(:)))
%        signals = [signals 0.4];
%        deviations(i) = deviations(i-1);
%    else
%        signals = [signals 0.2];
%        if (p(i) - outputmean(i) > 0)
%             deviations(i) = p(i) - outputmean(i);
%        else
%             deviations(i) = 0.5;
%        end
%    end
% end
% 
%figure;
%hold all;
%plot(p, 'LineWidth', 1);
%plot(outputmean, 'LineWidth', 2, 'Color', 'red');
%plot(outputmean+outputstdev, 'LineWidth', 2, 'Color', 'green');
%plot(outputmean+2*outputstdev, 'LineWidth', 1, 'Color', 'green');
%line([0 80], [1.5 1.5], 'Color', 'red');
% plot(signals);
%plot(deviations);
% plot(y,'r');
