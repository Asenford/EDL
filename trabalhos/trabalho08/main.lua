
-- Implementação de Closure e a co-rotina que movimenta o simbolo do loading de forma retangular. [trabalho - 08]
function loading (x,y,vx)
local ob; ob = {
	moveP = function (dx,dy)
		 x = x + dx
		 y = y + dy 
		 return x, y
	end,
	moveN = function (dx,dy)
		 x = x - dx
		 y = y - dy
		 return x, y
	end,
	get = function ()
		 return x, y
	end,
	co = coroutine.create(function (dt)
		while true do
			local wait = 1/4
			--direita
			ob.moveP( vx*dt +50, 0)
			dt = coroutine.yield()

			--wait
			love.timer.sleep(wait)
			dt = coroutine.yield()
			
			ob.moveP( vx*dt +50, 0)
			dt = coroutine.yield()
			
			--wait
			love.timer.sleep(wait)
			dt = coroutine.yield()
			
			ob.moveP( vx*dt+50, 0)
			dt = coroutine.yield()
			
			--wait
			love.timer.sleep(wait)
			dt = coroutine.yield()
				
			--Baixo
			ob.moveP( 0, vx*dt+50)
			dt = coroutine.yield()
			--wait
			love.timer.sleep(wait)
			dt = coroutine.yield()
			ob.moveP( 0, vx*dt+50)
			dt = coroutine.yield()
							
			--wait
			love.timer.sleep(wait)
			dt = coroutine.yield()
			
			--Esquerda
			ob.moveN( vx*dt+50, 0)
			dt = coroutine.yield()
			--wait
			love.timer.sleep(wait)
			dt = coroutine.yield()
			ob.moveN( vx*dt+50, 0)
			dt = coroutine.yield()
			--wait
			love.timer.sleep(wait)
			dt = coroutine.yield()
			ob.moveN( vx*dt+50, 0)
			dt = coroutine.yield()
			--wait
			love.timer.sleep(wait)
			dt = coroutine.yield()

			--Cima
			ob.moveN( 0, vx*dt+50)
			dt = coroutine.yield()
			--wait
			love.timer.sleep(wait)
			dt = coroutine.yield()
			ob.moveN( 0, vx*dt+50)
			dt = coroutine.yield()
			--wait
			love.timer.sleep(wait)
			dt = coroutine.yield()						
		end
	end),
}
return ob
end
function love.load()
	loadingScreen = true;
	larguraTela = 1280
	alturaTela = 720
	
	player = {x = 62, l = 70, a = 60, y = 200, gravity = 0}
		
	quantidadePulos={'*','*','*','*','*','*'}
	
	placar = {}
	
	posicaoPlacar = {15,15}
	
	fraseTutorial='visivel'

	canoAltura = 200
	canoLargura = 108
	
	function defineCanoY()
		local canoYMinimo = 108
		local canoY = love.math.random(
			canoYMinimo,
			alturaTela - canoAltura - canoYMinimo
		)
		return canoY
	end

	function reset()
		player.y = 200
		player.gravity = 0

		cano1X = larguraTela
		cano1tamanhoY = defineCanoY()

		cano2X = larguraTela + ((larguraTela + canoLargura) / 2)
		cano2TamanhoY = defineCanoY()

		placar[1] = 0

		proximoCano = 1
		quantidadePulos={'*','*','*','*','*','*'}
	end

	reset()
end

-- Inicialização do loading e do contador [trabalho - 08]
local lo = loading(500,  290,  30)
local cont = 0

function love.update(dt)
	--Teste para saber se ja foi feito o loading [trabalho - 08]
	if loadingScreen == true then
		--teste para saber se ja foram feitas as quantidades de voltas nescessárias para o loading [trabalho - 08]
		if cont < 40 then
			coroutine.resume(lo.co, dt)
			cont = cont +1
		else
			loadingScreen = false
		end
	else
		player.gravity = player.gravity + (916 * dt)
		player.y = player.y + (player.gravity * dt)

		local function canoMov(canoX, canoTamanhoY)
			canoX = canoX - (240 * dt)

			if (canoX + canoLargura) < 0 then
				canoX = larguraTela
				canoTamanhoY = defineCanoY()
			end

			return canoX, canoTamanhoY
		end

		cano1X, cano1tamanhoY = canoMov(cano1X, cano1tamanhoY)
		cano2X, cano2TamanhoY = canoMov(cano2X, cano2TamanhoY)

		function testeColisao(canoX, canoTamanhoY)
			return
			player.x < (canoX + canoLargura)
			and
			(player.x + player.l) > canoX
			and (
				player.y < canoTamanhoY
				or
				(player.y + player.a) > (canoTamanhoY + canoAltura)
			)
		end

		if testeColisao(cano1X, cano1tamanhoY)
		or testeColisao(cano2X, cano2TamanhoY)
		or player.y > alturaTela then
			reset()
		end

		local function updatePlacarCano(canoAtual, canoX, proximo)
			if proximoCano == canoAtual
			and (player.x > (canoX + canoLargura)) then
				placar[1] = placar[1] + 1
				quantidadePulos={'*','*','*','*'}


				proximoCano = proximo
			end
		end

		updatePlacarCano(1, cano1X, 2)
		updatePlacarCano(2, cano2X, 1)
	end
end

function love.draw()
	-- Teste para saber se vai ser desenhado a tela de loading ou a tela de jogo [trabalho - 08]
	if loadingScreen == true then
		local x,y = lo.get()
		love.graphics.print('Loading', 500, 200,0, 5, 5)
		love.graphics.rectangle('fill', x,y, 50,50)
	else
		love.graphics.setColor(137, 255, 235)
		love.graphics.rectangle('fill', 0, 0, larguraTela, alturaTela)

		love.graphics.setColor(224, 214, 68)
		love.graphics.rectangle('fill', player.x, player.y, player.l, player.a)

		local function criaCano(canoX, canoTamanhoY)
			love.graphics.setColor(94, 201, 72)
			love.graphics.rectangle(
				'fill',
				canoX,
				0,
				canoLargura,
				canoTamanhoY
			)
			love.graphics.rectangle(
				'fill',
				canoX,
				canoTamanhoY + canoAltura,
				canoLargura,
				alturaTela - canoTamanhoY - canoAltura
			)
		end

		criaCano(cano1X, cano1tamanhoY)
		criaCano(cano2X, cano2TamanhoY)

		love.graphics.setColor(0, 0, 0)
		love.graphics.print(placar, posicaoPlacar[1], posicaoPlacar[2], 0 , 5,5)
		love.graphics.print(quantidadePulos, 15, 550, 0 , 5,5)
		if fraseTutorial == 'visivel' then
			love.graphics.print('Aperte qualquer tecla para voar', 0, 300,0, 5, 5)
		end
	end	
end

function love.keypressed(key)
	-- teste para que somente após a tela  loading o jogador possa executar ações [trabalho - 08]
	if loadingScreen==false then
		fraseTutorial = 'invisivel'
		if table.getn(quantidadePulos) > 0 then
			if player.y > 0 then
				player.gravity = -420
				table.remove(quantidadePulos)
			end
		end
	end
end
