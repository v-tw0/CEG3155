LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY oneBitAdder IS
	PORT (
		i_CarryIn : IN STD_LOGIC;
		i_Ai, i_Bi : IN STD_LOGIC;
		o_Sum, o_CarryOut : OUT STD_LOGIC
	);
END oneBitAdder;

ARCHITECTURE rtl OF oneBitAdder IS
BEGIN
	o_Sum <= i_Ai XOR i_Bi XOR i_CarryIn;

	o_CarryOut <= (i_Ai AND i_Bi) OR (i_Ai AND i_CarryIn) OR (i_Bi AND i_CarryIn);

END rtl;