----------------------------------------------------------------------------------
-- Create Date:    20:24:48 05/20/2018 
-- Description: 
--      Module to make an AND operation between A,B (4 bits)
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mAND is
    Port ( A : in STD_LOGIC_VECTOR(3 DOWNTO 0);
           B : in STD_LOGIC_VECTOR(3 DOWNTO 0);
           X : out STD_LOGIC_VECTOR(3 DOWNTO 0));
end mAND;

architecture Behavioral of mAND is

begin
	-- 4-bit and operation
	X <= A AND B;
	
end Behavioral;