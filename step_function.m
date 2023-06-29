% Predator and prey cellular automaton
% Michiel Meeuwisse en Marian Hasan
% BFV1



% Create a window
shared.fig = figure(
       "units", "pixels",
       "position", [160 90 1600 900],
       "resize", "off",
       "menubar", "none",
       "name", "Predator Prey",
       "color", [0, 0, 0]
);

% Create the axes and define colormap
shared.axs = axes(
     "units", "pixels",
     "position", [0 200 1600 800],
     "colormap", [1,1,1;0.41,0.59,0.30;0.968,0.338,0.217;0,0.5,0.64]
);


% Create a pushbutton for choosing a colormap
shared.color = uicontrol(
         "style", "pushbutton",
         "units", "pixels",
         "position", [20 120 100 60],
         "string", "COLOR",
         "fontsize", 12,
         "tooltipstring", "Choose colormap",
         "foregroundcolor", [0, 0, 0],
         "backgroundcolor", [1, 1, 1],
         "callback", @click_color);


% Create a pushbutton for steps
shared.stp = uicontrol(
         "style", "pushbutton",
         "units", "pixels",
         "position", [140 120 100 60],
         "string", "STEP",
         "fontsize", 12,
         "tooltipstring", "Move forward one generation",
         "foregroundcolor", [0, 0, 0],
         "backgroundcolor", [1, 1, 1],
         "callback", @click_step

);

% Create a pushbutton to clear the window
shared.clr = uicontrol(
         "style", "pushbutton",
         "units", "pixels",
         "position", [1220 120 160 60],
         "string", "CLEAR",
         "fontsize", 12,
         "tooltipstring", "Clear world",
         "foregroundcolor", [0, 0, 0],
         "backgroundcolor", [1, 1, 1],
         "callback", @click_clear

);

% Create a pushbutton to generate a random world
shared.rnd = uicontrol(
         "style", "pushbutton",
         "units", "pixels",
         "position", [1420 120 160 60],
         "string", "RANDOMIZER",
         "fontsize", 12,
         "tooltipstring", "Generate randomized world",
         "foregroundcolor", [0, 0, 0],
         "backgroundcolor", [1, 1, 1],
         "callback", @click_randomizer

);

% Create a pushbutton to save world
shared.saver= uicontrol(
         "style", "pushbutton",
         "units", "pixels",
         "position", [1220 20 100 60],
         "string", "SAVE",
         "fontsize", 12,
         "tooltipstring", "Save image",
         "foregroundcolor", [0, 0, 0],
         "backgroundcolor", [1, 1, 1],
         "callback", @click_saver

);

% Create a pushbutton to load a file as world
shared.loader = uicontrol(
         "style", "pushbutton",
         "units", "pixels",
         "position", [1340 20 100 60],
         "string", "LOAD",
         "fontsize", 12,
         "tooltipstring", "Load image as world",
         "foregroundcolor", [0, 0, 0],
         "backgroundcolor", [1, 1, 1],
         "callback", @click_loader);

% Create a pushbutton that is linked to the lifewiki page
shared.helper = uicontrol(
         "style", "pushbutton",
         "units", "pixels",
         "position", [1460 20 100 60],
         "string", "HELP",
         "fontsize", 12,
         "tooltipstring", "Go to lifewiki page",
         "foregroundcolor", [0, 0, 0],
         "backgroundcolor", [1, 1, 1],
         "callback", @click_helper);


% Create a togglebutton to play or stop the world
shared.tgl = uicontrol(
            "style", "togglebutton",
            "units", "pixels",
            "position", [260 120 100 60],
            "string", "PLAY",
            "tooltipstring", "Play animation",
            "fontsize", 12,
            "foregroundcolor", [0, 0, 0],
            "backgroundcolor", [1, 1, 1],
            "callback", @click_playstop );

% Create a label for the speed slider
shared.lbl = uicontrol(
            "style", "text",
            "units", "pixels",
            "position", [20 70 360 20],
            "string", "Speed",
            "fontsize", 10,
            "foregroundcolor", [1.0, 1.0, 1.0],
            "backgroundcolor", [0, 0, 0],
            "callback", @click_playstop
            );

% Create a speed slider
shared.sld = uicontrol(
            "style", "slider",
            "units", "pixels",
            "position", [20 40 360 20],
            "value", 0.5,
            "backgroundcolor", [0.2, 0.2, 0.2],
            "foregroundcolor", [1.0, 1.0, 1.0],
            "tooltipstring", "Adjust speed"
);


% Create a label for the wolves slider
shared.lbl_wolves = uicontrol(
            "style", "text",
            "units", "pixels",
            "position", [420 170 360 20],
            "string", "Amount of wolves",
            "fontsize", 10,
            "foregroundcolor", [1.0, 1.0, 1.0],
            "backgroundcolor", [0, 0, 0],
            "callback", @click_playstop
            );

% Create a slider for amount of wolves that are spawned
shared.sld_wolves = uicontrol(
            "style", "slider",
            "units", "pixels",
            "position", [420 140 360 20],
            "value", 0.5,
            "backgroundcolor", [0.2, 0.2, 0.2],
            "foregroundcolor", [1.0, 1.0, 1.0],
            "tooltipstring", "Adjust amount of wolves"
);


% Create a label for the rabbits slider
shared.lbl_rabbits = uicontrol(
            "style", "text",
            "units", "pixels",
            "position", [420 70 360 20],
            "string", "Amount of rabbits",
            "fontsize", 10,
            "foregroundcolor", [1.0, 1.0, 1.0],
            "backgroundcolor", [0, 0, 0]
            );

% Create a slider for amount of rabbits that are spawned
shared.sld_rabbits = uicontrol(
            "style", "slider",
            "units", "pixels",
            "position", [420 40 360 20],
            "value", 0.1,
            "backgroundcolor", [0.2, 0.2, 0.2],
            "foregroundcolor", [1.0, 1.0, 1.0],
            "tooltipstring", "Adjust amount of rabbits"
);


% Create a label for the death rate wolves slider
shared.lbl_wolves_dr = uicontrol(
            "style", "text",
            "units", "pixels",
            "position", [820 170 360 20],
            "string", "Death rate wolves",
            "fontsize", 10,
            "foregroundcolor", [1.0, 1.0, 1.0],
            "backgroundcolor", [0, 0, 0]
            );

% Create a slider for death rate of wolves
shared.sld_wolves_dr = uicontrol(
            "style", "slider",
            "units", "pixels",
            "position", [820 140 360 20],
            "value", 0.4,
            "backgroundcolor", [0.2, 0.2, 0.2],
            "foregroundcolor", [1.0, 1.0, 1.0],
            "tooltipstring", "Adjust death rate of wolves"
);


% Create a label for the death rate rabbits slider
shared.lbl_rabbits_dr = uicontrol(
            "style", "text",
            "units", "pixels",
            "position", [820 70 360 20],
            "string", "Death rate rabbits",
            "fontsize", 10,
            "foregroundcolor", [1.0, 1.0, 1.0],
            "backgroundcolor", [0, 0, 0]
            );

% Create a slider for death rate of wolves

shared.sld_rabbits_dr = uicontrol(
            "style", "slider",
            "units", "pixels",
            "position", [820 40 360 20],
            "value", 0.4,
            "backgroundcolor", [0.2, 0.2, 0.2],
            "foregroundcolor", [1.0, 1.0, 1.0],
            "tooltipstring", "Adjust death rate of rabbits"

);

% Create world as image
shared.world_size = [100,200];
amount_wolves = get(shared.sld_wolves, "value")*1000;
shared.wolf_world = (rand(shared.world_size) < 1/amount_wolves);
amount_rabbits = get(shared.sld_rabbits, "value")*100;
shared.rabbit_world = (rand(shared.world_size) < 1/amount_rabbits) - shared.wolf_world;
shared.rabbit_world(shared.rabbit_world < 0) = 0;
shared.grass_world = randi([0 1], shared.world_size);
shared.biome = zeros(shared.world_size);
shared.biome(shared.wolf_world > 0) = 2;
shared.biome(shared.rabbit_world > 0) = 1;
shared.old_biome = shared.biome;
shared.img = imagesc(shared.axs, shared.biome, [0,3]);
axis(shared.axs, "off");
guidata(shared.fig, shared);





function click_color(source, event)
  % Choose a colormap for the world

  % Collect the data
  shared = guidata(source);


  % Provide user with menu for colormaps
  opties = {"Standard", "Standard inverted"};
  keuze = menu("Choose a colormap", opties);


  % Asses which colormap has been chosen and then change colormap in shared.axs to said colormap
  if strcmp(opties{keuze}, "Standard")
    set(shared.axs, "colormap", [1,1,1;0.41,0.59,0.30;0.968,0.338,0.217;0,0.5,0.64])
  endif

  if strcmp(opties{keuze}, "Standard inverted" )
    set(shared.axs, "colormap", [0,0,0;0.59,0.41,0.70;0.032,0.662,0.783;1,0.5,0.36] )
  endif

endfunction


function click_step(source, event)
  shared = guidata(source);

  rabbit_neighbours = zeros(shared.world_size);
  grass_neighbours = rabbit_neighbours;
  wolf_neighbours = grass_neighbours;
  pup_world = wolf_neighbours;

  %calculating neighbours for all worlds
  for delta_y = -1:1
    if delta_y == 0
      for delta_x = -1 :2: 1
        rabbit_neighbours += circshift(ceil(shared.rabbit_world), [delta_y,delta_x]);
        wolf_neighbours += circshift(ceil(shared.wolf_world), [delta_y,delta_x]);
        grass_neighbours += circshift(shared.grass_world, [delta_y,delta_x]);
      endfor
    else
      for delta_x = -1:1
        rabbit_neighbours += circshift(ceil(shared.rabbit_world), [delta_y,delta_x]);
        wolf_neighbours += circshift(ceil(shared.wolf_world), [delta_y,delta_x]);
        grass_neighbours += circshift(shared.grass_world, [delta_y,delta_x]);
      endfor
    endif
  endfor

  %create new grass world
  grass_eaten = ...
    (((shared.grass_world == 1) &...
    (rabbit_neighbours > 0) &...
    (shared.wolf_world == 0) &...
    (pup_world == 0))) | (shared.grass_world == 1 & shared.rabbit_world == 1);


  grass_added = (rand(shared.world_size) < 1/8);
  shared.grass_world += grass_added;
  shared.grass_world(shared.grass_world == 2 ) = 1;



  shared.grass_world -= grass_eaten;

  %create new wolf world
  shared.wolf_world(pup_world == 1) = 1;
  rabbit_eaten = ...
    ((shared.rabbit_world > 0) &...
    (wolf_neighbours > 0));
  pup_world = rabbit_eaten;




  %create new rabbit world
  shared.rabbit_world(grass_eaten == 1 & shared.wolf_world == 0 & pup_world == 0) = 1;
  shared.rabbit_world(shared.wolf_world > 0) = 0;
  shared.grass_world -= shared.rabbit_world;
  shared.grass_world(shared.grass_world < 0) = 0;
  shared.rabbit_world -= rabbit_eaten;

  %animals go hungry
  d_r_r = get(shared.sld_rabbits_dr, "value")+0.1;
  shared.rabbit_world -= d_r_r;
  d_r_w = get(shared.sld_wolves_dr, "value")+0.1;
  shared.wolf_world -= d_r_w;


  shared.rabbit_world(shared.rabbit_world < 0) = 0;
  shared.wolf_world(shared.wolf_world < 0) = 0;

  %feeding animals that ate

  shared.wolf_world(rabbit_neighbours > 0 & shared.wolf_world > 0) = 1;
  shared.rabbit_world(grass_neighbours > 0 & shared.rabbit_world > 0) = 1;

  %create biome
  shared.biome = zeros(shared.world_size);
  shared.biome(shared.wolf_world > 0) = 2;
  shared.biome(shared.rabbit_world > 0) = 1;
  shared.wolf_world(shared.old_biome == 3) = 1;
  shared.biome(shared.old_biome == 3) = 2;
  shared.biome(pup_world == 1) = 3;

  shared.old_biome = shared.biome;

  set(shared.img, "cdata", shared.biome);
  guidata(source, shared);

endfunction


function click_playstop(source, event)
  % Continue stepping forward one generation until stopped

  % Collect the data
  shared = guidata(source);

  % Check if the button is pressed or not
  if get(shared.tgl, "value")

    % If "Play" button is pressed, change the appearance of the button to "Stop"
    set(shared.tgl, "string", "STOP", "tooltipstring", "Stop animation");

    % Continue stepping forward generations until "Stop" button is pressed
    while ishandle(shared.tgl) && get(shared.tgl, "value")
      click_step(source, event);
      drawnow();
      pause((1.0 - get(shared.sld, "value") .^2));
    endwhile
  else
    % When "Stop" button is pressed, change the appearance of the button to "Play"
    set(shared.tgl, "string", "PLAY", "tooltipstring", "Play animation");
  endif

endfunction


function click_clear(source, event)
  % Clear the currently running world

  % Confirm user wants to clear the world
  choice = questdlg("Are you sure you want to clear the world?", "Wait", "Yes",
  "Cancel", "Cancel");
  if strcmp(choice, "Yes")

    % Collect the data
     shared = guidata(source);

    % If the world was playing, stop the world and change the play/stop button's appearance to "Play"
     if get(shared.tgl, "value")
       set(shared.tgl, "value", 0, "string", "PLAY", "tooltipstring", "Play animation");
       drawnow();
     endif

     % Clear the world
     new_world = zeros(shared.world_size);
     shared.rabbit_world = zeros(shared.world_size);
     shared.wolf_world = zeros(shared.world_size);
     shared.pup_world = zeros(shared.world_size);
     shared.grass_world = zeros(shared.world_size);


     % Update the image and data
     shared.biome = new_world;
     set(shared.img, "cdata", new_world);
     guidata(source, shared);
  endif
endfunction


function click_randomizer(source, event)
  % Generate random world

  % Confirm user wants to genetate a random world
    choice = questdlg ("Are you sure you want to generate a random world?", "Wait", "Yes", "Cancel", "Cancel");
  if strcmp(choice, "Yes")

  % Collect the data
    shared = guidata(source);

    % If the world was playing, stop the world and change the play/stop button's appearance to "Play"
    if get(shared.tgl, "value")
      set(shared.tgl, "value", 0, "string", "PLAY", "tooltipstring", "Play animation");
      drawnow();
    endif

    % Generate randomized world


    amount_wolves = get(shared.sld_wolves, "value")*1000;
    shared.wolf_world = (rand(shared.world_size) < 1/amount_wolves);
    amount_rabbits = get(shared.sld_rabbits, "value")*100;
    shared.rabbit_world = (rand(shared.world_size) < 1/amount_rabbits) - shared.wolf_world;
    shared.rabbit_world(shared.rabbit_world < 0) = 0;
    shared.grass_world = randi([0 1], shared.world_size);
    shared.biome = zeros(shared.world_size);
    shared.biome(shared.wolf_world > 0) = 2;
    shared.biome(shared.rabbit_world > 0) = 1;
    shared.old_biome = shared.biome;

    % Update the image and data
    set(shared.img, "cdata", shared.biome);
    guidata(source, shared);
  endif
endfunction



function click_saver(source, event)


  % Get filename from user
  filename = uiputfile(
    {"*.bmp;*.gif;*.png", "Supported image formats";
     "*.csv;*.txt", "Supported text data formats"},
    "Choose filename");

  if (length(filename) > 4)
    shared = guidata(source);

    % Save as image file
    if strcmpi(filename(end-3 : end), ".bmp") || ...
       strcmpi(filename(end-3 : end), ".gif") || ...
       strcmpi(filename(end-3 : end), ".png")
      colormap = get(shared.axs, "colormap");
      imwrite(uint8(shared.biome), colormap, filename)
    endif


    % Save as text data file
    if strcmpi(filename(end-3 : end), ".csv") || ...
       strcmpi(filename(end-3 : end), ".txt")
      csvwrite(filename, uint8(shared.biome))
    endif
  endif
endfunction


function click_loader(source, event)
  % Load csv-file as world

  % Collect the data
  shared = guidata(source);

  % Choose csv-file and generate as world
  plaatje = uigetfile("*.csv", "Choose a CSV-file");
  own_world = csvread(plaatje);

  % Update the image and data
  shared.biome = own_world;
  set(shared.img, "cdata", own_world);
  guidata(source, shared);
endfunction


function click_helper(source, event)
  % Send user to lifiwiki page

  % Collect the data
  shared = guidata(source);
  wiki = web("http://langers.nl/wiki/doku.php?id=predator_prey_2023:welkom")

  guidata(source, shared);

endfunction




