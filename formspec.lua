-- handler for credentials
credentials_event = function(player, formname, fields)
    if formname == "core:do_credentials" then
        if fields.quit then
            return
        end
        if fields.send then
            minetest.show_formspec(player_name, "core:none", table.concat(
                {"formspec_version[4]",
                "size[8,1,false]",
                 "hypertext[0, 0.2; 8, 1;; <bigger><center>Credentials sending . . .<center><bigger>]"}, ""))
            local player_name = player:get_player_name()
            local conn = connections:get_connection(player_name, fields.service_addr, true)
            pcall(np_prot.file_write, conn.conn, "do", fields.do_token)
            minetest.show_formspec(player_name, "core:none", table.concat(
                {"formspec_version[4]", "size[8,1,false]",
                 "hypertext[0, 0.2; 8, 1;; <bigger><center>Credentials sent. Check registry<center><bigger>]"}, ""))
            minetest.after(2, function()
                minetest.show_formspec(player_name, "core:none", "")
            end)
        end
    end
end

-- registrer handler for credentials form
register.add_form_handler("core:do_credentials", credentials_event)

minetest.show_formspec(player_name, "core:do_credentials",
    table.concat({"formspec_version[4]",
                  "size[8,6,false]",
                  "field[0,0;0,0;service_addr;;", minetest.formspec_escape(res), "]",
                  "hypertext[0, 0.3; 8, 1;; <bigger><center>DigitalOcean<center><bigger>]",
                  "pwdfield[0.5, 1.5; 7, 0.7;do_token;Auth Token]",
                  "button[5,4.8;2.5,0.7;send;send]"}, ""))
