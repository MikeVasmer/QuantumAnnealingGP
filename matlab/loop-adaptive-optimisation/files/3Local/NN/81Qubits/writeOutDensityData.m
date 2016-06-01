function [ ] = writeOutDensityData( figFile )
%WRITEOUTDENSITYDATA Takes a density plot and writes text files with
%relevant values

s = load(figFile, '-mat')

XData = s.hgS_070000.children(1).children(1).properties.XData;
YData = s.hgS_070000.children(1).children(1).properties.YData;
CData = s.hgS_070000.children(1).children(1).properties.CData;



end

