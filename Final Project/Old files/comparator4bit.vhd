Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
 
entity comparator4bit is
  port (
      i_Ai,i_Bi   : in std_logic_vector(3 downto 0);
      o_GT, o_EQ, o_LT  : out std_logic
   );
end comparator4bit ;
 
architecture bhv of comparator4bit is
begin
o_GT <= '1' when (i_Ai > i_Bi)
else '0';
o_EQ <= '1' when (i_Ai = i_Bi)
else '0';
o_LT <= '1' when (i_Ai < i_Bi)
else '0';
end bhv;
