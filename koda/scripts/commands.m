%matlab commands
	adjust_quiver_arrowhead_size.m				function adjust_quiver_arrowhead_size(quivergroup_handle, scaling_factor)
	autocorr.m				function varargout = autocorr(y,numLags,numMA,numSTD) %AUTOCORR Sample autocorrelation
	cell2csv.m				function cell2csv(fileName, cellArray, separator, excelYear, decimal) % Writes cell array content into a *.csv file.
	cell2num.m				function [O]=cell2num_S(i) % convert cell array into array of numbers
	cell2numS.m				function [O]=cell2num_S(i) % convert cell array of strings into array of numbers
	clearex.m				function clearex(varargin) %% This function clear all workspace
	colorScatterPlot.m				function [f] = colorScatterPlot(X,Y,Z,T,varargin) %% scatter plot with colors see below example
	commands.m				%matlab commands
	cprintf.m				function count = cprintf(style,format,varargin)
	createFig.m				%simple figure extension with figure positioning regarding the grid
	densityPlot.m				function [f] = densityPlot(pX,pY,pZ,pT,varargin) %% densityPlot see below example
	domain2meshgrid.m				function [X, Y, Z] = domain2meshgrid(domain, resolution)
	domain2vec.m				function [q, X, Y, Z] = domain2vec(domain, resolution)
	explode.m				function [split,numpieces]=explode(string,delimiters)
	filledCircle.m				function h = filledCircle(center,r,N,color)
	getColorMapColor.m				function [color] = getColorMapColor(clrMap,val) %arguments: clrMap - string, e.g. 'hot', val - value between 0 and 1
	getXMLElement.m				function [a] =  getXMLElement(XML,cellTarget); %[GK] gets you XML tag base on cell array input::getXMLElement(XMLin,{'case','casedef','constantsdef','coefficient'})
	getXMLvalue.m				function [a] =  getXMLValue(XML,cellTarget) % [GK] returns XML value based on cell input a=getXMLvalue(XMLin,{'case','casedef','constantsdef','coefficient'})
	gridLegend.m				% gridLegend : plots a legend in a multi column format
	interpolateToMeshGrid.m				function [xo, yo, fo] = interpolateToMeshGrid(x, y, f, nx, ny, varargin)
	meshgrid2vec.m				function [q] = meshgrid2vec(xgv, ygv, zgv)
	node2struct.m				function s = node2struct(node)
	parseXML.m				function theStruct = parseXML(filename)
	plotc.m				function [LG] = plotc(arg1x,arg1y,arg2,arg3)  %plot with variable existance checking example plotc('var_name','r+')
	plotCircle.m				function [x,y] = plotCircle(x,y,r,varargin) 
	plotclr.m				function plotc(x,y,v,marker)
	pltCycleMarker.m				function [f] = pltCycleMarker(i) %cycles markers
	putvar.m				function putvar(varargin)
	readline.m				function LINES = readline(FILE,NLINE,TYPE,varargin) %READLINE   Reads specific lines from an ascii file.
	rotateXLabels.m				function hh = rotateXLabels( ax, angle, varargin )
	scalVec.m				function [output,factor,offset,offset2] = scalVec(input,varargin) %% scales vector params: 'range',[-1,1]
	scontour.m				 function [C, handler] = scontour(x, y, v, xden, yden, varargin) %contour with supplied vectors of data instead of mesh
	smooth2.m				function matrixOut = smooth2(matrixIn, Nr, Nc) %2D smooth
	startup.m				%startup settings
	struct2Figure.m				function [out] = struct2figure(f,S)
	test.m				
	tricontour.m				function [c,h]=tricontour(tri,x,y,z,nv)
	uigetvar.m				function [variable,varname] = uigetvar(variableclass)
	zoomin.m				function ax = zoomin(f, zoom, axpos) % Displays a zoomed in subplot area
