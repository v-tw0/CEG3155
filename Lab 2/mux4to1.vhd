library ieee;
use ieee.std_logic_1164.all;

entity mux4to1 is
	port (
		i0,i1 : in STD_LOGIC_VECTOR(3 downto 0);
		i2,i3 : in STD_LOGIC_VECTOR(7 downto 0);
		s0,s1 : in STD_LOGIC;
		o_Result : out STD_LOGIC_VECTOR(7 downto 0)
	);
end mux4to1;
		
architecture behaviour of mux4to1 is 
begin 
	process (i0, i1, i2, i3, s0, s1) is
		begin
			if (s0 = '0' and s1 = '0') then
				for i in 7 downto 0 loop
					if(i > 3) then
						o_Result(i) <= '0';
					else
						o_Result(i) <= i0(i);
					end if;
				end loop;
			elsif (s0 = '0' and s1 = '1') then
				for i in 7 downto 0 loop
					if(i > 3) then
						o_Result(i) <= '0';
					else
						o_Result(i) <= i1(i);
					end if;
				end loop;
			elsif (s0 = '1' and s1 = '0') then
				o_Result <= i2;
			else 
				o_Result <= i3;
		end if;
	end process;
end behaviour;