----------------------------------------------------------------------------------
-- Create Date:    20:08:15 05/31/2018 
-- Module Name:    bcdadder - bcdadder_behav 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bcdadder is
    Port ( A,B : in  unsigned(3 downto 0);
           c_in : in  STD_LOGIC;
           SUM : out  STD_LOGIC;
           c_out : out  STD_LOGIC);
end bcdadder;

architecture bcdadder_behav of bcdadder is

-- 4-bit adder
component binadder
	Port( A, B : in  unsigned(3 downto 0);
           c_in : out  STD_LOGIC;
           SUM : out unsigned(3 downto 0);
           c_out : out  STD_LOGIC);
end component;

-- Auxiliar variables for the calcs
signal temp: unsigned(3 downto 0);
signal mux_set: unsigned(3 downto 0);
signal cout_adderone: std_logic;
signal cout_addertwo: std_logic;

begin
	-- Binary sum adder
	ADD01: binadder port map(A, B, c_in, temp, cout_adderone);
	
	-- Mux-like behavior
	PROCESS(ALL)
	BEGIN
		IF (cout_adderone = '1') OR (temp > "1010") THEN
			c_out <= '1';
			mux_set <= "0110";
		END IF;
	END PROCESS;
	
	-- BCD sum result
	ADD02: binadder port map(temp, mux_set, '0', SUM, cout_addertwo);
end bcdadder_behav;