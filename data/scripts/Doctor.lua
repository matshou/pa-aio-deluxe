-- Doctor --


function look_around(types, cb, range, justOne)
	local count = 0
	if range == "max" then range = 9999 end
	for k, v in pairs(types) do
		local os = this.GetNearbyObjects(v, (range or nearbyRange))
		for o, distance in pairs( os ) do
			count = count + 1
			if cb then
				cb(o, distance)
			end
			if justOne then return o end
		end
	end
	if justOne then
		return nil
	else
		return count
	end
end

function getObjCell(o)
	return World.GetCell(math.floor(o.Pos.x or 1), math.floor(o.Pos.y or 1))
end

function dist( from, to )
	return math.pow(math.pow( (from.Pos.x - to.Pos.x), 2) + math.pow( (from.Pos.y - to.Pos.y), 2) , 0.5)
end

function away_dest( who )
	return math.pow(math.pow( (who.Pos.x - who.Dest.x), 2) + math.pow( (who.Pos.y - who.Dest.y), 2) , 0.5)
end

local current_room_id

function sameRoom( o )
	return (current_room_id == getObjCell(o).Room.u)
end


function SpawnAt(type, to, dx, dy)
	return Object.Spawn(type, (to.Pos.x + (dx or 0)), (to.Pos.y + (dy or 0)))
end

function today()
	return math.floor( World.TimeIndex / (24 * 60) ) + 1
end








local Ready1 = 0
local Delay1 = 0.4
local Ready2 = 0
local Delay2 = 5

local inited = false

function Update()
	if not inited then Init() end
	if this.Damage > 0.7 then
		return
	end

	if this.last_serve_day < today() then
		this.last_serve_day = today()
		this.treat_time = 0
		this.treat_cost = 0
		updateTT()
	end

	if World.TimeIndex > Ready1 then
		Ready1 = World.TimeIndex + Delay1
		modHeal()
	end

	if World.TimeIndex > Ready2 then
		Ready2 = World.TimeIndex + Delay2
		-- healthCheck()
	end
end


function healthCheck()
	if this.Carrying.u ~= -1 then
		return
	end

	look_around({'Prisoner'}, healthCheckP, 6)

end


function healthCheckP(p)

end



function Init()
	inited = true
	if this.last_serve_day == nil then
		this.last_serve_day = today()
	end
	if this.treat_time == nil then
		this.treat_time = 0
	end
	if this.treat_cost == nil then
		this.treat_cost = 0
	end
	if this.last_call == nil then
		this.last_call = 0
	end
	updateTT()
end

function updateTT()
	this.Tooltip = {'doctor__tt', math.floor(this.treat_time), 'X', this.treat_cost, 'Y'}
end

-- Doctor originally heal at 0.1 per minute. That is too fast.
local old_heal_speed = 0.08
local new_heal_speed = 0.02
local heal_speed_mod = (old_heal_speed - new_heal_speed) * Delay1
local energy_cost_speed = 2
local energy_cost_each = energy_cost_speed * Delay1
local waste_poss_speed = 0.1
local waste_poss_each = waste_poss_speed * Delay1
local waste_drop_radius = 1

local treats = {
	{help_amount = 0.2, price = 5},
	{help_amount = 0.3, price = 10},
	{help_amount = 0.4, price = 20},
}

function modHeal()
	if this.Carrying.u == -1 then
		return
	end

	local h = look_around({'Prisoner', "Guard", "DogHandler", "Workman", "ArmedGuard", "Cook", "Janitor", "Gardener", "Doctor", "Psychologist", 'BoldHost', 'CameraMan', "Warden", "Chief", "Foreman", 'Sniper', "Accountant", "Lawyer",}, carryingO, 1, true)
	if h then
		-- print( h.LastTreated )
		-- print( (World.TimeIndex - (h.LastTreated or 0)) )
		if h.Type == 'Prisoner' and not h.Misbehavior == 'None' then
			-- Ignore
			return
		end
		local treat_diff = World.TimeIndex - (h.LastTreated or 0)
		local treating = treat_diff < Delay1
		local treating_bug = math.floor(treat_diff) == -7200
			-- print(treating_bug)
			-- print(away_dest(this))
			-- print(this.ReloadTimer)
			-- print(this.Energy)
			-- print(this.RestState)
			-- print(heal_speed_mod)
			-- print(this.JobId)
			-- print(h.HealingJobId)
			-- print('')
		-- treating_bug = false
		-- print(treating)

		if h.Damage < 0.98 and (treating or treating_bug) and away_dest(this) < 1.5 then
			-- if this.Energy > 0.2 then
				-- h.Damage = h.Damage + heal_speed_mod
			-- end
			this.Energy = this.Energy - energy_cost_each
			this.treat_time = this.treat_time + Delay1
			-- print(this.Energy)
			print(h.Damage)
			if math.random() < waste_poss_each then
				local level = math.floor(h.Damage*3)+1

				local t = treats[level]
				-- h.Damage = math.max(0, h.Damage - t.help_amount)

				local w = SpawnAt('MedWaste'..tostring(level), this, 0, 0.3)
				this.treat_cost = this.treat_cost + t.price
				if World.Balance then
					World.Balance = World.Balance - t.price
				end
				local warden = look_around({'Warden'}, nil, 'max', true)
				if warden then
					warden.med_expense = warden.med_expense + t.price
				end

				local curve = math.random() * 2 * math.pi
				local vx = math.cos(curve) * waste_drop_radius
				local vy = math.sin(curve) * waste_drop_radius

				w.ApplyVelocity(vx, vy)
				w.Or.x = vy
				w.Or.y = vx
			end
			updateTT()

		end
	end

end

function carryingO(e)
	return this.Carrying.u == e.Id.u
end



	current_room_id = getObjCell(this).Room.u

	-- local bs = this.GetNearbyObjects('MedicalBed', 6)


-- function JobComplete_HealPrisoner()
-- 	print('JobComplete_HealPrisoner')
-- end

	-- local g = look_around({'Prisoner'}, nil, 6, true)
	-- 	if
	-- 	g.FollowId.u = b.Id.u
	-- 	g.FollowId.i = b.Id.i
	-- 	g.Damage = 0.4
	-- 	b.Damage = 0.4
	-- 	break



		-- if p.Damage > 0 and then
		-- 	-- print('')
		-- 	-- print('p.Loaded')
		-- 	-- print(p.Id.u)
		-- 	-- print(p.Loaded)
		-- 	if (World.TimeIndex - p.LastTreated) > 0.1 then
		-- 		-- Before Healing
		-- 		if p.Damage < 0.72 then
		-- 			p.Damage = 0.72
		-- 		end
		-- 	else
		-- 		-- Healing
		-- 		print((World.TimeIndex - p.LastTreated))
		-- 		print(this.Carrying)
		-- 		print(this.Carrying.u)
		-- 		print()
		-- 		if p.Damage < 0.72 then
		-- 			-- p.Damage = p.Damage + 0.1*Delay1
		-- 		end
		-- 	end

		-- end
-- 					-- p.StatusEffects.tazed = 20
-- 					-- p.Damage = p.Damage + 0.02
-- 					-- print('p.LastTreated')
-- 					-- print(p.LastTreated)
-- or p.Loaded
-- 				for b, distance in pairs( bs ) do
-- 					-- print('b.Slot0.u')
-- 					-- print(b.Slot0.u)
-- 					if b.Slot0.u == -1 then
-- 						local d = dist(p, b)
-- 						if d < 1 then
-- 							b.Slot0.i = p.Id.i
-- 							b.Slot0.u = p.Id.u
-- 							print('CleanMedicalBed')
-- 							b.CreateJob('CleanMedicalBed')
-- 							break
-- 						end
-- 					end
-- 				end

-- 			end
