function batchprocessing(folder, force_overwrite = false)
  more off;
  files = dir(strcat(folder, "*.csv"));
  disp(sprintf("Detected %i files.", length(files)));
  numberOfNewFiles = 0;
  for i=1:length(files)
    j = 0;
    
    if(!force_overwrite && file_in_path(folder, strcat(files(i).name, ".png")) != 0)
      continue
    endif
    
    try 
      do
        j++;     
          data=dlmread(strcat(folder,files(i).name), ";");
      until (data(j, 1) > 0)
    catch
      disp(sprintf("Error in %s, continuing", files(i).name))
      continue
    end_try_catch
    
    if(columns(data) > 2)
      h = plotyy(data(:,1), data(:,2), data(:,1), data(:,3));
    elseif(columns(data) > 1)
      h = plot(data(:,1), data(:,2));
    else
      continue
    endif
    
    saveas(1, strcat(folder, files(i).name, ".png"), "png");
    close all;
    numberOfNewFiles++;
    
  endfor
  disp(sprintf("%i new files written, %i skipped.", numberOfNewFiles, length(files) - numberOfNewFiles));
  more on;
endfunction
