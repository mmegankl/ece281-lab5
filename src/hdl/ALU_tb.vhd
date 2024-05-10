----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2024 10:49:58 PM
-- Design Name: ECE281 Lab 5
-- Module Name: ALU_tb - Behavioral
-- Project Creators: C3C Raine Komata and C3C Megan Leong 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_tb is
end ALU_tb;

architecture test_bench of ALU_tb is
    component ALU is
        port ( i_op     : in STD_LOGIC_VECTOR (2 downto 0);
               i_A      : in STD_LOGIC_VECTOR (7 downto 0);
               i_B      : in STD_LOGIC_VECTOR (7 downto 0);
               o_flag   : out STD_LOGIC_VECTOR (2 downto 0);
               o_result : out STD_LOGIC_VECTOR (7 downto 0)
             );
    end component ALU;
    
    -- declare components and signals
        signal w_carry         : STD_LOGIC;
        signal w_result        : STD_LOGIC_VECTOR (7 downto 0);
        signal w_zero          : STD_LOGIC;
        signal w_sign          : STD_LOGIC;
        
        signal w_op : STD_LOGIC_VECTOR (2 downto 0);
        signal w_A, w_B : STD_LOGIC_VECTOR (7 downto 0);

        -- constants
        -- Clock period definitions
        constant k_clk_period : time := 10 ns;


begin

-- Port Maps
uut: ALU
port map (
    i_op => w_op,
    i_A => w_A,
    i_B => w_B,
    o_result => w_result,  
    o_flag(2) => w_sign,
    o_flag(0) => w_carry,
    o_flag(1) => w_zero
);

-- Simulation process
sim_proc: process
begin

-- 1 + 1 = 2, no carry
w_op <= "000"; w_A <= "00000001"; w_B <= "00000001";
wait for k_clk_period;
    assert w_result = "00000010" report "addition failed" severity failure;
    assert w_carry = '0' report "wrongful carryout (addition)" severity failure;
    assert w_zero = '0' report "wrongful zero value (addition)" severity failure;
    assert w_sign = '0' report "sign wrong (addition)" severity failure;

wait for k_clk_period;

-- 6 - 2 = 4, carry
w_op <= "001"; w_A <= "00000110"; w_B <= "00000010";
wait for k_clk_period;
    assert w_result = "00000100" report "subtraction failed" severity failure;
    assert w_carry = '1' report "no carryout (subtraction)" severity failure;
    assert w_zero = '0' report "wrongful zero value (subtraction)" severity failure;
    assert w_sign = '0' report "sign wrong (subtraction)" severity failure;

wait for k_clk_period;
    
-- -1 + 1 = 0, carry, zero
w_op <= "000"; w_A <= "11111111"; w_B <= "00000001";
wait for k_clk_period;
    assert w_result = "00000000" report "addition failed" severity failure;
    assert w_carry = '1' report "no carryout (addition)" severity failure;
    assert w_zero = '1' report "no zero value (addition)" severity failure;
    assert w_sign = '0' report "sign wrong (addition)" severity failure;
   
wait for k_clk_period;
     
-- 1 - 4 = -3, no carry, negative value
w_op <= "001"; w_A <= "00000001"; w_B <= "00000100";
wait for k_clk_period;
    assert w_result = "11111101" report "subtraction failed" severity failure;
    assert w_carry = '0' report "no carryout (subtraction)" severity failure;
    assert w_zero = '0' report "wrongful zero value (subtraction)" severity failure;
    assert w_sign = '1' report "sign wrong (subtraction)" severity failure;
 
 wait for k_clk_period;
            
-- 5 OR 3, op code 100
w_op <= "100"; w_A <= "00000101"; w_B <= "00000011";
wait for k_clk_period;
    assert w_result = "00000111" report "OR failed" severity failure;
    assert w_carry = '0' report "wrongful carryout (OR)" severity failure;
    assert w_zero = '0' report "wrongful zero value (OR)" severity failure;
    assert w_sign = '0' report "sign wrong (OR)" severity failure;
  
wait for k_clk_period;
    
-- 5 OR 3, op code 101
w_op <= "101"; w_A <= "00000101"; w_B <= "00000011";
wait for k_clk_period;
    assert w_result = "00000111" report "OR failed" severity failure;
    assert w_carry = '0' report "wrongful carryout (OR)" severity failure;
    assert w_zero = '0' report "wrongful zero value (OR)" severity failure;
    assert w_sign = '0' report "sign wrong (OR)" severity failure;
 
wait for k_clk_period; 
    
-- 5 AND 3, op code 010
w_op <= "010"; w_A <= "00000101"; w_B <= "00000011";
wait for k_clk_period;
    assert w_result = "00000001" report "AND failed" severity failure;
    assert w_carry = '0' report "wrongful carryout (AND)" severity failure;
    assert w_zero = '0' report "wrongful zero value (AND)" severity failure;
    assert w_sign = '0' report "sign wrong (AND)" severity failure;
    
wait for k_clk_period;
    
-- 5 LLS 3
w_op <= "111"; w_A <= "00000101"; w_B <= "00000011";
wait for k_clk_period;
    assert w_result = "00101000" report "LLS failed" severity failure;
    assert w_carry = '0' report "wrongful carryout (LLS)" severity failure;
    assert w_zero = '0' report "wrongful zero value (LLS)" severity failure;
    assert w_sign = '0' report "sign wrong (LLS)" severity failure;
 
 wait for k_clk_period;
    
-- 5 RLS 3, zero
w_op <= "110"; w_A <= "00000101"; w_B <= "00000011";
wait for k_clk_period;
    assert w_result = "00000000" report "RLS failed" severity failure;
    assert w_carry = '0' report "wrongful carryout (RLS)" severity failure;
    assert w_zero = '1' report "wrongful zero value (RLS)" severity failure;
    assert w_sign = '0' report "sign wrong (RLS)" severity failure;    

wait;    
end process;   

-- and, or, shift left, shift right, addition with/without carry

end test_bench;
