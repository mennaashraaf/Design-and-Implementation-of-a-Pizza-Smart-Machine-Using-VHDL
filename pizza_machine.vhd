----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/16/2023 03:09:11 PM
-- Design Name: 
-- Module Name: pizza_machine - Behavioral
-- Project Name: 
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

entity pizza_machine is
    Port ( clk,rst: in STD_LOGIC;
           start : in STD_LOGIC;
           PD : in STD_LOGIC;
           pressed : in STD_LOGIC;
           p : in STD_LOGIC_VECTOR(3 downto 0);
           cheeckSauce : in STD_LOGIC;
           cheeckCheese : in STD_LOGIC;
           ready : in STD_LOGIC;
           neededpepperoni : in STD_LOGIC;
           enoughPepperoni : in STD_LOGIC;
           auto : in STD_LOGIC;
           sauce : out STD_LOGIC;
           cheese : out STD_LOGIC;
           pressure : out STD_LOGIC;
           heat : out STD_LOGIC;
           conveyor : out STD_LOGIC;
           pepperoni : out STD_LOGIC);
end pizza_machine;

architecture Behavioral of pizza_machine is

Type state is (s0,s1,s2,s3,s4,s5,s6);
signal pr,nxt :state ;

begin
     seq : process(clk)
     begin
           if(rising_edge(clk)) then
              if(rst='1') then  pr <= s0  ;
              else              pr <= nxt ;
              end if;
           end if;
     end process seq ; 
     
     comb : process(pr,start,PD,pressed,p,cheeckSauce,cheeckCheese,ready,neededpepperoni,enoughPepperoni,auto)
     begin
           case pr is 
               when s0 =>  sauce <='0'; cheese <='0'; pressure <= '0'; heat <= '0'; conveyor <= '0'; pepperoni <= '0';
                           if(start = '1')  then  nxt <= s1 ;
                           else                   nxt <= s0 ;
                           end if;
               when s1 =>  sauce <='0'; cheese <='0'; pressure <= '0'; heat <= '0'; conveyor <= '0'; pepperoni <= '0';
                           if(PD='1')       then  nxt <= s2 ;
                           else                   nxt <= s1  ;
                           end if ;
               when s2 =>  sauce <='0'; cheese <='0'; pressure <= '1'; heat <= '0'; conveyor <= '0'; pepperoni <= '0';
                           if(pressed='1')       then  conveyor <= '1' ;
                            if(p(0)='1')         then  nxt <= s3 ;
                            else                       conveyor <= '1' ;   
                            end if ;
                           else                        nxt <= s2  ;
                           end if ;
               when s3 =>  sauce <='1'; cheese <='0'; pressure <= '0'; heat <= '0'; conveyor <= '0'; pepperoni <= '0';
                           if(cheeckSauce='1')       then  conveyor <= '1' ;
                            if(p(1)='1')         then  nxt <= s4 ;
                            else                       conveyor <= '1' ;   
                            end if ;
                           else                        nxt <= s3  ;
                           end if ;
               when s4 =>  sauce <='0'; cheese <='1'; pressure <= '0'; heat <= '0'; conveyor <= '0'; pepperoni <= '0';
                           if(cheeckCheese='1')       then  conveyor <= '1' ;
                            if(p(2)='1')         then  nxt <= s5 ;
                            else                       conveyor <= '1' ;   
                            end if ;
                           else                        nxt <= s4  ;
                           end if ;
               when s5 =>  sauce <='0'; cheese <='0'; pressure <= '0'; heat <= '1'; conveyor <= '0'; pepperoni <= '0';
                           if(ready='1')                then  conveyor <= '1' ;
                            if(p(3)='1') then
                             if(neededpepperoni='1')     then  nxt <= s6 ;
                             else                              conveyor <= '1' ;
                              if(auto<='1')              then  nxt <= s1 ;
                              else                             nxt <= s0 ;
                              end if ; 
                             end if ;
                            else                       conveyor <= '1' ;
                            end if ;
                           else                        nxt <= s5  ;
                           end if ;
               when s6 =>  sauce <='0'; cheese <='0'; pressure <= '0'; heat <= '0'; conveyor <= '0'; pepperoni <= '1';
                           if(enoughPepperoni='1')       then  conveyor <= '1' ;
                            if(auto='1')         then  nxt <= s1 ;
                            else                       nxt <= s0 ;   
                            end if ;
                           else                        nxt <= s6  ;
                           end if ;           
           end case;
     
     end process comb ;
    
end Behavioral;
