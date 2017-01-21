function [R] = rotation_matrix(angle)
C = cos(angle); 
S = sin(angle);
R = [C, -S; S, C];