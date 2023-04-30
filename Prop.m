classdef Prop
   properties
      mass {mustBeNumeric};
      x {mustBeNumeric};
      dim {mustBeNumeric};
   end
   methods
       function [obj, xx, mm] = Prop(m,x, xVect, mVect)
           if nargin > 0
                obj.mass = m;
                obj.x = x;
                xx = [xVect; obj.x];
                mm = [mVect; obj.mass];
           end
       end
       function V = Volume(obj)
           if size(obj.dim) == 3
               V = obj.dim(1)*obj.dim(2)*obj.dim(3);
           else
               disp("Not enough dimensions arguments");
           end
       end
   end
end