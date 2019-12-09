function  show_dir( dir )
[m, n] = size(dir);
x = 0:n-1;
y = 0:m-1;
quiver(x, y, cos(dir), sin(dir));
axis([0 n 0 m]),axis image, axis ij;


end

