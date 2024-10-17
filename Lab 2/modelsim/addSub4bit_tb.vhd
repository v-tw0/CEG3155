LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_addSub4bit IS
END tb_addSub4bit;

ARCHITECTURE behavior OF tb_addSub4bit IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT addSub4bit
        PORT(
            i_Ai, i_Bi : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            i_Control  : IN  STD_LOGIC;
            o_CarryOut : OUT STD_LOGIC;
            o_Sum      : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    -- Inputs
    SIGNAL i_Ai       : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL i_Bi       : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
    SIGNAL i_Control  : STD_LOGIC := '0'; -- 0 for add, 1 for subtract

    -- Outputs
    SIGNAL o_CarryOut : STD_LOGIC;
    SIGNAL o_Sum      : STD_LOGIC_VECTOR(3 DOWNTO 0);

    -- Clock period definition
    CONSTANT clk_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: addSub4bit PORT MAP (
        i_Ai       => i_Ai,
        i_Bi       => i_Bi,
        i_Control  => i_Control,
        o_CarryOut => o_CarryOut,
        o_Sum      => o_Sum
    );

    -- Stimulus process
    stim_proc: PROCESS
    BEGIN
        -- Test 1: Addition (i_Control = '0')
        i_Ai <= "0001"; -- 1
        i_Bi <= "0011"; -- 3
        i_Control <= '0'; -- Add
        WAIT FOR 20 ns;
        assert (o_Sum = "0100") report "Test 1 failed: 1 + 3 should be 4" severity error;

        -- Test 2: Addition (with carry)
        i_Ai <= "1011"; -- 11
        i_Bi <= "0110"; -- 6
        i_Control <= '0'; -- Add
        WAIT FOR 20 ns;
        assert (o_Sum = "0001" AND o_CarryOut = '1') report "Test 2 failed: 11 + 6 should be 1 with carry 1" severity error;

        -- Test 3: Subtraction (i_Control = '1')
        i_Ai <= "0101"; -- 5
        i_Bi <= "0010"; -- 2
        i_Control <= '1'; -- Subtract
        WAIT FOR 20 ns;
        assert (o_Sum = "0011") report "Test 3 failed: 5 - 2 should be 3" severity error;

        -- Test 4: Subtraction (with carry)
        i_Ai <= "0010"; -- 2
        i_Bi <= "0100"; -- 4
        i_Control <= '1'; -- Subtract
        WAIT FOR 20 ns;
        assert (o_Sum = "1110" AND o_CarryOut = '0') report "Test 4 failed: 2 - 4 should be -2 (signed 1110)" severity error;

        -- Test 5: Addition (i_Ai = 0, i_Bi = 0)
        i_Ai <= "0000"; -- 0
        i_Bi <= "0000"; -- 0
        i_Control <= '0'; -- Add
        WAIT FOR 20 ns;
        assert (o_Sum = "0000" AND o_CarryOut = '0') report "Test 5 failed: 0 + 0 should be 0" severity error;

        -- Test 6: Subtraction (i_Ai = 0, i_Bi = 0)
        i_Ai <= "0000"; -- 0
        i_Bi <= "0000"; -- 0
        i_Control <= '1'; -- Subtract
        WAIT FOR 20 ns;
        assert (o_Sum = "0000" AND o_CarryOut = '0') report "Test 6 failed: 0 - 0 should be 0" severity error;

        -- Test completed
        WAIT;
    END PROCESS;

END behavior;
