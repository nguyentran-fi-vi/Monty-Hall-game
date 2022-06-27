clc
clear all 
close all

n = 1e4;
nd = [3, 5, 10];    % number of doors
P = zeros(length(nd), 2);

for k = 1:length(nd) % go through the number of doors
    nn = nd(k);
    doors = 1:nn;
    for i = 1:n % go through number of simulations
        status_init = zeros(1,nn);
        status_host = zeros(1,nn);
        status_part = zeros(1,nn);
        part_choice = randi(nn); % participant chooses the door
        status_part(part_choice) = 1; % participant remembers the number of the door he/she chose at first
        status_host(part_choice) = 1; % host remembers the number of the door participant chose at first
        
        car = randi(nn); % number of the door where the car is
        status_host(car) = 1; % host remembers the number of the door where the car is in order not to reveal it
        doors_new_host = doors(status_init==status_host); % generate new set of doors from which host has to choose
        host_choice = doors_new_host(randi(length(doors_new_host))); % host reveals one of doors with no car
        
        status_part(host_choice) = 1; % participant remembers the number of the door host revealed
        doors_new = doors(status_init==status_part); % generate new set of doors from which partcipant can choose
        new_choice = doors_new(randi(length(doors_new))); % if participant decides to make a new choice
        no_switch_V(i) = car == part_choice; % determine whether the participant's guess was right (when he/she sticks with the original choice)
        switch_V(i) = car == new_choice; % determine whether the participant's guess was right (when he/she switches the door)
    end
    
    P(k,1) = sum(no_switch_V)/n;     % find mean of the games the player wins if he/she stick with the initial choice
    % mean(no_switch_V)
    P(k,2) = sum(switch_V)/n;   % find mean of the games the player wins if he/she switch the initial choice
    
    % bar plot
    figure(k)
    c = categorical({'no switch','switch'});
    bar(c,P(k,:))
    title(['Number of doors = ', num2str(nd(k))])

end

p_no_switch_a = P(1,1)
p_switch_a = P(1,2)

p_no_switch_b = P(2,1)
p_switch_b = P(2,2)

p_no_switch_c = P(3,1)
p_switch_c = P(3,2)
