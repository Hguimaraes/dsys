library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mStateMachine is
	PORT(
		BTN_RESET: STD_LOGIC;
		CLOCK : in  STD_LOGIC;
		LED_OUT: out STD_LOGIC_VECTOR(7 downto 0)
	);
end mStateMachine;

architecture Behavioral of mStateMachine is

component mReader is
	PORT (
 			CLOCK : in  STD_LOGIC;
			  
			-- Output variables to share between the State machines
           	result: out bcd_array;
  
			-- Control state
			rState: out STD_LOGIC;
			wState: in STD_LOGIC);
end component;

component mWriter is
	PORT (
 			CLOCK : in  STD_LOGIC;
			BTN_RESET: in STD_LOGIC;

			-- Output variables to share between the State machines
           	result: in bcd_array;
  
			-- Control state
			rState: in STD_LOGIC;
			wState: out STD_LOGIC);
end component;

-- Aux variables to control states or perform operations
SIGNAL resOP: bcd_array;

SIGNAL rState: STD_LOGIC;			-- 1 if finished the reading
SIGNAL wState: STD_LOGIC;			-- 0 off | 1 on

begin
	MR00: mReader port map(CLOCK, resOP, rState, wState);
	MW00: mWriter port map(CLOCK, BTN_RESET, resOP, rState, wState);
end Behavioral;