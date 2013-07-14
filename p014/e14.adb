-- Euler 14
-- Collatz #s

with ada.text_io;
use ada.text_io;

procedure e14 is

    package int_io is new ada.text_io.integer_io(integer);
    use int_io;
    package long_int_io is new ada.text_io.integer_io(long_integer);
    use long_int_io;

    function collatz(n : long_integer) return long_integer is
    begin
        if n mod 2 = 0 then
            return n / 2;
        else
            return (3 * n) + 1;
        end if;
    end collatz;

    function collatz_count(n : long_integer) return integer is
        count : integer;
        x : long_integer;
    begin
        count := 1;
        x := n;
        loop
            count := count + 1;
            x := collatz(x);
            if x < 2 then
                exit;
            end if;
        end loop;
        return count;
    end collatz_count;

    highest_len : integer;
    highest_n   : long_integer;
    count       : integer;
begin
    put_line("Euler 14");
    put_line("finding longest collatz chain for N=1..1,000,000");
    highest_len := -1;
    highest_n := -1;
    for n in long_integer range 1..1000000 loop
        count := collatz_count(n);
        if count > highest_len then
            highest_len := count;
            highest_n := n;
        end if;
    end loop;
    put(item => highest_n);
    put(item => " creates the longest sequence, with length ");
    put(item => highest_len);
    new_line;
end e14;
