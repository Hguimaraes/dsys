----------------------------------------------------------------------------------
-- Create Date:    21:20:00 05/20/2018 
-- Description: 
--      Module to make an 1bit adder
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Components of 1 Bit adder
entity adder1bit is
	port(a,b,c: in std_logic;
		sum, carry: out std_logic);
end adder1bit;

architecture adder1bit_behav of adder1bit is
begin
	sum <= (a XOR b) XOR c;
	carry <= (a AND b) OR (c AND (a XOR b));
end adder1bit_behav;

