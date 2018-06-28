library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package bcd_array_pkg is
	type bcd_array is array(0 downto 0) of unsigned(4 downto 0);
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use bcd_array_pkg.ALL;

entity mWriter is
	PORT (
 			CLOCK : in  STD_LOGIC;
			BTN_RESET: in STD_LOGIC;

			-- Output variables to share between the State machines
           	result: in bcd_array;
  
			-- Control state
			rState: in STD_LOGIC;
			wState: out STD_LOGIC);
end mWriter;

architecture writer_behav of mWriter is

-- States of the Writer machine
type STATE_TYPE is ( 
	sN0,   	-- Display on the LEDs one digit of Result
	sN1,   	-- Display on the LEDs one digit of Result
	sN2,   	-- Display on the LEDs one digit of Result
	sN3,   	-- Display on the LEDs one digit of Result
	sN4,   	-- Display on the LEDs one digit of Result
	sNULL	-- NULL State
);
SIGNAL state: STATE_TYPE;

-- Variaveis do Divisor de Freq
SIGNAL counter: integer := 0;
SIGNAL PTS: integer := 100000000;

BEGIN
	PROCESS (BTN_RESET, CLOCK)
	BEGIN
		IF (BTN_RESET = '1') THEN 
			state <= sNULL;
			wState <= '0';
		ELSE
			IF (CLOCK'EVENT AND CLOCK='1' AND rState = '1') THEN
				CASE state IS
					-- Print the first digit of result (the carry out)
					WHEN sN0 =>
						IF (counter = PTS) THEN
							-- First digit
							LED_OUT <= "0000" & result(0);
							state <= sN1;
							counter <= 0;
						ELSE
							counter <= counter + 1;
						END IF;
						
					-- Rest of the result
					WHEN sN1 =>
						IF (counter = PTS) THEN
							-- First digit
							LED_OUT <= "0000" & result(1);
							state <= sN2;
							counter <= 0;
						ELSE
							counter <= counter + 1;
						END IF;

					WHEN sN2 =>
						IF (counter = PTS) THEN
							-- First digit
							LED_OUT <= "0000" & result(2);
							state <= sN3;
							counter <= 0;
						ELSE
							counter <= counter + 1;
						END IF;

					WHEN sN3 =>
						IF (counter = PTS) THEN
							-- First digit
							LED_OUT <= "0000" & result(3);
							state <= sN4;
							counter <= 0;
						ELSE
							counter <= counter + 1;
						END IF;

					WHEN sN4 =>
						IF (counter = PTS) THEN
							-- First digit
							LED_OUT <= "0000" & result(4);
							state <= sN0;  -- Restart the cycle
							counter <= 0;
						ELSE
							counter <= counter + 1;
						END IF;
						
					-- NULL State (Do nothing - stop writing)
					WHEN sNULL =>
						state <= state;
				END CASE;
			END IF;
		END IF;
	END PROCESS;
END writer_behav;