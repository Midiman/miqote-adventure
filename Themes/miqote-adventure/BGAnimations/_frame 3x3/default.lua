local File, Width, Height = ...
assert( File );
assert( Width );
assert( Height );

local FullFile = THEME:GetPathB('','_frame files 3x3/'..File )
local Frame = LoadActor( FullFile )
return Def.ActorFrame {
	Frame .. { Name="UpLeft", InitCommand=cmd(setstate,0;pause;horizalign,right;vertalign,bottom;x,-Width/2;y,-Height/2) };
	Frame .. { Name="Up", InitCommand=cmd(setstate,1;pause;zoomtowidth,Width;vertalign,bottom;zoomtowidth,Width;y,-Height/2) };
	Frame .. { Name="UpRight", InitCommand=cmd(setstate,2;pause;horizalign,left;vertalign,bottom;x,Width/2;y,-Height/2) };
	Frame .. { Name="Left", InitCommand=cmd(setstate,3;pause;horizalign,right;x,-Width/2;zoomtoheight,Height) };
	Frame .. { Name="Middle", InitCommand=cmd(setstate,4;pause;zoomtowidth,Width;zoomtoheight,Height) };
	Frame .. { Name="Right", InitCommand=cmd(setstate,5;pause;horizalign,left;x,Width/2;zoomtoheight,Height) };
	Frame .. { Name="DownLeft", InitCommand=cmd(setstate,6;pause;horizalign,right;vertalign,top;x,-Width/2;y,Height/2) };
	Frame .. { Name="Down", InitCommand=cmd(setstate,7;pause;zoomtowidth,Width;vertalign,top;zoomtowidth,Width;y,Height/2) };
	Frame .. { Name="DownRight", InitCommand=cmd(setstate,8;pause;horizalign,left;vertalign,top;x,Width/2;y,Height/2) };
};
