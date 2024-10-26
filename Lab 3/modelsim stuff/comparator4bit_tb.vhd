LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY comparator4bit_tb IS
END comparator4bit_tb;

ARCHITECTURE behavior OF comparator4bit_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT comparator4bit
    PORT(
        i_Ai, i_Bi : IN  STD_LOGIC_VECTOR(3 downto 0);
        o_GT, o_LT, o_EQ : OUT STD_LOGIC
    );
    END COMPONENT;

    -- Signals for connecting to UUT
    SIGNAL i_Ai, i_Bi : STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL o_GT, o_LT, o_EQ : STD_LOGIC;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: comparator4bit PORT MAP (
        i_Ai => i_Ai,
        i_Bi => i_Bi,
        o_GT => o_GT,
        o_LT => o_LT,
        o_EQ => o_EQ
    );

    -- Test Process
    stim_proc: PROCESS
    BEGIN
        -- Test Case 1: A = 0000, B = 0000 (Expect o_EQ = '1', o_GT = '0', o_LT = '0')
        i_Ai <= "0000"; i_Bi <= "0000";
        WAIT FOR 10 ns;

        -- Test Case 2: A = 0001, B = 0000 (Expect o_GT = '1', o_EQ = '0', o_LT = '0')
        i_Ai <= "0001"; i_Bi <= "0000";
        WAIT FOR 10 ns;

        -- Test Case 3: A = 0010, B = 0011 (Expect o_LT = '1', o_EQ = '0', o_GT = '0')
        i_Ai <= "0010"; i_Bi <= "0011";
        WAIT FOR 10 ns;

        -- Test Case 4: A = 1010, B = 1010 (Expect o_EQ = '1', o_GT = '0', o_LT = '0')
        i_Ai <= "1010"; i_Bi <= "1010";
        WAIT FOR 10 ns;

        -- Test Case 5: A = 1100, B = 1001 (Expect o_GT = '1', o_EQ = '0', o_LT = '0')
        i_Ai <= "1100"; i_Bi <= "1001";
        WAIT FOR 10 ns;

        -- Test Case 6: A = 0110, B = 1110 (Expect o_LT = '1', o_EQ = '0', o_GT = '0')
        i_Ai <= "0110"; i_Bi <= "1110";
        WAIT FOR 10 ns;

        -- Test Case 7: A = 1111, B = 1111 (Expect o_EQ = '1', o_GT = '0', o_LT = '0')
        i_Ai <= "1111"; i_Bi <= "1111";
        WAIT FOR 10 ns;

        -- Stop simulation
        WAIT;
    END PROCESS;

END behavior;
