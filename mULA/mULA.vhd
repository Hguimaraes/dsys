----------------------------------------------------------------------------------
-- Create Date:    22:50:00 05/20/2018 
-- Description: 
--      Module to select what operation to perfom
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mULA is
	Port ( A : in  STD_LOGIC_VECTOR(3 downto 0);
          B : in  STD_LOGIC_VECTOR(3 downto 0);
			 OP: in  STD_LOGIC_VECTOR(3 downto 0);
          X : out  STD_LOGIC_VECTOR(3 downto 0));
end mULA;

architecture Behavioral of mULA is

-- AND
component mAND
	Port ( A,B : in  STD_LOGIC_VECTOR(3 downto 0);
           X : out  STD_LOGIC_VECTOR(3 downto 0));
end component;

-- NAND
component mNAND
	Port ( A,B : in  STD_LOGIC_VECTOR(3 downto 0);
           X : out  STD_LOGIC_VECTOR(3 downto 0));
end component;

-- OR
component mOR
	Port ( A,B : in  STD_LOGIC_VECTOR(3 downto 0);
           X : out  STD_LOGIC_VECTOR(3 downto 0));
end component;

-- XOR
component mXOR
	Port ( A,B : in  STD_LOGIC_VECTOR(3 downto 0);
           X : out  STD_LOGIC_VECTOR(3 downto 0));
end component;

-- NOT
component mNOT
	Port ( A : in  STD_LOGIC_VECTOR(3 downto 0);
          X : out  STD_LOGIC_VECTOR(3 downto 0));
end component;

-- Two's complement
component m2CMPLMT
    Port (A : in  STD_LOGIC_VECTOR(3 downto 0);
          X : out  STD_LOGIC_VECTOR(3 downto 0);
			 COUT: out STD_LOGIC_VECTOR(3 downto 0));
end component;

-- 4-bit adder
component mADD
	Port ( A,B : in  STD_LOGIC_VECTOR(3 downto 0);
           c_in : in  STD_LOGIC;
           X : out  STD_LOGIC_VECTOR(3 downto 0);
           c_out : out  STD_LOGIC);
end component;

-- 4-bit subtractor
component mSUB
	Port ( A : in  STD_LOGIC_VECTOR(3 downto 0);
          B : in  STD_LOGIC_VECTOR(3 downto 0);
          X : out  STD_LOGIC_VECTOR(3 downto 0);
			 Brw : out STD_LOGIC_VECTOR(3 downto 0));
end component;

-- aux variables for arithmetic operations
SIGNAL c_in: STD_LOGIC;
SIGNAL c_out: STD_LOGIC;
SIGNAL Brw: STD_LOGIC;

begin
	-- Set cin as 0
	c_in <= '0';
	
	OP00: mAND port map(A,B,X_AND);
	OP01: mNAND port map(A,B,X_NAND);
	OP02: mOR port map(A,B,X_OR);
	OP03: mXOR port map(A,B,X_XOR);
	OP04: mNOT port map(A,X_NOT);
	OP05: m2CMPLMT port map(A,B,X_2CMPLMT);
	OP06: mADD port map(A,B,c_in,X_ADD,c_out);
	OP07: mSUB port map(A,B,X_SUB, Brw);
	
	-- Select what operation to perform
	WITH OP SELECT 
		X	<= X_AND 		WHEN "0000",
				X_NAND 		WHEN "0001",
				X_OR 			WHEN "0010",
				X_XOR 		WHEN "0011",
				X_NOT 		WHEN "0100",
				X_2CMPLMT	WHEN "0101",
				X_ADD 		WHEN "0110",
				X_SUB 		WHEN "0111",
				"111111" 	WHEN OTHERS;
end Behavioral;
