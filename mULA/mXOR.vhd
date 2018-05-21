----------------------------------------------------------------------------------
-- Create Date:    20:35:00 05/20/2018 
-- Description: 
--      Module to make an XOR operation between A,B (4 bits)
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mXOR is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           X : out  STD_LOGIC);
end mXOR;

architecture Behavioral of mXOR is

begin
	-- 4-bit XOR operation
	X <= A XOR B;

end Behavioral;

