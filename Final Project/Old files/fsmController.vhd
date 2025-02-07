library ieee;
use ieee.std_logic_1164.all;

entity fsmController is
    port(
        i_SSCS, i_clk, i_resetbar, i_MSC, i_SSC : in STD_LOGIC;
        o_MSTL, o_SSTL: out STD_LOGIC_VECTOR (2 downto 0);
        counterReset : out STD_LOGIC;
        o_currentState, o_nextState: out STD_LOGIC_VECTOR (1 downto 0)
    );
end fsmController;

architecture rtl of fsmController is
    -- Separate signals for current and next state
    SIGNAL currentY0, currentY1, nextY0, nextY1, enable : STD_LOGIC;

    COMPONENT enARdFF_2 IS
        PORT(
            i_resetBar : IN STD_LOGIC;
            i_d : IN STD_LOGIC;
            i_enable : IN STD_LOGIC;
            i_clock : IN STD_LOGIC;
            o_q, o_qBar : OUT STD_LOGIC
        );
    END COMPONENT;
    
begin
    -- Flip-flop instances for storing the current state
    ffy0 : enARdFF_2
        PORT MAP (
            i_resetBar => i_resetbar,
            i_d => nextY0,       -- Load next state value
            i_enable => enable,
            i_clock => i_clk,
            o_q => currentY0,    -- Output to current state signal
            o_qBar => open       -- No need for the inverted output in this case
        );

    ffy1 : enARdFF_2
        PORT MAP (
            i_resetBar => i_resetbar,
            i_d => nextY1,       -- Load next state value
            i_enable => enable,
            i_clock => i_clk,
            o_q => currentY1,    -- Output to current state signal
            o_qBar => open       -- No need for the inverted output in this case
        );

    -- Define next state logic based on the current state and inputs
    nextY1 <= currentY0;
    nextY0 <= (i_SSCS AND NOT currentY1) OR (NOT currentY1 AND currentY0);

    -- Generate outputs based on the current state
    o_MSTL(2) <= currentY1;
    o_MSTL(1) <= NOT currentY1 AND currentY0;
    o_MSTL(0) <= NOT currentY1 AND NOT currentY0;

    o_SSTL(2) <= NOT currentY1;
    o_SSTL(1) <= currentY1 AND NOT currentY0;
    o_SSTL(0) <= currentY1 AND currentY0;

    -- Enable logic for state transition
    enable <= (i_MSC AND i_SSCS AND NOT currentY0 AND NOT currentY1) OR
              (currentY0 AND NOT currentY1 AND i_MSC) OR
              (currentY0 AND currentY1 AND i_SSC) OR
              (NOT currentY0 AND currentY1 AND i_SSC);

    counterReset <= enable;

    -- Map current and next states to output ports
    o_currentState(0) <= currentY0;
    o_currentState(1) <= currentY1;
    o_nextState(0) <= nextY0;
    o_nextState(1) <= nextY1;

end architecture;
