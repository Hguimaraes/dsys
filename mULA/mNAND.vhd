----------------------------------------------------------------------------------
-- Create Date:    21:12:00 05/20/2018 
-- Description: 
--      Module to make an NAND operation between A,B (4 bits)
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mNAND is
    Port ( A : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           B : in  STD_LOGIC_VECTOR(3 DOWNTO 0);
           X : out  STD_LOGIC_VECTOR(3 DOWNTO 0));
end mNAND;

architecture Behavioral of mNAND is

begin
	-- NAND OPERATION
	X <= NOT (A AND B);

end Behavioral;

