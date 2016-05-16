function grip(close,t)
    if input == 1
        sendCommand(t,'<c>\n')		%Close gripper
    elseif input == 0
        sendCommand(t,'<o>\n')		%Open gripper
    end
end