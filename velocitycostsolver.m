clc;

ra = 7000; % periapsis radius of initial circular orbit (km)
rb = 140e3;
rc = 175e3;% apoapsis radius of final circular orbit (km)
mu = 398600; % gravitational parameter of Earth (km^3/s^2)

a = (ra+rc)/2;


va = abs(sqrt((2*mu)/ra - mu/((ra+rb)/2)) - sqrt(mu/ra)); % velocity at periapsis
vb = abs(sqrt((2*mu)/rb - mu/((rb+rc)/2)) - sqrt((2*mu)/rb - mu/((ra+rb)/2))); % velocity at apoapsis
vc = abs(sqrt((2*mu)/rc - mu/((rb+rc)/2)) - sqrt(mu/rc)); % velocity at intermediate orbit

vbe = va+vb+vc;
fprintf('Velocity cost for Bielliptic Hohmann Transfer is: %f km/s\n',vbe);

va = abs(sqrt(mu*((2/ra)-(1/a)))-sqrt(mu/ra)); % Velocity in initial orbit
vb = abs(sqrt(mu/rc) - sqrt(mu*((2/rc)-(1/a)))); % Velocity in final orbit


vh = va+vb;
fprintf('Velocity cost for Hohmann Transfer is: %f km/s\n',vh);
