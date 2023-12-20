library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main is
	 Generic ( width1 : integer := 6;
				  width2 : integer := 6);
    Port ( inp1 : in  STD_LOGIC_VECTOR (width1-1 downto 0);
           inp2 : in  STD_LOGIC_VECTOR (width2-1 downto 0);
			  clk : in STD_LOGIC;
			  rst : in STD_LOGIC;
			  done : out STD_LOGIC;
           p : out  STD_LOGIC_VECTOR (width1+width2-1 downto 0));
end main;

architecture Behavioral of main is
	signal n : integer := width1-1;
	signal m : STD_LOGIC_VECTOR (width1-1 downto 0);
	signal q : STD_LOGIC_VECTOR (width2-1 downto 0);
	signal a : STD_LOGIC_VECTOR (width1-1 downto 0) := (others=>'0');
	signal q0 : STD_LOGIC := '0';
	signal decision : STD_LOGIC_VECTOR(1 downto 0) := (others=>'0');
	type state_type is (idle, calc1, calc2, finish);
	signal state : state_type := idle;
begin

	process (clk, rst, inp1, inp2)
	begin
		if (rst= '1') then
			n <= width1-1;
			m <= inp1;
			q <= inp2;
			a <= (others => '0');
			q0 <= '0';
			done <= '0';
			state <= idle;
		elsif (clk'event and clk='1') then
			case state is
				when idle =>
					n <= width1-1;
					m <= inp1;
					q <= inp2;
					a <= (others=>'0');
					q0 <= '0';
					done <= '0';
					state <= calc1;
				when calc1 =>
					n <= n;
					m <= inp1;
					q <= q;
					if decision="10" then
						a <= std_logic_vector(signed(a)-signed(m));
					elsif decision="01" then
						a <= std_logic_vector(signed(a)+signed(m));
					else
						a <= a;
					end if;
					q0 <= q0;
					done <= '0';
					state <= calc2;
				when calc2 =>
					m <= inp1;
					q(width2-1) <= a(0);
					q(width2-2 downto 0) <= q(width2-1 downto 1);
					a(width1-1) <= a(width1-1);
					a(width1-2 downto 0) <= a(width1-1 downto 1);
					q0 <= q(0);
					done <= '0';
					state <= calc1;
					n <= n-1;
					if n = 0 then
						n <= width1-1;
						done <= '1';
						state <= finish;
					end if;
				when finish =>
					n <= width1-1;
					m <= inp1;
					q <= inp2;
					a <= (others=>'0');
					q0 <= '0';
					done <= '0';
					state <= idle;
			end case;
		end if;
	end process;
p <= a&q when state=finish else (others=>'0');
decision <= q(0)&q0;
end Behavioral;