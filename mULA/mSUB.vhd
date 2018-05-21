----------------------------------------------------------------------------------
-- Create Date:    20:30:00 05/20/2018 
-- Description: 
--      Module X = A - B (4 bits)
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Subtraction entity
entity mSUB is
    Port ( A : in  STD_LOGIC_VECTOR(3 downto 0);
           B : in  STD_LOGIC_VECTOR(3 downto 0);
           X : out  STD_LOGIC_VECTOR(3 downto 0);
			  Brw : out STD_LOGIC);
end mSUB;

architecture Behavioral of mSUB is

signal m2comp: STD_LOGIC_VECTOR(3 downto 0);
signal aux_brw: STD_LOGIC;
signal cin: STD_LOGIC;
signal cout: STD_LOGIC;

-- 4-bit adder
component mADD
	Port (  A : in  STD_LOGIC_VECTOR(3 downto 0);
			  B : in  STD_LOGIC_VECTOR(3 downto 0);
           c_in : in  STD_LOGIC;
           X : out  STD_LOGIC_VECTOR(3 downto 0);
           c_out : out  STD_LOGIC);
end component;

-- Two's complement
component m2CMPLMT
    Port (A : in  STD_LOGIC_VECTOR(3 downto 0);
          X : out  STD_LOGIC_VECTOR(3 downto 0);
			 COUT: out STD_LOGIC);
end component;

begin
	-- CIN adder
	cin <= '0';
	
	-- A + m2CMPLMT(B)
	SUB001: m2CMPLMT port map(B, m2comp, cout);
	SUB002: mADD port map(A, m2comp, cin, X, aux_brw);
	Brw <= NOT aux_brw;

end Behavioral;