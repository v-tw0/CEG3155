LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY counterJK4bit IS
	PORT(
		i_resetBar, i_count, i_load, i_clk	: IN	STD_LOGIC;
		i_dataValue : IN STD_LOGIC_VECTOR(3 downto 0);
		o_Value	 : OUT	STD_LOGIC_VECTOR(3 downto 0));
END counterJK4bit;

ARCHITECTURE rtl OF counterJK4bit IS
	SIGNAL notLoad : STD_LOGIC;
	SIGNAL notData : STD_LOGIC_VECTOR(3 downto 0);
	SIGNAL aOut    : STD_LOGIC_VECTOR(3 downto 0);

	COMPONENT jkFF_2
	PORT(
		i_j, i_k	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;

	BEGIN
		notLoad <= not i_load;
		notData <= not i_dataValue;
		jk0 : jkFF_2
			PORT MAP(
				i_j => (i_load AND i_dataValue(0)) OR (i_count AND notLoad),
				i_k => (i_load AND notData(0)) OR (i_count AND notLoad),
				i_clock => i_clk,
				o_q => aOut(0));

		jk1 : jkFF_2
			PORT MAP(
				i_j => (i_load AND i_dataValue(1)) OR (i_count AND notLoad AND aOut(0)),
				i_k => (i_load AND notData(1)) OR (i_count AND notLoad AND aOut(0)),
				i_clock => i_clk,
				o_q => aOut(1));
				
		jk2 : jkFF_2
			PORT MAP(
				i_j => (i_load AND i_dataValue(2)) OR (i_count AND notLoad AND aOut(0) AND aOut(1)),
				i_k => (i_load AND notData(2)) OR (i_count AND notLoad AND aOut(0) AND aOut(1)),
				i_clock => i_clk,
				o_q => aOut(2));
				
		jk3 : jkFF_2
			PORT MAP(
				i_j => (i_load AND i_dataValue(3)) OR (i_count AND notLoad AND aOut(0) AND aOut(1) AND aOut(2)),
				i_k => (i_load AND notData(3)) OR (i_count AND notLoad AND aOut(0) AND aOut(1) AND aOut(2)),
				i_clock => i_clk,
				o_q => aOut(3));
	o_Value <= aOut;
END;