function [ solution ] = concAverages(perc_or_av)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


    directory_name = uigetdir;
    subfolders = dir(directory_name)
    
    
    subfolders = subfolders(arrayfun(@(x) x.name(1), subfolders) ~= '.');
    
    
    for i = length(subfolders):-1:1
        if ~isempty(strfind(subfolders(i).name, 'file_processor'))
            subfolders(i) = [];
        elseif ~isempty(strfind(subfolders(i).name, 'fig'))
            subfolders(i) = [];
        end
    end
    directories = cell(length(subfolders),1);
    
    
%     files = dir('*.mat')
    
    totRepsSA = [];
    totTimeSA = [];
    totRepsPIQMC = [];
    totTimePIQMC = [];
    totRepsHB = [];
    totTimeHB = [];
    totRepsPT = [];
    totTimePT = [];
    
    totPercSA = [];
    totPercPIQMC = [];
    totPercHB = []; 
    
    
    for i = length(subfolders):-1:1
        % Gets current folder name
        folder_name = strcat(directory_name, strcat(filesep,subfolders(i).name));
        directories{i} = folder_name;
        mat_files = dir(folder_name)
        for j = length(mat_files):-1:1;
            nameis = mat_files(j).name;
            switch perc_or_av
                case 'average'
                    if ~isempty(strfind(mat_files(j).name, 'average'));
                        av_file = mat_files(j).name
                        load(av_file);
                        totRepsSA = cat(1, totRepsSA, avRepsSA);
                        totTimeSA = cat(1, totTimeSA, avTimeSA);
                        totRepsPIQMC = cat(1, totRepsPIQMC, avRepsPIQMC);
                        totTimePIQMC = cat(1, totTimePIQMC, avTimePIQMC);
                        totRepsHB = cat(1, totRepsHB, avRepsHB);
                        totTimeHB = cat(1, totTimeHB, avTimeHB);
        %               totRepsPT = cat(1, totRepsPT, avRepsPT);
        %               totTimePT = cat(1, totTimePT, avTimePT);
                    end
                case 'percentage'
                    if ~isempty(strfind(mat_files(j).name, 'percentages'));
                        perc_file = mat_files(j).name;
                        perc_file = [folder_name, filesep, perc_file];
                        load(perc_file, 'percSA', 'percPIQMC', 'percHB');
                        
                        totPercSA = cat(1, totPercSA, percSA);
                        totPercPIQMC = cat(1, totPercPIQMC, percPIQMC);
                        totPercHB =  cat(1, totPercHB, percHB);
                    end
            end
        end
        
    end

    
    solution = {totRepsSA, totTimeSA, totRepsPIQMC, totTimePIQMC, totRepsHB, totTimeHB, totRepsPT, totTimePT, totPercSA, totPercPIQMC, totPercHB};

end

