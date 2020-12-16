library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SimonDice is

	port( clk: in std_logic;
		inicio: in std_logic;
		load : in std_logic_vector (4 downto 0);
		sq_player: in std_logic_vector (4 downto 0);
		red: out std_logic_vector (3 downto 0);
		green: out std_logic_vector (3 downto 0);
		blue: out std_logic_vector (3 downto 0);
		h_sync: out std_logic;
		v_sync: out std_logic
		);
end entity SimonDice;

architecture behavioral of SimonDice is

	--Reloj
	signal div_clk: std_logic;
	
	--Cuadros y contador
	signal r1: std_logic_vector(3 downto 0);
	signal g1: std_logic_vector(3 downto 0);
	signal b1: std_logic_vector(3 downto 0);
	signal h_sync1: std_logic;
	signal v_sync1: std_logic;
	signal iluminar: std_logic_vector (4 downto 0);
	
	--Secuencia aleatoria y puntajes
	signal reset_sq: std_logic := '0';
	signal sq_random: std_logic_vector (4 downto 0);
	signal puntaje: integer range 0 to 10 := 0;
	signal suma: integer range 0 to 10 := 0;
	signal valor1 : std_logic_vector (4 downto 0) :="10000" ;
	signal valor2 : std_logic_vector (4 downto 0):="01000";
	signal valor3 : std_logic_vector (4 downto 0):="00100";
	signal valor4 : std_logic_vector (4 downto 0):="00010";
	signal valor5 : std_logic_vector (4 downto 0):="00001";
	--Maquina de estados
	
	type estado is(sm0,sm1, sm2, sm3, sm4, sm5, sm6, sm7, sm8,
	sm9, sm10, sm11);
	signal pres_S : estado := sm0;
	signal next_s : estado;
	signal aux : std_logic := '0';
	component cuadro_generic is
			port( clk: in std_logic;
			iluminar: in std_logic_vector (4 downto 0);
			puntaje: in integer;
			red: out std_logic_vector (3 downto 0);
			green: out std_logic_vector (3 downto 0);
			blue: out std_logic_vector (3 downto 0);
			h_sync: out std_logic;
			v_sync: out std_logic
			 );
	end component cuadro_generic;
	component secuencia_aleatoria is
		port (
		clk : in std_logic;
		reset : in std_logic;
		random : out std_logic_vector(4 downto 0)
		);
	end component secuencia_aleatoria;
		component DivisorFrecuencia is
		Port (clk : in std_logic;
		div_clk : out std_logic
		);
	end component DivisorFrecuencia;
	
	begin
	--MAPEO DE PUERTOS PARA LOS TRES COMPONENTES
	U1: cuadro_generic port map(clk, iluminar, puntaje, r1, g1, b1, h_sync1, v_sync1);
	U2: secuencia_aleatoria port map(clk, reset_sq, sq_random);
	U3: DivisorFrecuencia port map (clk, div_clk);
	
	--SALIDAS INDEPENDIENTES DE LA MAQUINA (INTERFAZ DEL JUEGO)
	red <= r1;
	green <= g1;
	blue <= b1;
	h_sync <= h_sync1;
	v_sync <= v_sync1;
	
	--MOVIMIENTO DE LOS ESTADOS
	process(div_clk)
		begin
			if div_clk'event and div_clk='1' then
				pres_S <= next_s;
			end if;
	end process;
	
	entradas: process (pres_s, sq_player, div_clk, inicio)
	begin
	case (pres_s) is
	--ESTADO DE REPOSO
		when sm0 =>
			if inicio = '1' then
				next_s <= sm1;
			elsif inicio = '0' then
				next_s <= sm0;
			end if;
			
	--SECUENCIA ALEATORIA
		when sm1 =>
			next_s <= sm2;
		when sm2 =>
			next_s <= sm3;
		when sm3 =>
			next_s <= sm4;
		when sm4 =>
			next_s <= sm5;
		when sm5 =>
			next_s <= sm6;
			
--SECUENCIA DEL JUGADOR
		when sm6 =>
			if load(0) = '0' then
				next_s <= sm6;
			elsif load(0) = '1' then
				if (sq_player /= valor1) and (sq_player /= "00000") then
					next_s <= sm0;
				elsif sq_player = valor1 then
					next_s <= sm7;
				end if;
			end if;
		when sm7 =>
			if load(1) = '0' then
				next_s <= sm7;
			elsif load(1) = '1' then
				if (sq_player /= valor2) and (sq_player /= "00000") then
					next_s <= sm0;
				elsif sq_player = valor2 then
					next_s <= sm8;
				end if;
			end if;
		when sm8 =>
			if load(2) = '0' then	
				next_s <= sm8;
			elsif load(2) = '1' then
				if sq_player /= valor3 then
					next_s <= sm0;
				elsif sq_player = valor3 then
					next_s <= sm9;
				end if;
			end if;
		when sm9 =>
			if load(3) = '0' then
				next_s <= sm9;
			elsif load(3) = '1' then	
				if sq_player /= valor4 then
					next_s <= sm0;
				elsif sq_player = valor4 then
					next_s <= sm10;
				end if;
			end if;
		when sm10 =>
			if load(4) = '0' then
				next_s <= sm10;
			elsif load(4) = '1' then
				if sq_player /= valor5 then
					next_s <= sm0;
				elsif sq_player = valor5 then
					next_s <= sm11;
				end if;
			end if;
		--SECUENCIA CORRECTA
		when sm11 =>
			if aux = '0' then
				next_s <= sm11;
			elsif aux = '1' then
				next_s <= sm1;
			end if;
		--CASO OBLIGATORIO
		when others => next_s <= sm0;
	end case;
end process;

salidas: process(pres_s)
	begin
		case pres_s is
			when sm0 =>
				suma <= 0;
				iluminar <= "00000";
			when sm1 =>
				iluminar <= valor1;
			when sm2 =>
				iluminar <= valor2;
			when sm3 =>
				iluminar <= valor3;
			when sm4 =>
				iluminar <= valor4;
			when sm5 =>
				iluminar <= valor5;
			when sm6 =>
				iluminar <= sq_player;
			when sm7 =>
				iluminar <= sq_player;
			when sm8 =>
				iluminar <= sq_player;
			when sm9 =>
				iluminar <= sq_player;
			when sm10 =>
				iluminar <= sq_player;
				aux <= '0';
			when sm11 =>
				if aux = '1' then
					aux <= '1';
				elsif aux = '0' then
					suma <= suma +1;
					aux <= '1';
				end if;
	--CASO OBLIGATORIO
			when others => puntaje <= 0;
		end case;
end process;

puntaje <= suma;

end behavioral;
