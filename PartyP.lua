--[[Copyright © 2016, Allison Jane
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of <addon name> nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <your name> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Special Thanks to Mike McKee author of Enemybar, Morath86 author of barfiller, 
Cliff author of TParty, and sdahlka and Iryoku on the windower forums, looking at the 
coding of their various pieces really helped me piece this together.  
]]

_addon.name = 'PartyP'
_addon.author = 'Allison Jane'
_addon.version = '0.3'
_addon.language = 'english'

texts = require('texts')
config = require('config')

defaults = T{}
defaults.pos = {}
defaults.pos.x = 200
defaults.pos.y = 100
defaults.step = {}
defaults.step.x = 90
defaults.step.y = 20
defaults.pet = {}
defaults.pet.x = 840
defaults.pet.y = 440
defaults.font_size = 12

settings = config.load(defaults)
config.save(settings)

config.register(settings, function(settings_table) 
    local nondefault = defaults
	if settings_table.pos.x ~= nil then
		nondefault = settings_table
	end
	
	hp_settings = {}
	hp_display = {}
	mp_settings = {}
	mp_display = {}
	
	for i = 0, 5 do
		hp_settings[i] = {pos = {x = nondefault.pos.x + (nondefault.step.x * i), y = nondefault.pos.y}, text = {size = nondefault.font_size}}
		hp_display[i] = texts.new('HP: ${hpp|---}%', hp_settings[i])
		mp_settings[i] = {pos = {x = nondefault.pos.x + (nondefault.step.x * i), y = nondefault.pos.y + nondefault.step.y}, text = {size = nondefault.font_size}}
		mp_display[i] = texts.new('MP: ${mpp|---}%', mp_settings[i])
	end
	
	pet_settings = {pos = {x = nondefault.pet.x, y = nondefault.pet.y}, text = {size = nondefault.font_size}}
	p0pet = texts.new(' Pet: ${hpp|---}%', pet_settings)
end)

function Update()
	local party = windower.ffxi.get_party()
	local mypet = windower.ffxi.get_mob_by_target('pet')
	
    for i = 0, 5 do
        if party["p"..i] ~= nil then
            hp_display[i].hpp = party['p'..i].hpp
            mp_display[i].mpp = party['p'..i].mpp
            hp_display[i]:show()
            mp_display[i]:show()
        else
            hp_display[i]:hide()
            mp_display[i]:hide()
        end
    end

	if mypet ~= nil then
		p0pet.hpp = mypet.hpp
		p0pet:show()
	else
		p0pet:hide()
	end
end

-- Thanks sdahlka for the for the following code
frame_count = 0
windower.register_event('prerender',function()
    if not windower.ffxi.get_info().logged_in then -- stops prerender if not logged in yet
        return
    end
    if frame_count%30 == 0 and windower.ffxi.get_info().logged_in then
        Update()
    end
    frame_count = frame_count + 1
end)
