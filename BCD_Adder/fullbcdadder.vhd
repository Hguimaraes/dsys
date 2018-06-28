library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package bcd_array_pkg is
	type bcd_array is array(0 downto 0) of unsigned(3 downto 0);
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use bcd_array_pkg.ALL;

entity fullbcdadder is
    Port ( A, B : in bcd_array;
           SUM : out  bcd_array;
           carry: out STD_LOGIC);
end fullbcdadder;

architecture Behavioral of fullbcdadder is

-- 1-digit BCD Adder
component bcdadder
    Port ( A, B : in  unsigned(3 downto 0);
           c_in : in  STD_LOGIC;
           SUM : out  STD_LOGIC;
           c_out : out  STD_LOGIC);	
end component;

-- Auxiliar variables for operations
signal c_out: std_logic_vector(3 downto 0);

begin
	BCD00: bcdadder port map(A(0), B(0), '0', SUM(0), c_out(0));
	BCD01: bcdadder port map(A(1), B(1), c_out(0), SUM(1), c_out(1));
	BCD02: bcdadder port map(A(2), B(2), c_out(1), SUM(2), c_out(2));
	BCD03: bcdadder port map(A(3), B(3), c_out(2), SUM(3), c_out(3));
  carry <= c_out(3);
end Behavioral;

