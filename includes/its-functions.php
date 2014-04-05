<?php

function parseCLine($str)
{
    $tokens = explode(' ', $str, 20);
    $array = explodeArrayKeepDelimeter('(',$tokens);
    $array = explodeArrayKeepDelimeter(')',$array);
    $array = explodePointer($array);
    return $array;
}

function printCLine($array)
{
    foreach($array as $token)
    {
        echo("\"" . $token . "\" ");
    }
    echo('<br>');
}

function explodeArrayKeepDelimeter($delim, $tokens) {
    $array = array();
    foreach($tokens as $token)
    {
        $temp = explode($delim, $token, 20);
        $count = count($temp);
        if($count == 1)
            $array = array_merge((array)$array, (array)$temp);
        else
        {
            $temp2 = array();
            for($i = 0; $i < count($temp); $i++)
            {
                if($count >= 2)
                {
                    $temp2 = array_merge($temp2, (array)$temp[$i], (array)$delim, (array)$temp[$i+1]);
                    $count--;
                }
            }
            $array = array_values(array_filter(array_merge((array)$array, (array)$temp2)));
        }
    }
    return $array;
}

function explodePointer($array)
{
    $temp_array = array();
    $no_apost_flag = 1; // Set to 1 if no apostrophe is found
    $no_ptr_flag = 1; // Set to 1 if no valid pointer is found
    $float_ptr_flag = 0; // Set to 1 if a floating apostrophe is found
    foreach($array as $token)
    {
        if(strpos($token, '*') !== FALSE)
        {
            $no_apost_flag = 0;
        }
        $first_char = substr($token, 0, 1);
        $last_char = substr($token, -1, 1);
        if((strcmp($first_char, '*') == 0) && strlen($token) == 1) // If an apostrophe is floating EX: int * ptr
        {
            $float_ptr_flag = 1;
            $temp_array = array_merge($temp_array, (array)$token);
        }
        else if((strcmp($first_char, '*') == 0) && strlen($token) > 1) // If an apostrophe is found at the beginning of a token EX: int *ptr
        {
            $temp_array = array_merge($temp_array, (array)'*', (array)substr($token, 1));
            $no_ptr_flag = 0;
        }
        else if((strcmp($last_char, '*') == 0) && strlen($token) > 1) // If an apostrophe is found at the end of a token EX: int* ptr
        {
            $temp_array = array_merge($temp_array, (array)substr($token, 0, -1), (array)'*');
            $no_ptr_flag = 0;
        }
        else // Else just add the token to the array
            $temp_array = array_merge($temp_array, (array)$token);
    }
    $temp_array = array_values(array_filter($temp_array));
    $temp_array['FLOAT_PTR'] = $float_ptr_flag;
    $temp_array['NO_APOST'] = $no_apost_flag;
    $temp_array['NO_PTR'] = $no_ptr_flag;
    return $temp_array;
}

?>