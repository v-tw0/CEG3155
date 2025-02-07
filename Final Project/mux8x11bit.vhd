library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8x11bit is
    Port ( 
           i_values : in STD_LOGIC_VECTOR (7 downto 0);
           i_Sel : in std_logic_vector(2 downto 0);
           o_Q : out STD_LOGIC
         );
end mux8x11bit;

architecture Structural of mux8x11bit is
begin 
    o_Q <= (not(i_Sel(2)) and not(i_Sel(1)) and not(i_Sel(0)) and i_values(0)) 
        or (not(i_Sel(2)) and not(i_Sel(1)) and i_Sel(0) and i_values(1)) 
        or (not(i_Sel(2)) and i_Sel(1) and not(i_Sel(0)) and i_values(2))
        or (not(i_Sel(2)) and i_Sel(1) and i_Sel(0) and i_values(3))
        or (i_Sel(2) and not(i_Sel(1)) and not(i_Sel(0)) and i_values(4))
        or (i_Sel(2) and not(i_Sel(1)) and i_Sel(0) and i_values(5))
        or (i_Sel(2) and i_Sel(1) and not(i_Sel(0)) and i_values(6))
        or (i_Sel(2) and i_Sel(1) and i_Sel(0) and i_values(7));
end Structural;
