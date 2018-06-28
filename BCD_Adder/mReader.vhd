library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package bcd_array_pkg is
	type bcd_array is array(0 downto 0) of unsigned(4 downto 0);
	type bcd_array_temp is array(0 downto 0) of unsigned(3 downto 0);
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use bcd_array_pkg.ALL;

entity mReader is
	PORT (
 			CLOCK : in  STD_LOGIC;
			  
			-- Output variables to share between the State machines
           	result: out bcd_array;
  
			-- Control state
			rState: out STD_LOGIC;
			wState: in STD_LOGIC);
end mReader;

architecture Behavioral of mReader is

component fullbcdadder is
    Port ( A, B : in bcd_array_temp;
           SUM : out  bcd_array_temp;
           carry: out STD_LOGIC);
end component;

type STATE_TYPE is ( 
	sA,   	-- number A
	sB,   	-- number B
	sOP,   	-- Operation
	sNULL		-- NULL State
);
SIGNAL state: STATE_TYPE;

-- Helpers
SIGNAL CARRY_OUT: STD_LOGIC;
SIGNAL inter_result: bcd_array;
SIGNAL numA : bcd_array_temp;
SIGNAL numB : bcd_array_temp;
           	
begin
	FBCD00: fullbcdadder port map(numA, numB, inter_result, CARRY_OUT);

	PROCESS(CLOCK)
	BEGIN
		IF (CLOCK'EVENT AND CLOCK = '1' AND wState = '0') THEN
				-- Reader State Machine implementation
				CASE state IS
					-- READ Number A
					WHEN sA =>
						numA(0) <= "1000";
						numA(1) <= "0100"
						numA(2) <= "0010"
						numA(3) <= "0001"
						state <= sB; -- In normal code should be check for a enter code here

					-- READ Number B
					WHEN sB =>
						numB(0) <= "0001";
						numB(1) <= "0010"
						numB(2) <= "0100"
						numB(3) <= "1000"
						state <= sOP; -- In normal code should be check for a enter code here

					-- Make the operation
					WHEN sOP =>
						result(0) <= CARRY_OUT;
						result(1) <= inter_result(0);
						result(2) <= inter_result(1);
						result(3) <= inter_result(2);
						result(4) <= inter_result(3);
						state <= sNULL;
						
					-- Null state and finish this state machine
					WHEN sNULL =>
						state <= state;
						rState <= '1'; 
				END CASE;
			END IF;
	END PROCESS;
end Behavioral;