library ieee;
use ieee.std_logic_1164.all;

entity fsmController is
	port(
	i_SSCS ,i_clk, i_resetbar, i_MSC, i_SSC : in STD_LOGIC;
	MSTL, SSTL: out STD_LOGIC_VECTOR (2 downto 0);
	counterReset: out STD_LOGIC);
end fsmController;

architecture rtl of fsmController is
	SIGNAL y0,y1,y0_prime,y1_prime,bigY0,bigY1,enable: STD_LOGIC;

	COMPONENT enARdFF_2 IS
	PORT(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;
	
begin
	ffy0 : enARdFF_2
		PORT MAP (i_resetBar => i_resetbar, 
					 i_d => bigY0,
				  i_enable => enable,
				  i_clock => i_clk,
				  o_q => y0,
				  o_qBar => y0_prime);
				  
	ffy1 : enARdFF_2
		PORT MAP (i_resetBar => i_resetbar, 
					 i_d => bigY1,
				  i_enable => enable,
				  i_clock => i_clk,
				  o_q => y1,
				  o_qBar => y1_prime);

	bigY1 <= y0;
	bigY0 <= (i_SSCS AND y1_prime) OR (y1_prime AND y0);
	MSTL(2) <= y1;
	MSTL(1) <= y1_prime AND y0;
	MSTL(0) <= y1_prime AND y0_prime;
	SSTL(2) <= y1_prime;
	SSTL(1) <= y1 AND y0_prime;
	SSTL(0) <= y1 AND y0;
	enable  <= (i_MSC AND i_SSCS AND y0_prime AND y1_prime) OR (y0 AND y1_prime AND i_MSC) OR (y0 AND y1 AND i_SSC) OR (y0_prime AND y1 AND i_SSC);

	counterReset <= enable;
end architecture;