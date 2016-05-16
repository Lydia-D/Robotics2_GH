%makes sure value isn't zero so it can be rounded up to an integer

function array = nozero(array)
    array = array + 0.01;
end