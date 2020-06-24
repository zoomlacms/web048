<%@ page language="C#" autoeventwireup="true" inherits="Manage_Copyright_Royalty, App_Web_xgqknywv" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>版权收益</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <iframe runat="server" id="royalty_ifr" style="width:100%;" frameborder="0" marginheight="0" marginwidth="0"></iframe>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script>
    $("#royalty_ifr").load(function () {
        var $obj = $(this);
        $obj.height($(document).height() - 120);
    });
</script>
</asp:Content>
