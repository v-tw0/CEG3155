library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UART_FSM is
 Port (
    i_Greset, i_CLK: in std_logic;
    i_STATE_INFORMATION, i_IRQ: in std_logic_vector(1 downto 0);
    i_DATA_IN: in std_logic_vector(7 downto 0);
    o_R, o_UARTselect: out std_logic;
    o_ADDR: out std_logic_vector(1 downto 0);
    o_DATA_OUT: out std_logic_vector(7 downto 0)
 );
end UART_FSM;

architecture struct of UART_FSM is
    signal i_charM, i_charMcolor, i_charUnderscore, i_charS, i_charScolor, i_charg, i_chary, i_charr, i_charNewline, i_SCCRinit: std_logic_vector(7 downto 0);
    signal i_SI_load, i_SI0out, i_SI1out: std_logic;
    signal i_CHARSEL: std_logic_vector(2 downto 0);
    signal i_newStateCheck: std_logic;

    signal i_Y15_i, i_Y14_i, i_Y13_i, i_Y12_i, i_Y11_i, i_Y10_i, i_Y9_i, i_Y8_i, i_Y7_i, i_Y6_i, i_Y5_i, i_Y4_i, i_Y3_i, i_Y2_i, i_Y1_i, i_Y0_i: std_logic;
    signal o_y15, o_y14, o_y13, o_y12, o_y11, o_y10, o_y9, o_y8, o_y7, o_y6, o_y5, o_y4, o_y3, o_y2, o_y1, o_y0: std_logic;
    signal o_y15Bar, o_y14Bar, o_y13Bar, o_y12Bar, o_y11Bar, o_y10Bar, o_y9Bar, o_y8Bar, o_y7Bar, o_y6Bar, o_y5Bar, o_y4Bar, o_y3Bar, o_y2Bar, o_y1Bar, o_y0Bar: std_logic;
    signal i_resetcondition: std_logic;

    signal i_Y21_i, i_Y20_i, i_Y19_i, i_Y18_i, i_Y17_i, i_Y16_i: std_logic;
    signal o_y21, o_y20, o_y19, o_y18, o_y17, o_y16: std_logic;
    signal o_y21Bar, o_y20Bar, o_y19Bar, o_y18Bar, o_y17Bar, o_y16Bar: std_logic;

begin

    i_newStateCheck <= (i_SI1out xor i_STATE_INFORMATION(1)) or (i_SI0out xor i_STATE_INFORMATION(0));

    i_resetcondition <= (o_y21Bar and o_y20Bar and o_y19Bar and o_y18Bar and o_y17Bar and o_y16Bar and o_y15Bar and o_y14Bar and o_y13Bar and o_y12Bar and o_y11Bar and o_y10Bar and o_y9Bar and o_y8Bar and o_y7Bar and o_y6Bar and o_y5Bar and o_y4Bar and o_y3Bar and o_y2Bar and o_y1Bar and o_y0Bar);
    
    i_Y21_i <= (o_y13 and i_IRQ(0));
    i_Y20_i <= (o_y11 and i_IRQ(0));
    i_Y19_i <= (o_y9 and i_IRQ(0));
    i_Y18_i <= (o_y7 and i_IRQ(0));
    i_Y17_i <= (o_y5 and i_IRQ(0));
    i_Y16_i <= (o_y3 and i_IRQ(0));

    i_Y15_i <= (o_y14 and i_newStateCheck);
    i_Y14_i <= (o_y13 and i_IRQ(1) and not i_IRQ(0)) or (o_y14 and not i_newStateCheck);
    i_Y13_i <= (o_y12) or (o_y13 and not i_IRQ(1)) or (o_y21 and not i_IRQ(0));
    i_Y12_i <= (o_y11 and i_IRQ(1) and not i_IRQ(0));
    i_Y11_i <= (o_y10) or (o_y11 and not i_IRQ(1)) or (o_y20 and not i_IRQ(0));
    i_Y10_i <= (o_y9 and i_IRQ(1) and not i_IRQ(0));
    i_Y9_i <= (o_y8) or (o_y9 and not i_IRQ(1)) or (i_Y19 and not i_IRQ(0));
    i_Y8_i <= (o_y7 and i_IRQ(1) and not i_IRQ(0));
    i_Y7_i <= (o_y6) or (o_y7 and not i_IRQ(1)) or (i_Y18 and not i_IRQ(0));
    i_Y6_i <= (o_y5 and i_IRQ(1) and not i_IRQ(0));
    i_Y5_i <= (o_y4) or (o_y5 and not i_IRQ(1)) or (i_Y17 and not i_IRQ(0));
    i_Y4_i <= (o_y3 and i_IRQ(1) and not i_IRQ(0));
    i_Y3_i <= (o_y2) or (o_y3 and not i_IRQ(1)) or (i_Y16 and not i_IRQ(0));
    i_Y2_i <= (o_y1 and i_IRQ(1));
    i_Y1_i <= (o_y0) or (o_y15) or (o_y1 and not i_IRQ(1));
    i_Y0_i <= i_resetcondition;


    i_charM <= "01001101";
    i_charUnderscore <= "01011111";
    i_charS <= "01010011";
    i_charg <= "01100111";
    i_chary <= "01111001";
    i_charr <= "01110010";
    i_charNewline <= "00001010";
    i_SCCRinit <= "11000000";

    i_SI0: entity work.ENDFF(struct)
        port map(i_STATE_INFORMATION(0), i_SI_load, i_CLK, i_SI0out);

    i_SI1: entity work.ENDFF(struct)
        port map(i_STATE_INFORMATION(1), i_SI_load, i_CLK, i_SI1out);

    i_McolorMUX: entity work.mux4x18bit(struct)
        port map(i_charg, i_charr, i_chary, i_charr, i_SI1out, i_SI0out, i_charMcolor);

    i_ScolorMUX: entity work.mux4x18bit(struct)
        port map(i_charr, i_chary, i_charr, i_charg, i_SI1out, i_SI0out, i_charScolor);

    i_CharMUX: entity work.mux8x18bit(struct)
        port map(i_charM, i_charMcolor, i_charUnderscore, i_charS, i_charScolor, i_charNewline, i_SCCRinit, "00000000", i_CHARSEL, o_DATA_OUT);

    i_DFF0: entity work.dFF_2(rtl)
        port map(i_Y0_i, i_CLK, o_y0, o_y0Bar);
    i_DFF1: entity work.dFF_2(rtl)
        port map(i_Y1_i, i_CLK, o_y1, o_y1Bar);
    i_DFF2: entity work.dFF_2(rtl)
        port map(i_Y2_i, i_CLK, o_y2, o_y2Bar);
    i_DFF3: entity work.dFF_2(rtl)
        port map(i_Y3_i, i_CLK, o_y3, o_y3Bar);
    i_DFF4: entity work.dFF_2(rtl)
        port map(i_Y4_i, i_CLK, o_y4, o_y4Bar);
    i_DFF5: entity work.dFF_2(rtl)
        port map(i_Y5_i, i_CLK, o_y5, o_y5Bar);
    i_DFF6: entity work.dFF_2(rtl)
        port map(i_Y6_i, i_CLK, o_y6, o_y6Bar);
    i_DFF7: entity work.dFF_2(rtl)
        port map(i_Y7_i, i_CLK, o_y7, o_y7Bar);
    i_DFF8: entity work.dFF_2(rtl)
        port map(i_Y8_i, i_CLK, o_y8, o_y8Bar);
    i_DFF9: entity work.dFF_2(rtl)
        port map(i_Y9_i, i_CLK, o_y9, o_y9Bar);
    i_DFF10: entity work.dFF_2(rtl)
        port map(i_Y10_i, i_CLK, o_y10, o_y10Bar);
    i_DFF11: entity work.dFF_2(rtl)
        port map(i_Y11_i, i_CLK, o_y11, o_y11Bar);
    i_DFF12: entity work.dFF_2(rtl)
        port map(i_Y12_i, i_CLK, o_y12, o_y12Bar);
    i_DFF13: entity work.dFF_2(rtl)
        port map(i_Y13_i, i_CLK, o_y13, o_y13Bar);
    i_DFF14: entity work.dFF_2(rtl)
        port map(i_Y14_i, i_CLK, o_y14, o_y14Bar);
    i_DFF15: entity work.dFF_2(rtl)
        port map(i_Y15_i, i_CLK, o_y15, o_y15Bar);

    i_DFF16: entity work.dFF_2(rtl)
        port map(i_Y16_i, i_CLK, o_y16, o_y16Bar);
    i_DFF17: entity work.dFF_2(rtl)
        port map(i_Y17_i, i_CLK, o_y17, o_y17Bar);
    i_DFF18: entity work.dFF_2(rtl)
        port map(i_Y18_i, i_CLK, o_y18, o_y18Bar);
    i_DFF19: entity work.dFF_2(rtl)
        port map(i_Y19_i, i_CLK, o_y19, o_y19Bar);
    i_DFF20: entity work.dFF_2(rtl)
        port map(i_Y20_i, i_CLK, o_y20, o_y20Bar);
    i_DFF21: entity work.dFF_2(rtl)
        port map(i_Y21_i, i_CLK, o_y21, o_y21Bar);

    i_CHARSEL(0) <= o_y4 or o_y8 or o_y12;
    i_CHARSEL(1) <= o_y0 or o_y6 or o_y8;
    i_CHARSEL(2) <= o_y0 or o_y10 or o_y12;
    i_SI_load <= o_y0 or o_y15;
    
    o_ADDR(0) <= '0';
    o_ADDR(1) <= o_y0;
    o_R <= o_y21 or o_y20 or o_y19 or o_y18 or o_y17 or o_y16;
    o_UARTselect <= o_y0 or o_y2 or o_y4 or o_y6 or o_y8 or o_y10 or o_y12 or o_y21 or o_y20 or o_y19 or o_y18 or o_y17 or o_y16;

end struct;
