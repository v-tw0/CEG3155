LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY addSub4bit IS
 PORT(
  i_Ai, i_Bi : IN STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit inputs instead of 8-bit
  i_Control : IN STD_LOGIC;
  o_CarryOut : OUT STD_LOGIC;
  o_Sum : OUT STD_LOGIC_VECTOR(3 downto 0)       -- 4-bit output instead of 8-bit
 );
END addSub4bit;

ARCHITECTURE rtl OF addSub4bit IS
 SIGNAL int_Sum, int_CarryOut, int_ControlA, int_ControlB, int_carryIn, int_Control : STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit signals
 SIGNAL gnd : STD_LOGIC;

 COMPONENT oneBitAdder
 PORT(
  i_CarryIn : IN STD_LOGIC;
  i_Ai, i_Bi : IN STD_LOGIC;
  o_Sum, o_CarryOut : OUT STD_LOGIC
 );
 END COMPONENT;

BEGIN
 -- Concurrent Signal Assignment
 gnd <= '0';
 int_carryIn(3 downto 1) <= int_CarryOut(2 downto 0);  -- Adjust for 4-bit carry chain
 int_carryIn(0) <= i_Control;
 int_Control <= (others => i_Control);
 int_ControlA <= i_Ai;
 int_ControlB <= i_Bi xor int_Control;

 loop1: FOR i IN 3 DOWNTO 0 GENERATE  -- Loop for 4 bits instead of 8
  add: oneBitAdder
  PORT MAP (
   i_CarryIn => int_carryIn(i),
   i_Ai => int_ControlA(i),
   i_Bi => int_ControlB(i),
   o_Sum => int_Sum(i),
   o_CarryOut => int_CarryOut(i)
  );
 END GENERATE;

 -- Output Driver
 o_Sum <= int_Sum;
 o_CarryOut <= int_CarryOut(3);  -- Adjust for 4-bit output
END rtl;
