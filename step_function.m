shared.world_size = [10,10];

shared.wolf_world = (rand(world_size) < 1/30);
shared.rabbit_world = (rand(world_size) < 1/10) - shared.wolf_world;
shared.rabbit_world(shared.rabbit_world < 0) = 0;
shared.grass_world = randi([0 1], shared.world_size);
shared.biome = zeros(world_size);
shared.biome(shared.wolf_world > 0) = 2;
shared.biome(shared.rabbit_world > 0) = 1;

function click_step(source, event)
  shared = guidata(source);

  rabbit_neighbours = zeros(shared.world_size);
  grass_neighbours = rabbit_neighbours;
  wolf_neighbours = grass_neighbours;

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
    ((shared.grass_world == 1) &...
    (shared.rabbit_neighbours > 0) &...
    (shared.wolf_world == 0));

  grass_added = (rand(shared.world_size) < 1/8);
  shared.grass_world += grass_added;
  shared.grass_world(shared.grass_world == 2 ) = 1;

  shared.grass_world -= grass_eaten;

  %create new wolf world
  rabbit_eaten = ...
    ((shared.rabbit_world > 0) &...
    (wolf_neighbours > 0));

  shared.wolf_world += rabbit_eaten;

  %create new rabbit world
  shared.rabbit_world(grass_eaten == 1 & shared.wolf_world == 0) = 1;
  shared.rabbit_world(shared.wolf_world > 0) = 0;
  shared.grass_world -= shared.rabbit_world;
  shared.grass_world(grass_world < 0) = 0;

  %animals go hungry
  shared.rabbit_world -= 0.4;
  shared.wolf_world -= 0.4;

  shared.rabbit_world(shared.rabbit_world < 0) = 0;
  shared.wolf_world(shared.wolf_world < 0) = 0;

  %feeding animals that ate

  shared.wolf_world(rabbit_neighbours > 0 & shared.wolf_world > 0) = 1;
  shared.rabbit_world(grass_neighbours > 0 & shared.rabbit_world > 0) = 1;

  %create biome
  shared.biome = zeros(world_size);
  shared.biome(shared.wolf_world > 0) = 2;
  shared.biome(shared.rabbit_world > 0) = 1;

  set(shared.img, "cdata", shared.display);
  guidata(source, shared);

endfunction
