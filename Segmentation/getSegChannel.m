function [channelLabel] = getSegChannel(pixels)
%Ask the user which channel from the image should be used for segmentation.
%Use the Pixels object to get the number of channels, ask the pixelsService
%for the labels used for each channel then ask the user to choose.

% Copyright (C) 2013-2014 University of Dundee & Open Microscopy Environment.
% All rights reserved.
% 
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License along
% with this program; if not, write to the Free Software Foundation, Inc.,
% 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

global session;

numChannels = pixels.getSizeC.getValue;
pixelsId = pixels.getId.getValue;
fakeChannelNum = 0;
for thisChannel = 1:numChannels
    try
        channelLabel{thisChannel} = session.getPixelsService.retrievePixDescription(pixelsId).getChannel(thisChannel-1).getLogicalChannel.getEmissionWave.getValue;
    catch
        channelLabel{thisChannel} = fakeChannelNum;
        fakeChannelNum = fakeChannelNum + 1;
    end
end


end