local function ShowConfirmationDialog(dialogName, dialogTitle, bodyText, callbackYes, callbackNo, callbackSetup, forceUpdate)
    if (LibDialog) then
        LibDialog:RegisterDialog(
                DynamicCP.name,
                dialogName,
                dialogTitle,
                bodyText,
                callbackYes,
                callbackNo,
                callbackSetup,
                forceUpdate)
        LibDialog:ShowDialog(DynamicCP.name, dialogName)
    elseif (LibConsoleDialogs) then
        -- TODO: possibly remove dependency and implement it myself?
        d("TODO")
    else
        d("|cFF0000Couldn't show dialog?!|r")
    end
end
DynamicCP.ShowConfirmationDialog = ShowConfirmationDialog
