library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cuadro_generic is
	port( clk: in std_logic;
		iluminar: in std_logic_vector (4 downto 0);
		puntaje: in integer;
		aux: in integer;
		red: out std_logic_vector (3 downto 0);
		green: out std_logic_vector (3 downto 0);
		blue: out std_logic_vector (3 downto 0);
		h_sync: out std_logic;
		v_sync: out std_logic
		 );
end entity cuadro_generic;

architecture behavioral of cuadro_generic is

	constant cero: std_logic_vector(3 downto 0):="0000";
	constant uno: std_logic_vector(3 downto 0):="0001";
	constant dos: std_logic_vector(3 downto 0):="0010";
	constant tres: std_logic_vector(3 downto 0):="0011";
	constant cuatro: std_logic_vector(3 downto 0):="0100";
	constant cinco: std_logic_vector(3 downto 0):="0101";
	constant seis: std_logic_vector(3 downto 0):="0110";
	constant siete: std_logic_vector(3 downto 0):="0111";
	constant ocho: std_logic_vector(3 downto 0):="1000";
	constant nueve: std_logic_vector(3 downto 0):="1001";
	
	signal reloj_pixel : std_logic;
	signal column : integer := 0;
	signal row : integer := 0;
	signal display_ena : std_logic := '0';
	signal cuadro_uno,cuadro_dos,cuadro_tres,cuadro_cuatro,cuadro_cinco: std_logic; --PARA LOS BLOQUES
	signal a1,b1,c1,d1,e1,f1,g1: std_logic; --PARA LOS SEGMENTOS
	signal a2,b2,c2,d2,e2,f2,g2: std_logic;
	signal numero: std_logic_vector (7 downto 0);

component vga_generic is 
	GENERIC(   
		CONSTANT h_pulse : INTEGER := 96; 
		CONSTANT h_bp : INTEGER := 48; 
		CONSTANT h_pixels : INTEGER := 640; 
		CONSTANT h_fp : INTEGER := 16;
		CONSTANT v_pulse : INTEGER := 2; 
		CONSTANT v_bp : INTEGER := 33; 
		CONSTANT v_pixels : INTEGER := 480; 
		CONSTANT v_fp : INTEGER := 10   );  
		
	port(  reloj_pixel : in std_logic; --clk 25 Mhz 
	renglon : out integer; 
	columna : out  integer; 
	h_sync: out std_logic; 
	v_sync: out std_logic; 	
	display_ena : out std_logic :='0' );
end component; 

begin 
U2: vga_generic port map(reloj_pixel, row, column, h_sync, v_sync, display_ena); 
 
with (puntaje) select 
numero <= "00000000" when 0,
			 "00000001" when 1,
			 "00000010" when 2,
			 "00000011" when 3,
			 "00000100" when 4,
			 "00000101" when 5,
			 "00000110" when 6,
			 "00000111" when 7,
			 "00001000" when 8,
			 "00001001" when 9,
			 "00010000" when 10,
			 "00000000" when others; 
			 
relojpixel: process (clk) is

	begin
		if rising_edge(clk) then
		reloj_pixel <= not reloj_pixel;
		end if;
end process relojpixel;

INTERFAZ_POSICION: process (row, column)
	begin
--POSICIONES DE SEGMENTOS PARA EL DISPLAY DE UNIDADES
	if ((row > 100 and row < 110) and --segmento A1
		(column > 370 and column < 410)) then
			a1 <= '1';
			b1 <= '0';
			c1 <= '0';
			d1 <= '0';
			e1 <= '0';
			f1 <= '0';
			g1 <= '0';
			a2 <= '0';
			b2 <= '0';
			c2 <= '0';
			d2 <= '0';
			e2 <= '0';
			f2 <= '0';
			g2 <= '0';
			cuadro_uno <= '0';
			cuadro_dos <= '0';
			cuadro_tres <= '0';
			cuadro_cuatro <= '0';
			cuadro_cinco <= '0';
	elsif ((row > 110 and row < 140) and --segmento B1
		(column > 410 and column < 420)) then
				a1 <= '0';
				b1 <= '1';
				c1 <= '0';
				d1 <= '0';
				e1 <= '0';
				f1 <= '0';
				g1 <= '0';
				a2 <= '0';
				b2 <= '0';
				c2 <= '0';
				d2 <= '0';
				e2 <= '0';
				f2 <= '0';
				g2 <= '0';
				cuadro_uno <= '0';
				cuadro_dos <= '0';
				cuadro_tres <= '0';
				cuadro_cuatro <= '0';
				cuadro_cinco <= '0';
	elsif ((row > 150 and row < 180) and --segmento C1
		(column > 410 and column < 420)) then
			a1 <= '0';
			b1 <= '0';
			c1 <= '1';
			d1 <= '0';
			e1 <= '0';
			f1 <= '0';
			g1 <= '0';
			a2 <= '0';
			b2 <= '0';
			c2 <= '0';
			d2 <= '0';
			e2 <= '0';
			f2 <= '0';
			g2 <= '0';
			cuadro_uno <= '0';
			cuadro_dos <= '0';
			cuadro_tres <= '0';
			cuadro_cuatro <= '0';
			cuadro_cinco <= '0';
	elsif ((row > 180 and row < 190) and --segmento D1
		(column > 370 and column < 410)) then
			a1 <= '0';
			b1 <= '0';
			c1 <= '0';
			d1 <= '1';
			e1 <= '0';
			f1 <= '0';
			g1 <= '0';
			a2 <= '0';
			b2 <= '0';
			c2 <= '0';
			d2 <= '0';
			e2 <= '0';
			f2 <= '0';
			g2 <= '0';
			cuadro_uno <= '0';
			cuadro_dos <= '0';
			cuadro_tres <= '0';
			cuadro_cuatro <= '0';
			cuadro_cinco <= '0';
	elsif ((row > 150 and row < 180) and --segmento E1
		(column > 360 and column < 370)) then
			a1 <= '0';
			b1 <= '0';
			c1 <= '0';
			d1 <= '0';
			e1 <= '1';
			f1 <= '0';
			g1 <= '0';
			a2 <= '0';
			b2 <= '0';
			c2 <= '0';
			d2 <= '0';
			e2 <= '0';
			f2 <= '0';
			g2 <= '0';
			cuadro_uno <= '0';
			cuadro_dos <= '0';
			cuadro_tres <= '0';
			cuadro_cuatro <= '0';
			cuadro_cinco <= '0';
	elsif ((row > 110 and row < 140) and --segmento F1
		(column > 360 and column < 370)) then
			a1 <= '0';
			b1 <= '0';
			c1 <= '0';
			d1 <= '0';
			e1 <= '0';
			f1 <= '1';
			g1 <= '0';
			a2 <= '0';
			b2 <= '0';
			c2 <= '0';
			d2 <= '0';
			e2 <= '0';
			f2 <= '0';
			g2 <= '0';
			cuadro_uno <= '0';
			cuadro_dos <= '0';
			cuadro_tres <= '0';
			cuadro_cuatro <= '0';
			cuadro_cinco <= '0';
	elsif ((row > 140 and row < 150) and --segmento G1
		(column > 370 and column < 410)) then
			a1 <= '0';
			b1 <= '0';
			c1 <= '0';
			d1 <= '0';
			e1 <= '0';
			f1 <= '0';
			g1 <= '1';
			a2 <= '0';
			b2 <= '0';
			c2 <= '0';
			d2 <= '0';
			e2 <= '0';
			f2 <= '0';
			g2 <= '0';
			cuadro_uno <= '0';
			cuadro_dos <= '0';
			cuadro_tres <= '0';
			cuadro_cuatro <= '0';
			cuadro_cinco <= '0';
			
--POSICIONES DE SEGMENTOS PARA EL DISPLAY DE DECENAS
	elsif ((row > 100 and row <110) and --segmento A2
		(column > 310 and column < 350)) then
			a1 <= '0';
			b1 <= '0';
			c1 <= '0';
			d1 <= '0';
			e1 <= '0';
			f1 <= '0';
			g1 <= '0';
			a2 <= '1';
			b2 <= '0';
			c2 <= '0';
			d2 <= '0';
			e2 <= '0';
			f2 <= '0';
			g2 <= '0';
			cuadro_uno <= '0';
			cuadro_dos <= '0';
			cuadro_tres <= '0';
			cuadro_cuatro <= '0';
			cuadro_cinco <= '0';
	elsif ((row > 110 and row < 140) and --segmento B2
		(column > 350 and column < 360)) then
			a1 <= '0';
			b1 <= '0';
			c1 <= '0';
			d1 <= '0';
			e1 <= '0';
			f1 <= '0';
			g1 <= '0';
			a2 <= '0';
			b2 <= '1';
			c2 <= '0';
			d2 <= '0';
			e2 <= '0';
			f2 <= '0';
			g2 <= '0';
			cuadro_uno <= '0';
			cuadro_dos <= '0';
			cuadro_tres <= '0';
			cuadro_cuatro <= '0';
			cuadro_cinco <= '0';
	elsif ((row > 150 and row < 180) and --segmento C2
		(column > 350 and column < 360)) then
			a1 <= '0';
			b1 <= '0';
			c1 <= '0';
			d1 <= '0';
			e1 <= '0';
			f1 <= '0';
			g1 <= '0';
			a2 <= '0';
			b2 <= '0';
			c2 <= '1';
			d2 <= '0';
			e2 <= '0';
			f2 <= '0';
			g2 <= '0';
			cuadro_uno <= '0';
			cuadro_dos <= '0';
			cuadro_tres <= '0';
			cuadro_cuatro <= '0';
			cuadro_cinco <= '0';
	elsif ((row > 180 and row < 190) and --segmento D2
		(column > 310 and column < 350)) then
			a1 <= '0';
			b1 <= '0';
			c1 <= '0';
			d1 <= '0';
			e1 <= '0';
			f1 <= '0';
			g1 <= '0';
			a2 <= '0';
			b2 <= '0';
			c2 <= '0';
			d2 <= '1';
			e2 <= '0';
			f2 <= '0';
			g2 <= '0';
			cuadro_uno <= '0';
			cuadro_dos <= '0';
			cuadro_tres <= '0';
			cuadro_cuatro <= '0';
			cuadro_cinco <= '0';
	elsif ((row > 150 and row < 180) and --segmento E2
		(column > 300 and column < 310)) then
			a1 <= '0';
			b1 <= '0';
			c1 <= '0';
			d1 <= '0';
			e1 <= '0';
			f1 <= '0';
			g1 <= '0';
			a2 <= '0';
			b2 <= '0';
			c2 <= '0';
			d2 <= '0';
			e2 <= '1';
			f2 <= '0';
			g2 <= '0';
			cuadro_uno <= '0';
			cuadro_dos <= '0';
			cuadro_tres <= '0';
			cuadro_cuatro <= '0';
			cuadro_cinco <= '0';
	elsif ((row > 110 and row < 140) and --segmento F2
		(column > 300 and column < 310)) then
			a1 <= '0';
			b1 <= '0';
			c1 <= '0';
			d1 <= '0';
			e1 <= '0';
			f1 <= '0';
			g1 <= '0';
			a2 <= '0';
			b2 <= '0';
			c2 <= '0';
			d2 <= '0';
			e2 <= '0';
			f2 <= '1';
			g2 <= '0';
			cuadro_uno <= '0';
			cuadro_dos <= '0';
			cuadro_tres <= '0';
			cuadro_cuatro <= '0';
			cuadro_cinco <= '0';
	elsif ((row > 140 and row < 150) and --segmento G2
		(column > 310 and column < 350)) then
			a1 <= '0';
			b1 <= '0';
			c1 <= '0';
			d1 <= '0';
			e1 <= '0';
			f1 <= '0';
			g1 <= '0';
			a2 <= '0';
			b2 <= '0';
			c2 <= '0';
			d2 <= '0';
			e2 <= '0';
			f2 <= '0';
			g2 <= '1';
			cuadro_uno <= '0';
			cuadro_dos <= '0';
			cuadro_tres <= '0';
			cuadro_cuatro <= '0';
			cuadro_cinco <= '0';
			
--POSICIONES DE CUADROS
	elsif ((row > 300 and row <375) and
	(column >170 and column < 245)) then
			a1 <= '0';
			b1 <= '0';
			c1 <= '0';
			d1 <= '0';
			e1 <= '0';
			f1 <= '0';
			g1 <= '0';
			a2 <= '0';
			b2 <= '0';
			c2 <= '0';
			d2 <= '0';
			e2 <= '0';
			f2 <= '0';
			g2 <= '0';
			cuadro_uno <= '1';
			cuadro_dos <= '0';
			cuadro_tres <= '0';
			cuadro_cuatro <= '0';
			cuadro_cinco <= '0';
	elsif ((row > 300 and row <375) and
		(column > 265 and column < 340)) then
			a1 <= '0';
			b1 <= '0';
			c1 <= '0';
			d1 <= '0';
			e1 <= '0';
			f1 <= '0';
			g1 <= '0';
			a2 <= '0';
			b2 <= '0';
			c2 <= '0';
			d2 <= '0';
			e2 <= '0';
			f2 <= '0';
			g2 <= '0';
			cuadro_uno <= '0';
			cuadro_dos <= '1';
			cuadro_tres <= '0';
			cuadro_cuatro <= '0';
			cuadro_cinco <= '0';
	elsif ((row > 300 and row <375) and
		(column > 360 and column < 435)) then
			a1 <= '0';
			b1 <= '0';
			c1 <= '0';
			d1 <= '0';
			e1 <= '0';
			f1 <= '0';
			g1 <= '0';
			a2 <= '0';
			b2 <= '0';
			c2 <= '0';
			d2 <= '0';
			e2 <= '0';
			f2 <= '0';
			g2 <= '0';
			cuadro_uno <= '0';
			cuadro_dos <= '0';
			cuadro_tres <= '1';
			cuadro_cuatro <= '0';
			cuadro_cinco <= '0';
	elsif ((row > 300 and row <375) and
		(column > 455 and column < 530)) then
			a1 <= '0';
			b1 <= '0';
			c1 <= '0';
			d1 <= '0';
			e1 <= '0';
			f1 <= '0';
			g1 <= '0';
			a2 <= '0';
			b2 <= '0';
			c2 <= '0';
			d2 <= '0';
			e2 <= '0';
			f2 <= '0';
			g2 <= '0';
			cuadro_uno <= '0';
			cuadro_dos <= '0';
			cuadro_tres <= '0';
			cuadro_cuatro <= '1';
			cuadro_cinco <= '0';
	elsif ((row > 300 and row <375) and
		(column > 550 and column < 625)) then
			a1 <= '0';
			b1 <= '0';
			c1 <= '0';
			d1 <= '0';
			e1 <= '0';
			f1 <= '0';
			g1 <= '0';
			a2 <= '0';
			b2 <= '0';
			c2 <= '0';
			d2 <= '0';
			e2 <= '0';
			f2 <= '0';
			g2 <= '0';
			cuadro_uno <= '0';
			cuadro_dos <= '0';
			cuadro_tres <= '0';
			cuadro_cuatro <= '0';
			cuadro_cinco <= '1';
	else
			a1 <= '0';
			b1 <= '0';
			c1 <= '0';
			d1 <= '0';
			e1 <= '0';
			f1 <= '0';
			g1 <= '0';
			a2 <= '0';
			b2 <= '0';
			c2 <= '0';
			d2 <= '0';
			e2 <= '0';
			f2 <= '0';
			g2 <= '0';
			cuadro_uno <= '0';
			cuadro_dos <= '0';
			cuadro_tres <= '0';
			cuadro_cuatro <= '0';
			cuadro_cinco <= '0';
	end if;
end process;

INTERFAZ_IMAGEN: process(iluminar, puntaje,
cuadro_uno,cuadro_dos,cuadro_tres,cuadro_cuatro,cuadro_cinco,
a1,b1,c1,d1,e1,f1,g1,
a2,b2,c2,d2,e2,f2,g2)

	begin
		if (display_ena = '1') then
--DISPLAYS DE SIETE SEGMENTOS
			case numero(3 downto 0) is
				when cero =>
					if a1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif b1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif c1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif d1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif e1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif f1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					else
					red <= (OTHERS => '0');
					green <= (OTHERS => '0');
					blue <= (OTHERS => '0');
					end if;
				when uno=>
					if b1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif c1 ='1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					else
					red <= (OTHERS => '0');
					green <= (OTHERS => '0');
					blue <= (OTHERS => '0');
					end if;
					when dos =>
					if a1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif b1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif g1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif e1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif d1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					else
					red <= (OTHERS => '0');
					green <= (OTHERS => '0');
					blue <= (OTHERS => '0');
					end if;
				when tres =>
					if a1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif b1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif g1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif c1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif d1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					else
					red <= (OTHERS => '0');
					green <= (OTHERS => '0');
					blue <= (OTHERS => '0');
					end if;
				when cuatro =>
					if f1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif b1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif g1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif c1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					else
					red <= (OTHERS => '0');
					green <= (OTHERS => '0');
					blue <= (OTHERS => '0');
					end if;
				when cinco =>
					if a1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif f1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif g1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif c1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif d1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					else
					red <= (OTHERS => '0');
					green <= (OTHERS => '0');
					blue <= (OTHERS => '0');
					end if;
				when seis =>
					if f1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif g1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif c1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif e1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif d1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif a1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					else
					red <= (OTHERS => '0');
					green <= (OTHERS => '0');
					blue <= (OTHERS => '0');
					end if;
				when siete =>
					if a1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif b1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif c1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif g1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					else
					red <= (OTHERS => '0');
					green <= (OTHERS => '0');
					blue <= (OTHERS => '0');
					end if;
				when ocho =>
					if a1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif b1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif c1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif d1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif e1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif f1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif g1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					else
					red <= (OTHERS => '0');
					green <= (OTHERS => '0');
					blue <= (OTHERS => '0');
					end if;
				when nueve =>
					if a1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif b1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif c1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif f1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif g1 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					else
					red <= (OTHERS => '0');
					green <= (OTHERS => '0');
					blue <= (OTHERS => '0');
					end if;
				when others =>
					red<= (OTHERS => '0');
					green <= (OTHERS => '0');
					blue<= (OTHERS => '0');
			end case;
--DISPLAY PARA LAS DECENAS
			case numero(7 downto 4) is
				when cero =>
					if a2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif b2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif c2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif d2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif e2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif f2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					end if;
				when uno=>
					if b2 = '1' THEN
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif c2 ='1' THEN
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					end if;
					when dos =>
					if a2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif b2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif g2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif e2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif d2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					end if;
				when tres =>
					if a2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif b2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif g2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif c2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif d2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					end if;
				when cuatro =>
					if f2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif b2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif g2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif c2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					end if;
				when cinco =>
					if a2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif f2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif g2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif c2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif d2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					end if;
				when seis =>
					if f2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif g2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif c2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif e2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif d2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif a2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					end if;
				when siete =>
					if a2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif b2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif c2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif g2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					end if;
				when ocho =>
					if a2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif b2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif c2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif d2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif e2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif f2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif g2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					end if;
				when nueve =>
					if a2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif b2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif c2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif f2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					elsif g2 = '1' then
					red <= (OTHERS => '1');
					green <= (OTHERS => '1');
					blue <= (OTHERS => '1');
					end if;
				when others =>
					red<= (OTHERS => '0');
					green <= (OTHERS => '0');
					blue<= (OTHERS => '0');
			end case;
--CUADROS E ILUMINACION
			case iluminar is
				when "00001" => --ILUMINAR POSICION CINCO
					if cuadro_uno = '1' then
					red <= (OTHERS => '0');
					green <= (OTHERS => '0');
					blue <= "1000";
					elsif cuadro_dos = '1' then
					red <= "1000";
					green <= (OTHERS => '0');
					blue <= (OTHERS => '0');
					elsif cuadro_tres = '1' then
					red <= (OTHERS => '0');
					green <= "1000";
					blue <= (OTHERS => '0');
					elsif cuadro_cuatro = '1' then
					red <= "1100";
					green <= "1000";
					blue <= (OTHERS => '0');
					elsif cuadro_cinco = '1' then
					red <= (OTHERS => '0');
					green <= "1111";
					blue <= "1111";
					end if;
				when "00010" => --ILUMINAR POSICION CUATRO
					if cuadro_uno = '1' then
					red <= (OTHERS => '0');
					green <= (OTHERS => '0');
					blue <= "1000";
					elsif cuadro_dos = '1' then
					red <= "1000";
					green <= (OTHERS => '0');
					blue <= (OTHERS => '0');
					elsif cuadro_tres = '1' then
					red <= (OTHERS => '0');
					green <= "1000";
					blue <= (OTHERS => '0');
					elsif cuadro_cuatro = '1' then
					red <= "1111";
					green <= "1111";
					blue <= (OTHERS => '0');
					elsif cuadro_cinco = '1' then
					red <= (OTHERS => '0');
					green <= "1000";
					blue <= "1100";
					end if;
				when "00100" => --ILUMINAR POSICION TRES
					if cuadro_uno = '1' then
					red <= (OTHERS => '0');
					green <= (OTHERS => '0');
					blue <= "1000";
					elsif cuadro_dos = '1' then
					red <= "1000";
					green <= (OTHERS => '0');
					blue <= (OTHERS => '0');
					elsif cuadro_tres = '1' then
					red <= (OTHERS => '0');
					green <= "1111";
					blue <= (OTHERS => '0');
					elsif cuadro_cuatro = '1' then
					red <= "1100";
					green <= "1000";
					blue <= (OTHERS => '0');
					elsif cuadro_cinco = '1' then
					red <= (OTHERS => '0');
					green <= "1000";
					blue <= "1100";
					end if;
				when "01000" => --ILUMINAR POSICION DOS
					if cuadro_uno = '1' then
					red <= (OTHERS => '0');
					green <= (OTHERS => '0');
					blue <= "1000";
					elsif cuadro_dos = '1' then
					red <= "1111";
					green <= (OTHERS => '0');
					blue <= (OTHERS => '0');
					elsif cuadro_tres = '1' then
					red <= (OTHERS => '0');
					green <= "1000";
					blue <= (OTHERS => '0');
					elsif cuadro_cuatro = '1' then
					red <= "1100";
					green <= "1000";
					blue <= (OTHERS => '0');
					elsif cuadro_cinco = '1' then
					red <= (OTHERS => '0');
					green <= "1000";
					blue <= "1100";
					end if;
				when "10000" => --ILUMINAR POSICION UNO
					if cuadro_uno = '1' then
					red <= (OTHERS => '0');
					green <= (OTHERS => '0');
					blue <= "1111";
					elsif cuadro_dos = '1' then
					red <= "1000";
					green <= (OTHERS => '0');
					blue <= (OTHERS => '0');
					elsif cuadro_tres = '1' then
					red <= (OTHERS => '0');
					green <= "1000";
					blue <= (OTHERS => '0');
					elsif cuadro_cuatro = '1' then
					red <= "1100";
					green <= "1000";
					blue <= (OTHERS => '0');
					elsif cuadro_cinco = '1' then
					red <= (OTHERS => '0');
					green <= "1000";
					blue <= "1100";
					end if;
				when others => --NO ILUMINAR NADA
					if cuadro_uno = '1' then
					red <= (OTHERS => '0');
					green <= (OTHERS => '0');
					blue <= "1000";
					elsif cuadro_dos = '1' then
					red <= "1000";
					green <= (OTHERS => '0');
					blue <= (OTHERS => '0');
					elsif cuadro_tres = '1' then
					red <= (OTHERS => '0');
					green <= "1000";
					blue <= (OTHERS => '0');
					elsif cuadro_cuatro = '1' then
					red <= "1100";
					green <= "1000";
					blue <= (OTHERS => '0');
					elsif cuadro_cinco = '1' then
					red <= (OTHERS => '0');
					green <= "1000";
					blue <= "1100";
					end if;
				end case;
		end if;
	end process;
end behavioral;

 